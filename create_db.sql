USE tempdb;
GO
IF EXISTS(SELECT * FROM sys.databases WHERE [name] = N'Taskverwaltung')
BEGIN
    -- Disconnect all users and recreate database.
        ALTER DATABASE Taskverwaltung SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    	DROP DATABASE Taskverwaltung;
END;
CREATE DATABASE Taskverwaltung
GO
USE Taskverwaltung;   -- Change to your database name (USE does not allow variables)
GO

CREATE TABLE Student (
  StudentId INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL
);

CREATE TABLE Task (
  TaskId INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(255) NOT NULL,
  DueDate DATE NOT NULL,
  StudentId INTEGER,
  CONSTRAINT fk_Student_Task FOREIGN KEY (StudentId) REFERENCES Student(StudentId),
  CONSTRAINT chk_Task_DueDate CHECK (DueDate <= '2023')
);

CREATE TABLE Professor (
  ProfessorId INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL
);

CREATE TABLE TaskRating (
  TaskId INTEGER PRIMARY KEY,
  Rating INTEGER NOT NULL,
  ProfessorId INTEGER NOT NULL,
  CONSTRAINT fk_TaskRating_Task FOREIGN KEY (TaskId) REFERENCES Task(TaskId),
  CONSTRAINT fk_TaskRating_Professor FOREIGN KEY (ProfessorId) REFERENCES Professor(ProfessorId),
  CONSTRAINT chk_TaskRating_Rating CHECK (Rating >= 1 AND Rating <= 5)
);
