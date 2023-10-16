-- WINDOW FUNCTIONS

-- 1. Rank employees by salary in descending order.
SELECT  employee.EmployeeID,  FirstName,  LastName,  Salary,
  RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employee
 join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

-- 2. Calculate the average salary for each job title.
SELECT  JobTitle,
  AVG(Salary) OVER (PARTITION BY JobTitle) AS AvgSalary
FROM empsalary;

-- 3. Calculate the difference in age between each employee and the oldest employee in their department.
SELECT  employee.EmployeeID,  FirstName,  LastName,  Age,Jobtitle,
  MAX(Age) OVER (PARTITION BY JobTitle) - Age AS AgeDifferenceFromOldest
FROM Employee
 join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

-- 4. Rank employees within each job title by age in ascending order.
SELECT  employee.EmployeeID,  FirstName,  LastName,  JobTitle,  Age,
  DENSE_RANK() OVER (PARTITION BY JobTitle ORDER BY Age) AS AgeRank
FROM Employee
 join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

-- 5. Calculate the running total of salaries in ascending order of employee ID.
SELECT  employee.EmployeeID,  FirstName,  LastName,  Salary,
  SUM(Salary) OVER (ORDER BY EmployeeID ASC) AS RunningTotalSalary
FROM Employee
 join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;

-- 6. Calculate the difference in salary between each employee and their manager.
SELECT  employee.EmployeeID,  FirstName,  LastName,  Salary,
  LAG(Salary) OVER (ORDER BY EmployeeID ASC) AS ManagerSalary
FROM Employee
 join empsalary
 on employee.EmployeeID=empsalary.EmployeeID;


-- 7. Identify the age distribution within each job title.
SELECT  JobTitle,  Age,
  COUNT(*) OVER (PARTITION BY JobTitle, Age) AS AgeCount
FROM Employees;

-- 8. Calculate the difference in salary between each employee and the employee with the next highest salary.
SELECT  EmployeeID,  FirstName,  LastName,  Salary,
  Salary - LEAD(Salary) OVER (ORDER BY Salary DESC) AS SalaryDifferenceFromNextHighest
FROM Employees;

-- 9. Rank employees by salary within each gender, with the same rank for the same salary.
SELECT  employee.EmployeeID,  FirstName,  LastName,  Salary,  Gender,
  DENSE_RANK() OVER (PARTITION BY Gender ORDER BY Salary DESC) AS SalaryRank
FROM Employee
join empsalary
on employee.EmployeeID=empsalary.EmployeeID;













