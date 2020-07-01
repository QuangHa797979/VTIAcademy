-- Create Testingsyetem Database--
DROP DATABASE IF EXISTS Testingsyetem;
CREATE DATABASE  		Testingsyetem;
USE Testingsyetem;

-- Create Department Table --
DROP TABLE IF EXISTS         Department;
CREATE  TABLE IF NOT EXISTS  Department (
		Department_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Department_name		NVARCHAR(50) NOT NULL UNIQUE
);

-- Creat Position Table --
DROP TABLE IF EXISTS        `Position`;
CREATE 	TABLE IF NOT EXISTS `Position` (
		Position_id			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Position_name 		NVARCHAR(50) NOT NULL UNIQUE
);

-- Create Account Table --
DROP TABLE IF EXISTS 		`Account`;
CREATE TABLE IF NOT EXISTS	`Account`(
		Account_id			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
        Email				VARCHAR(50) NOT NULL UNIQUE,
        Username			VARCHAR(10) NOT NULL UNIQUE,
        Fullname  			NVARCHAR(30) NOT NULL,
        Department_id 		TINYINT UNSIGNED NOT NULL ,
        Position_id			TINYINT UNSIGNED NOT NULL ,
        Create_date 		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Department_id) REFERENCES Department (Department_id),
        FOREIGN KEY (Position_id) 	REFERENCES `Position`(Position_id)
);

-- Create `Group` Table --
DROP TABLE IF EXISTS 		`Group`;
CREATE TABLE IF NOT EXISTS	`Group` (
		Group_id 			TINYINT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,  
		Group_name  		NVARCHAR(50) NOT NULL UNIQUE,
        Creator_id  		TINYINT NOT NULL, 
        Create_date			DATETIME DEFAULT NOW(),
		FOREIGN KEY (Creator_id) REFERENCES `Account` (Account_id),
);  

-- Create GroupAccount Table --
DROP TABLE IF EXISTS 		GroupAccount;
CREATE TABLE IF NOT EXISTS	GroupAccount (
		ID					TINYINT AUTO_INCREMENT PRIMARY KEY,
		Group_id    		TINYINT UNSIGNED NOT NULL,
        Account_id  		TINYINT UNSIGNED NOT NULL,
        Join_date   		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Group_id) 		REFERENCES `Group` (Group_id),
        FOREIGN KEY (Account_id) 	REFERENCES `Account`(Account_id)
);

-- Create TypeQuestion Table --
DROP TABLE IF EXISTS  TypeQuestion;
CREATE TABLE IF NOT EXISTS	 TypeQuestion (
		Type_id      		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Type_name    		NVARCHAR(1000) NOT NULL UNIQUE
 );
 
 -- Create CategoryQuestion Table --
 DROP TABLE IF EXISTS         CategoryQuestion;
 CREATE TABLE IF NOT EXISTS   CategoryQuestion (
		Category_id   		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Category_name 		NVARCHAR(100) NOT NULL UNIQUE
);

-- Create Question Table --
DROP TABLE IF EXISTS        Question;
CREATE TABLE IF NOT EXISTS  Question (
		Question_id  		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content 	 		TEXT NOT NULL,
        Category_id  		TINYINT UNSIGNED NOT NULL,
        Type_id      		TINYINT UNSIGNED NOT NULL,
        Creator_id   		TINYINT UNSIGNED NOT NULL,
        Create_date  		DATETIME DEFAULT NOW(),
        FOREIGN KEY (Type_id ) 		REFERENCES TypeQuestion (Type_id),
        FOREIGN KEY (Category_id) 	REFERENCES CategoryQuestion (Category_id),
		FOREIGN KEY (Creator_id) 	REFERENCES `Account` (Account_id)
);

-- Create Answer Table --
DROP TABLE IF EXISTS         Answer;
CREATE TABLE IF NOT EXISTS   Answer (
		Answer_id     		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content       		TEXT NOT NULL,
        Question_id   		TINYINT UNSIGNED NOT NULL,
        isCorrect     		ENUM('True', 'False') NOT NULL, 
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);

-- Create Exam Table --
DROP TABLE IF EXISTS         Exam;
CREATE TABLE IF NOT EXISTS   Exam (
		Exam_id      		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `Code`       		INT UNSIGNED UNIQUE,
        Title     	 		NVARCHAR(500) NOT NULL,
		Category_id  		TINYINT UNSIGNED NOT NULL,
        Duration     		TINYINT UNSIGNED  NOT NULL,                                                           
		Creator_id   		TINYINT UNSIGNED NOT NULL,
        Create_date  		DATETIME DEFAULT NOW() NOT NULL,
        FOREIGN KEY (Category_id) 	REFERENCES CategoryQuestion (Category_id),
		FOREIGN KEY (Creator_id) 	REFERENCES `Account` (Account_id)
);

