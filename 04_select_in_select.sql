-- 1.  List each country name where the population is
--     larger than that of 'Russia'.
SELECT name
FROM world
WHERE
    population > (
        SELECT population
        FROM world
        WHERE name = 'Russia'
    );

-- 2. Show the countries in Europe with a per capita GDP 
--    greater than 'United Kingdom'.

--    Per Capita GDP: The per capita GDP is the gdp/population
SELECT name
FROM world
WHERE
    continent = 'europe'
    AND (gdp / population) > (
        SELECT gdp / population
        FROM world
        WHERE name = 'United Kingdom'
    );

-- 3. List the name and continent of countries
--    in the continents containing either Argentina
--    or Australia. Order by name of the country.
SELECT
    name,
    continent
FROM world
WHERE
    continent IN (
        SELECT continent
        FROM world
        WHERE name IN (
            'argentina',
            'australia'
        )
    )
ORDER BY name;

-- 4.  Which country has a population that is more than 
--     United Kingdom but less than Germany? Show the name and
--     the population.
SELECT
    name,
    population
FROM world
WHERE
    population > (
        SELECT population
        FROM world
        WHERE name = 'united kingdom'
    ) AND population < (
        SELECT population
        FROM world
        WHERE name = 'germany'
    );

-- 5. Show the name and the population of each country in Europe
--    Show the population as a percentage of the population of Germany.
SELECT
    name,
    CONCAT(
        ROUND(
            population / (
                SELECT population
                FROM world
                WHERE name = 'germany'
            ) * 100
        ), '%'
    ) AS population
FROM world
WHERE continent = 'europe';

-- 6. Which countries have a GDP greater than every country in Europe?
SELECT name
FROM world
WHERE gdp > ALL(
    SELECT gdp
    FROM world
    WHERE continent = 'europe'
);

-- 7. Find the largest country (by area) in each continent,
--    show the continent, the name and the area
SELECT
    x.continent,
    x.name,
    x.area
FROM world AS x
WHERE x.area >= ALL(
    SELECT y.area
    FROM world AS y
    WHERE
        y.continent = x.continent
        AND y.area > 0
);

--  8. List each continent and the name of the country
--     that comes first alphabetically.
SELECT 
    w1.continent,
    w1.name
FROM world AS w1
WHERE w1.name <= ALL(
    SELECT w2.name
    FROM world AS w2
    WHERE w1.continent = w2.continent
);

-- 9. Find the continents where all countries have a population <= 25000000.
--    Then find the names of the countries associated with these continents.
--    Show name, continent and population. 
SELECT 
    w1.name,
    w1.continent,
    w1.population 
FROM world AS w1
WHERE 25000000 >= ALL(
    SELECT w2.population
    FROM world AS w2
    WHERE w1.continent = w2.continent
);

-- 10. Some countries have populations more than three times that of all 
--     of their neighbours. Give the countries and continents.
SELECT 
    w1.name,
    w1.continent
FROM world AS w1
WHERE w1.population > ALL(
    SELECT w2.population * 3
    FROM world AS w2
    WHERE 
        w1.continent = w2.continent
        AND w1.name != w2.name
);