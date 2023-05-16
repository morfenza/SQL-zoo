-- 1. How many stops are in the database. 
SELECT COUNT(*)
FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart' 
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT 
    stops.id,
    stops.name
FROM stops
INNER JOIN route
    ON stops.id = route.stop
WHERE 
    route.num = '4'
    AND route.company = 'LRT';

-- 4. The query shown gives the number of routes that visit either
--    London Road (149) or Craiglockhart (53). Run the query and notice the two
--    services that link these stops have a count of 2. Add a HAVING clause to
--    restrict the output to these two routes. 
SELECT 
    company,
    num,
    COUNT(*) AS stops
FROM route
WHERE 
    stop = 149
    OR stop = 53
GROUP BY 
    company,
    num
HAVING stops = 2;

-- 5. Change the query so that it shows the services from 
--    Craiglockhart to London Road. 
SELECT 
    a.company,
    a.num,
    a.stop,
    b.stop
FROM route AS a
INNER JOIN route AS b
    ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE 
    a.stop = 53
    AND b.stop = 149;

-- 6. Change the query so that the services between
--    'Craiglockhart' and 'London Road' are shown.
SELECT 
    a.company,
    a.num, 
    stop_a.name,
    stop_b.name
FROM route AS a
INNER JOIN route AS b
    ON ( 
        a.company = b.company 
        AND a.num = b.num
    )
INNER JOIN stops AS stop_a 
    ON a.stop = stop_a.id
INNER JOIN stops AS stop_b
    ON b.stop = stop_b.id
WHERE 
    stop_a.name = 'Craiglockhart'
    AND stop_b.name = 'London Road';

-- 7. Give a list of all the services which connect 
--    stops 115 and 137 ('Haymarket' and 'Leith') 
SELECT DISTINCT 
    a.company,
    a.num
FROM route AS a
INNER JOIN route AS b
    ON (
        a.num = b.num 
        AND a.company = b.company
    )
WHERE 
    a.stop = 115
    AND b.stop = 137;

-- 8. Give a list of the services which connect 
--    the stops 'Craiglockhart' and 'Tollcross' 
SELECT DISTINCT
    a.company,
    a.num
FROM route AS a
INNER JOIN route AS b
    ON (
        a.num = b.num 
        AND a.company = b.company   
    )
INNER JOIN stops AS stop_a
    ON a.stop = stop_a.id
INNER JOIN stops AS stop_b
    ON b.stop = stop_b.id
WHERE 
    stop_a.name = 'Craiglockhart'
    AND stop_b.name = 'Tollcross';