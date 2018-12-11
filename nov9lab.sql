Sahil Gogna
CREATE TABLE teacher(teaNum varchar(20), teaFName varchar(20), teaLName varchar(20));

CREATE TABLE course(courseNum varchar(20), courseName varchar(20), teaNum varchar(20), 
                    CONSTRAINT PK PRIMARY KEY(courseNum), CONSTRAINT teaFK FOREIGN KEY(teaNum) REFERENCES teacher(teaNum));

CREATE TABLE GRADES(stuNum varchar(20), courseNum varchar(20), grade number, 
                    CONSTRAINT PK PRIMARY KEY(stuNum,courseNum), 
                    CONSTRAINT student_FK FOREIGN KEY(stuNum) REFERENCES student(student_id), 
                    CONSTRAINT courseFK FOREIGN KEY(courseNum) REFERENCES course(coursNum));

CREATE TABLE STUDENT(
    student_id varchar(20),
    stuFName VARCHAR(20),
    stuLName VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(student_id)
);

INSERT into STUDENT VALUES ("ALCE7888","Joe","Taylor"),
                            ("HILA7890","Mike","Ross"),
                            ("HILA7891","Ed","Sheeran");
INSERT INTO teacher VALUES("1","Mark","Jean"),
                            ("2","Ahmed","Ali");
INSERT INTO teacher VALUES("3","Sara","Maz");

INSERT INTO course VALUES("420-111-TE","Langage SQL","2"),
                            ("320-112-PP","Programmation VBA","1"),
                            ("mat1","MATH","3"),
                            ("net1","Network","3");

INSERT INTO grades VALUES("ALCE7888","420-111-TE",90),
                            ("PATE8756","320-112-PP",100),
                            ("HILA7890","mat1",79),
                            ("HILA7890","320-112-PP",50),
                            ("HILA7890","420-111-TE",55);


--Realize the following queries:
--1.	Display the full name of the student who has a grade(any grade)
SELECT stuFName AS "First Name", stuLName AS "Last Name" FROM Student WHERE stuNum IN (SELECT stuNum FROM Grades);
--2.	Display the full name and the number of the student who has a grade in the course number mat01.
SELECT stuFName AS "First Name", stuLName AS "Last Name", stuNum FROM Student where stuNum = (SELECT stuNum from Grades WHERE courseNum = "2");
--3.	Display the full name of the student who has grade in the course with the name  network
SELECT stuFName AS "First Name", stuLName AS "Last Name" FROM Student WHERE stuNum IN (SELECT stuNum from Grades where courseNum = (SELECT courseNum FROM Course WHERE courseName = "Java"));
--4.	Display the full name of the students who does not have any grade
SELECT stuFName AS "First Name", stuLName AS "Last Name" FROM Student WHERE stuNum NOT IN (SELECT stuNum FROM Grades);
--5.	Display the full name of the student who has a grade in the course net01greater than 70.
SELECT stuFName AS "First Name", stuLName AS "Last Name" FROM Student WHERE stuNum = (SELECT stuNum FROM Grades WHERE grade > 70 AND courseNum = (SELECT courseNum FROM Course WHERE courseName = "ObjC"));
--6.	Display the number of the student for each course.
SELECT count(stuNum) AS “Number of Students”, courseNum AS “Course” FROM Grades GROUP BY courseNum;
--7.	Display the number of the student for each course, but display only the courses that have student >3.
SELECT count(stuNum), courseNum FROM Grades GROUP BY courseNum HAVING count(stuNum)>3;
--8.	For each course select the maximum grade and the minimum grade
select max(grade), min(grade), courseNum from grades GROUP BY courseNum;
--9.	Display the grades of the student number 1 that are equals to the grades of the student number 2
SELECT grade, stuNum AS "StudentNumer" FROM Grades WHERE stuNum = "1" AND grade IN (SELECT grade FROM Grades WHERE stuNum = "2");
--10.	Display the grades of the student number 1 that are lower than all the grades of the student number2
SELECT grade, stuNum AS "StudentNumer" FROM Grades WHERE stuNum = "1" AND grade < (SELECT grade FROM Grades WHERE stuNum = “2");