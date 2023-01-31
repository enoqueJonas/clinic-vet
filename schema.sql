/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id int NOT NULL PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attemps int,
    neutered boolean,
    weight_kg decimal,
    species varchar(100) 
);
