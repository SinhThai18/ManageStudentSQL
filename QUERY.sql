-- ORDER BY , SAP XEP ALPHABET TEN HOC SINH 
SELECT * FROM Student
ORDER BY Student_Name

--INNER JOIN , LAY TEN HOC SINH LOP HO DANG HOC VA MON HOC.
SELECT Student.Student_Name, Class.ID_Class, Subject.Subject_Name
FROM Student
INNER JOIN StudentClass ON Student.ID_Student = StudentClass.ID_Student
INNER JOIN Class ON StudentClass.ID_Class = Class.ID_Class
INNER JOIN StudentSubject ON Student.ID_Student = StudentSubject.ID_Student
INNER JOIN Subject ON StudentSubject.Subject_Code = Subject.Subject_Code;

--A query that uses aggregate functions , TINH DIEM TONG CUA HOC SINH
A query that uses aggregate functions , 
SELECT ID_Student, Subject_Code, SUM(CAST(REPLACE(Weight, '%', '') AS DECIMAL(5, 2)) * Value/100) AS WeightedTotalScore
FROM Components_Points
WHERE Subject_Code = 'DBI202' AND ID_Student = 'HE170658'
GROUP BY ID_Student, Subject_Code;

--A query that uses the GROUP BY and HAVING clauses , ĐEM SO MON HOC SINH VIEN DA DANG KI
SELECT s.ID_Student, s.Student_Name, COUNT(ss.Subject_Code) AS NumberOfSubjects
FROM Student s
LEFT JOIN StudentSubject ss 
ON s.ID_Student = ss.ID_Student
GROUP BY s.ID_Student, s.Student_Name
HAVING COUNT(ss.Subject_Code) > 1;

--SUB QUERY WHERE CLAUSE , LAY TEN CUA HOC SINH TRONG MOT LOP HOC CU THE
SELECT s.Student_Name
FROM Student s
WHERE s.ID_Student IN (
    SELECT sc.ID_Student
    FROM StudentClass sc
    WHERE sc.ID_Class = 'SE1817'
);
--SUB QUERY AS RELATION LAY RA HOC SINH VA LOP
SELECT s.Student_Name, c.ID_Class
FROM Student s
INNER JOIN (
    SELECT DISTINCT ID_Student, ID_Class
    FROM StudentClass
) c ON s.ID_Student = c.ID_Student;

--A query that uses partial matching in the WHERE clause , lay ra hoc sinh ho nguyen
SELECT Student_Name
FROM Student
WHERE Student_Name LIKE '%Nguyen%';

--SEFT JOIN , LAY RA GIAO VIEN CUNG MAJOR
SELECT t1.Teacher_Name AS TeacherName, t2.Teacher_Name AS Colleague
FROM Teacher AS t1
JOIN Teacher AS t2 ON t1.Major = t2.Major
WHERE t1.ID_Teacher = 'sonnt5' AND t2.ID_Teacher != 'sonnt5';