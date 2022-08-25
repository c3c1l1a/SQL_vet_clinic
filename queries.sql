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









