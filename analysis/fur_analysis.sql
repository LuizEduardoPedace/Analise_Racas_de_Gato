-- Agrupar pelo Pelo
WITH lap_div AS (
    SELECT
        fur,
        lapcat,
        ROW_NUMBER() OVER (PARTITION BY fur ORDER BY COUNT(lapcat) DESC) AS gn
    FROM catbreeds
    WHERE 
        fur IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY fur, lapcat
), pop_avg AS (
    SELECT 
        fur,
        ROUND(AVG(popularityus2017),2) AS avg_pop,
        ROUND(AVG(malewtkg),2) AS avg_weight
        FROM catbreeds
        WHERE 
            fur IS NOT NULL AND 
            breedname != 'Chinchilla' AND
            popularityus2017 IS NOT NULL
        GROUP BY fur
), trait_div AS (
    SELECT
        fur,
        Trait,
        ROW_NUMBER() OVER (PARTITION BY fur ORDER BY COUNT(Trait) DESC) AS hn
    FROM cat_all
    WHERE 
        fur IS NOT NULL AND 
        breedname != 'Chinchilla'
    GROUP BY fur, Trait
)

SELECT
    pop_avg.fur,
    avg_pop,
    lap_div.lapcat,
    avg_weight,
    Trait
FROM pop_avg
JOIN lap_div ON lap_div.fur = pop_avg.fur
JOIN trait_div ON trait_div.fur = pop_avg.fur
WHERE lap_div.gn = 1 AND trait_div.hn = 1


-- Preço Médio
SELECT
    fur,
    ROUND(AVG(avgkittenprice),2) AS avg_price
FROM catbreeds
WHERE fur IS NOT NULL AND 
        breedname != 'Chinchilla'
GROUP BY fur
