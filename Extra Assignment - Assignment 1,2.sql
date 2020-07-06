-- bai 1 --
DROP DATABASE IF EXISTS trainner3;
CREATE DATABASE trainner3;
USE trainner3;

DROP TABLE IF EXISTS Trainning_Class;
CREATE TABLE Trainning_Class
( 
	Trainning_Class_id   INT AUTO_INCREMENT PRIMARY KEY,
	Trainning_Class_name VARCHAR(100)
);

DROP TABLE IF EXISTS Trainnes;
CREATE TABLE Trainnes
(
	Trainee_ID			INT(20) AUTO_INCREMENT PRIMARY KEY,
	Full_Name 			NVARCHAR(30),
	Birth_Date			DATE,
	Gender				ENUM ('Male', 'Female', 'Unkown'),
	ET_IQ				TINYINT UNSIGNED NOT NULL CHECK (ET_IQ <=20 AND ET_IQ > 0),
	ET_Gmath			TINYINT UNSIGNED NOT NULL CHECK (ET_Gmath <=20 AND ET_Gmath > 0),
	ET_English			TINYINT UNSIGNED NOT NULL CHECK (ET_English <=50 AND ET_English > 0),
	Trainning_Class_id	INT,
	Evaluation_Notes	TEXT,
    FOREIGN KEY (Trainning_Class_id) REFERENCES Trainning_Class(Trainning_Class_id)
);

ALTER TABLE Trainnes
ADD COLUMN VTI_Account INT NOT NULL UNIQUE;

-- bai 2 --
DROP TABLE IF EXISTS bang2;
CREATE TABLE bang2
(
	ID				INT(10) AUTO_INCREMENT PRIMARY KEY,
	Name			VARCHAR(50),
	Code			NUMERIC(5),
	Modifieddate	DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- bai 3 --
DROP TABLE IF EXISTS bang3;
CREATE TABLE bang3
(
	ID				INT(10) PRIMARY KEY AUTO_INCREMENT,
    Birthdate		DATE,
    Gender			INT COMMENT '0:Male, 1:Female, NULL:Unkown',
    IsDeletedFlag	BIT
    );
    
    




 




