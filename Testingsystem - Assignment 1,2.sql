-- Create Testingsystem1 Database --
DROP DATABASE IF EXISTS Testingsystem1;
CREATE DATABASE  		Testingsystem1;
USE Testingsystem1;

-- Create Department Table --
DROP TABLE IF EXISTS         Department;
CREATE  TABLE IF NOT EXISTS  Department (
		Department_id 		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Department_name		NVARCHAR(50) NOT NULL UNIQUE
);

-- Creat Position Table --
DROP TABLE IF EXISTS        `Position`;
CREATE 	TABLE IF NOT EXISTS `Position` (
		Position_id			INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Position_name 		NVARCHAR(50) NOT NULL UNIQUE
);

-- Create Account Table --
DROP TABLE IF EXISTS 		`Account`;
CREATE TABLE IF NOT EXISTS	`Account`(
		Account_id			INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
        Email				VARCHAR(30) NOT NULL UNIQUE,
        Username			VARCHAR(10) NOT NULL UNIQUE,
        Fullname  			NVARCHAR(30) NOT NULL,
        Department_id 		INT(10) UNSIGNED NOT NULL ,
        Position_id			INT(10) UNSIGNED NOT NULL ,
        Create_date 		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Department_id) REFERENCES Department (Department_id),
        FOREIGN KEY (Position_id) 	REFERENCES `Position`(Position_id)
);

-- Create Group Table --
DROP TABLE IF EXISTS 		`Group`;
CREATE TABLE IF NOT EXISTS	`Group` (
		Group_id 			INT(10) UNSIGNED  AUTO_INCREMENT PRIMARY KEY,  
		Group_name  		NVARCHAR(50) NOT NULL UNIQUE,
        Creator_id  		INT(10) NOT NULL, 
        Create_date			DATETIME DEFAULT NOW()
);  

-- Create Group Account Table --
DROP TABLE IF EXISTS 		GroupAccount;
CREATE TABLE IF NOT EXISTS	GroupAccount (
		ID					INT(10) AUTO_INCREMENT PRIMARY KEY,
		Group_id    		INT(10) UNSIGNED NOT NULL,
        Account_id  		INT(10) UNSIGNED NOT NULL,
        Join_date   		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Group_id) 		REFERENCES `Group` (Group_id),
        FOREIGN KEY (Account_id) 	REFERENCES `Account`(Account_id)
);

-- Create Type Question Table --
DROP TABLE IF EXISTS  TypeQuestion;
CREATE TABLE IF NOT EXISTS	 TypeQuestion (
		Type_id      		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Type_name    		NVARCHAR(50) NOT NULL UNIQUE
 );
 
 -- Create Category Question Table --
 DROP TABLE IF EXISTS         CategoryQuestion;
 CREATE TABLE IF NOT EXISTS   CategoryQuestion (
		Category_id   		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Category_name 		NVARCHAR(100) NOT NULL UNIQUE
);

-- Create Question Table --
DROP TABLE IF EXISTS        Question;
CREATE TABLE IF NOT EXISTS  Question (
		Question_id  		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content 	 		TEXT NOT NULL,
        Category_id  		INT(10) UNSIGNED NOT NULL,
        Type_id      		INT(10) UNSIGNED NOT NULL,
        Creator_id   		INT(10) UNSIGNED NOT NULL,
        Create_date  		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Type_id) 		REFERENCES TypeQuestion (Type_id),
        FOREIGN KEY (Category_id) 	REFERENCES CategoryQuestion (Category_id),
		FOREIGN KEY (Creator_id) 	REFERENCES `Account` (Account_id)
);

-- Create Answer Table --
DROP TABLE IF EXISTS         Answer;
CREATE TABLE IF NOT EXISTS   Answer (
		Answer_id     		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content       		TEXT NOT NULL,
        Question_id   		INT(10) UNSIGNED NOT NULL,
        isCorrect     		ENUM('True', 'False') NOT NULL, 
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);

-- Create Exam Table --
DROP TABLE IF EXISTS         Exam;
CREATE TABLE IF NOT EXISTS   Exam (
		Exam_id      		INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `Code`       		INT(10) UNSIGNED UNIQUE,
        Title     	 		NVARCHAR(500) NOT NULL,
		Category_id  		INT(10) UNSIGNED NOT NULL,
        Duration     		INT(10) UNSIGNED  NOT NULL,                                                           
		Creator_id   		INT(10) UNSIGNED NOT NULL,
        Create_date  		DATETIME DEFAULT NOW() NOT NULL,
        FOREIGN KEY (Category_id) 	REFERENCES CategoryQuestion (Category_id),
		FOREIGN KEY (Creator_id) 	REFERENCES `Account` (Account_id)
);

-- Create Exam Question Table --
DROP TABLE IF EXISTS         ExamQuestion;
CREATE TABLE IF NOT EXISTS   ExamQuestion (
		Exam_id     		INT(10) UNSIGNED NOT NULL,
        Question_id 		INT(10) UNSIGNED NOT NULL,
        PRIMARY KEY (Exam_id, Question_id),
		FOREIGN KEY (Exam_id) REFERENCES Exam (Exam_id),
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);


