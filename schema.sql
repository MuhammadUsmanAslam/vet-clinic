/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (id integer, name varchar(100), date_of_birth date, escape_attempts integer, neutered boolean, weight_kg decimal, PRIMARY KEY(id));

/* Alter Animals Table */
ALTER TABLE animals ADD species varchar(100);

/* Project Day 3 */

/*// create owners table:*/
CREATE TABLE owners (id int, full_name varchar(100), age int, PRIMARY KEY(id));

/*// Create species table:*/
CREATE TABLE species (id int, name varchar(100), PRIMARY KEY(id));

/*// Modify animals table:*/

/*// Remove column species*/
ALTER TABLE animals DROP COLUMN species;

/*// Add column species_id which is a foreign key referencing species table*/
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);

/*// Add column owner_id which is a foreign key referencing the owners table*/
ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);


/* Project Day 4 */
/* 1 Create a table named vets with the following columns: */
CREATE TABLE vets (id INT Generated ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR(100), age INT, date_of_graduation DATE);

/* 2 Create a "join table" called specializations to handle this relationship. */
CREATE TABLE specializations (species_id INT CONSTRAINT fk_specializations_species_id REFERENCES species(id), vet_id INT CONSTRAINT fk_vet_id REFERENCES vets(id));

/* 3 Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */
CREATE TABLE visits (animal_id INT CONSTRAINT fk_animal_id REFERENCES animals(id), vet_id INT CONSTRAINT fk_visits_vet_id REFERENCES vets(id), visited_date date NOT NULL DEFAULT CURRENT_DATE);