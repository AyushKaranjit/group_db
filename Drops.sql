-- File: Drops.sql
-- Purpose: Drop all tables and constraints maintaining referential integrity
-- Author: Ayush Karanjit
-- Date: April 17, 2025

-- Disable foreign key constraints to prevent errors during table drops
-- This makes the drop process more efficient and avoids constraint violations

SET CONSTRAINTS ALL DEFERRED;

-- Drop tables in the reverse order of their dependencies
-- Start with tables that have foreign keys referencing other tables

-- Drop student_submissions (depends on students and submissions)
DROP TABLE student_submissions CASCADE CONSTRAINTS;

-- Drop submissions (depends on assignments and markers)
DROP TABLE submissions CASCADE CONSTRAINTS;

-- Drop assignments (depends on modules)
DROP TABLE assignments CASCADE CONSTRAINTS;

-- Drop attendances (depends on modules)
DROP TABLE attendances CASCADE CONSTRAINTS;

-- Drop module_lists (depends on students and modules)
DROP TABLE module_lists CASCADE CONSTRAINTS;

-- Drop degree_modules (depends on degrees and modules)
DROP TABLE degree_modules CASCADE CONSTRAINTS;

-- Drop modules (depends on examiners)
DROP TABLE modules CASCADE CONSTRAINTS;

-- Now drop tables with no dependencies or whose dependents have been dropped

-- Drop students
DROP TABLE students CASCADE CONSTRAINTS;

-- Drop markers
DROP TABLE markers CASCADE CONSTRAINTS;

-- Drop examiners
DROP TABLE examiners CASCADE CONSTRAINTS;

-- Drop degrees
DROP TABLE degrees CASCADE CONSTRAINTS;

-- Verify all tables have been dropped
SELECT table_name 
FROM user_tables 
WHERE table_name IN ('DEGREES', 'EXAMINERS', 'MARKERS', 'STUDENTS', 
                     'MODULES', 'DEGREE_MODULES', 'MODULE_LISTS', 
                     'ATTENDANCES', 'ASSIGNMENTS', 'SUBMISSIONS', 
                     'STUDENT_SUBMISSIONS');

-- After all tables are dropped, permanently remove them from the recyclebin
PURGE RECYCLEBIN;

COMMIT;