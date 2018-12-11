Agregate function: that perform operation on set of values and give us results

newschema.db created

SELECT min(grade) from registration;
SELECT max(grade) from registration;
SELECT avg(grade) from registration;

.header ON will display column name as avg(column_name) so we use alias of the TABLE

SELECT avg(course_grade) as average from registration; /*average is alias */

/* to get two columns combined */
.header ON
.mode Column
 select student_firstname || student_lastname as studentName from student;

 /*to  count*/ 
SELECT count(student_id) as NumberOfStudents from student;
SELECT student_id, course_id from registration WHERE thesession LIKE "S%"; 
SELECT student_id as Student_ID from registration WHERE course_grade in(70,80,90);

///agregate functions:

SELECT min(grade) FROM registration;
SELECT max(grade) FROM registration;
SELECT avg(grade) FROM registration;
SELECT count(*) FROM student;
SELECT count(student_id) from student;
SELECT round(grade) FROM registration;

/////ALIAS
SELECT avg(grade) AS Average FROM registration;
/////
SELECT DISTINCT(city) FROM student;
/////
select student_id from registration where grade in(70,80,90,100);
///////
SELECT * FROM student ORDER BY student_lastname; /// Ascending by DEFAULT
SELECT * FROM student ORDER BY student_lastname DESC;

SELECT count(student_id), student_city FROM student GROUP BY student_city;
SELECT count(student_id) as "Number of students" , course_id FROM registration GROUP BY course_id;


/* when you find for each, grouping use group by and use having with it



*/ 