--- create a database
CREATE DATABASE Sample1
--- create a database


--- rename a database
ALTER DATABASE Sample1 MODIFY Name = Sample2
--- rename a database


--- alter database name with system stored procedure
EXECUTE sp_renameDB Sample2, Sample1
--- alter database name with system stored procedure


--- drop a databse 
DROP DATABASE Sample1
--- drop a databse 


--- create a database with 2 tables
CREATE DATABASE Sample1

USE [Sample1] -- USE to ensure we are usiing Sample1 DB 
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
--- create a database with 2 tables



-- insert values in the tables
INSERT INTO Gender(ID, Sex)
VALUES (1, 'Male'), 
	   (2, 'Female'), 
	   (3, 'Other');

INSERT INTO Person(ID, Name, email, GenderID)
VALUES (1, 'Alex', 'alex.com', 1), 
	   (2, 'Brooklyn', 'brooke.com', 2), 
	   (3, 'Catherine', 'cathy.com', 3);
-- insert values in the tables



--- assign Person.GenderId as foreign key referencing Gender.ID for data integrity
ALTER TABLE Person ADD CONSTRAINT Person_GenderID_FK
FOREIGN KEY (GenderID) REFERENCES Gender(ID)

--- this should fail because Gender.ID = 4 doesnt exist 
INSERT INTO Person(ID, Name, email, GenderID)
VALUES (4, 'Dorothy', 'dora.com', 4);
--- assign Person.GenderId as foreign key referencing Gender.ID for data integrity



-- default constraint: insert default value when no input is provided for a field
ALTER TABLE Person
ADD CONSTRAINT DF_Person_GenderID
DEFAULT 3 FOR GenderID

INSERT INTO Person(ID, Name, email)  -- testing default contsraint 
VALUES (4, 'Earl', 'earl.com')
SELECT * FROM Person                 -- you should see GenderID = 3

ALTER TABLE Person                   -- you can always drop these constraints with below code
DROP CONSTRAINT DF_Person_GenderID
-- default constraint: insert default value when no input is provided for a field



-- cascading referential integrity : not allowing foreign key reference rows to be deleted
-- you can configure settings such that all the FK reference rows will be / updated with default values / deleted / set to Null /
DELETE FROM Gender WHERE ID = 2  -- supposed to fail


-- "CHECK CONSTRAINT"

SELECT * FROM Person  -- Add a check constarint to age column so that it checks limits of the variable input
ALTER TABLE Person
ADD Age int  
ALTER TABLE Person
ADD CONSTRAINT CK_Person_Age CHECK (Age>0 AND Age<150)

-- testing check constraint 
UPDATE Person SET Age = 190
UPDATE Person SET Age = 25
-- ? Need to find a way to add column and simultaneously update it with unique values
-- "CHECK CONSTRAINT"



--IDENTITY COLUMN

--Identity column, used as a unique identifier in case of similar entries 
--column must be declared in table properties, set isIdentity as yes and you can also set seed and increment
SELECT * FROM tstPerson
Insert into tstPerson values('Amy') -- you cant insert PersonId as IDENTITY_INSERT is OFF
Insert into tstPerson values('Brooke'),('Cindy'),('Dani')
--now if you try and delete Amy and try to replace her with Alex that wont happen unless ID_INSERT is ON
delete from tstPerson where PersonId = 1
-- switch on IDENTITY_INSERT
SET IDENTITY_INSERT tstPerson ON
-- if you dont want to supply the ID you must turn IDENTITY_INSERT OFF
insert into tstPerson (PersonId, Name) values(1,'Alex')
-- retrieve last generated identity 
select SCOPE_IDENTITY()
-- another way using global variable
select @@IDENTITY

--IDENTITY COLUMN



-- TRIGGER
-- do thing2 on table2 when thing1 on table1
create trigger trForInsert on Person for insert
as 
Begin
	insert into tstPerson Values ('ABCD')
End
-- TRIGGER



-- UNIQUE KEY CONSTRAINT
-- then whatabout primarykey? We cannot have multiple PKs, 
-- if you want to enforce uniqueness on multiple columns use unique key constraint
-- UK allows nulls unlike PK
ALTER TABLE Person
ADD Constraint UQ_Person_email Unique(email)

insert into Person values (4, 'Hailey', 'alex.com',1,20)

ALTER TABLE Person 
drop constraint UQ_Person_email
-- UNIQUE KEY CONSTRAINT
