-- Top 10 raças mais baratas
SELECT
    breedname,
    avgkittenprice
FROM catbreeds
WHERE avgkittenprice IS NOT NULL AND breedname != 'Chinchilla'
ORDER BY avgkittenprice
LIMIT 12
-- fur
WITH Top_12_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        fur
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL AND breedname != 'Chinchilla'
    ORDER BY avgkittenprice
    LIMIT 12
)
SELECT
    fur,
    COUNT(breedname)
FROM Top_12_breed
GROUP BY fur
-- weight
WITH Top_12_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        malewtkg
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL AND breedname != 'Chinchilla'
    ORDER BY avgkittenprice
    LIMIT 12
)
SELECT
    ROUND(AVG(malewtkg),1) AS weight_top_12
FROM Top_12_breed
-- Popularity
SELECT
    breedname,
    popularityus2017
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
ORDER BY avgkittenprice
LIMIT 13
-- Temperament
WITH top_12_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        Temperament
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL AND breedname != 'Chinchilla'
    ORDER BY avgkittenprice
    LIMIT 12
)
SELECT 
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait,
    COUNT(breedname) AS count_breed
FROM top_12_breed
GROUP BY Trait
ORDER BY count_breed DESC