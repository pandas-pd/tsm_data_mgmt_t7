CREATE TYPE inhabitant_state AS ENUM ('friendly', 'evil', 'kidnapped', 'emigrated', '?');
CREATE TYPE inhabitant_gender AS ENUM ('m', 'f', 'd', '?');

CREATE TABLE Village (
    villageid SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    chief INTEGER NOT NULL
);

CREATE TABLE Inhabitant (
    personid SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    villageid INTEGER NOT NULL
        REFERENCES Village(villageid),
    gender inhabitant_gender,
    job TEXT NOT NULL,
    gold INTEGER,
    state inhabitant_state
);

CREATE TABLE Item (
    item TEXT NOT NULL,
    owner INTEGER
);

INSERT INTO Village (name, chief)
VALUES
('Monkeycity', 1),
('Cucumbertown', 6),
('Onionville',13);

INSERT INTO Inhabitant (name, villageid, gender, job, gold, state)
VALUES
('Paul Bakerman', 1, 'm', 'baker', 850, 'friendly'),
('Ernest Perry', 3, 'm', 'weaponsmith', 280, 'friendly'),
('Rita Ox', 1, 'f', 'baker', 350, 'friendly'),
('Carl Ox', 1, 'm', 'merchant', 250, 'friendly'),
('Dirty Dieter', 3, 'm', 'smith', 650, 'evil'),
('Gerry Slaughterer', 2, 'm', 'butcher', 4850, 'evil'),
('Peter Slaughterer', 3, 'm', 'butcher', 3250, 'evil'),
('Arthur Tailor', 2, 'm', 'pilot', 490, 'kidnapped'),
('Tiffany Drummer', 1, 'f', 'baker', 550, 'evil'),
('Peter Drummer', 1, 'm', 'smith', 600, 'friendly'),
('Dirty Diane', 3, 'f', 'farmer', 10, 'evil'),
('Otto Alexander', 2, 'm', 'dealer', 680, 'friendly'),
('Fred Dix', 3, 'm', 'author', 420, 'friendly'),
('Enrico Carpenter', 3, 'm', 'weaponsmith', 510, 'evil'),
('Helen Grasshead', 2, 'f', 'dealer', 680, 'friendly'),
('Ivy Hatter', 1, 'f', 'dealer', 770, 'evil'),
('Edward Grasshead', 3, 'm', 'butcher', 990, 'friendly'),
('Ryan Horse', 3, 'm', 'blacksmith', 390, 'friendly'),
('Ann Meaty', 2, 'f', 'butcher', 2280, 'friendly');

INSERT INTO Item (item, owner)
VALUES
('teapot', NULL),
('cane', 5),
('hammer', 2),
('ring', NULL),
('coffee cup', NULL),
('bucket', NULL),
('rope', 17),
('carton', NULL),
('lightbulb', NULL);