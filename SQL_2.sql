--Book : Beginning T-SQL: A Step-by-Step Approach, Kathi Kellenberger and Lee Everest

/* Exercises in this book will use both the AdventureWorks2019 and WideWorldImporters databases. 
AdventureWorks is a fictitious cycling company thatsells bicycles and accessories online and to bike shops. 
WideWorldImporters is a fictitious wholesale company that imports quirky items like USB flash drives that look
like food */  


-- activate adventureworks2019 DB
USE AdventureWorks2019;
GO


-- Explore AdventureWorks DB
SELECT * FROM INFORMATION_SCHEMA.TABLES  -- I see 91 objects
SELECT DISTINCT TABLE_SCHEMA FROM INFORMATION_SCHEMA.TABLES  -- 6 unique table_schemas, 2 table_types : BASE_TABLE and VIEW


-- Check job titles of all employees
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee;
---The first part, HumanResources is a SCHEMA name. In SQLServer, groups of related tables can be organized together as schemas
--The best practice is to write SELECT lists specifying exactly the columns that you need and return only the rows you need. Not *
-- If you want to get table names GoTo > Table > Script Table as > SELECT TO > Copy to clipboard
-- Table names are usually not case sensitive unless its 'collation' is turned on


-- Write a SELECT statement that lists the customers. 
--Include the CustomerID, StoreID, and AccountNumber columns from the Sales.Customer table.
SELECT [CustomerID]
      ,[StoreID]
      ,[AccountNumber]
  FROM [AdventureWorks2019].[Sales].[Customer];


-- Write a SELECT statement that lists the name, product number, and color of 
-- each product from the Production.Product table.
SELECT [Name]
      ,[ProductNumber]
      ,[Color]
  FROM [AdventureWorks2019].[Production].[Product];


-- Write a SELECT statement that lists the customer ID numbers and sales order
-- ID numbers from the Sales.SalesOrderHeader table.
SELECT [CustomerID]
	   ,[SalesOrderId]
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader];


-- Write a SELECT statement that lists only the StateProvinceCode and the StateProvinceName 
-- from the Application.StateProvincestable. 
-- Include a literal value as the first column in the SELECT list: 'StateAbbr/Name:'
SELECT 'StateAbbr/Name:'  AS [ST/Name]
	  ,[StateProvinceCode]
	  ,[StateProvinceName] 
  FROM [WideWorldImporters].[Application].[StateProvinces];


-- Run this query: SELECT '[Application].[StateProvinces]' AS table;. 
-- Explain what happens. Now change the query so that it runs without error
SELECT '[Application].[StateProvinces]' AS table;
-- Incorrect syntax near the keyword 'table' as table is a reserved keyword 
SELECT '[Application].[StateProvinces]' AS [table];


-- Why should you specify column names rather than an asterisk 
-- when writing the select list? Give at least two reasons.
-- Ans: Reduce compute power, better performace, hide confidential data


-- Write a query using a WHERE clause that displays all the employees listed in
-- the HumanResources.Employee table who have the job title “Research and Development Engineer.”
-- Display the BusinessEntityID, the login ID, and the job title for each one.
SELECT *
	FROM [AdventureWorks2019].[HumanResources].[Employee]
	WHERE [JobTitle] = 'Research and Development Engineer'


-- Write a query displaying all the columns of the Production.ProductCostHistory table 
-- from the rows in which the standard cost is between the values of $10 and $13
SELECT * 
	FROM [AdventureWorks2019].[Production].[ProductCostHistory]
		WHERE [StandardCost] BETWEEN 10 AND 13


-- Rewrite the query you wrote in Question 1, changing it so the employees who
-- do not have the title “Research and Development Engineer” are displayed
SELECT *
	FROM [AdventureWorks2019].[HumanResources].[Employee]
	WHERE [JobTitle] <> 'Research and Development Engineer'


/*Write a SELECT statement to return the CityName and
LatestRecordedPopulation of the Application.Cities table. Limit
(filter) the results to CityName equal to Simi Valley*/
SELECT [CityName]
	  ,[LatestRecordedPopulation]
	FROM [WideWorldImporters].[Application].[Cities]
	WHERE [CityName] = 'Simi Valley' 


/*Write a SELECT statement to return all the customers from the Sales.Customers table
who signed up in 2016. Include the CustomerID,
CustomerName, and AccountOpenedDate*/
SELECT [CustomerID]
	  ,[CustomerName]
	  ,[AccountOpenedDate]
	FROM [WideWorldImporters].[Sales].[Customers]
	WHERE [AccountOpenedDate] BETWEEN '2016-01-01' AND '2016-12-31'


-- Exercise 3-3 
/*Write a query displaying the sales order ID, order date, and total due from the
Sales.SalesOrderHeader table. Retrieve only those rows where the order
was placed during the month of September 2012*/
SELECT [SalesOrderId]
	  ,[OrderDate]
	  ,[TotalDue]
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
	WHERE [OrderDate] BETWEEN '2012-09-01' AND '2012-09-30'


/*. Include rows where the Total Due is $10,000 or more or SalesOrderID is less than 43000*/
SELECT [SalesOrderId]
	  ,[OrderDate]
	  ,[TotalDue]
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
	WHERE [TotalDue] >= 10000 OR [SalesOrderID] < 43000


/*Write a SELECT statement against the WideWorldImporters database; issue a
query to the [Application].[StateProvinces] table including both 1 and
45 for StateProvinceID.*/
SELECT * 
	FROM [WideWorldImporters].[Application].[StateProvinces]
	WHERE [StateProvinceID] IN (1,45)


/**/
	