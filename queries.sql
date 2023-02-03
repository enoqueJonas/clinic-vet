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

DELETE from animals;

ROLLBACK;

/* ------------------------------------------------------------- */

BEGIN;

DELETE from animals 
    WHERE date_of_birth > '2022/01/01';

SAVEPOINT sp1;

UPDATE animals SET meightk_kg = meightk_kg * -1;

UPDATE animals set meightk_kg = meightk_kg * -1
    WHERE meightk_kg < 0;

COMMIT;

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

/* ------------------------------------------------------------- */

SELECT o.full_name, a.name from animals a
    JOIN owners o on o.id = a.owner_id
        WHERE o.full_name = 'Melody Pond';

SELECT a.name, s.name from animals a
    JOIN species s ON a.species_id = s.id
        WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name from owners o
    LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, count(a.species_id) from species s
    JOIN animals a ON s.id = a.species_id
        GROUP BY s.name;

SELECT a.name, o.full_name from animals a
    JOIN owners o ON a.owner_id = o.id
        JOIN species s ON a.species_id = s.id
            WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name, a.escape_attemps from animals a
    JOIN owners o ON a.owner_id = o.id
        WHERE a.escape_attemps = 0 AND o.full_name = 'Dean Winchester';

SELECT o.full_name, count(a.owner_id) as owns from owners o
    JOIN animals a ON o.id = a.owner_id
        GROUP by o.full_name
            HAVING MAX(a.owner_id) = 3;

/* ------------------------------------------------------------- */

SELECT a.name from animals a 
    JOIN visits v ON a.id = v.animal_id
    JOIN vets ve ON v.vet_id = ve.id
        WHERE v.date_of_visit = (SELECT MAX(date_of_visit) from visits 
                                    WHERE vet_id = (SELECT id from vets 
                                                        WHERE name = 'William Tatcher'));       

SELECT count(*) from visits
    WHERE vet_id = (SELECT id from vets WHERE name = 'Stephie Mendez');

SELECT v.name, s.name from vets v
    FULL JOIN specializations sp ON v.id = sp.vet_id
    FULL JOIN species s ON sp.species_id = s.id;

SELECT a.name from animals a
    JOIN visits v ON a.id = v.animal_id
    JOIN vets ve ON v.vet_id = ve.id
        WHERE ve.name = 'Stephie Mendez' AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-10-30';

SELECT a.name, count(*) from visits v
    JOIN animals a ON v.animal_id = a.id
    GROUP by a.name
    ORDER BY count(*) desc LIMIT 1;
    
SELECT min(v.date_of_visit), v.animal_id from visits v
    WHERE v.vet_id = (SELECT id from vets WHERE name = 'Maisy Smith')
    GROUP by v.animal_id
    ORDER BY min(v.date_of_visit) asc
    LIMIT 1;

SELECT ve.name, a.name, v.date_of_visit from vets ve
    JOIN visits v ON ve.id = v.vet_id
    JOIN animals a ON v.animal_id = a.id
    WHERE v.date_of_visit = (SELECT max(date_of_visit) from visits);

SELECT count(*) from visits v
    JOIN vets ve On v.vet_id = ve.id
    WHERE v.vet_id = (SELECT distinct ve.id from vets ve
                        WHERE not exists (
                            SELECT vet_id from specializations
                                WHERE vet_id = ve.id
                        ));

SELECT count(v.animal_id), s.name from visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN species s ON a.species_id = s.id
    WHERE v.vet_id = (SELECT id from vets WHERE name = 'Maisy Smith')
    GROUP BY s.name, v.vet_id
    ORDER By count(v.animal_id) desc LIMIT 1;

SELECT COUNT(*) FROM visits
WHERE vet_id NOT IN (SELECT vet_id FROM specializations
WHERE species_id = (SELECT species_id FROM animals
WHERE id = visits.animal_id));