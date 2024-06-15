-- Tạo một trigger sau khi thêm điểm trong bảng Components_Points
ALTER TRIGGER UpdateCourseTotal
ON Components_Points
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @StudentID VARCHAR(50);
    DECLARE @SubjectCode VARCHAR(50);
    DECLARE @TotalScore DECIMAL(10, 2);
    
    -- Lấy ID_Student và Subject_Code từ bảng Components_Points
    SELECT @StudentID = ID_Student, @SubjectCode = Subject_Code FROM inserted;

    -- Tính lại điểm trung bình cho học sinh và môn học
    SELECT @TotalScore = SUM(CAST(Value AS DECIMAL(10, 2))/100 * CAST(REPLACE(Weight, '%', '') AS DECIMAL(10, 2)))
    FROM Components_Points
    WHERE ID_Student = @StudentID AND Subject_Code = @SubjectCode;

    -- Kiểm tra xem dữ liệu đã tồn tại trong bảng CourseTotal chưa
    IF NOT EXISTS (SELECT 1 FROM CourseTotal WHERE Subject_Code = @SubjectCode AND ID_Student = @StudentID)
    BEGIN
        -- Nếu chưa tồn tại, thêm một bản ghi mới
        INSERT INTO CourseTotal (Status, Total, Subject_Code, ID_Student)
        VALUES (
            CASE
                WHEN @TotalScore >= 5.0 THEN 'pass'
                ELSE 'not passed'
            END,
            @TotalScore,
            @SubjectCode,
            @StudentID
        );
    END
    ELSE
    BEGIN
        -- Nếu đã tồn tại, cập nhật bản ghi hiện có
        UPDATE CourseTotal
        SET Total = @TotalScore,
            Status = CASE
                WHEN @TotalScore >= 5.0 THEN 'pass'
                ELSE 'not passed'
            END
        WHERE Subject_Code = @SubjectCode AND ID_Student = @StudentID;
    END
END;

SELECT * FROM CourseTotal WHERE ID_Student = 'HE170658' AND Subject_Code='DBI202';

SELECT * FROM CourseTotal

SELECT * FROM Components_Points
ORDER BY Subject_Code


INSERT INTO Components_Points (Grade_Item, Weight, Value, Comment, Total, Subject_Code, ID_Student)
VALUES ('Quiz 1..', '10%', 4, 'Good performance', 4, 'CSD201', 'HE170658'),
('Quiz 2.', '10%', 1, 'Good performance', 1, 'CSD201', 'HE170658'),
('ASM.', '20%', 3, 'Good performance', 3, 'CSD201', 'HE170658'),
('PE.', '30%', 2, 'Good performance', 2, 'CSD201', 'HE170658'),
('FE.', '30%', 1, 'Good performance', 1, 'CSD201', 'HE170658');


SELECT * FROM CourseTotal WHERE ID_Student = 'HE170658' AND Subject_Code='CSD201';

DELETE FROM Components_Points;

INSERT INTO Components_Points (Grade_Item, Weight, Value, Comment, Total, Subject_Code, ID_Student)
VALUES ('Quiz 1', '10%', 8, 'Good performance', 8, 'DBI202', 'HE170658'),
('Quiz 2', '10%', 8, 'Good performance', 8, 'DBI202', 'HE170658'),
('ASM', '20%', 8, 'Good performance', 8, 'DBI202', 'HE170658'),
('PE', '30%', 8, 'Good performance', 8, 'DBI202', 'HE170658'),
('FE', '30%', 8, 'Good performance', 8, 'DBI202', 'HE170658');