drop table if exists Lahman_AllstarFull;
drop table if exists Lahman_Appearances;
drop table if exists Lahman_AwardsManagers;
drop table if exists Lahman_AwardsPlayers;
drop table if exists Lahman_AwardsShareManagers;
drop table if exists Lahman_AwardsSharePlayers;
drop table if exists Lahman_Batting;
drop table if exists Lahman_BattingPost;
drop table if exists Lahman_CollegePlaying;
drop table if exists Lahman_Fielding;
drop table if exists Lahman_FieldingOF;
drop table if exists Lahman_FieldingOFsplit;
drop table if exists Lahman_FieldingPost;
drop table if exists Lahman_HallOfFame;
drop table if exists Lahman_HomeGames;
drop table if exists Lahman_Managers;
drop table if exists Lahman_ManagersHalf;
drop table if exists Lahman_Parks;
drop table if exists Lahman_People;
drop table if exists Lahman_Pitching;
drop table if exists Lahman_PitchingPost;
drop table if exists Lahman_Salaries;
drop table if exists Lahman_Schools;
drop table if exists Lahman_SeriesPost;
drop table if exists Lahman_Teams;
drop table if exists Lahman_TeamsFranchises;
drop table if exists Lahman_TeamsHalf;

CREATE TABLE Lahman_Parks(
    'park_key' TEXT PRIMARY KEY,
    'park_name' TEXT,
    'park_alias' TEXT,
    'city' TEXT,
    'state' TEXT,
    'country' TEXT
    );


CREATE TABLE Lahman_TeamsFranchises(
    'FranchisesfranchID' TEXT PRIMARY KEY,
    'franchName' TEXT,
    'active' TEXT,
    'NAassoc' TEXT
    );
CREATE TABLE Lahman_People(  
    'playerID' TEXT PRIMARY KEY,
    'birthYear' YEAR,
    'birthMonth' INT,
    'birthDay' INT,
    'birthCountry' TEXT,
    'birthState' TEXT,
    'birthCity' TEXT,
    'deathYear' INT,
    'deathMonth' INT,
    'deathDay' INT,
    'deathCountry' TEXT,
    'deathState' TEXT,
    'deathCity' TEXT,
    'nameFirst' TEXT,
    'nameLast' TEXT,
    'nameGiven' TEXT,
    'weight' INT,
    'height' INT,
    'bats' TEXT,
    'throws' TEXT,
    'debut' DATE,
    'finalGame' DATE,
    'retroID' TEXT,
    'bbrefID' TEXT
    );
CREATE TABLE Lahman_Teams(
    'yearID' YEAR,
    'lgID' TEXT ,
    'teamID' TEXT ,
    'franchID' TEXT REFERENCES Lahman_TeamsFrachise('FranchisesfranchID'),
    'divID' TEXT,
    'Rank' INT,
    'G' INT,
    'Ghome' INT,
    'W' INT,
    'L' INT,
    'DivWin' TEXT,
    'WCWin' TEXT,
    'LgWin' TEXT,
    'WSWin' TEXT,
    'R' INT,
    'AB' INT,
    'H' INT,
    'SecondBase' INT,
    'ThirdBase' INT,
    'HR' INT,
    'BB' INT,
    'SO' INT,
    'SB' INT,
    'CS' INT,
    'HBP' INT,
    'SF' INT,
    'RA' INT,
    'ER' INT,
    'ERA' INT,
    'CG' INT,
    'SHO' INT,
    'SV' INT,
    'IPouts' INT,
    'HA' INT,
    'HRA' INT,
    'BBA' INT,
    'SOA' INT,
    'E' INT,
    'DP' INT,
    'FP' INT,
    'name' TEXT,
    'park' TEXT,
    'attendance' INT,
    'BPF' INT,
    'PPF' INT,
    'teamIDBR' TEXT,
    'teamIDlahman45' TEXT,
    'teamIDretro' TEXT, 
    PRIMARY KEY (yearID, teamID, lgID) 
    );
CREATE TABLE Lahman_Schools(
    'schoolID' INT  PRIMARY KEY,
    'name_full' INT,
    'city' INT,
    'state' INT,
    'country' INT
    );

.mode csv
.import Parks_headless.csv Lahman_Parks
.import Schools_headless.csv Lahman_Schools
.import Teams_headless.csv Lahman_Teams
.import People_headless.csv Lahman_People
.import TeamsFranchises_headless.csv Lahman_TeamsFranchises


CREATE TABLE Lahman_AllStarFull(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'gameNum' INT,
    'gameID' TEXT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT  REFERENCES Lahman_Teams('lgID'),
    'gP' INT,
    'startingPos' INT
    );
