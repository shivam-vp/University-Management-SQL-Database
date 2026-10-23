-- QUERY 1: Average grade given by each professor
SELECT
    p.professor_id,
    p.first_name,
    p.last_name,
    ROUND(AVG(g.grade), 2) AS average_grade,
    COUNT(g.grade_id) AS assessments_marked
FROM Professors p
JOIN Courses c
    ON p.professor_id = c.professor_id
JOIN Grades g
    ON c.course_id = g.course_id
GROUP BY
    p.professor_id,
    p.first_name,
    p.last_name
ORDER BY average_grade DESC;




-- QUERY 2: Top grades for each student
WITH RankedGrades AS (
    SELECT
        s.student_id,
        s.first_name,
        s.last_name,
        c.course_name,
        g.grade,
        g.assessment_date,
        ROW_NUMBER() OVER (
            PARTITION BY s.student_id
            ORDER BY g.grade DESC, g.assessment_date DESC
        ) AS grade_rank
    FROM Students s
    JOIN Grades g
        ON s.student_id = g.student_id
    JOIN Courses c
        ON g.course_id = c.course_id
)
SELECT
    student_id,
    first_name,
    last_name,
    course_name,
    grade,
    assessment_date
FROM RankedGrades
WHERE grade_rank <= 3
ORDER BY student_id, grade_rank;





-- QUERY 3: Sort students by the number of courses they are enrolled in
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(DISTINCT g.course_id) AS enrolled_courses
FROM Students s
LEFT JOIN Grades g
    ON s.student_id = g.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY
    enrolled_courses DESC,
    s.last_name,
    s.first_name;





-- QUERY 4: Courses ranked from lowest average to highest
SELECT
    c.course_id,
    c.course_name,
    p.first_name AS professor_first_name,
    p.last_name AS professor_last_name,
    ROUND(AVG(g.grade), 2) AS average_grade,
    COUNT(g.grade_id) AS total_assessments,
    COUNT(DISTINCT g.student_id) AS students_assessed
FROM Courses c
JOIN Professors p
    ON c.professor_id = p.professor_id
LEFT JOIN Grades g
    ON c.course_id = g.course_id
GROUP BY
    c.course_id,
    c.course_name,
    p.first_name,
    p.last_name
ORDER BY
    average_grade IS NULL ASC,
    average_grade ASC;




-- QUERY 5: Which student and professor have most courses in common
WITH StudentProfessorCourses AS (
    SELECT DISTINCT
        s.student_id,
        s.first_name AS student_first_name,
        s.last_name AS student_last_name,
        p.professor_id,
        p.first_name AS professor_first_name,
        p.last_name AS professor_last_name,
        c.course_id,
        c.course_name
    FROM Students s
    JOIN Grades g
        ON s.student_id = g.student_id
    JOIN Courses c
        ON g.course_id = c.course_id
    JOIN Professors p
        ON c.professor_id = p.professor_id
),
CommonCourseCounts AS (
    SELECT
        student_id,
        student_first_name,
        student_last_name,
        professor_id,
        professor_first_name,
        professor_last_name,
        COUNT(*) AS courses_in_common
    FROM StudentProfessorCourses
    GROUP BY
        student_id,
        student_first_name,
        student_last_name,
        professor_id,
        professor_first_name,
        professor_last_name
),
RankedPairs AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            ORDER BY courses_in_common DESC
        ) AS pair_rank
    FROM CommonCourseCounts
)
SELECT
    student_first_name,
    student_last_name,
    professor_first_name,
    professor_last_name,
    courses_in_common
FROM RankedPairs
WHERE pair_rank = 1
ORDER BY
    student_last_name,
    professor_last_name;
