-- Chapter 4 Using Built-in Functions and Expressions

-- Concatenation
-- Syntax CONCAT(<val>, <val1>, <val2>)
SELECT 'ab'+'c'
SELECT BusinessEntityID, FirstName + ',' + LastName AS [Full Name]
	FROM [AdventureWorks2019].[Person].[Person]

SELECT CONCAT ('I ', 'love', ' writing', ' T-SQL') AS RESULT; 

DECLARE @a VARCHAR(30) = 'My birthday is on '
DECLARE @b DATE = '1980/08/25'
SELECT CONCAT (@a, @b) AS RESULT;

-- ISNULL and COALESCE to replace NULL values with empty space
-- Syntax ISNULL(<val>, <replacement>)
SELECT BusinessEntityID, FirstName + ' ' + ISNULL(MiddleName,'') +
 ' ' + LastName AS [Full Name]
FROM [AdventureWorks2019].[Person].[Person];

SELECT BusinessEntityID, FirstName + COALESCE(' ' + MiddleName,'') +
 ' ' + LastName AS [Full Name]
FROM [AdventureWorks2019].[Person].[Person];


-- CAST and CONVERT to change data type 
-- Syntax CAST(<col> AS type)
-- Syntax CONVERT(type, <col>)
SELECT CAST(BusinessEntityID AS NVARCHAR) + ': ' + LastName
 + ', ' + FirstName AS ID_Name
FROM [AdventureWorks2019].[Person].[Person];

SELECT CONVERT(NVARCHAR(10),BusinessEntityID) + ': ' + LastName
 + ', ' + FirstName AS ID_Name
FROM [AdventureWorks2019].[Person].[Person];

SELECT BusinessEntityID, BusinessEntityID + 1 AS "Adds 1",
 CAST(BusinessEntityID AS NVARCHAR(10)) + '1' AS "Appends 1"
FROM [AdventureWorks2019].[Person].[Person];


-- Exercise 4-1
/* Write a query that returns data from the Person.Address table in this format 
AddressLine1 (City PostalCode) from the Person.Address table */
SELECT [City] + ' ' + CAST([PostalCode] AS nvarchar) AS "AddressLine1"
	FROM [AdventureWorks2019].[Person].[Address]


/*Write a query using the Production.Product table displaying the product ID, 
color, and name columns. If the color column contains a NULL, replace the color 
with No Color */
SELECT [ProductID]
	  ,[Name]
	  ,COALESCE([Color], 'No Color') AS [Color]
	FROM [AdventureWorks2019].[Production].[Product]


/* Modify the query written in Question 2 so that the description of the product 
is returned formatted as Name: Color. Make sure that all rows display a value 
even if the Color value is missing.*/
SELECT [ProductID]
	  ,[Name] + ': ' + COALESCE([Color], 'No Color') AS "Description"
	FROM [AdventureWorks2019].[Production].[Product]


/*Write a query using the Production.Product table displaying a description 
with the ProductID: Name format. Hint: You will need to use a function to write 
this query*/
SELECT CAST([ProductID] AS NVARCHAR) + ': ' + [Name] AS "Description"
	FROM [AdventureWorks2019].[Production].[Product]


/*Switch to WideWorldImporters. Write a query using the Application.
Cities table. Using the CONCAT() function, put together CityName and 
LatestRecordedPopulation separating the values with a hyphen.*/
SELECT CONCAT([CityName], '-', [LatestRecordedPopulation]) AS "Answer"
	FROM [WideWorldImporters].[Application].[Cities]


/*Write a query against the Application.People table using only FullName
and SearchName. Format the output like this:
FullName (SearchName)
Here is an example output:
Bijoya Thakur (Bijoya Bijoya Thakur)*/
SELECT CONCAT([FullName], ' (',[SearchName],')') 
	FROM [WideWorldImporters].[Application].[People]


/*Write a query using the Application.Cities table, returning only 
CityName, LatestRecordedPopulation. Use COALESCE or ISNULL to 
return 0 for those cities not reporting a LatestRecordedPopulation.*/
SELECT [CityName], COALESCE([LatestRecordedPopulation], '0') AS LatestRecordedPopulation
	FROM [WideWorldImporters].[Application].[Cities]


