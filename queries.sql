/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';

SELECT name from animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT name from animals WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/* Project Day 2 */

UPDATE animals SET species = 'unspecified';

ROLLBACK;

UPDATE animals SET species = 'digimon' WHERE name like '%mon';

UPDATE animals SET species = 'pokemon' WHERE species is NULL;

DELETE FROM animals;

rollback;

SELECT * FROM animals;

DELETE FROM animals WHERE date_of_birth >= '2022-01-01';

SAVEPOINT first_savepoint;

UPDATE animals SET weight_kg = weight_kg*-1;

ROLLBACK TO SAVEPOINT first_savepoint;

UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;

COMMIT;

SELECT count(animals) FROM animals;

SELECT count(animals) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;

SELECT MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-12-31' AND date_of_birth <= '2000-01-01' GROUP BY species;