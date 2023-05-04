/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23), (2, 'Gabumon', '2018-11-15', 2, true, 8), (3, 'Pikachu', '2021-01-07', 1, false, 15.04), (4, 'Devimon', '2017-05-12', 5, true, 11);

/* Project day 2 */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, false, 11), (6, 'Plantmon', '2021-11-15', 2, true, 5.7), (7, 'Squirtle', '1993-04-02', 3, false, 12.13), (8, 'Angemon', '2005-06-12', 1, true, 45), (9, 'Boarmon', '2005-06-07', 7, true, 20.04), (10, 'Blossom', '1998-10-13', 3, true, 17), (11, 'Ditto', '2022-05-14', 4, true, 22);

/* Project Day 3 */

/*// Insert the following data into the owners table:*/
INSERT INTO owners (id, full_name, age) VALUES (1, 'Sam Smith', 34), (2, 'Jennifer Orwell', 19), (3, 'Bob', 45), (4, 'Melody Pond', 77), (5, 'Dean Winchester', 14), (6, 'Jodie Whittaker', 38);

/*// Insert the following data into the species table:*/
INSERT INTO species (id, name) VALUES (1, 'Sam Smith'), (2, 'Sam Smith');

/*// Modify your inserted animals so it includes the species_id value:*/
/*// 1 If the name ends in "mon" it will be Digimon*/
UPDATE animals SET species_id = species.id from species WHERE animals.name like '%mon' AND species.name = 'Digimon';

/*// 2 All other animals are Pokemon*/
UPDATE animals SET species_id = species.id from species WHERE animals.name NOT LIKE '%mon' AND species.name = 'Pokemon';

/*// Modify your inserted animals to include owner information (owner_id):*/
/*// 1 Sam Smith owns Agumon:*/
UPDATE animals SET owner_id = owners.id from owners WHERE animals.name = 'Agumon' AND owners.full_name = 'Sam Smith';

/*// 2 Jennifer Orwell owns Gabumon and Pikachu.*/
UPDATE animals SET owner_id = owners.id from owners WHERE animals.name = 'Pikachu' OR animals.name = 'Gabumon' AND owners.full_name = 'Jennifer Orwell';

/*// 3 Bob owns Devimon and Plantmon.*/
UPDATE animals SET owner_id = owners.id from owners WHERE animals.name = 'Devimon' OR animals.name = 'Plantmon' AND owners.full_name = 'Bob';

/*// 4 Melody Pond owns Charmander, Squirtle, and Blossom.*/
UPDATE animals SET owner_id = owners.id from owners WHERE animals.name = 'Charmander' OR animals.name = 'Squirtle' OR animals.name = 'Blossom' AND owners.full_name = 'Melody Pond';

/*/ 5 Dean Winchester owns Angemon and Boarmon.*/
UPDATE animals SET owner_id = owners.id from owners WHERE animals.name = 'Angemon' OR animals.name = 'Boarmon' AND owners.full_name = 'Dean Winchester';