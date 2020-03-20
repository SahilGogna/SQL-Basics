CREATE TABLE client(
    id_client varchar(20) PRIMARY KEY,
    last_name varchar(20),
    first_name varchar(20)
);

CREATE TABLE product(
    id_product varchar(20) PRIMARY KEY,
    name_product varchar(20)
);

CREATE TABLE client_product(
    id_client varchar(20),
    id_product varchar(20),
    date_purchased date,
    CONSTRAINT PK PRIMARY KEY (id_client, id_product),
    CONSTRAINT FK_client FOREIGN KEY (id_client) REFERENCES client(client_id),
    CONSTRAINT FK_product FOREIGN KEY (id_product) REFERENCES product(product_id)
);

INSERT INTO client VALUES ( "1", "singh", "vishal");
INSERT INTO client(id_client, first_name) VALUES ("2", "Sara ");
SELECT * FROM client;

ALTER TABLE client ADD phone_number varchar(20);

INSERT INTO product VALUES ("Product 1", "Mobile");
INSERT INTO product VALUES ("Product 2", "laptop");
INSERT INTO product VALUES ("Product 3", "tablet");

SELECT * FROM product;

INSERT into client_product VALUES ("1","Product 1", "2018-09-19"),("2","Product 2", "2017-04-22");

.mode column 
SELECT * table name // these 2 commands are to display your TABLE

.header ON
SELECT * table name /* now this will display header on the table */


INSERT INTO client VALUES ( 3, "hi", "hello","12343");

/*renaming the table*/
ALTER table table_name RENAME TO new_name;

SELECT * from client WHERE client_id=1;

SELECT * from client WHERE client_id=1 and last_name="bag";


CREATE TABLE student (
    student_id varchar(20) PRIMARY KEY,
    student_lastname varchar(20),
    student_firstname varchar(20),
    student_mobilenumber varchar(20),
    student_city varchar(20)
);

CREATE TABLE course (
    course_id varchar(20) PRIMARY KEY,
    course_name varchar(20),
    course_description varchar(20),
    price varchar(20)
);

CREATE TABLE registration(
    course_id varchar(20),
    student_id varchar(20),
    thesession varchar(20),
    course_grade number,
    registration_date date,
    CONSTRAINT PK PRIMARY KEY(course_id, student_id,thesession),
    CONSTRAINT FK_student FOREIGN KEY(student_id) REFERENCES student(student_id),
    CONSTRAINT FK_course FOREIGN KEY(course_id) REFERENCES course(course_id)
);

INSERT into student VALUES ("ALCE7888","Alcine","Ed","(514)234-7888","Montreal"),
                            ("PATE8756","Patol","Emile","(514)566-8756","Montreal"),
                            ("HILA7890","Hilan","Anne","(450)687-7890","Longueuil"),
                            ("GAPM9076","Gaspe","Mohan","(450)873-9076","Longueuil");

INSERT INTO course VALUES ("444-678-TT","SGBDR","Introduction aux bases de données relationnelles","750"),
("420-111-TE","Langage SQL","Langage structuré de programmation","800"),
("320-112-PP","Programmation VBA","Visual Basic pour Applications","775");

INSERT INTO registration VALUES ("444-678-TT","ALCE7888","S2017",85,"21-06-2016"),
("444-678-TT","PATE8756","S2017",90,"21-06-2016"),
("444-678-TT","HILA7890","S2017",80,"21-06-2016"),
("420-111-TE","GAPM9076","F2017",75,"08-09-2016"),
("420-111-TE","ALCE7888","F2017",78,"08-09-2016"),
("420-111-TE","PATE8756","F2017",83,"08-09-2016"),
("420-111-TE","HILA7890","F2017",77,"08-09-2016");

SELECT * from student;
SELECT course_id FROM course where course_name= "SGBDR";
SELECT (student_id) from registration WHERE course_id="420-111-TE";
SELECT student_lastname,student_firstname from student WHERE student_city="Montreal";
SELECT student_lastname,student_firstname from student WHERE student_city!="Montreal";
SELECT student_id FROM registration WHERE course_grade > 80;
SELECT student_id, course_id from registration WHERE thesession="S2017";
