
USE university_db;

INSERT INTO Professors
    (first_name, last_name, email)
VALUES
    ('Alice', 'Morgan', 'alice.morgan@university.edu'),
    ('David', 'Chen', 'david.chen@university.edu'),
    ('Sarah', 'Patel', 'sarah.patel@university.edu'),
    ('James', 'Wilson', 'james.wilson@university.edu');

INSERT INTO Students
    (first_name, last_name, email)
VALUES
    ('Emma', 'Brown', 'emma.brown@student.edu'),
    ('Liam', 'Smith', 'liam.smith@student.edu'),
    ('Olivia', 'Jones', 'olivia.jones@student.edu'),
    ('Noah', 'Garcia', 'noah.garcia@student.edu'),
    ('Ava', 'Taylor', 'ava.taylor@student.edu');

INSERT INTO Courses
    (course_name, professor_id)
VALUES
    ('Database Systems', 1),
    ('Artificial Intelligence', 2),
    ('Web Development', 3),
    ('Statistics', 1),
    ('Computer Networks', 4),
    ('Machine Learning', 2);

INSERT INTO Grades
    (student_id, course_id, grade, assessment_date)
VALUES
    -- Emma: four courses
    (1, 1, 65, '2026-05-10'),
    (1, 1, 72, '2026-06-10'),
    (1, 2, 58, '2026-05-12'),
    (1, 3, 88, '2026-05-15'),
    (1, 4, 70, '2026-05-20'),

    -- Liam: four courses
    (2, 1, 80, '2026-05-10'),
    (2, 2, 75, '2026-05-12'),
    (2, 3, 68, '2026-05-15'),
    (2, 5, 55, '2026-05-22'),

    -- Olivia: four courses
    (3, 1, 90, '2026-05-10'),
    (3, 2, 85, '2026-05-12'),
    (3, 4, 92, '2026-05-20'),
    (3, 6, 89, '2026-05-25'),

    -- Noah: four courses
    (4, 2, 62, '2026-05-12'),
    (4, 3, 78, '2026-05-15'),
    (4, 5, 81, '2026-05-22'),
    (4, 6, 74, '2026-05-25'),

    -- Ava: four courses
    (5, 1, 55, '2026-05-10'),
    (5, 3, 60, '2026-05-15'),
    (5, 4, 64, '2026-05-20'),
    (5, 5, 70, '2026-05-22');
