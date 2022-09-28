-- Script Generator by Edgar v1.0
-- Nếu database không tồn tại => Tạo mới database đó
IF NOT EXISTS (
    SELECT name FROM master.dbo.sysdatabases 
    WHERE name = N'QLyKyThi'
)
    BEGIN
        CREATE DATABASE QLyKyThi
    END
GO

-- Sử dụng database
USE QlyKyThi
GO

-- Khởi tạo table
CREATE TABLE exam (
    examID SMALLINT PRIMARY KEY,
    timeExam DATETIME
)
GO

CREATE TABLE room (
    eNumber SMALLINT PRIMARY KEY,
    examID SMALLINT,
    capacity INT,
    building NCHAR(5)
)
GO

CREATE TABLE section (
    sNumber SMALLINT PRIMARY KEY,
    examID SMALLINT,
    enrollment INT
)
GO

CREATE TABLE course (
    courseID SMALLINT PRIMARY KEY,
    sNumber SMALLINT,
    courseName NVARCHAR(30),
    department NVARCHAR(30)
)
GO

-- Khởi tạo quan hệ khoá
-- Khoá ngoại giữa room và exam
ALTER TABLE room ADD CONSTRAINT FK_ROOM_EXAM FOREIGN KEY (examID) REFERENCES exam(examID)

-- Khoá ngoại giữa section và exam
ALTER TABLE section ADD CONSTRAINT FK_SECITON_EXAM FOREIGN KEY (examID) REFERENCES exam(examID)

-- Khoá ngoại giữa course và section
ALTER TABLE course ADD CONSTRAINT FK_COURSE_SECTION FOREIGN KEY (sNumber) REFERENCES section(sNumber)


-- thêm dữ liệu vào bảng
DECLARE @i INT = 0
DECLARE @n INT = 100

while @i <= @n
    BEGIN
        DECLARE @examID NVARCHAR(30) = @i
        DECLARE @timeExam DATETIME = '2022-12-22 12:00:05'

        INSERT exam(examID, timeExam)
        VALUES (@examID, @timeExam)

        SET @i = @i + 1
    END
GO

SELECT * FROM exam
GO