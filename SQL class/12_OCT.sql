/*alter an already exusting table */
ALTER TABLE table_name ADD column_name type;

/* how to add value to newly added column, we can't use insert beacause it is used to insert a new row*/
UPDATE table_name SET column_name="value"; /*added value to all rows*/

/*unique value for each row and column*/
UPDATE table_name SET column_name="value" where student_id="id_value";

/* using two columns as constraints */
UPDATE student set college ="canada" WHERE first_name="pabel" and last_name ="ed";

/*to apply discount of 50% on price of courses*/
UPDATE course set price=price*0.5;

/*never compare sets with equal use in*/



SELECT productid, productname from product WHERE price= (select max(price) from product);

SELECT productid, productname from product WHERE productid = (select productid from invoicedProduct where price = (SELECT max(price) from invoicedPrice));

SELECT productName FROM product where productId = ANY (SELECT productid from invoicedProducts where quantity = 4);

CREATE TABLE person (
    idperson number,
    lastname varchar(20),
    firstname varchar(20),
    age number,
    CONSTRAINT pk PRIMARY KEY(idperson)
);

CREATE TABLE car(
    id_car number,
    type VARCHAR(20),
    car_year date,
    price number,
    idperson number,
    CONSTRAINT pk PRIMARY KEY(id_car),
    CONSTRAINT fk FOREIGN KEY(idperson) REFERENCES person(idperson)
);

INSERT INTO person VALUES (1, "rights","adam",23),
                          (2, "broad","jass",24),
                          (3, "ponting","bob",18),
                          (4, "gilchrist","jane",27),
                          (5, "anderson","jack",29) ;

INSERT INTO car VALUES    (1, "sports","2018-09-19",12000,1),
                          (2, "muscle","2018-09-19",2000,2),
                          (3, "vintage","2018-09-19",800,3),
                          (4, "sports","2018-09-19",8000,4),
                          (5, "vintage","2018-09-19",125000,1);

/*The first name and the last name of person who does not have cars*/
SELECT firstname as "First Name", lastname as "Last Name" FROM person WHERE idperson NOT IN (select idperson from car);

/*The first name and the last name of person who does not have a car with the price >20000*/
SELECT firstname as "First Name", lastname as "Last Name" FROM person WHERE idperson IN (select idperson from car WHERE price <20000);

/*The first name and the last name of person who has the most expensive car*/
SELECT firstname as "First Name", lastname as "Last Name" from person where idperson = (SELECT idperson from car WHERE price = (SELECT max(price) from car));

/*The number of person for each car type*/
SELECT count(idperson) as "Count", type AS "Type" FROM car GROUP BY (type); 

/*The first name and the last name of oldest person*/
SELECT firstname as "First Name", lastname as "Last Name" from person WHERE age= (SELECT max(age) from person);

/*Extract the 3 first record of your person table*/
SELECT * from person limit 3;