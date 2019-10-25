--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY, 
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY, 
	emailAddress varchar(50) NOT NULL,
	name varchar(50),
	cash integer,
	location integer
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID), 
	playerID integer REFERENCES Player(ID),
	score integer
	);

CREATE TABLE Property {
	ID integer PRIMARY KEY,
	name text,
	houses integer,
	hotels integer,
	ownerID integer
}


-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

-- -- Retrieve a list of all the games, ordered by date with the most recent game coming first. 
-- SELECT * FROM Game ORDER BY time DESC
-- -- Retrieve all the games that occurred in the past week.
-- SELECT * FROM Game WHERE time + interval '7 days' > CURRENT_TIMESTAMP
-- -- Retrieve a list of players who have (non-NULL) names.
-- SELECT * FROM Player WHERE name is NOT NULL
-- -- Retrieve a list of IDs for players who have some game score larger than 2000.
-- SELECT playerID FROM PlayerGame WHERE score > 2000
-- -- Retrieve a list of players who have GMail accounts.
-- SELECT * FROM Player WHERE emailAddress LIKE '%gmail%'


-- -- Retrieve all “The King”’s game scores in decreasing order.
-- SELECT score FROM Player, PlayerGame WHERE Player.ID = PlayerGame.playerID AND Player.name = 'The King'
-- -- Retrieve the name of the winner of the game played on 2006-06-28 13:20:00.
-- SELECT Player.name FROM Player, PlayerGame, Game WHERE Game.ID = PlayerGame.gameID AND Game.time = '2006-06-28 13:20:00' ORDER BY PlayerGame.score DESC LIMIT 1
-- -- So what does that P1.ID < P2.ID clause do in the last example query?
-- It compares two player IDs. Since there are two of the same type, they were given the names P1 and P2.
-- -- The query that joined the Player table to itself seems rather contrived. Can you think of a realistic situation in which you’d want to join a table to itself?
-- This could be a way to remove duplicate entries from a table.

