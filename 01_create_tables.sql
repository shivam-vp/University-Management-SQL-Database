
CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    professor_id INT NOT NULL,

    CONSTRAINT fk_course_professor
        FOREIGN KEY (professor_id)
        REFERENCES Professors(professor_id)
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade DECIMAL(5,2) NOT NULL,
    assessment_date DATE NOT NULL,

    CONSTRAINT chk_grade_range
        CHECK (grade BETWEEN 0 AND 100),

    CONSTRAINT fk_grade_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    CONSTRAINT fk_grade_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
);

CREATE INDEX idx_grades_student_course
    ON Grades(student_id, course_id);

CREATE INDEX idx_grades_course
    ON Grades(course_id);
