CREATE TABLE department(
    dep_id VARCHAR(20),
    dep_name VARCHAR(20),
    dep_location VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(dep_id)
);

CREATE TABLE software(
    soft_id VARCHAR(20),
    dep_id VARCHAR(20),
    soft_name VARCHAR(20),
    soft_title VARCHAR(30),
    CONSTRAINT PK PRIMARY KEY(soft_id),
    CONSTRAINT fk FOREIGN KEY(dep_id) REFERENCES department(dep_id)
);

CREATE TABLE client(
    client_id VARCHAR(20),
    client_Fname VARCHAR(20),
    client_Lname VARCHAR(20),
    client_phone VARCHAR(20),
    client_city VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(client_id)
);

CREATE TABLE sale(
    client_id VARCHAR(20),
    soft_id VARCHAR(20),
    sale_date date,
    sale_price currency,
    sale_Quantity number,
    CONSTRAINT PK PRIMARY KEY(soft_id,client_id,sale_date),
    CONSTRAINT FK_Soft FOREIGN KEY(soft_id) REFERENCES software(soft_id),
    CONSTRAINT FK_Client FOREIGN KEY(client_id) REFERENCES client(client_id)
);

CREATE TABLE supplier(
    sup_id number,
    sup_Fname VARCHAR(20),
    sup_Lname VARCHAR(20),
    sup_phone VARCHAR(20),
    CONSTRAINT PK PRIMARY KEY(sup_id)
);

CREATE TABLE purchase(
    soft_id VARCHAR(20),
    sup_id VARCHAR(20),
    purchase_date date,
    purchase_price currency,
    purchase_quantity number,
    CONSTRAINT PK PRIMARY KEY(soft_id, sup_id),
    CONSTRAINT FK_Soft FOREIGN KEY(soft_id) REFERENCES software(soft_id),
    CONSTRAINT FK_Sup FOREIGN KEY(sup_id) REFERENCES supplier(sup_id)
);

INSERT INTO department VALUES ("DEPPROG", "programming","floor 1"),
                                ("DEPRES", "network","floor 2");
--("DEPTEC", "Technical support","floor 3")

INSERT INTO software VALUES ("Log01", "DEPPROG", "Visual studio","Software to use c++"),
                            ("Log02", "DEPRES", "Dreamweaver","Software for web"),
                            ("Log03", "DEPRES","NetLimiter","Software to contrôle the network activity");

INSERT INTO client VALUES ("LAZM01","Lazar","Marie","(514)234-7888","Montreal"),
                          ("TOUM02","Touma","Melanie","(514)566-8756","Montreal"),
                          ("MAJI03","Majic","Imane","(450)687-7890","Longueuil"),
                          ("GAPM9076","Gaspe","Mohan","(450)873-9076","Longueuil");

INSERT INTO sale VALUES ("LAZM01","Log01","21-06-2017",2000,10),
                        ("TOUM02","Log02","01-07-2018",100,100),
                        ("MAJI03","Log01","21-06-2016",1000,20),
                        ("GAPM9076","Log03","12-09-2015",750,35);


INSERT INTO supplier VALUES ("SUP01","Desjadins","Marcel","(514)234-7888"),
                            ("SUP02","Pare","Jo","(450)687-7890"),
                            ("SUP03","Leblond","Anick","(514)566-8756"),
                            ("SUP04","Tarier","Mami","(450)873-9076");


INSERT INTO purchase VALUES ("Log01","SUP01","21-06-2016",1000,7),
                            ("Log02","SUP02","21-09-2018",500,17),
                            ("Log03","SUP03","21-03-2017",1500,25);

--  display the client (id, name)  who made the highest sales.
SELECT c.client_id as "Client Id",c.client_Fname as "Client First Name", max(s.sale_Quantity) as "Quantity"
FROM client c INNER JOIN sale s
ON c.client_id = s.client_id;

-- Display the software id provided by the supplier  SUP01
SELECT soft_id as "Software Id"
FROM purchase
WHERE sup_id = "SUP01";

-- Display the software id and software name provided by the supplier  SUP01
SELECT s.soft_id as "Software Id", s.soft_name as "Software Name"
FROM software s INNER join purchase p
ON s.soft_id = p.soft_id
AND p.sup_id = "SUP01";

-- Display the softwares list of the software that has never been sold (nested queries)
SELECT soft_id as "Unsold Software Id"
FROM software 
WHERE soft_id NOT IN (SELECT soft_id from sale);

-- Display the customer (full name) who made sales above the maximum purchase
SELECT c.client_Fname as "Client First Name", c.client_Lname as "Client Last Name"
FROM client c INNER JOIN sale s
ON c.client_id = s.client_id
WHERE s.sale_Quantity > (select max(purchase_Quantity) from purchase);

-- Display the id and the name of the software provided by the supplier pare jo
SELECT s.soft_id as "Software Id", s.soft_name as "Software Name"
FROM software s INNER JOIN purchase p
ON s.soft_id = p.soft_id
INNER JOIN supplier sup
ON p.sup_id = sup.sup_id
where sup.sup_Fname = "Pare"
AND sup.sup_Lname = "Jo";

-- Display all the softwares with theire department name, display even the department that does not have softwares
SELECT  d.dep_name as "Department Name", s.soft_id as "Software Id"
FROM department d LEFT JOIN software s
ON s.dep_id = d.dep_id;