-- What are the diff b/n ISNULL and COALESCE
/*The main difference is, that COALESCE is ANSI-Standard
so you will also find it in other RDBMSs, the other difference is 
you can give a whole list of values to be checked to COALESCE whereas to ISNULL you can only pass one.*/

/*Write a query using the Sales.SpecialOffer table. Display the difference 
between the MinQty and MaxQty columns along with the SpecialOfferID
and Description columns.*/
SELECT [SpecialOfferID], [Description], [MaxQty], [MinQty], [MaxQty] - [MinQty] AS [Difference]
	FROM [AdventureWorks2019].[Sales].[SpecialOffer]


/*Write a query using the Sales.SpecialOffer table. Multiply the MinQty
column by the DiscountPct column. Include the SpecialOfferID and 
Description columns in the results.*/
SELECT [SpecialOfferID], [Description], [MinQty], [DiscountPct], [MinQty]*[DiscountPct] AS [Multix]
	FROM [AdventureWorks2019].[Sales].[SpecialOffer]


-- Skipping easy ones


/*Local temporary tables are the tables stored in tempdb.  
These tables are automatically destroyed at the termination of the procedure or session. 
They are specified with the prefix #, for example #table_name and these temp tables can be created with the same name in multiple windows.*/

/*Global temporary tables are also stored in tempdb. They are available to all sessions and all users. 
They are dropped automatically when the last session using the temporary table has completed. T
hey are specified with the prefix ##, for example ##table_name.*/


-- STring functions are very useful for data cleaning, checkout documentation
-- RTRIM, LTRIM, and TRIM
CREATE TABLE #trimExample (COL1 VARCHAR(10));
GO
--Populate the table
INSERT INTO #trimExample (COL1)
VALUES ('a'),('b   '),('   c'),('   d   ');
--Select the values using the functions
SELECT COL1, '*' + RTRIM(COL1) + '*' AS "RTRIM",
 '*' + LTRIM(COL1) + '*' AS "LTRIM",
 '*' + TRIM(COL1) + '*' AS "TRIM"
FROM #trimExample;
--Clean up
DROP TABLE #trimExample;


-- The LEFT and RIGHT functions return a specified number of characters on the left or right side of a string
-- LEN and DATALENGTH 
/*. DATALENGTH returns the same value as LEN when the string is a CHAR or VARCHAR data type, which takes one byte per character. 
The difference occurs when using DATALENGTH on NCHAR or NVARCHAR data types, which take up to two bytes*/


/*CHARINDEX to find the position of a string inside a string*/
SELECT LastName, CHARINDEX('e',LastName) AS "Find e",
 CHARINDEX('e',LastName,4) AS "Skip 3 Characters",
 CHARINDEX('be',LastName) AS "Find be",
 CHARINDEX('Be',LastName) AS "Find Be"
FROM AdventureWorks2019.Person.Person
WHERE BusinessEntityID IN (293,295,211,297,299,3057,15027);


/*SUBSTRING is just like LEFT with better control*/
SELECT LastName, SUBSTRING(LastName,1,4) AS "First 4",
 SUBSTRING(LastName,5,50) AS "Characters 5 and later"
FROM AdventureWorks2019.Person.Person
WHERE BusinessEntityID IN (293,295,211,297,299,3057,15027);


/*CHOOSE allows you to select a value in an array based on an index. The CHOOSE function 
requires an index value and list of values for the array*/


/*REVERSE returns a string in reverse order*/

/*Use UPPER and LOWER to change a string to either uppercase or lowercase*/

/*Use REPLACE to substitute one string value inside another string value.*/

/*STRING_SPLIT splits the string into muliple rows*/
SELECT value
FROM STRING_SPLIT('dog cat fish bird lizard',' ');
/*STRING_AGG aggregates rows into a single row*/
SELECT STRING_AGG(Name, ', ') AS List
FROM AdventureWorks2019.Production.ProductCategory;


-- NESTING FUNCTIONS : inner functions executes first
SELECT EmailAddress
	  ,SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress) + 1,50) AS DOMAIN
