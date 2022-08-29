/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg>10.5;
SELECT * from animals WHERE neutered=TRUE;
SELECT * from animals WHERE name!='Ganumon';
SELECT * from animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;


/* ====Transaction 1====*/
BEGIN;
UPDATE animals 
SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
/* ====End Transaction 1====*/


/* ====Transaction 2====*/
BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';
UPDATE animals 
SET species='pokemon'
WHERE name NOT LIKE '%mon'; 
COMMIT;
SELECT * FROM animals;
/* ====End Transaction 2====*/


/* ====Transaction 3====*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
/* ====End Transaction 3====*/

/* ====Transaction 4====*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg<0;
SELECT * FROM animals;
COMMIT;
/* ====Transaction 4====*/


/* Aggregates */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals GROUP BY escape_attempts HAVING escape_attempts=0;
SELECT AVG(weight_kg) from animals;
SELECT neutered, SUM(escape_attempts) AS escape_attempts from animals GROUP BY neutered;
SELECT species, Min(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) as avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-1-1' GROUP by species;

/* Queries to multiple tables */
SELECT melody.full_name AS owner, animals.name AS animal 
FROM (SELECT full_name, id FROM owners WHERE full_name='Melody Pond') as melody
LEFT JOIN animals ON animals.owners_id = melody.id;


SELECT pokemon.name AS species_type, animals.name as animal
FROM (SELECT name, id FROM species WHERE species.name = 'Pokemon') as pokemon
LEFT JOIN animals ON animals.species_id = pokemon.id;

SELECT owners.full_name as owners, animals.name as animal
FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT species.name as species_name, animals_aggr.count
FROM (SELECT species_id, COUNT(*) AS count FROM animals GROUP BY species_id) AS animals_aggr
LEFT JOIN species ON  animals_aggr.species_id = species.id;

SELECT jenifer.full_name, digimon.name AS species_type, animals.name AS animal_name
FROM animals
INNER JOIN (SELECT full_name, id FROM owners WHERE owners.full_name='Jennifer Orwell') AS jenifer
ON animals.owners_id = jenifer.id
INNER JOIN (SELECT name, id FROM species WHERE species.name = 'Digimon') AS digimon 
ON animals.species_id=digimon.id;

SELECT animal_name, owner, escape_attempts
From (SELECT animals.name as animal_name, dean.full_name as owner, animals.escape_attempts as escape_attempts
FROM animals
INNER JOIN (SELECT full_name, id FROM owners WHERE owners.full_name='Dean Winchester') as dean
ON animals.owners_id = dean.id) AS deans_animals
WHERE escape_attempts = 0;


SELECT T.full_name, t.number_of_animals
FROM (SELECT owners.full_name, animal_count.number_of_animals
FROM owners
LEFT JOIN (SELECT owners_id, COUNT(*) AS number_of_animals FROM animals GROUP BY owners_id) AS animal_count
ON owners.id = animal_count.owners_id) as T;







