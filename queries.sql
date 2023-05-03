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
BEGIN;

UPDATE animals SET species = 'unspecified';

ROLLBACK;

UPDATE animals SET species = 'digimon' WHERE name like '%mon';

UPDATE animals SET species = 'pokemon' WHERE species is NULL;

BEGIN;

DELETE FROM animals;

rollback;

SELECT * FROM animals;

BEGIN;

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

/* Project Day 3 */

/*// Write queries (using JOIN) to answer the following questions:*/

/*// 1 What animals belong to Melody Pond?*/
SELECT animals.name FROM owners INNER JOIN animals ON animals.owner_id=owners.id AND owners.full_name = 'Melody Pond';

/*// 2 List of all animals that are pokemon (their type is Pokemon).*/
SELECT animals.name FROM species INNER JOIN animals ON animals.species_id=species.id AND species.name = 'Pokemon';

/*// 3 List all owners and their animals, remember to include those that don't own any animal.*/
SELECT animals.name, owners.full_name FROM animals RIGHT JOIN owners ON animals.owner_id=owners.id;

/*// 4 How many animals are there per species?*/
SELECT species.name, COUNT(animals.id) AS total_animals FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

/*// 5 List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name AS AnimalName, species.name AS SpeciesName, owners.full_name AS OwnerName FROM animals INNER JOIN species ON animals.species_id = species.id INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name='Jennifer Orwell' AND species.name= 'Digimon';


/*// 6 List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name, owners.full_name, animals.escape_attempts FROM animals INNER JOIN owners ON animals.owner_id=owners.id INNER JOIN species ON animals.species_id=species.id WHERE escape_attempts=0 AND owners.full_name='Dean Winchester';

/*// 7 Who owns the most animals?*/
SELECT owners.full_name, COUNT(animals.id) AS AnimalCount FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.id ORDER BY animal_count DESC LIMIT 1;