FROM AdventureWorks2019.Production.ProductReview;

SELECT physical_name,
 RIGHT(physical_name,CHARINDEX('\',REVERSE(physical_name))-1) AS 
FileName
FROM sys.database_files;


-- Exercise 4-3
/*Write a query that displays the first ten characters of the AddressLine1
column in the Person.Address table.*/
SELECT [AddressLine1]
	  ,LEFT([AddressLine1], 10) As [first10]
	FROM [AdventureWorks2019].[Person].[Address]


/*Write a query that displays characters 10 to 15 of the AddressLine1 column 
in the Person.Address table*/
SELECT [AddressLine1]
	  ,RIGHT(LEFT([AddressLine1], 15), 6) As [10to15]
	FROM [AdventureWorks2019].[Person].[Address]


/*Write a query displaying the first and last names from the Person.Person
table all in uppercase*/
SELECT UPPER([FirstName]) AS [FirstNameUpper],UPPER([LastName]) AS [LastNameUpper]
	FROM [AdventureWorks2019].[Person].[Person]


/*The ProductNumber in the Production.Product table contains a hyphen (-). 
Write a query that uses the SUBSTRING function and the CHARINDEX function 
to display the characters in the product number following the hyphen. Note: 
There is also a second hyphen in many of the rows; ignore the second hyphen 
for this question. Hint: Try writing this statement in two steps, the first using the 
CHARINDEX function and the second adding the SUBSTRING function*/
SELECT [ProductNumber]
      ,CHARINDEX('-', [ProductNumber]) AS Hyphen
	  ,SUBSTRING([ProductNumber], CHARINDEX('-', [ProductNumber])+1, 50) AS Answer
	FROM [AdventureWorks2019].[Production].[Product]


/*Switch to the WideWorldImporters database. Write a SELECT statement to 
the Application.Countries table, creating a new code, which is the first 
three characters of the CountryName capitalized. Alias the column NewCode, 
returning only the column created and the IsoAlpha3Code column. Hint: You 
will use both the UPPER() function and the LEFT() function.*/
SELECT * 
	FROM [WideWorldImporters].[Application].[Countries]

SELECT [CountryName], UPPER(LEFT(CountryName, 3)) AS [NewCode], [IsoAlpha3Code] 
	FROM [WideWorldImporters].[Application].[Countries]


/* In the CustomerName (located in the Sales.Customer table), return only the 
portion inside of parentheses, including the parentheses. Hint: See the “Nesting 
Functions” section. You may need to use a number of built-in functions, such as 
SUBSTRING(), CHARINDEX(), and LEN() */
SELECT * 
	FROM [WideWorldImporters].[Sales].[Customers];

SELECT [CustomerID], [CustomerName], SUBSTRING( [CustomerName], CHARINDEX('(', [CustomerName]), CHARINDEX(')', [CustomerName])) AS [Answer]
	FROM [WideWorldImporters].[Sales].[Customers];


-- DATE and TIME functions
-- GETDATE(), SYSDATETIME()
SELECT GETDATE()      -- 2021-06-30 18:52:49.993
	  ,SYSDATETIME(); -- 2021-06-30 18:52:49.9972158


-- DATEADD()
SELECT OrderDate, DATEADD(year,1,OrderDate) AS OneMoreYear,
 DATEADD(month,1,OrderDate) AS OneMoreMonth,
 DATEADD(day,-1,OrderDate) AS OneLessDay
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);


-- DATEDIFF()
SELECT OrderDate, GETDATE() CurrentDateTime,
 DATEDIFF(year,OrderDate,GETDATE()) AS YearDiff,
 DATEDIFF(month,OrderDate,GETDATE()) AS MonthDiff,
 DATEDIFF(d,OrderDate,GETDATE()) AS DayDiff
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);


--DATENAME (returns strings), DATEPART(returns numbers)
SELECT OrderDate, DATEPART(year,OrderDate) AS OrderYear,
 DATEPART(month,OrderDate) AS OrderMonth,
 DATEPART(day,OrderDate) AS OrderDay,
 DATEPART(weekday,OrderDate) AS OrderWeekDay
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);

