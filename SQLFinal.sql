-- Question 1: Creation of the tables of the database 

CREATE TABLE MEMBER(
    id_member NUMBER,
    member_lname VARCHAR(25) NOT NULL,
    member_fname VARCHAR(25),
    city VARCHAR(30),
    phone VARCHAR(15),
    registration_date DATE NOT NULL,
    CONSTRAINT pk PRIMARY KEY(id_member)
);

CREATE TABLE TITLE(
    id_title NUMBER,
    title VARCHAR(60) NOT NULL,
    description VARCHAR(300) NOT NULL,
    category VARCHAR(20),
    release_date Date,
    CONSTRAINT PK PRIMARY KEY(id_title)
);

CREATE TABLE COPY_TITLE(
    id_copy NUMBER,
    id_title NUMBER,
    status_title VARCHAR(15) NOT NULL,
    CONSTRAINT PK PRIMARY KEY(id_copy,id_title),
    CONSTRAINT FK FOREIGN KEY(id_title) REFERENCES TITLE(id_title)
);

CREATE TABLE LOCATION_Table(
    id_title NUMBER,
    id_copy NUMBER,
    id_member NUMBER,
    date_location Date,
    return_date DATE,
    CONSTRAINT PK PRIMARY KEY(date_location, id_member, id_copy, id_title),
    CONSTRAINT FK_MEM FOREIGN KEY(id_member) REFERENCES MEMBER(id_member),
    CONSTRAINT FK_COPY FOREIGN KEY(id_copy) REFERENCES COPY_TITLE(id_copy),
    CONSTRAINT FK_TITLE FOREIGN KEY(id_title) REFERENCES TITLE(id_title)
);

CREATE TABLE BOOKING(
    booking_date DATE NOT NULL,
    id_member NUMBER NOT NULL UNIQUE,
    id_title NUMBER NOT NULL UNIQUE,
    CONSTRAINT PK PRIMARY KEY (booking_date, id_member, id_title),
    CONSTRAINT FK_MEM FOREIGN KEY(id_member) REFERENCES MEMBER(id_member),
    CONSTRAINT FK_TITLE FOREIGN KEY(id_title) REFERENCES TITLE(id_title)
);

-- Question 2: Inserting the data 

INSERT INTO TITLE VALUES    (92,"Willie and Christmas too","All the friends of Willie are doing the invites list","Child","05-10-2016"),
                            (94,"Alien again","Another installation in the history of science fiction","Scientifc","19-05-2017"),
                            (98,"The glob","Spitting an airplane next to a small American town","Scientifc","16-06-2016"),
                            (100,"My day off","Hopefully a teenager runs away from school for a day in New York","Comedy","13-11-2017"),
                            (102,"Miracle on ice","Six-year-old child discovers that miracles still exist","Fiction","12-12-2016"),
                            (93,"Soda Gang","After the discovery of a drug cache, a couple finds themselves in front of a gang group",
                            "Action","14-11-2017");

INSERT INTO MEMBER VALUES   (101,"Valesquez","Carmen","Montreal","514-999-0000","19-06-2015"),
                            (102,"Ngao","Ladoris","Laval","450-999-3333","13-11-2014"),
                            (103,"Nagayama","Midory","Three Rivers","819-888-3456","15-12-2014"),
                            (104,"Quick","Marc","Montreal","514-877-9999","05-01-2010"),
                            (105,"Desjardins","Audrey","Ottawa","613-098-3344","10-03-2011"),
                            (106,"Terrier","Molly","Sherbrooke","819-988-3344","22-05-2009");

INSERT INTO COPY_TITLE VALUES (1, 92, "available"),
                              (1, 94, "available"),
                              (2, 94, "rented"),
                              (1, 98, "available"),
                              (1, 100, "available"),
                              (2, 100, "available"),
                              (3, 100, "rented"),
                              (1, 102, "available");

