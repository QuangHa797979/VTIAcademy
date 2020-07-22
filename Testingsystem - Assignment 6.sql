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

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban --
-- và in ra tất cả các account thuộc phòng ban đó --

DROP PROCEDURE IF EXISTS getInfoAccountOFDEPT;
DELIMITER $$
CREATE PROCEDURE getInfoAccountOFDEPT(IN department_name VARCHAR(100))
BEGIN
	SELECT *
    FROM `account`
    WHERE DepartmentID = (SELECT DepartmentID 
						  FROM department
                          WHERE DepartmentName = department_name);
END $$
DELIMITER ;
CALL Testingsystem.getInfoAccountOFDEPT('Nhân sự');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group --

DROP PROCEDURE IF EXISTS question2;
DELIMITER $$
CREATE PROCEDURE question2()
BEGIN
		SELECT *, COUNT(1), GROUP_CONCAT(AccountID)
		FROM groupaccount
		GROUP BY GroupID;
		END $$
DELIMITER ;
CALL testingsystem.question2();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question --
-- được tạo trong tháng hiện tại --

DROP PROCEDURE IF EXISTS getInfoTypeOfQuestion;
DELIMITER $$
CREATE PROCEDURE getInfoTypeOfQuestion()
		BEGIN
		SELECT TypeID, COUNT(QuestionID) AS "Số câu", CreateDate
		FROM `question`
		GROUP BY TypeID
		HAVING MONTH (CreateDate) = MONTH(now());
END $$
DELIMITER $$
CALL Testingsystem.getInfoTypeOfQuestion()

-- Question 4: Tao store để trả ra id cua type question có nhiều câu hỏi nhất --

SET sql_mode = 'IGNORE_SPACE';
DROP PROCEDURE IF EXISTS list_of_type_question_which_have_the_most_questions;
DELIMITER $$
CREATE PROCEDURE list_of_type_question_which_have_the_most_questions()
BEGIN
	SELECT TypeID FROM typequestion
    WHERE TypeID IN
	(WITH list_of_type_question_which_have_the_most_questions AS(
		SELECT TypeID, COUNT(QuestionID) AS number_of_questions
		FROM question  
		GROUP BY TypeID
		HAVING number_of_questions = 
	(WITH list_of_type_question_with_number_of_questions AS(
		SELECT TypeID, COUNT(QuestionID) AS number_of_questions
		FROM question 
		GROUP BY TypeID)
		SELECT MAX (number_of_questions) FROM list_of_type_question_with_number_of_questions))
		SELECT TypeID FROM list_of_type_question_which_have_the_most_questions);
END$$
DELIMITER ;

CALL TestingSystem.list_of_type_question_which_have_the_most_questions();

-- Question 5: Sử dụng store của question 4 để tìm ra tên của type question --

SET sql_mode = 'IGNORE_SPACE';
DROP PROCEDURE IF EXISTS list_of_type_name_which_have_the_most_questions;
DELIMITER $$
CREATE PROCEDURE list_of_type_name_which_have_the_most_questions()
BEGIN
	SELECT TypeName FROM typequestion
    WHERE TypeID IN
	(WITH list_of_type_name_which_have_the_most_questions AS(
		SELECT TypeID, COUNT(QuestionID) AS number_of_questions
		FROM question 
		GROUP BY TypeID
		HAVING number_of_questions = 
	(WITH list_of_type_question_with_number_of_questions AS(
		SELECT TypeID, COUNT(QuestionID) AS number_of_questions
		FROM question  
		GROUP BY TypeID)
		SELECT MAX (number_of_questions) FROM list_of_type_question_with_number_of_questions))
    SELECT TypeID FROM list_of_type_name_which_have_the_most_questions);
END$$
DELIMITER ;

CALL TestingSystem.list_of_type_name_which_have_the_most_questions();

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi --
-- và trả về group có tên chứa chuỗi của người dùng nhập vào --
-- hoặc trả về user có username chứa chuỗi của người dùng nhập vào --

DROP PROCEDURE IF EXISTS question6;
DELIMITER $$
CREATE PROCEDURE question6 (IN InputGroupName VARCHAR(100), IN InputUserName VARCHAR(100))
BEGIN
		SELECT GroupName, UserName
		FROM `group`
		WHERE GroupID = (SELECT GroupID
						  FROM `group`
						  WHERE GroupName LIKE CONCAT('%', InputGroupName, '%') OR UserName LIKE CONCAT('%', InputUserName, '%'));
END $$
DELIMITER ;
CALL  question6('test');

-- Question 7: Viết 1 store cho phép người dùng nhập vào FullName, Email --
-- và trong store sẽ tự động gán --
-- Username sẽ giống email nhưng bỏ phần @..mail đi --
-- PositionID: sẽ có default là developer --
-- DepartmentID: sẽ được cho vào 1 phòng ban chờ: bán hàng --
-- Sau đó in ra kết quả tạo thành công --

