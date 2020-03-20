SELECT s.stuFName, s.stuLName, s.student_id 
FROM STUDENT s, GRADES g 
WHERE s.student_id = g.stuNum
And g.grade = 90;

SELECT c.courseName
FROM course c, GRADES g, STUDENT s
WHERE c.courseNum = g.courseNum
AND s.student_id = g.stuNum
AND s.stuFName = "Joe";

-- internal join
SELECT c.courseNum
FROM course c INNER JOIN GRADES g
ON c.courseNum = g.courseNum
WHERE g.grade = 90;

SELECT c.courseName
FROM course c INNER JOIN GRADES g INNER JOIN STUDENT s
on c.courseNum = g.courseNum
AND s.student_id = g.stuNum
AND s.stuFName = "Joe"; 

--right join
INSERT into STUDENT VALUES ("LC0011","Babbu","Maan");

SELECT s.stuFName, s.stuLName , g.grade
FROM STUDENT s INNER JOIN GRADES g
on s.student_id = g.stuNum;

SELECT s.stuFName, s.stuLName , g.grade
FROM STUDENT s LEFT JOIN GRADES g
on s.student_id = g.stuNum;

SELECT s.soft_id as "Software Id", sup.sup_id as "Supplier Id"
FROM software s INNER JOIN purchase p 
ON s.soft_id = p.soft_id
INNER JOIN supplier sup
ON p.sup_id = sup.sup_id
AND sup.sup_id = "SUP01";