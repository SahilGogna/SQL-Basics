/*
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT SUM(ci.POPULATION)
FROM CITY ci
INNER JOIN COUNTRY Co 
on ci.CountryCode = co.Code
and co.CONTINENT = "Asia"; 