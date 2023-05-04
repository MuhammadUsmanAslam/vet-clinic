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
SELECT owners.full_name, COUNT(animals.id) AS AnimalCount FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.id ORDER BY AnimalCount DESC LIMIT 1;

/* Project Day 4 */
/* 1 Who was the last animal seen by William Tatcher? */
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.visited_date DESC lIMIT 1;

/* 2 How many different animals did Stephanie Mendez see? */
SELECT vets.name, count(animals.name) FROM animals 
  JOIN visits on visits.animal_id = animals.id
  JOIN vets on vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name;

/* 3 List all vets and their specialties, including vets with no specialties. */
SELECT vets.name, species.name FROM vets
  LEFT JOIN specializations on specializations.vet_id = vets.id
  LEFT JOIN species on specializations.species_id = species.id;

/* 4 List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name, vets.name, visits.visited_date FROM animals 
  JOIN visits on visits.animal_id = animals.id
  JOIN vets on vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez'
    AND visits.visited_date
    BETWEEN '2020-04-01' AND '2020-08-30';

/* 5 What animal has the most visits to vets? */
SELECT animals.name, count(*) FROM animals
  JOIN visits on visits.animal_id = animals.id
  GROUP BY animals.name
  ORDER BY count desc limit 1;

/* 6 Who was Maisy Smith's first visit? */
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  WHERE vets.name = 'Maisy SMith'
  ORDER BY visits.visited_date ASC lIMIT 1;

/* 7 Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name, vets.name, visits.visited_date FROM animals
  JOIN visits on animals.id = visits.animal_id
  JOIN vets on visits.vet_id = vets.id
  ORDER BY visits.visited_date DESC lIMIT 1;

/* 8 How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(*) FROM vets 
  JOIN visits ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specializations ON vets.id = specializations.vet_id
  WHERE NOT specializations.species_id = animals.species_id;

/* 9 What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT vets.name, species.name, count(species.name) from vets 
  JOIN visits on visits.vet_id = vets.id 
  JOIN animals on visits.animal_id = animals.id 
  JOIN species on animals.species_id = species.id 
  WHERE vets.name = 'Maisy SMith' 
  GROUP BY species.name, vets.name 
  ORDER BY count DESC lIMIT 1;