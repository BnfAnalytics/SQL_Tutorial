# Example 1: Create a view of customers with their contact information.
SELECT CustomerName,ContactName,City
FROM Customers;

CREATE VIEW CustomerContact AS
SELECT CustomerName, ContactName, city
FROM Customers
Where city='london';

SELECT* FROM customerContact;

# Example 2: Create a view of employees and their hire dates.
use dm1_aug;
SELECT* from employee;
# Before running this query , create a new column name HireData and insert dates into this column
CREATE VIEW EmployeeHiringDates AS
SELECT EmployeeID, LastName, FirstName, HireDate
FROM Employees;
SELECT* FROM EmployeeBirthDates;

# Example 3: Create a view of orders with their order dates.
CREATE VIEW OrderDates AS
SELECT OrderID, OrderDate
FROM Orders;
SELECT* from orderdates;

# Example 4: Create a view of products with their prices.
CREATE VIEW ProductPrices AS
SELECT ProductName, Price
FROM Products;

# Example 5: Create a view of orders with customer information.
CREATE VIEW OrderCustomerInfo AS
SELECT o.OrderID, c.CustomerName, c.ContactName
FROM Orders o
INNER JOIN Customers c 
  ON o.CustomerID = c.CustomerID;

# Example 6: Create a view of employees with their managers' information.
CREATE VIEW EmployeeManagers AS
SELECT e.EmployeeID, e.FirstName, e.LastName, m.FirstName AS ManagerFirstName, m.LastName AS ManagerLastName
FROM Employee e
LEFT JOIN Employee m 
   ON e.EmployeeID = m.EmployeeID;

# Example 7: Create a view of products with their suppliers' information.
CREATE VIEW ProductSuppliers AS
SELECT p.ProductName, s.SupplierName, s.ContactName, s.Phone
FROM Products p
INNER JOIN Suppliers s 
     ON p.SupplierID = s.SupplierID;

# Example 8: Create a view of orders with product details.
CREATE VIEW OrderProductDetails AS
SELECT o.OrderID, p.ProductName, od.Quantity, od.UnitPrice
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

# Example 9: Create a view of customers and their orders.
CREATE VIEW CustomerOrders AS
SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

# Example 10: Create a view of employees and the number of orders they've handled.
CREATE VIEW EmployeeOrderCounts AS
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

# Example 11: Create a view of employees with their total sales.
CREATE VIEW EmployeeTotalSales AS
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

# Example 12: Create a view of customers with their average order value.
CREATE VIEW CustomerAvgOrderValue AS
SELECT c.CustomerID, c.CustomerName, AVG(od.Quantity * od.UnitPrice) AS AvgOrderValue
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;

# Example 13: Create a view of products with the number of times they've been ordered.
CREATE VIEW ProductOrderCounts AS
SELECT p.ProductID, p.ProductName, COUNT(od.OrderID) AS OrderCount
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

# Example 14: Create a view of customers with their total purchases and total payments.
CREATE VIEW CustomerPurchaseSummary AS
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity) AS TotalPurchases, SUM(od.Quantity * od.UnitPrice) AS TotalPayments
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;

# Example 15: Create a view of products with their total sold quantity.
CREATE VIEW ProductSoldQuantity AS
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalSoldQuantity
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

# Example 16: Create a view of employees with the number of orders they've handled, including year-wise breakdown.
CREATE VIEW EmployeeOrderCountsByYear AS
SELECT e.EmployeeID, e.FirstName, e.LastName, YEAR(o.OrderDate) AS OrderYear, COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, OrderYear;

# Example 17: Create a view of customers with their highest order value and corresponding date.
CREATE VIEW CustomerMaxOrderValue AS
SELECT c.CustomerID, c.CustomerName, MAX(od.Quantity * od.UnitPrice) AS MaxOrderValue,
       o.OrderDate AS MaxOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;

# Example 18: Create a view of employees with their total sales and average order value.
CREATE VIEW EmployeeSalesAndAvgOrderValue AS
SELECT e.EmployeeID, e.FirstName, e.LastName,
       SUM(od.Quantity * od.UnitPrice) AS TotalSales,
       AVG(od.Quantity * od.UnitPrice) AS AvgOrderValue
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

# Example 19: Create a view of products with their total sales and average price.
CREATE VIEW ProductSalesAndAvgPrice AS
SELECT p.ProductID, p.ProductName,
       SUM(od.Quantity * od.UnitPrice) AS TotalSales,
       AVG(od.UnitPrice) AS AvgPrice
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

# Example 20: Create a view of employees with the number of orders they've handled in each month.
CREATE VIEW EmployeeMonthlyOrderCounts AS
SELECT e.EmployeeID, e.FirstName, e.LastName,
       YEAR(o.OrderDate) AS OrderYear,
       MONTH(o.OrderDate) AS OrderMonth,
       COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, OrderYear, OrderMonth;