--2011-05-31 00:00:00.000	2011	5	31	3
--2011-06-04 00:00:00.000	2011	6	4	7
--2013-11-21 00:00:00.000	2013	11	21	5

SELECT OrderDate, DATENAME(year,OrderDate) AS OrderYear,
 DATENAME(month,OrderDate) AS OrderMonth,
 DATENAME(day,OrderDate) AS OrderDay,
 DATENAME(weekday,OrderDate) AS OrderWeekDay
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);

--2011-05-31 00:00:00.000	2011	May	    31	Tuesday
--2011-06-04 00:00:00.000	2011	June	4	Saturday
--2013-11-21 00:00:00.000	2013	Novembe 21	Thursday


-- DAY, MONTH, YEAR ; these are just like datepart but standalone
SELECT OrderDate, YEAR(OrderDate) AS OrderYear,
 MONTH(OrderDate) AS OrderMonth,
 DAY(OrderDate) AS OrderDay
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesOrderID in (43659,43714,60621);


--FORMAT - to convert date formats, including country specfic formats 
DECLARE @d DATETIME = GETDATE();
SELECT FORMAT( @d, 'dd', 'en-US' ) AS Result;
SELECT FORMAT( @d, 'yyyy-M-d') AS Result;
SELECT FORMAT( @d, 'MM/dd/yyyy', 'en-IN' ) AS Result;


--DATEFROMPARTS
SELECT DATEFROMPARTS(2012, 3, 10) AS RESULT;
SELECT TIMEFROMPARTS(12, 10, 32, 0, 0) AS RESULT;
SELECT DATETIME2FROMPARTS (2012, 3, 10, 12, 10, 32, 0, 0) AS RESULT;


--EOMONTH ; returns end date of month given
SELECT EOMONTH(GETDATE()) AS [End of this month],
 EOMONTH(GETDATE(),1) AS [End of next month],
 EOMONTH('2020-01-01') AS [Another month]


 --Exercise 4-4
 /*Write a query that calculates the number of days between the date an 
order was placed and the date that it was shipped using the Sales.
SalesOrderHeader table. Include the SalesOrderID, OrderDate, and 
ShipDate columns.*/
SELECT [SalesOrderID], [OrderDate], [ShipDate], DATEDIFF(DAY, [OrderDate], [ShipDate]) AS 'Duration in days'
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] ;


/*Write a query that displays only the date, not the time, for the order date and 
ship date in the Sales.SalesOrderHeader table.*/
SELECT [SalesOrderID], [OrderDate], CONVERT(VARCHAR(12), [OrderDate], 111) AS 'Formatted date'
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] ;


/*Write a query that adds six months to each order date in the Sales.
SalesOrderHeader table. Include the SalesOrderID and OrderDate
columns*/
SELECT [SalesOrderID], [OrderDate], DATEADD(MONTH,6,[OrderDate])
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader];


/*Write a query that displays the year of each order date and the numeric 
month of each order date in separate columns in the results. Include the 
SalesOrderID and OrderDate columns.*/
SELECT [SalesOrderID], [OrderDate], DATEPART(YEAR, [OrderDate]) As 'YEAR', DATEPART(MONTH, [OrderDate]) AS 'Month'
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader];


/*Write a SELECT statement that returns the date five quarters in the past from 
today’s date.*/
SELECT GETDATE(), DATEADD(QUARTER, -5, GETDATE()) As '5 Qs in past'

SELECT [SalesOrderID], [OrderDate], DATEADD(MONTH, -15, [OrderDate]) As '5 Qs in past'
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader];


