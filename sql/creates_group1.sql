/* 
Group 1,
Ayush Karanjit 24812931,
Anuskar Sigdel 24812606,
Utsab Thami Magar 24814107,
Nabin Thapaliya 24814102
*/


-- @E:\DB-PROJECT\creates_group1.txt


-- Create table for degrees
CREATE TABLE degrees (
    degree_id NUMBER(5),
    degree_title VARCHAR2(30),
    detail VARCHAR2(100),
    degree_level VARCHAR2(5),
    degree_year NUMBER(1)
);

-- Create table for examiners
CREATE TABLE examiners (
    examiner_id NUMBER(5),
    examiner_fname VARCHAR2(15),
    examiner_lname VARCHAR2(15),
    institution VARCHAR2(30),
    contact_detail VARCHAR2(20),
    address VARCHAR2(30)
);

-- Create table for markers
CREATE TABLE markers (
    marker_id NUMBER(5),
    marker_fname VARCHAR2(15),
    marker_lname VARCHAR2(15),
    contact_detail VARCHAR2(20),
    address VARCHAR2(30)
);

-- Create table for students
CREATE TABLE students (
    student_id NUMBER(5),
    degree_id NUMBER(5),
    student_fname VARCHAR2(15),
    student_lname VARCHAR2(15),
    dob DATE,
    contact_number VARCHAR2(20),
    address VARCHAR2(30)
);

-- Create table for modules
CREATE TABLE modules (
    module_id NUMBER(5),
    examiner_id NUMBER(5),
    module_name VARCHAR2(30),
    detail VARCHAR2(30),
    status CHAR(1)
);

-- Create table for degree_modules
CREATE TABLE degree_modules (
    module_id NUMBER(5),
    degree_id NUMBER(5),
    start_date DATE,
    semester VARCHAR2(2)
);

-- Create table for module_lists
CREATE TABLE module_lists (
    module_list_id NUMBER(5),
    student_id NUMBER(5),
    module_id NUMBER(5),
    enrollment_date DATE
);

-- Create table for attendances
CREATE TABLE attendances (
    attendance_id NUMBER(5),
    module_list_id NUMBER(5),
    attendance_date DATE,
    status CHAR(1)
);

-- Create table for assignments
CREATE TABLE assignments (
    assignment_id NUMBER(5),
    module_id NUMBER(5),
    code VARCHAR2(5),
    title VARCHAR2(30),
    weighting NUMBER(5,2),
    type VARCHAR2(20)
);

-- Create table for submissions
CREATE TABLE submissions (
    submission_id NUMBER(5),
    assignment_id NUMBER(5),
    marker_id NUMBER(5),
    receipt_no VARCHAR2(4),
    submission_date DATE,
    submission_time DATE
);

-- Create table for student_submissions
CREATE TABLE student_submissions (
    student_id NUMBER(5),
    submission_id NUMBER(5),
    grade VARCHAR2(2),
    feedback VARCHAR2(100)
);

-- COMMIT CHANGES
-- This saves all the changes made to the database schema
COMMIT;
