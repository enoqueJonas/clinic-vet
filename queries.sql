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
