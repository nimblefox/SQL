--- create a database
CREATE DATABASE Sample1

--- rename a database
ALTER DATABASE Sample1 MODIFY Name = Sample2

--- alter database name with system stored procedure
EXECUTE sp_renameDB Sample2, Sample1

--- drop a databse 
DROP DATABASE Sample1

--- create a database with 2 tables and insert values
CREATE DATABASE Sample1
USE [Sample1]
GO

CREATE TABLE Gender
(
ID int NOT NULL Primary Key,
Sex nvarchar (50) NOT NULL
)

INSERT INTO Gender(ID, Sex)
VALUES (1, 'Male'), 
	   (2, 'Female'), 
	   (3, 'Other');


CREATE TABLE Person
(
ID int NOT NULL Primary Key,
Name nvarchar (50) NOT NULL, 
email nvarchar (50) NOT NULL, 
GenderID int NOT NULL
)

INSERT INTO Person(ID, Name, email, GenderID)
VALUES (1, 'Alex', 'alex.com', 1), 
	   (2, 'Brooklyn', 'brooke.com', 2), 
	   (3, 'Catherine', 'cathy.com', 3);


--- assign generid as foreign key for data integrity
ALTER TABLE Person ADD CONSTRAINT Person_GenderID_FK
FOREIGN KEY (GenderID) REFERENCES Gender(ID)

--- this should fail now 
INSERT INTO Person(ID, Name, email, GenderID)
VALUES (4, 'Dorothy', 'dora.com', 4);
