-- Chapter 5
-- Joining Tables


-- Inner Join: only common records
SELECT COUNT(SalesOrderID)
FROM AdventureWorks2019.Sales.SalesOrderHeader;
--31,465

SELECT SalesOrderID
FROM AdventureWorks2019.Sales.SalesOrderDetail;
--1,21,317

SELECT s.SalesOrderID, s.OrderDate, s.TotalDue, d.SalesOrderDetailID,
 d.ProductID, d.OrderQty
FROM AdventureWorks2019.Sales.SalesOrderHeader AS s
INNER JOIN AdventureWorks2019.Sales.SalesOrderDetail AS d ON s.SalesOrderID = d.SalesOrderID;
 
-- incorrect query join
SELECT s.SalesOrderID, OrderDate, TotalDue, SalesOrderDetailID,
 d.ProductID, d.OrderQty
FROM AdventureWorks2019.Sales.SalesOrderHeader AS s
INNER JOIN AdventureWorks2019.Sales.SalesOrderDetail d ON 1 = 1;


-- Joining on a Different Column Name
SELECT c.CustomerID, c.PersonID, p.BusinessEntityID, p.LastName
FROM AdventureWorks2019.Sales.Customer AS c
INNER JOIN AdventureWorks2019.Person.Person AS p ON c.PersonID = p.BusinessEntityID;

-- Joining on More Than One Column
SELECT sod.SalesOrderID, sod.SalesOrderDetailID,
 so.ProductID, so.SpecialOfferID, so.ModifiedDate
FROM AdventureWorks2019.Sales.SalesOrderDetail AS sod
INNER JOIN AdventureWorks2019.Sales.SpecialOfferProduct AS so
 ON so.ProductID = sod.ProductID AND
 so.SpecialOfferID = sod.SpecialOfferID
WHERE sod.SalesOrderID IN (51116,51112);

-- Joining Three or More Tables
SELECT soh.SalesOrderID, soh.OrderDate, p.ProductID, p.Name
FROM AdventureWorks2019.Sales.SalesOrderHeader as soh
INNER JOIN AdventureWorks2019.Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN AdventureWorks2019.Production.Product AS p ON sod.ProductID = p.ProductID
ORDER BY soh.SalesOrderID;

SELECT soh.SalesOrderID, soh.OrderDate, p.ProductID, p.Name
FROM Sales.SalesOrderHeader as soh
INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product AS p ON sod.ProductID = p.ProductID
ORDER BY soh.SalesOrderID;