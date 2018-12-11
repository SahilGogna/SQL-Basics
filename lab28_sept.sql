Question 1: 

CREATE table product (
    product_id number,
    product_name VARCHAR(20),
    product_price currency,
    CONSTRAINT pk PRIMARY KEY(product_id)
);

INSERT INTO product VALUES (1,"Laptop",130),
                           (2,"Iphone",190),
                           (3,"Laptop",300),
                           (4,"Iphone",120),
                           (5,"Televiseur",80);


--Question 1:

--Display the total price for each product
SELECT SUM(product_price) as "Total Price", product_name as Product  FROM product GROUP BY product_name; 

--Display the total price for each product but only total product >100
SELECT SUM(product_price) as "Total Price", product_name as Product  FROM product GROUP BY product_name HAVING sum(product_price) > 100;

--Question 2:

--Display the average of grades of all students
SELECT avg(course_grade) as "Average grade" from registration;

--Display the average of the students grade of student who have the course 444-678-TT
SELECT avg(course_grade) as "Average grade", course_id as "Course Name" from registration where course_id = "444-678-TT";

--what the number of the students registered in the course 420-111-TE in the session E2017 
SELECT count(student_id) as "Number of Students", course_id as "Course Name" from registration where course_id="420-111-TE" AND thesession="E2017";

--what is the total cost of all prices of all courses.
SELECT sum(course_price) as "Total Cost" from course;

--Display the student id of students who has grade >the average of all the class
SELECT student_id FROM registration WHERE grade > (SELECT avg(grade) FROM registration);


--Question 3:

CREATE table country_population(
    record_id number,
    country VARCHAR(20),
    country_population number,
    year_recorded DATE,
    CONSTRAINT pk PRIMARY KEY(record_id)
);

INSERT into country_population VALUES (1,"India", 1000, "1990"),
                                      (2,"Nepal", 200, "1990"),
                                      (3,"India", 1500, "1991"),
                                      (4,"Sri Lanka", 500, "1990"),
                                      (5,"Nepal", 400, "1991"),
                                      (6,"India", 2000, "1992"); 

--How many records are the table?
SELECT count(record_id) as "Total Records" from country_population;

--What is the total population of all records? Display the result with the header  totalPopulation
SELECT sum(country_population) as "Total Population" FROM country_population;

--Display the largest population, the smallest popupation, give alias to your columns
SELECT max(country_population) as "Max Population", min(country_population) as "Min Population" FROM country_population;

--Display the total population of each country
SELECT sum(country_population) as "Total Population", country as "Country Name" FROM country_population GROUP BY (country);

--Display the total population of each country each year
SELECT sum(country_population) as "Total Population" , country as "Country Name", year_recorded as "Year" FROM country_population GROUP BY country,year_recorded;

--Display the total population of each country only if this population is > 1000.
SELECT sum(country_population) as "Total Population", country as "Country Name" FROM country_population GROUP BY (country) HAVING sum(country_population)>1000;