.import AllStarFull_headless.csv Lahman_AllStarFull
CREATE TABLE Lahman_Appearances(
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'teamID' TEXT  REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'G_all' INT,
    'GS'  INT,
    'G_batting' INT,
    'G_defense' INT,
    'G_p' INT,
    'G_c' INT,
    'G_1b' INT,
    'G_2b' INT,
    'G_3b' INT,
    'G_ss' INT,
    'G_lf' INT,
    'G_cf' INT,
    'G_rf' INT,
    'G_of' INT,
    'G_dh' INT,
    'G_ph' INT,
    'G_pr' INT
    );
.import Appearances_headless.csv Lahman_Appearances
CREATE TABLE Lahman_AwardsManagers(
    'playerID' TEXT  REFERENCES Lahman_People('playerID'),
    'awardID' TEXT,
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'Tie' TEXT ,
    'Notes' INT
    );
.import AwardsManagers_headless.csv Lahman_AwardsManagers
CREATE TABLE Lahman_AwardsPlayers(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'awardID' TEXT,
    'yearID' YEAR REFERENCES Lahman_People('yearID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'tie' TEXT ,
    'notes' INT
    );
.import AwardsPlayers_headless.csv Lahman_AwardsPlayers
CREATE TABLE Lahman_AwardsShareManagers(
    'awardID' TEXT,
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'pointsWon' INT,
    'pointsMax' INT,
    'votesFirst' INT
    );
.import AwardsShareManagers_headless.csv Lahman_AwardsShareManagers
CREATE TABLE Lahman_AwardsSharePlayers(
    'awardID' TEXT,
    'yearID' YEAR  REFERENCES Lahman_Teams('yearID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'playerID' TEXT REFERENCES Lahman_People('playerID') ,
    'pointsWon' INT,
    'pointsMax' INT,
    'votesFirst' INT
    );
.import AwardsSharePlayers_headless.csv Lahman_AwardsSharePlayers
CREATE TABLE Lahman_Batting(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'stint' INT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'G' INT,
    'AB' FLOAT,
    'R' INT,
    'H' FLOAT,
    'SecondBase' INT,
    'ThirdBase' INT,
    'HR' INT,
    'RBI' INT,
    'SB' INT,
    'CS' INT,
    'BB' INT,
    'SO' INT,
    'IBB' INT,
    'HBP' INT,
    'SH' INT,
    'SF' INT,
    'GIDP' INT
    );
.import Batting_headless.csv Lahman_Batting
CREATE TABLE Lahman_BattingPost(
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'round' INT,
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'G' INT,
    'AB' FLOAT,
    'R' INT,
    'H' FLOAT,
    'SecondBase' INT,
    'ThirdBase' INT,
    'HR' INT,
    'RBI' INT,
    'SB' INT,
    'CS' INT,
    'BB' INT,
    'SO' INT,
    'IBB' INT,
    'HBP' INT,
    'SH' INT,
    'SF' INT,
    'GIDP' INT
    );
.import BattingPost_headless.csv Lahman_BattingPost
CREATE TABLE Lahman_CollegePlaying(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'schoolID' TEXT REFERENCES Lahman_Schools('schoolID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID')
    );
.import CollegePlaying_headless.csv Lahman_CollegePlaying
CREATE TABLE Lahman_Fielding(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'stint' INT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'POS' TEXT,
    'G' INT,
    'GS' INT,
    'InnOuts' INT,
    'PO' INT,
    'A' INT,
    'E' INT,
    'DP' INT,
    'PB' INT,
    'WP' INT,
    'SB' INT,
    'CS' INT,
    'ZR' INT
    );
.import Fielding_headless.csv Lahman_Fielding

CREATE TABLE Lahman_FieldingOF(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'stint' INT,
    'Glf' INT,
    'Gcf' INT,
    'Grf' INT
    );
    
.import FieldingOF_headless.csv Lahman_FieldingOF

CREATE TABLE Lahman_FieldingOFsplit(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'stint' INT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'POS' TEXT,
    'G' INT,
    'GS' INT,
    'InnOuts' INT,
    'PO' INT,
    'A' INT,
    'E' INT,
    'DP' INT,
    'PB' INT,
    'WP' INT,
    'SB' INT,
    'CS' INT,
    'ZR' INT
    );
.import FieldingOFsplit_headless.csv Lahman_FieldingOFsplit

CREATE TABLE Lahman_FieldingPost(
    'playerID' TEXT  REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'round' INT,
    'POS' TEXT,
    'G' INT,
    'GS' INT,
    'InnOuts' INT,
    'PO' INT,
    'A' INT,
    'E' INT,
    'DP' INT,
    'TP' INT,
    'PB' INT,
    'SB' INT,
    'CS' INT
    );
.import FieldingPost_headless.csv Lahman_FieldingPost


CREATE TABLE Lahman_HallOfFame(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearid' YEAR REFERENCES Lahman_Teams('yearID'),
    'votedBy' TEXT,
    'ballots' FLOAT,
    'needed' FLOAT,
    'votes' INT,
    'inducted' TEXT ,
    'category' TEXT,
    'needed_note' TEXT);

.import HallOfFame_headless.csv Lahman_HallOfFame
CREATE TABLE Lahman_HomeGames(
    'year_key' INT REFERENCES Lahman_Teams('yearID'),
    'league_key' TEXT REFERENCES Lahman_Teams('lgIG'),
    'team_key' TEXT REFERENCES Lahman_Teams('teamID'),
    'park_key' TEXT REFERENCES Lahman_Parks('park_key'),
    'span_first' DATE,
    'span_last' DATE,
    'games' INT,
    'openings' INT,
    'attendance' INT
    );
.import HomeGames_headless.csv Lahman_HomeGames

CREATE TABLE Lahman_Managers(
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'inseason' INT,
    'G' INT,
    'W' INT,
    'L' INT,
    'rank' INT,
    'plyrMgr' TEXT
    );

.import Managers_headless.csv Lahman_Managers

CREATE TABLE Lahman_ManagersHalf(
    'playerID' TEXT REFERENCES Lahman_People('PlayerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' INT REFERENCES Lahman_Teams('lgID'),
    'inseason' INT,
    'half' INT,
    'G' INT,
    'W' INT,
    'L' INT,
    'rank' INT
    );

.import ManagersHalf_headless.csv Lahman_ManagersHalf


CREATE TABLE Lahman_Pitching(
    'playerID'  TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'stint' INT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'W' INT,
    'L' INT,
    'G' INT,
    'GS' INT,
    'CG' INT,
    'SHO' INT,
    'SV' INT,
    'IPouts' INT,
    'H' INT,
    'ER' INT,
    'HR' INT,
    'BB' INT,
    'SO' INT,
    'BAOpp' INT,
    'ERA' INT,
    'IBB' INT,
    'WP' INT,
    'HBP' INT,
    'BK' INT,
    'BFP' INT,
    'GF' INT,
    'R' INT,
    'SH' INT,
    'SF' INT,
    'GIDP' INT
    );

.import Pitching_headless.csv Lahman_Pitching

CREATE TABLE Lahman_PitchingPost(
    'playerID'  TEXT REFERENCES Lahman_People('playerID'),
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'round' INT,
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'W' INT,
    'L' INT,
    'G' INT,
    'GS' INT,
    'CG' INT,
    'SHO' INT,
    'SV' INT,
    'IPouts' INT,
    'H' INT,
    'ER' INT,
    'HR' INT,
    'BB' INT,
    'SO' INT,
    'BAOpp' INT,
    'ERA' INT,
    'IBB' INT,
    'WP' INT,
    'HBP' INT,
    'BK' INT,
    'BFP' INT,
    'GF' INT,
    'R' INT,
    'SH' INT,
    'SF' INT,
    'GIDP' INT
    );
.import PitchingPost_headless.csv Lahman_Pitching

CREATE TABLE Lahman_Salaries(
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'playerID' TEXT REFERENCES Lahman_People('playerID'),
    'salary' INT
    );
.import Salaries_headless.csv Lahman_Salaries

CREATE TABLE Lahman_SeriesPost(
    'yearID' YEAR  REFERENCES Lahman_Teams('yearID'),
    'round' TEXT,
    'teamIDwinner' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgIDwinner' TEXT ,
    'teamIDloser' TEXT REFERENCES Lahman_Teams('teamID'),
    'lgIDloser' TEXT,
    'wins' INT,
    'losses' INT,
    'ties' INT
    );
.import SeriesPost_headless.csv Lahman_SeriesPost
CREATE TABLE Lahman_TeamsHalf(
    'yearID' YEAR REFERENCES Lahman_Teams('yearID'),
    'lgID' TEXT REFERENCES Lahman_Teams('lgID'),
    'teamID' TEXT REFERENCES Lahman_Teams('teamID'),
    'Half' INT,
    'divID' TEXT,
    'DivWin' TEXT,
    'Rank' INT,
    'G' INT,
    'W' INT,
    'L' INT
    );
.import TeamsHalf_headless.csv Lahman_TeamsHalf