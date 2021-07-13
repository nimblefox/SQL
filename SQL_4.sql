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