-- 1. Modify the query to show data from Spain
SELECT
    name,
    confirmed,
    deaths,
    recovered,
    DAY(whn) AS day_of_week
FROM covid
WHERE
    name = 'Spain'
    AND MONTH(whn) = 3
    AND YEAR(whn) = 2020
ORDER BY whn;

-- 2 Modify the query to show confirmed for the day before.
SELECT
    name,
    confirmed,
    DAY(whn) AS day_of_week,
    LAG(confirmed, 1)
        OVER (PARTITION BY name ORDER BY whn) AS confirmed_day_before
FROM covid
WHERE
    name = 'Italy'
    AND MONTH(whn) = 3
    AND YEAR(whn) = 2020
ORDER BY whn;

-- 3. Show the number of new cases for each day, for Italy, for March.
SELECT
    name,
    DAY(whn) AS day_of_week,
    LAG(confirmed, 0) OVER (PARTITION BY name ORDER BY whn)
    - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
        AS confirmed
FROM covid
WHERE
    name = 'Italy'
    AND MONTH(whn) = 3
    AND YEAR(whn) = 2020
ORDER BY whn;

-- 4. Show the number of new cases in Italy for each week in
--    2020 - show Monday only.
SELECT 
    name,
    DATE_FORMAT(whn,'%Y-%m-%d') AS week_date,
    LAG(confirmed, 0) OVER (PARTITION BY name ORDER BY whn)
    - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
        AS confirmed
FROM covid
WHERE
    name = 'Italy'
    AND WEEKDAY(whn) = 0
    AND YEAR(whn) = 2020
ORDER BY whn;

-- 5. You can JOIN a table using DATE arithmetic.
--    This will give different results if data is missing.  

--    Show the number of new cases in Italy for each
--    week - show Monday only.
SELECT
    tw.name,
    DATE_FORMAT(tw.whn,'%Y-%m-%d') AS week_date,
    tw.confirmed - lw.confirmed AS confirmed
FROM covid AS tw
LEFT JOIN covid AS lw
    ON
        DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
        AND tw.name = lw.name
WHERE 
    tw.name = 'Italy'
    AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 6. Add a column to show the ranking for the number of deaths due to COVID.
SELECT
    name,
    confirmed,
    RANK() OVER (ORDER BY confirmed DESC) AS rc,
    deaths,
    RANK() OVER (ORDER BY deaths DESC) AS rd
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

-- 7. Show the infection rate ranking for each country. 
--    Only include countries with a population of at least 10 million.

--    SQLzoo has a bug, this is one is correct!
SELECT 
    world.name,
    ROUND(100000 * covid.confirmed / world.population, 2) AS ir,
    RANK() OVER (ORDER BY ir DESC) AS world_rank
FROM covid 
INNER JOIN world
    ON covid.name = world.name
WHERE 
    covid.whn = '2020-04-20'
    AND world.population >= 10000000
ORDER BY world.population DESC

-- Question 8 query does not work properly!