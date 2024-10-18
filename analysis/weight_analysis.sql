-- Agrupar pelo Peso
WITH weight_div AS (
    SELECT
        malewtkg,
        fur,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(fur) DESC) AS rn
    FROM catbreeds
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY malewtkg, fur
    ORDER BY malewtkg DESC
), lap_div AS (
    SELECT
        malewtkg,
        lapcat,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(lapcat) DESC) AS gn
    FROM catbreeds
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY malewtkg, lapcat
    ORDER BY malewtkg DESC
), pop_avg AS (
    SELECT 
        malewtkg,
        ROUND(AVG(popularityus2017),2) AS avg_pop
        FROM catbreeds
        WHERE 
            malewtkg IS NOT NULL AND 
            breedname != 'Chinchilla' AND
            popularityus2017 IS NOT NULL
        GROUP BY malewtkg
), trait_div AS (
    SELECT
        malewtkg,
        Trait,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(Trait) DESC) AS hn
    FROM cat_all
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla'
    GROUP BY malewtkg, Trait
    ORDER BY malewtkg DESC
)

SELECT
    pop_avg.malewtkg,
    avg_pop,
    lap_div.lapcat,
    weight_div.fur,
    trait_div.Trait
FROM pop_avg
JOIN weight_div ON weight_div.malewtkg = pop_avg.malewtkg
JOIN lap_div ON lap_div.malewtkg = pop_avg.malewtkg
JOIN trait_div ON trait_div.malewtkg = pop_avg.malewtkg
WHERE weight_div.rn = 1 AND lap_div.gn = 1 AND trait_div.hn = 1
ORDER BY pop_avg.malewtkg DESC


-- Preço Médio
SELECT
    malewtkg,
    ROUND(AVG(avgkittenprice),2) AS avg_price
FROM catbreeds
WHERE malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla'
GROUP BY malewtkg
ORDER BY malewtkg DESC