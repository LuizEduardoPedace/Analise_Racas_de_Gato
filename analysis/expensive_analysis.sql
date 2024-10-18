-- Top 10 raças mais caras
SELECT
    breedname,
    avgkittenprice
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
ORDER BY avgkittenprice DESC
LIMIT 10
-- fur
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        fur
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    fur,
    COUNT(breedname)
FROM Top_10_breed
GROUP BY fur
-- weight
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        malewtkg
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    ROUND(AVG(malewtkg),1) AS weight_top_10
FROM Top_10_breed
-- Popularity
SELECT
    breedname,
    popularityus2017
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
ORDER BY avgkittenprice DESC
LIMIT 10
-- Temperament
WITH top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        Temperament
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT 
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait,
    COUNT(breedname) AS count_breed
FROM top_10_breed
GROUP BY Trait
ORDER BY count_breed DESC
LIMIT 12
-- Lap
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        lapcat
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    lapcat,
    COUNT(breedname)
FROM Top_10_breed
GROUP BY lapcat