-- Mathematical Functions
-- ABS
SELECT ABS(-2)
-- POWER
SELECT POWER(2, 3)
-- SQRT 
SELECT SQRT(9)
-- ROUND ; 3rd argument optional for truncation
SELECT ROUND(1234.1294,2) AS "2 places on the right",
 ROUND(1234.1294,-2) AS "2 places on the left",
 ROUND(1234.1294,2,1) AS "Truncate 2",
 ROUND(1234.1294,-2,1) AS "Truncate -2";
 -- RAND
 SELECT RAND()
 SELECT CAST(RAND() * 100 AS INT) + 1 AS "1 to 100",
 CAST(RAND()* 1000 AS INT) + 900 AS "900 to 1900",
 CAST(RAND() * 5 AS INT)+ 1 AS "1 to 5"
 

 -- Exercise 4-5
 /*Write a query using the Sales.SalesOrderHeader table that displays the 
SubTotal rounded to two decimal places. Include the SalesOrderID column 
in the results.*/
SELECT [SalesOrderID], ROUND([SubTotal],2)	
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]


/*Modify the query from Question 1 so that the SubTotal is rounded to the 
nearest dollar but still displays two zeros to the right of the decimal place*/
SELECT [SalesOrderID], [SubTotal], ROUND([SubTotal],-0,1)	
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] 


/* Write a query that calculates the square root of the SalesOrderID value from 
the Sales.SalesOrderHeader table.*/
SELECT [SalesOrderID], 	SQRT([SalesOrderID])
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] 


/*Write a statement that generates a random number between 1 and 10 each 
time it is run.*/
SELECT CAST(RAND()*10 AS INT)+1;


/*Without running the queries, supply the values returned by the SELECT
statements.*/
SELECT SQRT(2.2)


-- Logical functions and expressions
-- CASE WHEN works like if from python
-- SIMPLE CASE : To write the simple CASE expression, come up with an expression that you want to evaluate, often a column name, and a list of possible values. 
SELECT Title,
 CASE Title
 WHEN 'Mr.' THEN 'Male'
 WHEN 'Ms.' THEN 'Female'
 WHEN 'Mrs.' THEN 'Female'
 WHEN 'Miss' THEN 'Female'
 ELSE 'Unknown' END AS Gender
FROM AdventureWorks2019.Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423)

-- SEARCHED CASE : use the searched CASE syntax when the expression is too complicated for the simple CASE syntax.
SELECT Title,
 CASE WHEN Title IN ('Ms.','Mrs.','Miss') THEN 'Female'
	  WHEN Title = 'Mr.' THEN 'Male'
      ELSE 'Unknown' END AS Gender
FROM AdventureWorks2019.Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423);

-- CASE cant return multiple data types
SELECT Title,
 CASE WHEN Title IN ('Ms.','Mrs.','Miss') THEN 1
 WHEN Title = 'Mr.' THEN 'Male'
 ELSE '1' END AS Gender
FROM AdventureWorks2019.Person.Person
WHERE BusinessEntityID IN (1,5,6,357,358,11621,423)

-- CASE return columns
SELECT VacationHours,SickLeaveHours,
 CASE WHEN VacationHours > SickLeaveHours THEN VacationHours
 ELSE SickLeaveHours END AS 'More Hours'
FROM AdventureWorks2019.HumanResources.Employee;

-- IIF 
DECLARE @a INT = 50
DECLARE @b INT = 20
SELECT IIF (@a > @b, 'TRUE', 'FALSE') AS RESULT;

-- USING COALESCE as IF all NULL 
SELECT ProductID,Size, Color,
 COALESCE(Size, Color,'No color or size') AS 'Description'
FROM AdventureWorks2019.Production.Product
WHERE ProductID in (1,2,317,320,680,706);


-- ADMIN FUNCTIONS
SELECT DB_NAME() AS "Database Name",
 HOST_NAME() AS "Host Name",
 CURRENT_USER AS "Current User",
 SUSER_NAME() AS "Login",
 USER_NAME() AS "User Name",
 APP_NAME() AS "App Name";


-- Exercise 4-6
/*Write a query using the HumanResources.Employee table to display the 
BusinessEntityID column. Also include a CASE expression that displays 
Even when the BusinessEntityID value is an even number or Odd when it is 
odd. Hint: Use the modulo operator.*/
SELECT BusinessEntityID, 
	   CASE WHEN (BusinessEntityID % 2) = 0 THEN 'Even'
	   ELSE 'Odd' END AS Answer
	FROM [AdventureWorks2019].[HumanResources].[Employee];


