/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR (100),
    date_of_birth DATE NOT NULL, 
    escape_attempts INT,
    neutered BOOL NOT NULL,
    weight_kg REAL NOT NULL,
    PRIMARY KEY(id)
);

/* Add species column*/
ALTER TABLE animals ADD species VARCHAR;

/* Owners table */
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR NOT NULL,
    age INT,
    PRIMARY KEY(id)
);

/* Species table */
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    PRIMARY KEY(ID)
);

/* Modify animals table */
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals 
ADD CONSTRAINT species_id
FOREIGN KEY(species_id)
REFERENCES species(id)
ON DELETE CASCADE; 

ALTER TABLE animals ADD owners_id INT;
ALTER TABLE animals
ADD CONSTRAINT owners_constaint
FOREIGN KEY(owners_id)
REFERENCES owners(id)
ON DELETE CASCADE;







