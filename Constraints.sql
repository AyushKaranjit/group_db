-- File: Constraints.sql
-- Purpose: Implement all integrity constraints for the database
-- Author: Ayush Karanjit
-- Date: April 17, 2025

-- PRIMARY KEY CONSTRAINTS
-- These establish entity integrity by ensuring unique identification

-- PRIMARY KEY for degrees table
ALTER TABLE degrees 
ADD CONSTRAINT pk_degrees 
PRIMARY KEY (degree_id);

-- PRIMARY KEY for examiners table
ALTER TABLE examiners 
ADD CONSTRAINT pk_examiners 
PRIMARY KEY (examiner_id);

-- PRIMARY KEY for markers table
ALTER TABLE markers 
ADD CONSTRAINT pk_markers 
PRIMARY KEY (marker_id);

-- PRIMARY KEY for students table
ALTER TABLE students 
ADD CONSTRAINT pk_students 
PRIMARY KEY (student_id);

-- PRIMARY KEY for modules table
ALTER TABLE modules 
ADD CONSTRAINT pk_modules 
PRIMARY KEY (module_id);

-- PRIMARY KEY for attendances table
ALTER TABLE attendances 
ADD CONSTRAINT pk_attendances 
PRIMARY KEY (attendance_id);

-- PRIMARY KEY for assignments table
ALTER TABLE assignments 
ADD CONSTRAINT pk_assignments 
PRIMARY KEY (assignment_id);

-- PRIMARY KEY for submissions table
ALTER TABLE submissions 
ADD CONSTRAINT pk_submissions 
PRIMARY KEY (submission_id);

-- COMPOSITE PRIMARY KEYS for junction tables
-- These establish entity integrity for many-to-many relationships

-- COMPOSITE PRIMARY KEY for degree_modules table
ALTER TABLE degree_modules 
ADD CONSTRAINT pk_degree_modules 
PRIMARY KEY (module_id, degree_id);

-- COMPOSITE PRIMARY KEY for module_lists table
ALTER TABLE module_lists 
ADD CONSTRAINT pk_module_lists 
PRIMARY KEY (student_id, module_id);

-- COMPOSITE PRIMARY KEY for student_submissions table
ALTER TABLE student_submissions 
ADD CONSTRAINT pk_student_submissions 
PRIMARY KEY (student_id, submission_id);

-- FOREIGN KEY CONSTRAINTS
-- These establish referential integrity between related tables

-- FOREIGN KEY for modules table
ALTER TABLE modules 
ADD CONSTRAINT fk_m_examiners 
FOREIGN KEY (examiner_id) REFERENCES examiners(examiner_id);

-- FOREIGN KEYS for degree_modules table
ALTER TABLE degree_modules 
ADD CONSTRAINT fk_dm_modules 
FOREIGN KEY (module_id) REFERENCES modules(module_id);

ALTER TABLE degree_modules 
ADD CONSTRAINT fk_dm_degrees 
FOREIGN KEY (degree_id) REFERENCES degrees(degree_id);

-- FOREIGN KEYS for module_lists table
ALTER TABLE module_lists 
ADD CONSTRAINT fk_ml_students 
FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE module_lists 
ADD CONSTRAINT fk_ml_modules 
FOREIGN KEY (module_id) REFERENCES modules(module_id);

-- FOREIGN KEY for attendances table
ALTER TABLE attendances 
ADD CONSTRAINT fk_a_modules 
FOREIGN KEY (module_id) REFERENCES modules(module_id);

-- FOREIGN KEY for assignments table
ALTER TABLE assignments 
ADD CONSTRAINT fk_a_modules 
FOREIGN KEY (module_id) REFERENCES modules(module_id);

-- FOREIGN KEYS for submissions table
ALTER TABLE submissions 
ADD CONSTRAINT fk_s_assignments 
FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id);

ALTER TABLE submissions 
ADD CONSTRAINT fk_s_markers 
FOREIGN KEY (marker_id) REFERENCES markers(marker_id);

-- FOREIGN KEYS for student_submissions table
ALTER TABLE student_submissions 
ADD CONSTRAINT fk_s_students 
FOREIGN KEY (student_id) REFERENCES students(student_id);

ALTER TABLE student_submissions 
ADD CONSTRAINT fk_s_submissions 
FOREIGN KEY (submission_id) REFERENCES submissions(submission_id);

-- CHECK CONSTRAINTS
-- These implement domain integrity by limiting values

-- CHECK constraint for semester in degree_modules
ALTER TABLE degree_modules 
ADD CONSTRAINT check_semester 
CHECK (semester IN ('S1', 'S2'));

-- CHECK constraint for status in attendances
ALTER TABLE attendances 
ADD CONSTRAINT check_attendance_status 
CHECK (status IN ('Present', 'Absent'));

-- DEFAULT CONSTRAINTS
-- These set default values for columns

-- DEFAULT constraint for degree_year in degrees
ALTER TABLE degrees 
MODIFY degree_year DEFAULT '4';

-- DEFAULT constraint for status in modules
ALTER TABLE modules 
MODIFY status DEFAULT 'Y';

-- DEFAULT constraint for date in attendances
ALTER TABLE attendances 
MODIFY date DEFAULT SYSDATE;

-- Verify constraints have been created
SELECT constraint_name, constraint_type, table_name 
FROM user_constraints 
ORDER BY table_name, constraint_type;

COMMIT;