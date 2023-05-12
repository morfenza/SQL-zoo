-- 1. List the teachers who have NULL for their department. 
SELECT teacher.name
FROM teacher
WHERE teacher.dept IS NULL;

-- 3. Use a different JOIN so that all teachers are listed. 
SELECT 
    teacher.name,
    dept.name
FROM teacher
LEFT JOIN dept
    ON (teacher.dept = dept.id);

-- 4. Use a different JOIN so that all departments are listed. 
-- PS: SQLFLUFF DISLIKES RIGHT JOINS!!
-- SELECT 
--     teacher.name,
--     dept.name
-- FROM teacher
-- RIGHT JOIN dept
--     ON (teacher.dept=dept.id)

-- 5. Show teacher name and mobile number or '07986 444 2266'
SELECT 
    teacher.name,
    COALESCE(teacher.mobile, '07986 444 2266') AS mobile
FROM teacher;

-- 6. Use the COALESCE function and a LEFT JOIN to print the teacher name 
--    and department name. Use the string 'None' where there is no department. 
SELECT 
    teacher.name,
    COALESCE(dept.name, 'None') AS dept
FROM teacher
LEFT JOIN dept
    ON (teacher.dept = dept.id);

-- 7. Use COUNT to show the number of teachers and the number of mobile phones. 
SELECT 
    COUNT(teacher.name) AS number_of_teacher,
    COUNT(teacher.mobile) AS number_of_mobile_numbers
FROM teacher;

-- 8. Use COUNT and GROUP BY dept.name to show each department and the number
--    of staff. Use a RIGHT JOIN to ensure that the Engineering department 
--    is listed. 
-- PS: SQLFLUFF DISLIKES THIS ONES TOO!
-- SELECT 
--     dept.name,
--     COUNT(teacher.dept) AS number_of_staff
-- FROM teacher
-- RIGHT JOIN dept
--     ON teacher.dept = dept.id
-- GROUP BY dept.name

-- 9. Use CASE to show the name of each teacher followed by 'Sci' if the
--    teacher is in dept 1 or 2 and 'Art' otherwise. 
SELECT
    teacher.name,
    CASE 
        WHEN teacher.dept = 1 OR teacher.dept = 2 THEN 'Sci'
        WHEN teacher.dept IS NULL THEN 'Art'
    END AS dept
FROM teacher;

-- 10. Use CASE to show the name of each teacher followed by 'Sci' 
--     if the teacher is in dept 1 or 2, show 'Art' if the teacher's
--     dept is 3 and 'None' otherwise. 
SELECT
    teacher.name,
    CASE 
        WHEN teacher.dept = 1 OR teacher.dept = 2 THEN 'Sci'
        WHEN teacher.dept = 3 THEN 'Art'
        WHEN teacher.dept IS NULL THEN 'None'
    END AS dept
FROM teacher;