/*Write a query using the Sales.SalesOrderDetail table to display a 
value (Under 10 or 10–19 or 20–29 or 30–39 or 40 and over) based on the 
OrderQty value by using the CASE expression. Include the SalesOrderID
and OrderQty columns in the results.*/
SELECT [OrderQty], 
	   CASE WHEN [OrderQty] < 10 THEN 'Under 10'
	        WHEN [OrderQty] >= 10 AND [OrderQty] < 20 THEN '10-19'
			WHEN [OrderQty] >= 20 AND [OrderQty] < 30 THEN '20-29'
			WHEN [OrderQty] >= 30 AND [OrderQty] < 40 THEN '30-39'
			WHEN [OrderQty] >= 40 THEN '40 and over' END AS [Classifier]
	FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]


/*Using the Person.Person table, build the full names using the Title, 
FirstName, MiddleName, LastName, and Suffix columns. Check the table 
definition to see which columns allow NULL values and use the COALESCE
function on the appropriate columns*/
SELECT [Title], [FirstName], [MiddleName], [LastName], [Suffix],
	   COALESCE([Title], '') + COALESCE(' ' + [FirstName], '') + COALESCE(' ' + [MiddleName], '') + COALESCE(' ' + [LastName], '') + COALESCE(' ' + [Suffix], '') AS [FullName]
	FROM [AdventureWorks2019].[Person].[Person]



/*Look up the SERVERPROPERTY function in SQL Server’s online documentation. 
Write a statement that displays the edition, instance name, and machine name 
using this function*/
SELECT  
  SERVERPROPERTY('MachineName') AS ComputerName,
  SERVERPROPERTY('ServerName') AS InstanceName,  
  SERVERPROPERTY('Edition') AS Edition,
  SERVERPROPERTY('ProductVersion') AS ProductVersion,  
  SERVERPROPERTY('ProductLevel') AS ProductLevel;  
GO  


/* Switch to WideWorldImporters. Write a query against the Purchasing.
PurchaseOrders table and return the DeliveryMethodID column. Add a 
Figure 4-33. The results of using administrative system functions
Chapter 4 Using Built-in Functions and Expressions141
CASE expression that returns Freight if the DeliveryMethodID is equal to 7, 8, 9, 
or 10. Otherwise, return Other/Courier. Alias this as DeliveryMethod*/
USE [WideWorldImporters]
GO

SELECT [DeliveryMethodID],
	   CASE WHEN [DeliveryMethodID] IN ('7','8','9','10') THEN 'Freight'
			ELSE 'Other/Courier' END AS 'method'
  FROM [Purchasing].[PurchaseOrders]




  -- Exercise 4.7 

/*Write a query using the Sales.SalesOrderHeader table to display the 
orders placed during 2011 by using a function. Include the SalesOrderID and 
OrderDate columns in the results.*/
SELECT [SalesOrderID], [OrderDate]
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
	WHERE YEAR(OrderDate) = 2011;


/*Write a query using the Sales.SalesOrderHeader table listing the sales 
in order of the month the order was placed and then the year the order was 
placed. Include the SalesOrderID and OrderDate columns in the results*/
SELECT  [SalesOrderID], [OrderDate]
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
	ORDER BY MONTH(OrderDate), YEAR(OrderDate);


/* Write a query that displays the PersonType and the name columns from the 
Person.Person table. Sort the results so that rows with a PersonType of 
IN, SP, or SC sort by LastName. The other rows should sort by FirstName. 
Hint: Use the CASE expression.*/
SELECT [PersonType], [FirstName], [MiddleName], [LastName]
	FROM [AdventureWorks2019].[Person].[Person]
	ORDER BY CASE WHEN [PersonType] in ('IN','SP','SC')
		THEN [LastName] ELSE [FirstName] END; 


/*Write a query that returns sales for Saturday in the Sales.Orders table. 
Return CustomerID, OrderDate, and the result of the DATENAME function in 
the SELECT list. Alias the new column OrderDay.*/
SELECT [CustomerID], [OrderDate], DATENAME(WEEKDAY, OrderDate) AS [DAYNAME]
	FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
	WHERE DATENAME(WEEKDAY, OrderDate) = 'Saturday'