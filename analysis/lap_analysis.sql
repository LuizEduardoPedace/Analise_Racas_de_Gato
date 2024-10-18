-- Agrupar pelo Peso
WITH lap_div AS (
    SELECT
        lapcat,
        fur,
        ROW_NUMBER() OVER (PARTITION BY lapcat ORDER BY COUNT(fur) DESC) AS rn
    FROM catbreeds
    WHERE 
        lapcat IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY lapcat, fur
), pop_avg AS (
    SELECT 
        lapcat,
        ROUND(AVG(popularityus2017),2) AS avg_pop,
        ROUND(AVG(malewtkg),2) AS avg_weight
        FROM catbreeds
        WHERE 
            lapcat IS NOT NULL AND 
            breedname != 'Chinchilla' AND
            popularityus2017 IS NOT NULL
        GROUP BY lapcat
), trait_div AS (
    SELECT
        lapcat,
        Trait,
        ROW_NUMBER() OVER (PARTITION BY lapcat ORDER BY COUNT(Trait) DESC) AS hn
    FROM cat_all
    WHERE 
        lapcat IS NOT NULL AND 
        breedname != 'Chinchilla'
    GROUP BY lapcat, Trait
)

SELECT
    pop_avg.lapcat,
    avg_pop,
    avg_weight,
    lap_div.fur,
    trait_div.Trait
FROM pop_avg
JOIN lap_div ON lap_div.lapcat = pop_avg.lapcat
JOIN trait_div ON trait_div.lapcat = pop_avg.lapcat
WHERE lap_div.rn = 1 AND trait_div.hn = 1


-- Preço Médio
SELECT
    lapcat,
    ROUND(AVG(avgkittenprice),2) AS avg_price
FROM catbreeds
WHERE lapcat IS NOT NULL AND 
        breedname != 'Chinchilla'
GROUP BY lapcat
