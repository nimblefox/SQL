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


