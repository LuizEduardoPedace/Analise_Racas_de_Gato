-- Menos populares
SELECT
    breedname,
    popularityus2017
FROM catbreeds
WHERE popularityus2017 IS NOT NULL
ORDER BY popularityus2017 DESC
LIMIT 10
-- Price
WITH bot_pop AS (
    SELECT
        breedname,
        popularityus2017,
        avgkittenprice
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017 DESC
    LIMIT 11
)
SELECT ROUND(AVG(avgkittenprice),2)
FROM bot_pop
-- Fur
WITH bot_pop AS (
    SELECT
        breedname,
        popularityus2017,
        fur
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017 DESC
    LIMIT 11
)
SELECT fur, COUNT(breedname)
FROM bot_pop
GROUP BY fur
-- Lap
WITH bot_pop AS (
    SELECT
        breedname,
        popularityus2017,
        lapcat
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017 DESC
    LIMIT 11
)
SELECT lapcat, COUNT(breedname)
FROM bot_pop
GROUP BY lapcat
-- Weight
WITH bot_pop AS (
    SELECT
        breedname,
        popularityus2017,
        malewtkg
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017 DESC
    LIMIT 11
)
SELECT ROUND(AVG(malewtkg),2)
FROM bot_pop
-- Temperamento
WITH bot_pop AS (
    SELECT
        breedname,
        popularityus2017,
        Temperament
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017 DESC
    LIMIT 11
)
SELECT
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait, 
    COUNT(breedname) AS count
FROM bot_pop
GROUP BY Trait
ORDER BY count DESC
LIMIT 12