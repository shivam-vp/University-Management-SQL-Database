
USE university_db;
-- Check the number of records in each table
SELECT 'Students' AS table_name, COUNT(*) AS total
FROM Students
UNION ALL
SELECT 'Professors', COUNT(*) FROM Professors
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Grades', COUNT(*) FROM Grades;

-- Find courses without any assessment records
SELECT
    c.course_id,
    c.course_name
FROM Courses c
LEFT JOIN Grades g
    ON c.course_id = g.course_id
WHERE g.grade_id IS NULL;

-- Check for students without any recorded grades
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM Students s
LEFT JOIN Grades g
    ON s.student_id = g.student_id
WHERE g.grade_id IS NULL;

-- Verify that no grade falls outside the valid range
SELECT *
FROM Grades
WHERE grade < 0 OR grade > 100;
