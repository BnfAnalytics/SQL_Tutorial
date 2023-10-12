# Create Table and insert Data into Table
Create Table Employee
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
);
Insert into Employee VALUES
(1001, 'Jim', 'Halpert', 30, 'Male');
Insert into employee values
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');

SELECT* FROM employee;

CREATE TABLE empsalary
(EmployeeID int,
JobTitle varchar(50),
salary int
);

insert into empsalary values
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000);


insert into employee values
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male');

select* from employee;
select* from empsalary; # to see the table empsalary

/* Contents
1. WHERE 
2. Update/Delete
3. Having Clause
4. Joins
5. Union/Union ALL
6. Pivot in SQL (Case Statement)
7. Subqueries
8. String Functions
9. Partition by
10. CTEs(Common Table Expressions)
11. Views
12. Window Function

6/9/2023
13. Temp Tables
14. Stored Procedures

7/9/2023
15. Triggers
*/
-- 1. WHERE --
select* from employee
WHERE age=30; # Where works like filter in SQL

SELECT* FROM employee
WHERE firstname='Pam';

/* 8/8/2023
2. Update/Delete
3. Having Clause
4. Joins
*/


# update and Delete functions
SELECT* FROM employee;
UPDATE employee
SET employeeid=1012
WHERE Firstname='Holly' AND Lastname='Flax';

UPDATE employee
SET age=31,gender='Female'
WHERE Firstname='Holly' AND Lastname='Flax';

delete from employee
WHERE employeeid=1005;
/* Having function
Aggregated functions
SUM
Average
Count
MAx
Min*/
SELECT * from empsalary;
SELECT Jobtitle,avg(salary) as avgsalary
from empsalary
group by JobTitle
HAVING avg(salary)>40000;

SELECT jobtitle, COUNT(*) AS employee_count
FROM empsalary
GROUP BY jobtitle
HAVING COUNT(*) > 3;

CREATE VIEW Empcount AS
SELECT jobtitle, COUNT(*) AS employee_count
FROM empsalary
GROUP BY jobtitle
HAVING COUNT(*) > 2;

select* from empcount;


/* #Joins
1. INNER JOIN
2. Cross Join(Full outer Join)
3. Right Join
4. Left Join
*/
SELECT* FROM employee;
SELECT* FROM empsalary;

SELECT employee.employeeid,firstname,age, gender,salary 
FROM employee
INNER JOIN empsalary
  ON employee.employeeid=empsalary.EmployeeID
WHERE age>30;

SELECT employee.employeeid,firstname,age, gender,salary 
FROM employee
Right JOIN empsalary
  ON employee.employeeid=empsalary.EmployeeID;
  
SELECT employee.employeeid,firstname,age, gender,salary 
FROM employee
LEFT JOIN empsalary
  ON employee.employeeid=empsalary.EmployeeID;

SELECT employee.employeeid,firstname,age, gender,salary 
FROM employee
cross JOIN empsalary;

/* 5. Union/Union ALL
6. Pivot in SQL (Case Statement)
*/

#UNION and UNION ALL
Create Table ITEmployee
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
);

Insert into itemployee values
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hideroshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female');

SELECT * FROM employee
UNION ALL  # allow all duplicate values
SELECT* FROM itemployee;

SELECT * FROM employee
UNION 
SELECT* FROM itemployee;

SELECT EmployeeID, FirstName, Age FROM employee
UNION 
SELECT EmployeeID,salary,JobTitle FROM empsalary;

# Case Statement(Pivot in SQL)
SELECT Firstname,LastName,Age,
CASE
   WHEN age>30 THEN 'Expert'
   WHEN age Between 27 and 30 then 'Experience'
   Else 'Freshers'
   END as professional
   
FROM employee;



SELECT Firstname,Lastname, Jobtitle,Salary,
CASE
  WHEN JobTitle='Salesman' Then salary+(salary*0.1) # 10% increment to salesman
  WHEN JobTitle='Accountant' then salary+(salary*0.05) #5% increment to accountant
  WHEN JobTitle='HR' then salary+(salary*0.0001) # 0.001% increment to HR
  Else salary+(salary*0.03)
  END as SalaryAfterRaise
From employee
Join empsalary
  on employee.EmployeeID=empsalary.EmployeeID;

                             # Subqueries (In SELECT,FROM and WHERE)
#SELECT
SELECT employeeID,SALARY,
                 (SELECT AVG(Salary) FROM empsalary) as AllAvgSalary
from empsalary;





SELECT EmployeeID,Salary, AVG(Salary) as AllAvgSalary
from empsalary
GROUP by EmployeeID,salary;

#FROM

SELECT employeeID,AllAvgSalary
FROM (SELECT employeeID,SALARY,
                 (SELECT AVG(Salary) FROM empsalary) as AllAvgSalary
	   from empsalary) as newtable;




# 28.8.2023
#WHERE 
SELECT employeeID,Jobtitle,Salary
FROM empsalary
WHERE EmployeeID in (SELECT EmployeeID FROM employee WHERE age>30);


# 11. String Functions

