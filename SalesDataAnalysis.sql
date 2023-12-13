USE [Sales Sample]

SELECT * FROM Customers
SELECT * FROM Sales
SELECT * FROM Products

--Basic Data Exploration----------------------------------------------------------------

--Total Sales per Year

SELECT '2003' AS Year, COUNT(*) AS TotalSales FROM SALES
WHERE YearId = '2003'
UNION ALL
SELECT '2004' AS Year, COUNT(*) FROM SALES
WHERE YearId = '2004'
UNION ALL
SELECT '2005' AS Year, COUNT(*) FROM SALES
WHERE YearId = '2005';

--Top 10 Selling Products

SELECT TOP (10) ProductCode, ProductLine, SUM(QuantityOrdered) AS TotalQuantitySold
FROM Sales
GROUP BY ProductCode, ProductLine
ORDER BY TotalQuantitySold DESC

--Top 10 Selling Products in the USA

SELECT TOP (10) ProductCode, ProductLine, SUM(QuantityOrdered) AS TotalQuantitySold
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
WHERE CO.Country = 'USA'
GROUP BY ProductCode, ProductLine
ORDER BY TotalQuantitySold DESC

--Top 10 Selling Products in the Canada

SELECT TOP (10) ProductCode, ProductLine, SUM(QuantityOrdered) AS TotalQuantitySold
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
WHERE CO.Country = 'Canada'
GROUP BY ProductCode, ProductLine
ORDER BY TotalQuantitySold DESC

--Total Number of Customers

SELECT COUNT(*) AS NumberOfCustomers
FROM Customers;

--Customers in USA

SELECT COUNT(*) AS NumberOfCustomers
FROM Customers
WHERE Country = 'USA'

--Customers in Canada

SELECT COUNT(*) AS NumberOfCustomers
FROM Customers
WHERE Country = 'Canada'

--Time-based Analysis--------------------------------------------------------------------

--Monthly Sales

SELECT YEAR(OrderDate) AS SalesYear, MONTH(OrderDate) AS SalesMonth, SUM(QuantityOrdered * PriceEach) AS MonthlySales
FROM Sales
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY SalesYear, SalesMonth;

--Monthly Sales in USA

SELECT YEAR(OrderDate) AS SalesYear, MONTH(OrderDate) AS SalesMonth, SUM(QuantityOrdered * PriceEach) AS MonthlySales
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
WHERE Country = 'USA'
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY SalesYear, SalesMonth;

--Sales Growth

SELECT YEAR(OrderDate) AS SalesYear, SUM(QuantityOrdered * PriceEach) AS TotalSales
FROM Sales
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;

--Sales Growth in USA

SELECT YEAR(OrderDate) AS SalesYear, SUM(QuantityOrdered * PriceEach) AS TotalSales
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
WHERE Country = 'USA'
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear;

--Customer Analysis---------------------------------------------------------------------

--Top 10 Highest Spending Customers

SELECT TOP (10) SA.CustomerNumber, CO.CompanyName, COUNT(*) AS TotalOrders, SUM(QuantityOrdered * SA.PriceEach) AS TotalSpent
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
GROUP BY SA.CustomerNumber, CO.CompanyName
ORDER BY TotalSpent DESC

--Top 10 Most Loyal Customer

SELECT TOP (10) CO.CustomerNumber, CO.CompanyName, COUNT(DISTINCT OrderNumber) AS TotalOrders
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
GROUP BY CO.CustomerNumber, CO.CompanyName
ORDER BY TotalOrders DESC

--Product Analysis-----------------------------------------------------------------------

--Top 10 Products generating the Most Revenue

SELECT TOP (10) ProductCode, ProductLine, SUM(QuantityOrdered * PriceEach) AS TotalRevenue
FROM Sales
GROUP BY ProductCode, ProductLine
ORDER BY TotalRevenue DESC

--Top 10 Products generating the Most Revenue in USA

SELECT TOP (10) ProductCode, ProductLine, SUM(QuantityOrdered * PriceEach) AS TotalRevenue
FROM Sales AS SA
JOIN Customers AS CO ON SA.CustomerNumber = CO.CustomerNumber
WHERE Country = 'USA'
GROUP BY ProductCode, ProductLine
ORDER BY TotalRevenue DESC