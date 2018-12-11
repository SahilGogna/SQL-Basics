-- Design the relational model E-R
-- Be sure all the tables are in the three normal forms
-- Create relationships between tables
-- Identify primary keys and foreign keys
CREATE TABLE Member(
    code VARCHAR(5),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(10),
    city VARCHAR(15),
    CONSTRAINT pk PRIMARY KEY(code)
);

CREATE TABLE MOTORCYCLE(
    motonum VARCHAR(10),
    type_moto VARCHAR(10),
    moto_description VARCHAR(10),
    color VARCHAR(10),
    price currency,
    CONSTRAINT pk PRIMARY KEY(motonum)
);

CREATE TABLE MemMoto(
    code VARCHAR(5),
    motonum VARCHAR(10),
    date_rented DATE,
    CONSTRAINT  pk PRIMARY KEY(code, motonum, date_rented),
    CONSTRAINT fk_code FOREIGN KEY(code) REFERENCES Member(code),
    CONSTRAINT fk_motonum FOREIGN KEY(motonum) REFERENCES MemMoto(motonum)
); 
-- Insert data inside tables (member , motorcycle) and for the resulting table insert 2 records of your choice by respecting inserting order

INSERT INTO Member VALUES ("RicP","Rick","Prince","(514)333-2244","Montréal"),
                          ("IsaC","Isa","Chevalier","(514)556-7788","Montréal"),
                          ("LivD","Livy","Duc","(514)678-5544","Montréal"),
                          ("LynB","Lyne","Bella","(450)456-7720","Montréal");

INSERT INTO MOTORCYCLE VALUES ("MOTO001","Italien","ATALA","Red",100),
                             ("MOTO002","Deca","BTWIN","Black",225),
                             ("MOTO003","Italien","Suisse","White",400),
                             ("MOTO004","Italien","Japonais","Black",200);

INSERT INTO MemMoto VALUES ("RicP","MOTO001","21-06-2017"),
                           ("IsaC","MOTO001","22-06-2017");

-- Add the field cellphone to the member table, define the datatype as number
ALTER TABLE Member ADD cellphone number;

-- Extract the information of all the motorcycles with the color black.
SELECT * FROM MOTORCYCLE WHERE color ="Black";

-- Extract the id and the type of the motorcycle that the description started by J
SELECT motonum ,type_moto  from MOTORCYCLE WHERE moto_description LIKE "J%";
