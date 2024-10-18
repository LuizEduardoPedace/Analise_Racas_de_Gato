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




-- Média de preço x pelo
SELECT
    fur,
    SUM(avgkittenprice) AS sum_fur
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
GROUP BY fur
ORDER BY sum_fur DESC

-- Média de preço x lap
SELECT
    lapcat,
    SUM(avgkittenprice) AS sum_lap
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
GROUP BY lapcat
ORDER BY sum_lap DESC

-- Média de preço x peso
SELECT
    malewtkg,
    SUM(avgkittenprice) AS sum_weight
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
GROUP BY malewtkg
ORDER BY sum_weight DESC

-- Traços x Lap
SELECT 
    Trait,
    ROUND(count_Lap::NUMERIC/(count_Lap + count_Non_Lap)::NUMERIC,2) AS lap_percentage,
    ROUND(count_Non_Lap::NUMERIC/(count_Lap + count_Non_Lap)::NUMERIC,2) AS non_lap_percentage
FROM (
    SELECT 
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait, 
    SUM(CASE WHEN lapcat = 'Lap' THEN 1 ELSE 0 END) AS count_Lap,
    SUM(CASE WHEN lapcat = 'Non Lap' THEN 1 ELSE 0 END) AS count_Non_Lap
    FROM CatBreeds
    GROUP BY Trait
)
WHERE count_Lap + count_Non_Lap > 4
ORDER BY lap_percentage DESC

-- Traços x pelo
SELECT 
    Trait,
    ROUND(count_short_fur::NUMERIC/(count_long_fur+count_medium_fur+count_short_fur)::NUMERIC,2) AS short_fur_Avg,
    ROUND(count_medium_fur::NUMERIC/(count_long_fur+count_medium_fur+count_short_fur)::NUMERIC,2) AS short_medium_Avg,
    ROUND(count_long_fur::NUMERIC/(count_long_fur+count_medium_fur+count_short_fur)::NUMERIC,2) AS short_long_Avg

FROM (
    SELECT 
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait, 
    SUM(CASE WHEN fur = 'Short' THEN 1 ELSE 0 END) AS count_short_fur,
    SUM(CASE WHEN fur = 'Medium' THEN 1 ELSE 0 END) AS count_medium_fur,
    SUM(CASE WHEN fur = 'Long' THEN 1 ELSE 0 END) AS count_long_fur
    FROM CatBreeds
    GROUP BY Trait
)
WHERE count_long_fur + count_medium_fur + count_short_fur > 4
ORDER BY short_long_Avg DESC

-- Média de preço por temperamento
WITH TraitSplit AS (
    SELECT
        BreedName,
        UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait,
        AvgKittenPrice,
        malewtkg,
        popularityus2017
    FROM CatBreeds
)
SELECT
    Trait,
    ROUND(AVG(AvgKittenPrice),2) AS AvgPrice,
    ROUND(AVG(malewtkg),2) AS AvgWeight,
    ROUND(AVG(popularityus2017),2) AS AvgPopularity
FROM TraitSplit
GROUP BY Trait
HAVING COUNT(Trait) > 4
ORDER BY AvgPrice DESC;
