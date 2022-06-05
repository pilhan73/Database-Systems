
CREATE TABLE teams
(team_id NUMBER NOT NULL,
team_name VARCHAR2(30) NOT NULL,
games_played NUMBER NOT NULL,
mtch_won NUMBER DEFAULT 0 NOT NULL,
mtch_lost NUMBER DEFAULT 0 NOT NULL,
mtch_drw NUMBER DEFAULT 0 NOT NULL,
ssnal_pts NUMBER DEFAULT 0 NOT NULL,
PRIMARY KEY(team_id)
);

CREATE TABLE matches
(match_id NUMBER NOT NULL,
home_id NUMBER NOT NULL REFERENCES teams(team_id),
away_id NUMBER NOT NULL REFERENCES teams(team_id),
date_id VARCHAR2(20) NOT NULL,
PRIMARY KEY(match_id)
);

CREATE TABLE players
(team_id NUMBER NOT NULL REFERENCES teams(team_id),
player_name VARCHAR2(25),
player_surname VARCHAR2(25),
player_id NUMBER NOT NULL,
kit NUMBER NOT NULL,
ssnl_goals NUMBER DEFAULT 0 NOT NULL,
ssnl_assts NUMBER DEFAULT 0 NOT NULL,
PRIMARY KEY(player_id)
);

CREATE TABLE scores
(match_id NUMBER NOT NULL REFERENCES matches(match_id),
player_id NUMBER NOT NULL REFERENCES players(player_id),
asst_id NUMBER,
asst_time NUMBER,
score_time NUMBER DEFAULT 0 NOT NULL,
score_count NUMBER DEFAULT 0 NOT NULL,
PRIMARY KEY(score_count)
);

CREATE TABLE stadiums
(match_id NUMBER NOT NULL REFERENCES matches(match_id),
team_id NUMBER NOT NULL REFERENCES teams(team_id),
venue_id NUMBER NOT NULL,
venue_name VARCHAR2(70),
PRIMARY KEY(venue_id)
);

CREATE TABLE fixtures
(game_week NUMBER NOT NULL,
final_score NUMBER NOT NULL,
wld_status NUMBER NOT NULL,
PRIMARY KEY(final_score)
);

INSERT INTO TEAMS(team_id, team_name, games_played, mtch_won, mtch_lost, mtch_drw, ssnal_pts) VALUES (01, 'Fenerbahce', 1, 1, 0, 0, 1);
INSERT INTO TEAMS(team_id, team_name, games_played, mtch_won, mtch_lost, mtch_drw, ssnal_pts) VALUES (02, 'Galatasaray', 1, 0, 1, 0);

INSERT INTO PLAYERS(team_id, player_name, player_surname, player_id, kit, ssnl_goals, ssnl_assts) VALUES (01, 'Alex', 'De Souza', 0110, 10, 2, 0);
INSERT INTO PLAYERS(team_id, player_name, player_surname, player_id, kit, ssnl_goals, ssnl_assts) VALUES (02, 'Fernando', 'Muslera', 0201, 01, 0, 0);

INSERT INTO MATCHES(match_id, home_id, away_id, date_id) VALUES (234201401, 01, 02, '23 April 2014')


SELECT * FROM scores;

SELECT * FROM stadium;

SELECT * FROM teams;

SELECT * FROM players;

SELECT * FROM fixtures;

SELECT * FROM matches;

SELECT * player_id
FROM scores
WHERE score_count >= 1;

SELECT *
FROM players
ORDER BY player_id;

SELECT scores.player_id, players.player_surname, scores.score_count
FROM scores
INNER JOIN scores ON scores.player_id=players.player_id
/* tried to tally the names of the players who have scored during the season  */

SELECT scores.player_id, scores.match_id, scores.score_time
    FROM scores 
    WHERE score_time 
UNION
SELECT scores.player_id, scores.match_id, scores.score_time
    FROM scores
    WHERE asst_time = score_time

/* Tried to show and list the players who scored and assisted the individual goals
throughout the season */

SELECT teams.team_name, teams.player_id, players.player_surname
    FROM teams
MINUS
SELECT teams.games_played, teams.mtch_drw, teams.mtch_lost, teams.mtch_won, teams.ssnal_pts
    FROM teams

/* Show only the members of individual team, WITHOUT the seasonal score info or 
any ranking informations. AKA the lineup */ 
