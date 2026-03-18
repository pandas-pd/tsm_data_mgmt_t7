CREATE TYPE inhabitant_state AS ENUM ('friendly', 'evil', 'kidnapped', 'emigrated', '?');
CREATE TYPE inhabitant_gender AS ENUM ('m', 'f', 'd', '?');
CREATE TYPE archive_category AS ENUM ('tool', 'consumeable', 'clothing', 'trinket');

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

CREATE TABLE CollectorArchive (
    entryid SERIAL PRIMARY KEY,
    villageid INTEGER NOT NULL
        REFERENCES Village(villageid),
    personid INTEGER NOT NULL
        REFERENCES Inhabitant(personid),
    category archive_category,
    rarity_score INTEGER NOT NULL CHECK (rarity_score BETWEEN 1 AND 3),
    estimated_value INTEGER NOT NULL,
    recorded_day DATE NOT NULL,
    description TEXT NOT NULL,
    next_entryid INTEGER NULL
        REFERENCES CollectorArchive(entryid)
        DEFAULT NULL
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

INSERT INTO CollectorArchive (villageid, personid, category, rarity_score, estimated_value, recorded_day, description)
VALUES
(3, 11, 'consumeable', 1, 40, '2019-11-03', 'Dried island herbs'),
(3, 14, 'clothing', 1, 115, '2022-05-22', 'Leather smith apron'),
(2, 15, 'clothing', 2, 480, '2024-08-09', 'Fine dealer gloves'),
(3, 13, 'consumeable', 3, 750, '2023-08-30', 'Rare ink vial'),
(2, 8, 'clothing', 2, 390, '2018-09-27', 'Brass-buttoned coat'),
(1, 16, 'clothing', 3, 940, '2020-12-15', 'Deep violet cloak'),
(3, 18, 'tool', 1, 130, '2024-06-20', 'Oversized iron bellows'),
(3, 5, 'trinket', 2, 340, '2020-03-11', 'Tarnished cane grip'),
(2, 6, 'consumeable', 2, 220, '2021-04-19', 'Wax-sealed sausage'),
(2, 19, 'tool', 3, 870, '2021-07-08', 'Engraved butcher cleaver'),
(2, 12, 'trinket', 3, 810, '2022-10-04', 'Amber origin pendant'),
(1, 4, 'trinket', 1, 80, '2018-06-25', 'Carved merchant seal'),
(1, 1, 'consumeable', 1, 60, '2018-02-14', 'Sealed honey jar'),
(3, 17, 'trinket', 1, 95, '2025-02-02', 'Knotted rope token'),
(1, 3, 'consumeable', 2, 175, '2025-01-10', 'Spiced rye loaf'),
(1, 9, 'trinket', 2, 260, '2023-04-17', 'Engraved brass cup'),
(3, 2, 'tool', 2, 310, '2019-03-12', 'Worn blacksmith hammer');