SELECT * FROM `Department`;
DROP PROCEDURE IF EXISTS sp_importInf_Of_Account;
DELIMITER $$
CREATE PROCEDURE sp_importInf_Of_Account
(IN in_Email VARCHAR(50), IN in_FullName NVARCHAR(50))
BEGIN
	DECLARE Username1 VARCHAR(150) DEFAULT SUBSTRING_INDEX("cuongnm@gmail.com.vn",'@',1);
	DECLARE PositionID TINYINT UNSIGNED DEFAULT 1;
	DECLARE DepartmentID TINYINT UNSIGNED DEFAULT 10;
    
	SET foreign_key_checks = 0;
	INSERT INTO `Account` (Email, Username, FullName, DepartmentID, PositionID)
	VALUE 				  (in_Email, Username1, in_FullName, DepartmentID, PositionID);
	SELECT *
	FROM `Account` a
	WHERE a.Username = Username1;
END $$
DELIMITER ;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice --
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất --

DROP PROCEDURE IF EXISTS get_question_which_have_longest_content_ess_and_mul;
DELIMITER $$
CREATE PROCEDURE get_question_which_have_longest_content_ess_and_mul (IN in_type_name ENUM('Essay', 'Multiple-Choice'))
BEGIN
	SELECT q.Content, LENGTH(q.Content) AS length_of_content
    FROM question q
    WHERE LENGTH(q.Content) = (SELECT MAX(LENGTH(q.Content))
							   FROM question q
							   JOIN typequestion tq ON q.TypeID = tq.TypeID
                               WHERE tq.TypeName = in_type_name);
END$$
DELIMITER ; 

CALL get_question_which_have_longest_content_ess_and_mul('Essay');

CALL get_question_which_have_longest_content_ess_and_mul('Multiple Choice');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID --

DROP PROCEDURE IF EXISTS delete_exam_by_exam_id;
DELIMITER $$
CREATE PROCEDURE delete_exam_by_exam_id (IN in_exam_id TINYINT)
BEGIN
	DELETE FROM examquestion 
    WHERE ExamID = in_exam_id;
    
    DELETE FROM exam
    WHERE ExamID = in_exam_id;
END$$
DELIMITER ;

CALL delete_exam_by_exam_id(2);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa) --
-- sau đó in ra số lượng bản ghi đã xóa từ các bảng liên quan trong khi xóa --

DROP PROCEDURE IF EXISTS sp_DeleteUser3Years;
DELIMITER $$
CREATE PROCEDURE sp_DeleteUser3Years()
BEGIN
	SET foreign_key_checks = 0;
	DELETE
	FROM exam
	WHERE (YEAR(NOW()) - YEAR(CreateDate)) > 3;
END $$
DELIMITER ;

SELECT *
FROM exam;

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng --
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về --
-- phòng ban default là phòng ban chờ việc --

DROP PROCEDURE IF EXISTS sp_DeleteDepartment;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDepartment
(IN in_DepartmentName NVARCHAR(50))
BEGIN
		SET foreign_key_checks = 0;
		UPDATE `account`
		SET DepartmentID = 10
		WHERE DepartmentID = (SELECT DepartmentID
							  FROM Department
							  WHERE DepartmentName = in_DepartmentName);
		DELETE
		FROM Department
		WHERE DepartmentName = in_DepartmentName;
END$$
DELIMITER ;

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay --

DROP PROCEDURE IF EXISTS number_of_questions_created_per_month_this_year;
DELIMITER $$
CREATE PROCEDURE number_of_questions_created_per_month_this_year()
BEGIN
	SELECT months_in_year.`month`, COUNT(q.QuestionID) AS number_of_questions
	FROM question q 
    RIGHT JOIN (SELECT 1 AS `month` UNION
				SELECT 2 AS `month` UNION
				SELECT 3 AS `month` UNION
				SELECT 4 AS `month` UNION
				SELECT 5 AS `month` UNION
				SELECT 6 AS `month` UNION
				SELECT 7 AS `month` UNION
				SELECT 8 AS `month` UNION
				SELECT 9 AS `month` UNION
				SELECT 10 AS `month` UNION
				SELECT 11 AS `month` UNION
				SELECT 12 AS `month`) AS months_in_year
	ON MONTH(q.CreateDate) = months_in_year.`month`
	WHERE YEAR(q.CreateDate) = YEAR(NOW())
	-- WHERE DATE_FORMAT(q.create_date, '%Y') = DATE_FORMAT(NOW(), '%Y')
	GROUP BY months_in_year.`month`;
END$$
DELIMITER ;

CALL number_of_questions_created_per_month_this_year();

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong --
-- 6 tháng gần đây nhất (nếu tháng nào không có thì sẽ in ra là 'không có câu hỏi nào trong tháng') --

DROP PROCEDURE IF EXISTS number_of_questions_created_last_six_months;
DELIMITER $$
CREATE PROCEDURE number_of_questions_created_last_six_months()
BEGIN
	SELECT last_six_months.`month`, 
    IF(COUNT(q.QuestionID) = 0, 'khong co cau hoi nao trong thang', COUNT(q.QuestionID)) AS number_of_questions
	FROM (SELECT MONTH(CURRENT_DATE - INTERVAL 5 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 4 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 3 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 2 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AS `month` UNION
		  SELECT MONTH(CURRENT_DATE - INTERVAL 0 MONTH) AS `month`) AS last_six_months
	LEFT JOIN question q ON last_six_months.`month` = MONTH(q.CreateDate)
	GROUP BY last_six_months.`month`;
END$$
DELIMITER ;

CALL number_of_questions_created_last_six_months();












