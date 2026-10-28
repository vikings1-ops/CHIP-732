-- CRUD/CREATE: create a student table and insert values
DROP TABLE IF EXISTS student;

CREATE TABLE student (
	s_id	INT PRIMARY KEY,
	year_start INT,
	first_name TEXT,
	last_name TEXT,
	addr_street TEXT,
	addr_city TEXT,
	addr_state TEXT,
	photo TEXT
);

INSERT INTO student VALUES (1258,2017,"Sarah","Johnson","2111 Main St.","Cincinnati","OH","/static/img/1258.png");
INSERT INTO student VALUES (3698,2018,"Jack","Miller","15 Vine St.","Cincinnati","OH","/static/img/5687.png");
INSERT INTO student VALUES (5687,2019,"Bruce","Timberland","6601 Tram Ave.","Newport","KY","/static/img/5687.png");
INSERT INTO student VALUES (5699,2019,"Nathan","Lee","4567 Wastern Row Rd.","Mason","OH","/static/img/5699.png");

-- CHECKING POINT: change a last name and re-execute 1-18. You should not run into any problems. 

-- CRUD/CREATE: create teacher table and insert values
DROP TABLE IF EXISTS teacher;

CREATE TABLE teacher (
	t_id	INT PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL
);

INSERT INTO teacher VALUES (123,"Li","Zhang");
INSERT INTO teacher VALUES (456,"Danny","Wu");
-- INSERT INTO teacher VALUES (789,"",NULL);

-- CEHCKING POINT: insert empty strings versus null value

-- CRUD/CREATE: create course table and insert values
DROP TABLE IF EXISTS course;

CREATE TABLE course (
	c_id TEXT PRIMARY KEY,
	name TEXT,
	level TEXT
);

INSERT INTO course VALUES ("BE/PH 8093","Introduction to Database Management","G");
INSERT INTO course VALUES ("DSGN 809","Independet Study","G");
INSERT INTO course VALUES ("BMIN 1234","Data Analysis in Python","U/G");

-- CHECK POINT: insert your own course

-- CRUD/CREATE: create student course mapping table
-- one student can enroll in multiple courses
-- one course can have multiple students
DROP TABLE IF EXISTS student_course;

CREATE TABLE student_course (
	seq	INT PRIMARY KEY,
	s_id INT,
	c_id INT,
	FOREIGN KEY (s_id) REFERENCES student (s_id),
	FOREIGN KEY (c_id) REFERENCES course (c_id)  
);

INSERT INTO student_course VALUES (1,1258,"BE/PH 8093");
INSERT INTO student_course VALUES (2,3698,"BE/PH 8093");
INSERT INTO student_course VALUES (3,5687,"BE/PH 8093");
INSERT INTO student_course VALUES (4,1258,"BMIN 1234");
INSERT INTO student_course VALUES (5,3698,"BMIN 1234");
INSERT INTO student_course VALUES (6,5687,"DSGN 809");

-- CHECKING POINT: INSERT a random course, error!
-- INSERT INTO student_course VALUES (7,3698,"BMIN 4000");

-- CRUD/CREATE: create teacher course mapping table
-- one course can be taught by only one teacher
-- one teacher can teach multiple courses
DROP TABLE IF EXISTS teacher_course;

CREATE TABLE teacher_course (
	seq	INT PRIMARY KEY,
	t_id INT,
	c_id INT,
	FOREIGN KEY (t_id) REFERENCES teacher (t_id),
	FOREIGN KEY (c_id) REFERENCES course (c_id)  
);

INSERT INTO teacher_course VALUES (1,123,"BE/PH 8093");
INSERT INTO teacher_course VALUES (2,456,"BMIN 1234");
INSERT INTO teacher_course VALUES (3,456,"DSGN 809");

-- CHECKING POINT: insert the 4th row with a random teacher, error!
-- INSERT INTO teacher_course VALUES (4,999,"DSGN 809");

-- CHECKING POINT: make year_start a date format
DROP TABLE IF EXISTS student;

CREATE TABLE student (
	s_id	INT PRIMARY KEY,
	year_start DATE,
	first_name TEXT,
	last_name TEXT,
	addr_street TEXT,
	addr_city TEXT,
	addr_state TEXT,
	photo TEXT
);

INSERT INTO student VALUES (1258,'2017-01-01',"Sarah","Johnson","2111 Main St.","Cincinnati","OH","/static/img/1258.png");
INSERT INTO student VALUES (3698,'2018-02-28',"Jack","Miller","15 Vine St.","Cincinnati","OH","/static/img/5687.png");
INSERT INTO student VALUES (5687,'2019-09-30',"Bruce","Timberland","6601 Tram Ave.","Newport","KY","/static/img/5687.png");
INSERT INTO student VALUES (5699,'2019-11-11',"Nathan","Lee","4567 Wastern Row Rd.","Mason","OH","/static/img/5699.png");

-- CRUD/READ: Join two tables
SELECT a.t_id,last_name||', '||first_name AS name, count(*)
FROM teacher a
LEFT JOIN teacher_course b
ON a.t_id=b.t_id
GROUP BY a.t_id,name
ORDER BY count(*) DESC
;

SELECT a.s_id,last_name||', '||first_name AS name, count(*)
FROM student a
LEFT JOIN student_course b
ON a.s_id=b.s_id
GROUP BY a.s_id,name
ORDER BY count(*) DESC
;

-- CRUD/UPDATE: Alter table/column name and change it back using the DB Browser
ALTER TABLE student RENAME TO student2;
ALTER TABLE student2 RENAME COLUMN first_name TO firstName;
ALTER TABLE student2 RENAME COLUMN firstName TO first_name;
ALTER TABLE student2 RENAME TO student;

-- CRUD/UPDATE: change value
UPDATE student SET addr_city='Columbus' WHERE s_id=1258;

-- CRUD/DELETE: delete a record
DELETE FROM student_course WHERE seq=6;
DELETE FROM student WHERE addr_city='Mason';

-- VIEW
DROP VIEW IF EXISTS patient_bc;

CREATE VIEW patient_bc AS
SELECT random_pat_id,ethnic_group
FROM patient
WHERE gender='Female'
AND patient_race='Black or African American'
;

SELECT ETHNIC_GROUP,COUNT(*)
FROM patient_bc
GROUP BY ETHNIC_GROUP
ORDER BY COUNT(*) DESC
;