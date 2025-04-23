/* 
Group 1,
Ayush Karanjit 24812931,
Anuskar Sigdel 24812606,
Utsab Thami Magar 24814107,
Nabin Thapaliya 24814102
*/

-- @E:\DB-PROJECT\queries_group1.txt

-- a) A simple query to return all the records from one table
SELECT * FROM students;

-- b) A projection query with 3 columns sorted in reverse alphabetical order
SELECT student_fname, student_lname, address 
FROM students 
ORDER BY student_lname DESC;

-- c) Restriction queries with multiple clauses

-- Comparison operator with predicate for people who live in Kathmandu
SELECT * FROM students 
WHERE address = 'Kathmandu';

-- Condition matching a pattern (begins with 'A')
SELECT * FROM students 
WHERE student_fname LIKE 'A%';

-- Negative condition with predicate (do not live in Kathmandu)
SELECT * FROM students 
WHERE address != 'Kathmandu';

-- Logic operator with predicates for students born after 2000 from Kathmandu
SELECT * FROM students 
WHERE address = 'Kathmandu' AND dob > TO_DATE('01-JAN-2000', 'DD-MON-YYYY');

-- Logic operator with predicates for students born in July or living in Pokhara
SELECT * FROM students 
WHERE TO_CHAR(dob, 'MON') = 'JUL' OR address = 'Pokhara';

-- Date range condition for this year's module enrollments
SELECT ml.student_id, s.student_fname, s.student_lname, ml.enrollment_date
FROM module_lists ml
JOIN students s ON ml.student_id = s.student_id
WHERE ml.enrollment_date BETWEEN TO_DATE('01-JAN-2025', 'DD-MON-YYYY') 
                            AND TO_DATE('31-DEC-2025', 'DD-MON-YYYY');

-- d) Join queries to extract insightful information

-- 2 tables join: Find all students enrolled in Computer Science degree
-- Purpose: Shows which students are currently pursuing Computer Science
SELECT s.student_id, s.student_fname, s.student_lname, d.degree_title, d.degree_level
FROM students s
JOIN degrees d ON s.degree_id = d.degree_id
WHERE d.degree_title = 'Computer Science';

-- 3 tables join: Find all students with their modules and respective examiner
-- Purpose: Helps track which examiner is responsible for each student's modules
SELECT s.student_id, s.student_fname, s.student_lname, 
       m.module_name, m.detail,
       e.examiner_fname, e.examiner_lname
FROM students s
JOIN module_lists ml ON s.student_id = ml.student_id
JOIN modules m ON ml.module_id = m.module_id
JOIN examiners e ON m.examiner_id = e.examiner_id;

-- e) Demonstrating additional or integrated skills

-- Parameterized query to find students by specific degree
-- Can be used with variable binding in application code
VARIABLE degree_id NUMBER
BEGIN
  :degree_id := 1; -- Set a sample value
END;
/
SELECT * FROM students 
WHERE degree_id = :degree_id;

-- Function to calculate student age
SELECT student_id, student_fname, student_lname, 
       TRUNC((SYSDATE - dob)/365.25) AS age_years
FROM students;

-- Query with subquery to find students with above-average grades
SELECT s.student_id, s.student_fname, s.student_lname, ss.grade
FROM students s
JOIN student_submissions ss ON s.student_id = ss.student_id
WHERE ss.grade IN ('A+', 'A', 'A-')
ORDER BY s.student_id;

-- Query with aggregate function to count submissions by module
SELECT m.module_name, COUNT(ss.submission_id) AS submission_count
FROM modules m
JOIN assignments a ON m.module_id = a.module_id
JOIN submissions s ON a.assignment_id = s.assignment_id
JOIN student_submissions ss ON s.submission_id = ss.submission_id
GROUP BY m.module_name
ORDER BY submission_count DESC;

-- Query to find attendance percentage for modules
SELECT m.module_name, 
       COUNT(CASE WHEN a.status = 'P' THEN 1 END) AS present_count,
       COUNT(*) AS total_count,
       ROUND(COUNT(CASE WHEN a.status = 'P' THEN 1 END) * 100 / COUNT(*), 2) AS attendance_percentage
FROM modules m
JOIN module_lists ml ON m.module_id = ml.module_id
JOIN attendances a ON ml.module_list_id = a.module_list_id
GROUP BY m.module_name
ORDER BY attendance_percentage DESC;

-- COMMIT CHANGES
-- This saves all the changes made to the database schema
COMMIT;
