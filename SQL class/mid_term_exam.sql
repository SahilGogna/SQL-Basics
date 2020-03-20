-- Create the relational model with all the required tables

-- Identify the primary key, foreign keys and relationships
-- ANS Client and Product table has many to many relationship so new table is created. Primary and foreign keys are mentioned in queris below.

-- Be sure all your tables respect the three normal forms
-- Insert data in all your tables , by respecting the inserting order

CREATE TABLE CLIENT(
    client_id VARCHAR(10),
    client_fname VARCHAR(20),
    client_lname VARCHAR(20),
    phone VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(client_id)
);

CREATE TABLE PRODUCT(
    product_id VARCHAR(10),
    product_name VARCHAR(20),
    product_description VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(product_id)
);

CREATE TABLE CLIENTPRODUCT(
    client_id VARCHAR(10),
    product_id VARCHAR(10),
    price currency,
    quantity number,
    purchase_date date,
    CONSTRAINT PK PRIMARY KEY(client_id,product_id,purchase_date),
    CONSTRAINT FK_CLIENT FOREIGN KEY(client_id) REFERENCES CLIENT(client_id),
    CONSTRAINT FK_PRODUCT FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id)
);

INSERT INTO CLIENT VALUES ("Ric01","Alce","Rick","(514)333-2244"),
                          ("Isa01","Chevalier","Isa","(514)666-7777"),
                          ("liv01","Duc","Liv","(514)666-5555"),
                          ("lin01","Blaise","Line","(450)444-7777");

INSERT INTO PRODUCT VALUES ("Ceri01","Cherry","From Gaspésie"),
                           ("Bleu01","Cornflower","From Lac St-Jean"),
                           ("Frai01","Strawberry","From Orléans"),
                           ("Fram01","Raspburry","From Québec");

INSERT INTO CLIENTPRODUCT VALUES ("Ric01","Ceri01","60", "50","8-03-2018"),
                                 ("Ric01","Bleu01","40", "10","8-03-2018"),
                                 ("Isa01","Frai01","50", "25","10-03-2018"),
                                 ("Isa01","Bleu01","40", "38","10-03-2018"),
                                 ("Isa01","Fram01","60", "27","14-03-2017"),
                                 ("lin01","Bleu01","40", "15","14-03-2017"),
                                 ("lin01","Fram01","60", "40","15-03-2017");


-- Rename the table CLIENT to CLIENTS
ALTER TABLE CLIENT RENAME TO CLIENTS;

-- In the table CLIENTS, your client provide you an additionnal information : client_city, so add this field.
ALTER TABLE CLIENTS ADD client_city VARCHAR(20);

-- Insert Montréal city for the two clients:  Alce rick and Duc Liv
UPDATE CLIENTS set client_city ="Montréal" WHERE client_fname="Alce" and client_lname ="Rick";
UPDATE CLIENTS set client_city ="Montréal" WHERE client_fname="Duc" and client_lname ="Liv";

-- Insert Terrebonne for the client Chevalier Lisa.
UPDATE CLIENTS set client_city ="Terrebonne" WHERE client_fname="Chevalier" and client_lname ="Lisa";

-- Extract the client (first name and last name) living in Montréal
SELECT client_fname AS "First Name",client_lname AS "Last Name" FROM CLIENTS WHERE client_city = "Montréal";

-- Display the name and description of the most expensive product.
SELECT product_name AS "Product Name", product_description AS "Description" FROM PRODUCT WHERE product_id IN (SELECT product_id FROM CLIENTPRODUCT WHERE price = (SELECT max(price) FROM CLIENTPRODUCT));
