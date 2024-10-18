-- Preço Médio
SELECT
    Trait,
    ROUND(AVG(avgkittenprice),2) AS avg_price
FROM cat_all
GROUP BY Trait
HAVING COUNT(breedname) > 1
ORDER BY avg_price DESC


-- Popularidade
SELECT 
    Trait,
    ROUND(AVG(popularityus2017),2) AS avg_pop    
FROM cat_all
WHERE 
    malewtkg IS NOT NULL AND 
    popularityus2017 IS NOT NULL
GROUP BY Trait
HAVING COUNT(breedname) > 1
ORDER BY avg_pop


-- Peso
SELECT 
    Trait,
    ROUND(AVG(malewtkg),2) AS avg_weight
FROM cat_all
WHERE 
    malewtkg IS NOT NULL AND 
    popularityus2017 IS NOT NULL
GROUP BY Trait
HAVING COUNT(breedname) > 1
ORDER BY avg_weight DESC

-- Fur
SELECT
    fur,
    COUNT(Trait)
FROM (SELECT 
    Trait,
    fur,
    ROW_NUMBER() OVER (PARTITION BY Trait ORDER BY COUNT(fur) DESC) AS fn
FROM cat_all
WHERE fur IS NOT NULL
GROUP BY Trait, fur
HAVING COUNT(breedname) > 1)
WHERE fn = 1
GROUP BY fur


-- Lap
SELECT
    lapcat,
    COUNT(Trait)
FROM (SELECT 
    Trait,
    lapcat,
    ROW_NUMBER() OVER (PARTITION BY Trait ORDER BY COUNT(lapcat) DESC) AS fn
FROM cat_all
WHERE lapcat IS NOT NULL
GROUP BY Trait, lapcat
HAVING COUNT(breedname) > 1)
WHERE fn = 1
GROUP BY lapcat