-- view is basically a virtual table
CREATE VIEW nameStudent
as SELECT fname, lname
   FROM Table_name;

SELECT * FROM nameStudent;