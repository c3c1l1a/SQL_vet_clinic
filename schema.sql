/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name varchar(100),
    date_of_birth date, 
    escape_attempts integer,
    neutered bool,
    weight_kg real,
);