CREATE TABLE emperror
(EmployeeID varchar(10), 
FirstName varchar(50), 
LastName varchar(50)
);
INSERT INTO emperror VALUES
('1001   ','Jimbo','Halbert'),
('   1002','Pamela','Beasely'),
('1005','TOby','Flenderson-Fired');

SELECT* from emperror;
-- USING TRIM,LTRIM,RTRIM

SELECT EmployeeID,TRIM(employeeID) as IDTRIM
from emperror;

SELECT EmployeeID,LTRIM(employeeID) as IDLTRIM
from emperror;

SELECT EmployeeID,RTRIM(employeeID) as IDRTRIM
from emperror;

-- using REPLACE
SELECT Lastname, REPLACE(Lastname,'-Fired','') as LastNameFixed
from emperror;

SELECT Firstname, REPLACE(Firstname,'O','o') as FirstNameFixed
from emperror;

-- Using UPPER and LOWER
SELECT firstname, LOWER(Firstname)
from emperror;

SELECT firstname, upper(Firstname)
from emperror;

/* 1/9/2023
Friday(IST)
7. Partition by
8. CTEs(Common Table Expressions)
*/
# Partition BY
SELECT Firstname, LastName,gender, salary,
   count(gender) OVER(partition by gender) as Tgender
FROM employee
Join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

SELECT Firstname, LastName,gender, salary,JobTitle,
   avg(salary) OVER(partition by JobTitle) as Tgender
FROM employee
Join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

#CTEs(Common Table Expressions)

with Rankofemp as(
SELECT e.EmployeeID, e.FirstName, es.JobTitle, es.salary,
    row_number() OVER (ORDER BY es.salary DESC) as rank1
from employee as e
join empsalary as es
 on e.EmployeeID=es.EmployeeID
)
SELECT* from Rankofemp;

with cte_1 as(
SELECT Firstname, LastName,gender, salary,JobTitle,
   avg(salary) OVER(partition by JobTitle) as Tgender
FROM employee
Join empsalary
 on employee.EmployeeID=empsalary.EmployeeID
)
SELECT* from cte_1;

/* Temp Tables*/
# CREATE TABLE @temp_empsalary
CREATE temporary TABLE temp_empsalary(
empid int,
jobtitle varchar(50),
Salary int
);
SELECT* FROM temp_empsalary;

# INSERT into temp_empsalary values ('1001', 'Salesman','45000');

INSERT INTO temp_empsalary
SELECT* FROM empsalary;

DROP TABLE IF exists temp_employee;
CREATE temporary TABLE temp_employee1(
Jobtitle varchar(50),
Empperjob int,
AvgAge int,
AvgSalary int);

INSERT INTO temp_employee
SELECT jobtitle, count(jobtitle), Avg(age), avg(salary)
FROM employee as emp
  JOIN empsalary as sal
     on emp.EmployeeID=sal.EmployeeID
GROUP by jobtitle;

SELECT* from temp_employee;




/* Stored Procedures*/
# Get all customers from a specific city
DELIMITER //
CREATE PROCEDURE GetallcustomerbyCity( in cityname VARCHAR(50))
BEGIN
    SELECT* 
    FROM customers 
    WHERE City=cityname;
END; 
//
DELIMITER ;

CALL GetallcustomerbyCity('London');

# Get order details for a specific order ID
DELIMITER //
CREATE PROCEDURE GetOrderdetails( in order_ID int)
BEGIN
    SELECT* 
    FROM orderdetails 
    WHERE OrderID=order_ID;
END; 
//
DELIMITER ;

CALL GetOrderdetails(10248);

Select* from orderdetails;






DELIMITER //
CREATE PROCEDURE TotalOrders( 
                              IN customer_ID int,
                              OUT totalAmount decimal(10,2))
BEGIN
    SELECT SUM(Quantity) into totalAmount
    FROM orderdetails
    WHERE OrderID IN(
                   SELECT orderid 
                   FROM Orders
                   WHERE CustomerID=customer_ID);
END; 
//
DELIMITER ;
CALL TotalOrders(5, @totalAmount);
SELECT @totalAmount;


# Update Product Price by a percentage

DELIMITER //
CREATE PROCEDURE updatedPrices(IN product_ID int, IN percentageChange Int)
begin
 Update products
 SET Price=Price*(1+percentageChange/100)
 Where ProductID=product_ID;
 END;
 
 //
 DELIMITER ;

CALL updatedPrices(10,10);
select* from updatedPrices;

# Get the top N Customers with the highest purchase amount

DELIMITER //
CREATE PROCEDURE GetTopCustomers(IN n Int)
begin
 SELECT c.CustomerName, SUM(od.Quantity*p.Price) as TotalAmount
 FROM Customers c
 JOIN Orders o ON c.customerID=o.CustomerID
 JOin orderdetails od ON o.orderID=od.OrderID
 join products p	on od.ProductID=p.ProductID
 GROUP BY c.CustomerName
 order by TotalAmount desc
 LIMIT n;
 END;
  //
 DELIMITER ;
CALL GetTopCustomers(3);







