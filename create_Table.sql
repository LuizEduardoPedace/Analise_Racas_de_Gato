CREATE DATABASE pet_Analysis;
 
CREATE TABLE CatBreeds (
    BreedName VARCHAR(100),
    AltBreedName VARCHAR(100),
    LapCat VARCHAR(20),
    Fur VARCHAR(20),
    MaleWtKg DECIMAL(5,2),
    Temperament TEXT,
    AvgKittenPrice DECIMAL(10,2),
    MalaysiaPopularity INT,
    PopularityUS2017 INT
);

/*
\copy CatBreeds FROM 'C:/Users/pedac/OneDrive/Documentos/Projects for Data Science/pet_Analysis/cat/cat_breed_characteristics.csv' DELIMITER ',' CSV HEADER;
*/

CREATE TABLE cat_all AS 
SELECT
    breedname,
    lapcat,
    fur,
    malewtkg,
    temperament,
    avgkittenprice,
    popularityus2017,
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait
FROM catbreeds
WHERE breedname != 'Chinchilla'