use master; 

Create DataBase School_1; 
use School_1;

Create Table ClassRoom
(ClassID INT NOT NULL Primary Key, 
Name VARCHAR(50),
ClassTime Time); 

INSERT INTO ClassRoom (ClassID, Name, ClassTime)
VALUES ('01', 'English', '07:30:00'),
       ( '02' , 'Math', '08:30:00'),
	   ('03' , 'History', '09:30:00'),
	   ('04' , 'P.E' , '10:30:00'),
	   ('05' , 'Science' , '12:00:00'),
	   ('06' , 'Spanish' , '12:45:00'),
	   ('07' , 'Music' , '01:30:00');

--1.  
Alter Table Administration
ADD constraint ClassID Check( ClassID <= 7); 



Create Table Administration
(TeacherID Int NOT NULL Primary Key,
ClassID Int FOREIGN KEY REFERENCES Classroom(ClassID),
First_Name VARCHAR(50),
Last_Name VARCHAR(50)); 

ALTER TABLE Administration
ADD CONSTRAINT FK_ClassID
FOREIGN KEY (ClassID) REFERENCES ClassRoom(ClassID);

INSERT INTO Administration(TeacherID, ClassID, First_Name, Last_Name)
VALUES ('123' , '1' , 'Rose' , 'Lee'),
       ('145' , '2' , 'Leon' , 'Hammock'),
	   ('167' , '3' , 'Todd' , 'Gibby'),
	   ('179' , '4' , 'Eric' , 'Row' ),
	   ('196' , '5' , 'Susan' , 'Rose'),
	   ('189' , '6' , 'Yuan' , 'Rick' ),
	   ('177' , '7' , 'Morty' , 'Sanchez');
	   
Create Table Student
(StudentID Int NOT NULL Primary Key,
ClassID Int FOREIGN KEY REFERENCES Classroom(ClassID),
First_Name VARCHAR(50),
Last_Name VARCHAR(50));

INSERT INTO Student( StudentID, ClassID, First_Name, Last_Name)
VALUES ('2842' , '1' , 'Rose', 'Harry'),
	   ('3242' , '2' , 'Willaim' , 'Shakes'),
	   ('4432' , '3' , 'Lily' , 'Rose'),
	   ('5232' , '4' , 'Jake' , 'Styles'),
	   ('6824' , '5' , 'Freddy' ,'Cool'),
	   ('7248' , '6' , 'Harry' , 'Will'),
	   ('8467' , '7' , 'Rick' , 'Falre');



-- Queries 
-- 2
/* Here we are getting the time that each student and proffesor have class*/ 
--2.1 - 2.2
SELECT CR.ClassTime, AD.Last_Name AS 'Teacher Last Name', ST.First_name 
FROM Classroom CR INNER JOIN Administration AD 
ON CR.ClassID = AD.ClassID INNER JOIN 
Student ST ON AD.ClassID = ST.ClassID; 


/*A student is tranfsering out and getting replace with jessica james with studentID 2999
and she is replacing the student in math class*/
--3
UPDATE Student
SET StudentID = '2999', ClassID = '2', First_Name = 'Jessica' , Last_Name = 'James'
WHERE ClassID = '2'; 


SELECT * FROM Student; 


/* Here we are creating a procedure to get teachers that teach all classes.*/ 
--5
Create procedure Selectallclasses
AS
SELECT Last_Name, TeacherID, Name
FROM Administration INNER JOIN 
ClassRoom ON Administration.ClassID = ClassRoom.ClassID;

EXEC Selectallclasses; 

/* Here we are using the having clause to see how manying Repeating students are in the same class*/
--2.3
SELECT COUNT(ClassID) AS 'All Repeating Students' , First_Name
FROM Student
GROUP BY First_Name
HAVING COUNT(ClassID) = '2'; 