INSERT INTO LOCATION_Table VALUES  (92,1,101,"10-06-2017","18-07-2017"),
                                   (94,1,101,"22-03-2016","18-07-2017"),
                                   (98,3,102,"10-05-2016","18-07-2017"),
                                   (100,1,104,"14-04-2016","18-07-2017"),
                                   (102,2,103,"13-04-2017","18-07-2017");

-- Question 3: Creating Views
-- 1. Create a view named titre_dispo_view to display the title of the movie and the availability of its copies and the expected return date.
-- 2. Display all the records in the view, order your results in descending order of the title

CREATE VIEW titre_dispo_view
AS SELECT t.title, ct.status_title, lt.return_date
   FROM TITLE t INNER JOIN LOCATION_Table lt 
   ON t.id_title = lt.id_title
   INNER JOIN COPY_TITLE ct 
   ON lt.id_title = ct.id_title;

select * from titre_dispo_view ORDER BY title DESC;

-- Question 4: Modification of tables
-- Add a new title  
-- The film is' intersteller wars', it is classified in the category of science fiction, its launch date is 12-dec-2017, 
-- its description is' action and science-fiction film, is what the rebels can save humans? ' 
INSERT INTO TITLE VALUES (103,"intersteller wars","action and science-fiction film, is what the rebels can save humans?","science fiction","12-12-2017");

-- Make sure you add 2 copies of this movie
INSERT INTO COPY_TITLE VALUES (1,103,"available"),
                              (2,103,"available");
--  Add two bookings using  
-- The first booking of valesquez Carmen, who wants to rent the movie 'intersteller wars'. 
-- - The second booking is from Quick Marc who wants to rent the movie 'Miracle on ice' 
INSERT INTO BOOKING VALUES ("29-11-2018",101,103),
                           ("29-11-2018",104,102);

-- The member valesquez Carmen actually rents the movie 'intersteller wars' copy 1, so add this rental and delete her booking.
INSERT INTO LOCATION_Table VALUES (92,1,101,"29-11-2018","05-12-2018");
INSERT INTO LOCATION_Table VALUES (92,2,104,"29-11-2018","05-12-2018");

DELETE FROM BOOKING WHERE booking_date = "29-11-2018" AND id_title = 103 AND id_member = 101;
DELETE FROM BOOKING WHERE booking_date = "29-11-2018" AND id_title = 102 AND id_member = 104;

-- Add the field price to the table  TITLE, this field should be of data type number.
ALTER TABLE TITLE ADD price NUMBER;

-- Verify your  modifications  using schema command
.schema title

-- Add prices to all films 
UPDATE TITLE SET price = 12 WHERE title = "Alien again";
UPDATE TITLE SET price = 45 WHERE title = "The glob";
UPDATE TITLE SET price = 21 WHERE title = "My day off";
UPDATE TITLE SET price = 30 WHERE title = "Miracle on ice";
UPDATE TITLE SET price = 45 WHERE title = "Soda Gang";
UPDATE TITLE SET price = 89 WHERE title = "intersteller wars";

--Write a query that displays the title and status of all movies whose copies have the available status. (Use the join)
SELECT t.title , ct.status_title
FROM Title T , COPY_TITLE ct
WHERE t.id_title = ct.id_title
AND ct.status_title= "available";

--Write a query that displays the title and category of any copy that has the same category as the movie Alien Again (use the subqueries)
SELECT title as "Title", category as "Category" FROM TITLE WHERE category like (SELECT category FROM TITLE WHERE title = "Alien again" );

-- Display the first and last name and city of the members living neither in Montreal nor in three rivers, as well as their title of rented films.
SELECT m.member_lname AS "Last Name", m.member_fname AS "First Name", m.city AS "City", t.title AS "Rented Films"
FROM MEMBER m INNER JOIN LOCATION_Table lt 
ON m.id_member = lt.id_member
INNER JOIN TITLE t
ON lt.id_title = t.id_title
WHERE  city NOT IN ("Montreal", "Three Rivers");

