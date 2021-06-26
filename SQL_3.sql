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