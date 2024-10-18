-- Mais populares
SELECT
    breedname,
    popularityus2017
FROM catbreeds
WHERE popularityus2017 IS NOT NULL
ORDER BY popularityus2017
LIMIT 11
-- Price
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        avgkittenprice
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT ROUND(AVG(avgkittenprice),2)
FROM top_pop
-- Fur
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        fur
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT fur, COUNT(breedname)
FROM top_pop
GROUP BY fur
-- Lap
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        lapcat
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT lapcat, COUNT(breedname)
FROM top_pop
GROUP BY lapcat
-- Weight
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        malewtkg
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT ROUND(AVG(malewtkg),2)
FROM top_pop
-- Temperamento
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        Temperament
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait, 
    COUNT(breedname) AS count
FROM top_pop
GROUP BY Trait
ORDER BY count DESC
LIMIT 15