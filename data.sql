/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23),
			 ('Gabumon', '2018-11-15', 2, TRUE, 8),
			 ('Pikachu', '2021-1-7', 1, FALSE, 15.04),
			 ('Devimon', '2017-05-12', 5, TRUE, 11 );


/* Add more data*/
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, FALSE, -11),
			 ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
			 ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
			 ('Angemon', '2005-06-12', 1, TRUE, -45),
			 ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
			 ('Blossom', '1998-10-13', 3, TRUE, 17), 
			 ('Ditto', '2022-05-14', 4, TRUE, 22);


/* Add data in Owners table */
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
			 ('Jennifer Orwell', 19), 
			 ('Bob', 45),
			 ('Melody Pond', 77), 
			 ('Dean Winchester', 14),
			 ('Jodie Whittaker', 38);

/* Add data to species table */
INSERT INTO species (name)
VALUES ('Pokemon'), 
			 ('Digimon');

/* Update the species_id in the animals table*/
BEGIN;
UPDATE animals
SET species_id = digimon.id
FROM (SELECT id FROM species WHERE species.name='Digimon') AS digimon
WHERE animals.name LIKE '%mon';
SELECT * from animals;
COMMIT;

BEGIN;
UPDATE animals
SET species_id = pokemon.id 
FROM (SELECT id FROM species WHERE species.name='Pokemon') AS pokemon
WHERE animals.name NOT LIKE '%mon';
SELECT * from animals;
COMMIT;

/* Update the owner_id in the animals table */
BEGIN;
UPDATE animals 
SET owners_id = sam.id
FROM (SELECT id from owners WHERE owners.full_name='Sam Smith') AS sam
WHERE animals.name='Agumon';
SELECT * FROM animals;

UPDATE animals
SET owners_id = jenifer.id 
FROM (SELECT id from owners WHERE owners.full_name='Jennifer Orwell') AS jenifer
WHERE animals.name = 'Gabumon' OR animals.name='Pikachu';
SELECT * FROM animals;

UPDATE animals
SET owners_id = bob.id 
FROM (SELECT id FROM owners WHERE owners.full_name='Bob') AS bob
WHERE animals.name = 'Devimon' OR animals.name='Plantmon';
SELECT * FROM animals;

UPDATE animals
SET owners_id = melody.id 
FROM (SELECT id FROM owners WHERE owners.full_name='Melody Pond') as melody
WHERE animals.name = 'Charmander' OR animals.name='Squirtle' OR animals.name='Blossom';
SELECT * FROM animals;

UPDATE animals 
SET owners_id = dean.id 
FROM (SELECT id FROM owners WHERE owners.full_name='Dean Winchester') as dean
WHERE animals.name = 'Angemon' OR animals.name = 'Boarmon';
SELECT * from animals;

COMMIT;








