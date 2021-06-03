--- create a database
CREATE DATABASE Sample1


--- rename a database
ALTER DATABASE Sample1 MODIFY Name = Sample2


--- alter database name with system stored procedure
EXECUTE sp_renameDB Sample2, Sample1


--- drop a databse 
DROP DATABASE Sample1


--- create a database with 2 tables
CREATE DATABASE Sample1


-- USE to ensure we are usiing Sample1 DB 
USE [Sample1]
GO

CREATE TABLE Gender
(
ID int NOT NULL Primary Key,
Sex nvarchar (50) NOT NULL
)

CREATE TABLE Person
(
ID int NOT NULL Primary Key,
Name nvarchar (50) NOT NULL, 
email nvarchar (50) NOT NULL, 
GenderID int NOT NULL
)


-- insert values in the tables
INSERT INTO Gender(ID, Sex)
VALUES (1, 'Male'), 
	   (2, 'Female'), 
	   (3, 'Other');

INSERT INTO Person(ID, Name, email, GenderID)
VALUES (1, 'Alex', 'alex.com', 1), 
	   (2, 'Brooklyn', 'brooke.com', 2), 
	   (3, 'Catherine', 'cathy.com', 3);



--- assign generid as foreign key for data integrity
ALTER TABLE Person ADD CONSTRAINT Person_GenderID_FK
FOREIGN KEY (GenderID) REFERENCES Gender(ID)

--- this should fail because Gender.ID = 4 doesnt exist 
INSERT INTO Person(ID, Name, email, GenderID)
VALUES (4, 'Dorothy', 'dora.com', 4);


-- inserting default values when no input is provided for a column
ALTER TABLE Person
ADD CONSTRAINT DF_Person_GenderID
DEFAULT 3 FOR GenderID

-- testing default contsraint 
INSERT INTO Person(ID, Name, email)
VALUES (4, 'Earl', 'earl.com')
SELECT * FROM Person
-- you should see GenderID = 3

-- you can always drop these constraints with below code
ALTER TABLE Person
DROP CONSTRAINT DF_Person_GenderID


-- cascading referential integrity : not allowing foreign key reference rows to be deleted
-- you can allow with changed settings so that all the reference values will be / updated with default ones / deleted too / set to Null /
DELETE FROM Gender WHERE ID = 2 


-- add age column and check contsraint limits
SELECT * FROM Person
ALTER TABLE Person
ADD Age int  
ALTER TABLE Person
ADD CONSTRAINT CK_Person_Age CHECK (Age>0 AND Age<150)

-- testing check constraint 
UPDATE Person SET Age = 190
UPDATE Person SET Age = 25
-- ? Need to find a way to add column and simultaneously update it with unique values
