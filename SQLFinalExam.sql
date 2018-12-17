--author Sahil Gogna

--question 1 create Tables
CREATE TABLE CD(
    cdNo VARCHAR(20),
    title VARCHAR(20),
    author VARCHAR(20),
    price currency,
    CONSTRAINT pk PRIMARY KEY(cdNo)
);

CREATE TABLE CLIENT(
    id_client VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    CONSTRAINT pk PRIMARY KEY(id_client)
);

CREATE TABLE PURCHASE(
    cdNo VARCHAR(20),
    id_client VARCHAR(20),
    purchase_price currency,
    quantity number,
    purchase_date date,
    CONSTRAINT pk PRIMARY KEY(id_client, cdNo , purchase_date),
    CONSTRAINT fk_client FOREIGN KEY(id_client) REFERENCES CLIENT(id_client),
    CONSTRAINT fk_cd FOREIGN KEY(cdNo) REFERENCES CD(cdNo)
);

--question 2 inserting the values

INSERT INTO CLIENT VALUES ("JokP2244", "Joker", "Prince", "5143332244"),
                          ("JumC7788", "Jumper", "Chevalier", "5145567788"),
                          ("JacB7720", "Jack", "Baron", "4504567720");

INSERT INTO CD VALUES ("CD1000","La mer", "Prince", 15),
                        ("CD1001","Le soleig", "Prince", 20),
                        ("CD1002","La plage", "Leduc", 20),
                        ("CD1003","La sable", "Leduc", 20);

INSERT INTO PURCHASE VALUES ("CD1000","JokP2244", 15,30,"08-10-2016"),
                            ("CD1001","JokP2244", 20,10,"08-10-2016"),
                            ("CD1000","JumC7788", 15,20,"08-10-2016"),
                            ("CD1001","JumC7788", 25,50,"10-10-2016"),
                            ("CD1002","JumC7788", 25,20,"21-10-2016"),
                            ("CD1003","JacB7720", 20,20,"21-10-2016");

-- question 3 
.header on
.schema CLIENT
.schema CD
.schema PURCHASE

select * from CLIENT;
select * from CD;
select * from PURCHASE;

-- question 4 (price is from purchase table as told in exam)

CREATE VIEW CLIENT_CD
AS SELECT  id_client AS "Client ID", first_name AS "First Name", last_name AS "Last Name"
FROM CLIENT WHERE id_client IN (SELECT id_client FROM PURCHASE
WHERE purchase_price < (SELECT avg(purchase_price) FROM PURCHASE));

-- question 5
ALTER TABLE CLIENT ADD city VARCHAR(20);

--question 6
SELECT avg(price) AS "Average Price", max(price) AS "Maximum Price", min(price) AS "Minimum", count(price) AS "Count"
FROM CD;

--question 7 (price is from purchase table as told in exam)
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM CLIENT WHERE id_client IN (SELECT id_client FROM PURCHASE WHERE purchase_price > (SELECT avg(purchase_price) FROM PURCHASE));

--question 8
SELECT last_name AS "Last Name", first_name AS "First Name"
FROM CLIENT WHERE id_client IN (SELECT id_client FROM PURCHASE WHERE purchase_date = "08-10-2016");

--question 9
UPDATE CD SET price = price*0.95;

--question 10
DELETE FROM PURCHASE WHERE purchase_date = "08-10-2016" 
AND id_client = (SELECT id_client FROM CLIENT WHERE first_name = "Joker" AND last_name = "Prince");

