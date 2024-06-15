
ALTER VIEW StudentInfo AS
SELECT
    S.Student_Name AS StudentName,
	C.ID_Class AS ClassName,
    C.Major AS Major
FROM Student S
JOIN StudentClass SC ON S.ID_Student = SC.ID_Student
JOIN Class C ON SC.ID_Class = C.ID_Class;


SELECT * FROM StudentInfo;

SELECT * FROM StudentClass