ALTER PROCEDURE CalculateTotalScoreWithPercentage
    @StudentID VARCHAR(50),
    @SubjectCode VARCHAR(50)
AS
BEGIN
    DECLARE @TotalScore DECIMAL(10, 2); 
    SELECT @TotalScore = SUM(CAST(Value AS DECIMAL(10, 2))/100 * CAST(REPLACE(Weight, '%', '') AS DECIMAL(10, 2)))
    FROM Components_Points
    WHERE ID_Student = @StudentID AND Subject_Code = @SubjectCode;
    PRINT 'Total for Student ' + @StudentID + ' in Subject ' + @SubjectCode + ' is: ' + CAST(@TotalScore AS VARCHAR(50));
END;

EXEC CalculateTotalScoreWithPercentage
    @StudentID = 'HE170658',
    @SubjectCode = 'DBI202';
