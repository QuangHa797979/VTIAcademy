/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE IF NOT EXISTS TestingSystem;
USE TestingSystem;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    DepartmentID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 		NVARCHAR(30) NOT NULL UNIQUE KEY
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    Gender                  VARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW()
);

-- create table 5: GroupAccount
CREATE TABLE IF NOT EXISTS GroupAccount(
	GroupID						TINYINT UNSIGNED,
    AccountID					TINYINT UNSIGNED,
    JoinDate					DATETIME,
    FOREIGN KEY (GroupID) 		REFERENCES `Group` (GroupID) ON DELETE NO ACTION,
    FOREIGN KEY (AccountID) 	REFERENCES `Account` (AccountID)
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId)
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    AnswersID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    PRIMARY KEY (ExamID,QuestionID)
);

/*	abc
	fdgfdgd
*/
-- Add data Department
INSERT INTO Department(DepartmentName) 
VALUES
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);
    
-- Add data position
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 


-- Add data Account
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyen Hai Dang'		,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Tong Quang Anh'		,   '1'			,   '2'		,'2020-03-05'),
					('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
					('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
					('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang'	,   '4'			,   '4'		,'2020-03-10'),
					('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
					('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		,'2020-04-05'),
					('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
					('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
					('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09'),
					('vtiaccademy@gmail2.com'			, 'vtiaccademy2'	,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

-- Add data Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Developement'		,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');

-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


-- Add data TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Add data Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java'	,	1		,   '1'			,   '1'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	1		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	5		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	4		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	6		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   2			,	1		),
                    (N'Trả lời 07'	,   2			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   8			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
                        
                        
 USE TestingSystem;                       
-- Question 1: Tạo trigger không cho phép người dùng nhập vào group có ngày tạo trước 1 năm trước  --
-- trước 1 năm trước = từ 2 năm trước đổ về trước --
-- ví dụ: năm nay là năm 2020, trước 1 năm trước tức là từ ngày '2018-12-31' trở về trước --

DROP TRIGGER IF EXISTS verify_create_time_on_account;
DELIMITER $$
CREATE TRIGGER verify_create_time_on_account
BEFORE INSERT ON `group`
FOR EACH ROW
BEGIN
	IF (DATEDIFF(CURRENT_DATE(), NEW.CreateDate) > 365) THEN 
    SIGNAL SQLSTATE '10000' 
    SET MESSAGE_TEXT = 'lỗi create date khi them moi account';
    END IF;

END $$
DELIMITER ;

SET foreign_key_checks = 0;
SET GLOBAL log_bin_trust_function_creators = 1;
INSERT INTO `group`(GroupID, CreatorID, CreateDate)
VALUES ('grouptest' , '1' ,'2016-03-05');
SELECT * FROM `group`;

CREATE INDEX group_name
ON `group` (GroupName);

SELECT QuestionID, Content, CreatorID,
CASE WHEN CreatorID = 1 THEN 10
	 WHEN CreatorID = 1 THEN 112
     END AS USER_NAME
     FROM question;
     
-- Question 2: Tạo trigger không cho phép người dùng thêm bất cứ user nào vào department 'Sale' nữa, --
-- khi thêm thì hiện ra thông báo "Department" "Sale" cannot add more user --

DROP TRIGGER IF EXISTS before_accounts_insert_department_sale;
DELIMITER $$
CREATE TRIGGER before_accounts_insert_department_sale
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
	DECLARE department_id_sale TINYINT;
    SELECT DepartmentID INTO department_id_sale
    FROM department
    WHERE DepartmentName = 'Sale';
    
    IF NEW.DepartmentID = department_id_sale THEN
		SIGNAL SQLSTATE '12345' -- disallow insert this record
		SET MESSAGE_TEXT = 'Department Sale can not add more user';
	END IF;	
END$$
DELIMITER ;

SET foreign_key_checks = 0;
SET GLOBAL log_bin_trust_function_creators = 1;
INSERT INTO account (Email, Username, FullName, DepartmentID, PositionID)
VALUES				('Test',	'Test', 'Test',	       3, 			  1);

SELECT * FROM account;

-- Question 3: Cấu hình 1 group nhiều nhất là 5 user --

DROP TRIGGER IF EXISTS Max_Account_In_Group;
DELIMITER $$
CREATE TRIGGER Max_Account_In_Group
BEFORE INSERT ON `groupaccount`
FOR EACH ROW
BEGIN
IF(new.GroupID in (SELECT GroupID
				   FROM groupaccount
                   GROUP BY GroupID
                   HAVING COUNT(AccountID) >= 5))
THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Một group có nhiều nhất 5 User';
END IF;
END $$
DELIMITER ;
SELECT *
FROM groupaccount;

INSERT INTO `groupaccount` ( GroupID , AccountID , JoinDate )
VALUE 						( 1 ,       3 ,     '2020-03-05');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question --

DROP TRIGGER IF EXISTS Max_Question_In_Exam;
DELIMITER $$
CREATE TRIGGER Max_Question_In_Exam
BEFORE INSERT ON examquestion
FOR EACH ROW
BEGIN
IF (NEW.ExamID in (SELECT ExamID
				   FROM examquestion
                   GROUP BY ExamID
                   HAVING COUNT(QuestionID) >= 10))
THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Một bài thi có nhiều nhất là 10 Question';
END IF;
END $$
DELIMITER ;

INSERT INTO examquestion ( ExamID , QuestionID )
VALUE ( 1 , 33);

SELECT *
FROM examquestion;

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com --
-- (đây là tài khoản admin, không cho phép user xóa), còn lại các tài khoản khác thì sẽ --
-- cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó --

DROP TRIGGER IF EXISTS before_accounts_delete;
DELIMITER $$
CREATE TRIGGER before_accounts_delete 
BEFORE DELETE ON account
FOR EACH ROW
BEGIN
	DECLARE v_account_id TINYINT;
    
    SELECT AccountID INTO v_account_id
    FROM account
    WHERE Email = OLD.Email;
	
	IF OLD.Email = 'admin@gmail.com' THEN
		SIGNAL SQLSTATE '12345' 
		SET MESSAGE_TEXT = 'This is Admin account, you can not delete!';
	ELSE 
		DELETE FROM groupaccount WHERE AccountID = v_account_id;
        UPDATE `group` SET CreatorID = NULL WHERE CreatorID = v_account_id;
        UPDATE exam SET CreatorID = NULL WHERE CreatorID = v_account_id;
        UPDATE question SET CreatorID = NULL WHERE CreatorID = v_account_id;
    END IF;
END$$
DELIMITER ;

SET foreign_key_checks = 0;
SET GLOBAL log_bin_trust_function_creators = 1;
DELETE FROM account
WHERE Email = 'haidang29productions@gmail.com';

SELECT * FROM account;

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table account, --
-- hãy tạo trigger cho phép người dùng khi tạo account không điền vào DepartmentID --
-- thì sẽ được phân vào phòng ban "Waitting Department" --

DROP TRIGGER IF EXISTS before_accounts_insert;
DELIMITER $$
CREATE TRIGGER before_accounts_insert 
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
	DECLARE v_department_id TINYINT ;
    
    SELECT DepartmentID INTO v_department_id 
    FROM department
    WHERE DepartmentName = 'Waiting Department';
    
    IF NEW.DepartmentID IS NULL THEN
		SET NEW.DepartmentID = v_department_id;
	END IF;
END$$
DELIMITER ; 

SET foreign_key_checks = 0;
SET GLOBAL log_bin_trust_function_creators = 1;
INSERT INTO account (Email,   Username,  FullName,  PositionID)
VALUES				 ('Test1',  'Test1',     'Test1',     1);

SELECT * FROM account;

-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: nếu người dùng nhập vào gender của account là --
-- nam, nữ, chưa xác định sẽ đổi lại thành M, F, U cho giống với cấu hình ở database --

DROP TRIGGER IF EXISTS Auto_Gender_Update;
DELIMITER $$
CREATE TRIGGER Auto_Gender_Update
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
		IF NEW.Gender = 'Nam' THEN
		SET NEW.Gender = 'M';
		ELSEIF NEW.Gender = 'Nữ' THEN
		SET NEW.Gender = 'F';
		ELSEIF NEW.Gender = 'Chưa xác định' THEN
		SET NEW.Gender = 'U';
END IF;
END $$
DELIMITER ;

INSERT INTO `account`(Email , Username , FullName ,Gender , DepartmentID , PositionID, CreateDate)
VALUE ('haidang29productions@gmail.com1' , 'dangblack1' ,'Nguyen Hai Dang' ,'Nu' , '5' , '1' ,'2020-03-05');
SELECT * FROM `account`;            

-- Question 12: Lấy ra thông tin exam trong đó --
-- Duration <= 30 thì sẽ đổi thành giá trị 'Short time' --
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị 'Medium time' --
-- Duration > 60 thì sẽ đổi thành giá trị 'Long time' --

SELECT ExamID,Title,`Code`,
CASE 	WHEN Duration <= 30 THEN "Short time" 
		WHEN Duration > 30 AND Duration <= 60 THEN "Medium time"
		WHEN Duration > 60 THEN "Long time"             
	END AS Duration
FROM exam;


