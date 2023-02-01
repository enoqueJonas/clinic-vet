/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals 
    WHERE name like '%mon';

SELECT name from animals 
    WHERE EXTRACT('Year' from date_of_birth) BETWEEN 2016 AND 2019;

SELECT name from animals 
    WHERE neutered = true AND escape_attemps < 3;

SELECT date_of_birth from animals 
    WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attemps from animals 
    WHERE weight_kg > 10.5;

SELECT * from animals 
    WHERE neutered = true;

SELECT * from animals 
    WHERE name != 'Gabumon';

SELECT * from animals 
    WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* ------------------------------------------------------------- */
BEGIN;

UPDATE animals set species = 'unspecified';

select * from animals;

ROLLBACK;

/* ------------------------------------------------------------- */

BEGIN;

UPDATE animals set species = 'digimon'
    WHERE name like '%mon';

UPDATE animals set species = 'pokemon'
    WHERE species is NULL;

COMMIT;

/* ------------------------------------------------------------- */

SELECT count(*) from animals;

SELECT count(escape_attemps) from animals
    WHERE escape_attemps = 0;

SELECT AVG(meightk_kg) from animals;

SELECT neutered, count(escape_attemps) from animals
    GROUP BY neutered;

SELECT species, MAX(meightk_kg), MIN(meightk_kg) from animals
    GROUP BY species;

SELECT species, AVG(escape_attemps) from animals
    WHERE EXTRACT('Year' from date_of_birth) BETWEEN 1990 AND 2000
    GROUP BY species;