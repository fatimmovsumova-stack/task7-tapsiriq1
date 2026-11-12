USE UniversityDB;
GO

IF OBJECT_ID('Grades', 'U') IS NOT NULL DROP TABLE Grades;
IF OBJECT_ID('Students', 'U') IS NOT NULL DROP TABLE Students;
GO

CREATE TABLE Students (
    StudentId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NULL,
    Age INT NOT NULL,
    FacultyId INT NOT NULL
);

CREATE TABLE Grades (
    GradeId INT PRIMARY KEY IDENTITY(1,1),
    StudentId INT NOT NULL,
    SubjectName NVARCHAR(100) NOT NULL,
    Score INT CHECK (Score BETWEEN 0 AND 100),
    CONSTRAINT FK_Grades_Students FOREIGN KEY (StudentId) REFERENCES Students(StudentId) ON DELETE CASCADE
);

INSERT INTO Students (FirstName, LastName, Email, Age, FacultyId) VALUES
('Elvin', 'Mammadov', 'elvin.mammadov@bmu.edu.az', 20, 1),
('Aysel', 'Aliyeva', 'aysel.aliyeva@bmu.edu.az', 19, 2),
('Orxan', 'Hasanov', 'orxan.hasanov@bmu.edu.az', 22, 1),
('Murad', 'Musayev', 'murad.musayev@bmu.edu.az', 21, 2),
('Nigar', 'Mustafayeva', 'nigar.mustafayeva@bmu.edu.az', 18, 3);

INSERT INTO Grades (StudentId, SubjectName, Score) VALUES
(1, N'Verilənlər Bazası', 85),
(1, N'Alqoritmlər', 90),
(2, N'Verilənlər Bazası', 65),
(2, N'Alqoritmlər', 68),
(3, N'Verilənlər Bazası', 78),
(3, N'Əməliyyat Sistemləri', 82),
(4, N'Verilənlər Bazası', 95),
(5, N'Alqoritmlər', 55);
GO

SELECT COUNT(*) AS UmumiTelebeSayi
FROM Students;

SELECT 
    CAST(AVG(Age * 1.0) AS DECIMAL(5,2)) AS OrtaYas,
    MIN(Age) AS EnKicikYas,
    MAX(Age) AS EnBoyukYas
FROM Students;

SELECT 
    FacultyId AS FakulteId,
    COUNT(*) AS TelebeSayi
FROM Students
GROUP BY FacultyId;

SELECT 
    s.StudentId,
    s.FirstName AS Ad,
    s.LastName AS Soyad,
    CAST(AVG(g.Score * 1.0) AS DECIMAL(5,2)) AS OrtaQiymet
FROM Students s
INNER JOIN Grades g ON s.StudentId = g.StudentId
GROUP BY s.StudentId, s.FirstName, s.LastName
HAVING AVG(g.Score * 1.0) > 70;
GO