-- Create ExamQuestion Table --
DROP TABLE IF EXISTS         ExamQuestion;
CREATE TABLE IF NOT EXISTS   ExamQuestion (
		Exam_id     		TINYINT UNSIGNED NOT NULL,
        Question_id 		TINYINT UNSIGNED NOT NULL,
        PRIMARY KEY (Exam_id, Question_id),
		FOREIGN KEY (Exam_id) REFERENCES Exam (Exam_id),
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);


USE 				Testingsyetem;
    -- Create Department Table --
INSERT INTO 		Department( Department_name)
VALUES                        ( 'Marketing'       ),        -- 1
							  ( 'sale'            ),        -- 2
							  ( 'Manager'         ),        -- 3
                              ( 'Accounting'      ),        -- 4
                              ( 'Administration'  ),        -- 5
                              ( 'Training'        ),        -- 6
                              ( 'Human Resource'  ),        -- 7
                              ( 'Customer Service'),        -- 8
                              ( 'Client Service'  ),        -- 9
							  ('Production'       );		-- 10
                              
                              
    -- Creat Position Table -- 
INSERT INTO 		`Position`(Position_name)
VALUES						  ( 'Customers Service' ),
                              ( 'Saleman'        	),
                              ( 'ScrumMaster' 		),
                              ( 'PM'          		),
                              ('Developer'			) ;
		
        
	-- Create Account Table --
 INSERT INTO 		`Account`(       Email                  ,    Username ,    Fullname            , Department_id, Position_id	)
 VALUES                      ('mai.nguyenthi@gmail.com'     ,   'Mai'     ,   'Nguyen Thi Mai'     ,    10         ,   3      	),      -- 1
							 ('phuong.dangthanh@gmail.com'  ,   'Phương'  ,   'Dang Thanh Phuong ' ,    2          ,   2      	),      -- 2
                             ('oanh.nguyenkim@gmail.com'    ,   'Hương'   ,   'Nguyen Kim Oanhhhh' ,    10         ,   5     	),      -- 3
                             ('tung.phungvan@gmail.com'     ,   'Hằng'    ,   'Phung Van Tung'     ,    1          ,   1      	),      -- 4
                             ('trang.dinhthu@gmail.com'     ,   'Trang'   ,   'Dinh Thu Trang'     ,    9          ,   2      	),      -- 5
                             ('hai.nguyenvan@gmail.com'     ,   'Hải'     ,   'Nguyen Van Hai'     ,    3          ,   2      	),      -- 6
                             ('hung.domanh@gmail.com'       ,   'Hùng'    ,   'Do Manh Hung'       ,    9          ,   5      	),      -- 7      
                             ('linh.dangthuy@gmail.com'     ,   'Linh'    ,   'Dang Thuy Linh'     ,    9          ,   1      	),      -- 8
                             ('loan.dinhthu@gmail.com'      ,   'Loan'    ,   'Dinh Thu Loan'      ,    1          ,   2      	),      -- 9
                             ('han.tranthanh@gmail.com'     ,   'Hà'      ,    'Tran Thanh Ha'     ,    2          ,   4      	);      -- 10
                             

	-- Create `Group` Table --
INSERT INTO 		`Group`  ( Group_name   ,   Creator_id )   
VALUES 				         ( 'Group A '   ,     2        ),       -- 1
							 ( 'Group B '   ,     3        ),       -- 2
							 ( 'Group C '   ,     1        ),       -- 3
							 ( 'Group D '   ,     4        ),       -- 4
							 ( 'Group E '   ,     5        ),       -- 5
                             ( 'Group EF '  ,     2        ),       -- 6
                             ( 'Group IQ '  ,     1        ),       -- 7 
                             ( 'Group GH '  ,     4        ),       -- 8
                             ( 'Group HJ '  ,     3        ),       -- 9
                             ( 'Group JY '  ,     5        );       -- 10
                            -- 
-- Create GroupAccount Table --
INSERT INTO  	GroupAccount (  Group_id    ,    Account_id  )              
 VALUES                      (     1        ,       2        ),      -- 1
							 (     3        ,       1        ),      -- 2
                             (     4        ,       4        ),      -- 3
						     (     1        ,       5        ),      -- 4
                             (     2        ,       3        ),      -- 5
                             (     5        ,       6        ),      -- 6
                             (     4        ,       8        ),      -- 7
                             (     2        ,       7        ),      -- 8
                             (     5        ,       1        ),       -- 9
                             (     3        ,       9        );      -- 10
                             
-- Create TypeQuestion Table --
INSERT INTO    TypeQuestion  (   Type_name     )
VALUES                       ( 'Essay'         ),
                             ('Numerica'       ),
                             ('Multiple-Choice'),
                             ('Description'    ),
                             ( 'Stack'         ),
                             ('Caculated'      ),
                             ('Short Answer'   ),
                             ('Yes or No'      );
							












