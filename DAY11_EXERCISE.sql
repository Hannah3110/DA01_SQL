--Day11_Exercise1
select A.CONTINENT, floor(avg(B.POPULATION))
from COUNTRY as A
INNER JOIN CITY as B
on B.COUNTRYCODE=A.CODE
group by A.CONTINENT
--Day11_Exercise2
