-- bai 1 --
DROP DATABASE IF EXISTS trainner3;
CREATE DATABASE trainner3;
USE trainner3;

DROP TABLE IF EXISTS Trainning_Class;
CREATE TABLE Trainning_Class
( 
	Trainning_Class_id   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Trainning_Class_name VARCHAR(100)
);

DROP TABLE IF EXISTS Trainnes;
CREATE TABLE Trainnes
(
	Trainee_ID			INT(20) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Full_Name 			NVARCHAR(30) NOT NULL,
	Birth_Date			DATE NOT NULL,
	Gender				ENUM ('Male', 'Female', 'Unkown'),
	ET_IQ				TINYINT UNSIGNED NOT NULL CHECK (ET_IQ <=20 AND ET_IQ > 0),
	ET_Gmath			TINYINT UNSIGNED NOT NULL CHECK (ET_Gmath <=20 AND ET_Gmath > 0),
	ET_English			TINYINT UNSIGNED NOT NULL CHECK (ET_English <=50 AND ET_English > 0),
	Trainning_Class_id	INT UNSIGNED,
	Evaluation_Notes	TEXT,
    FOREIGN KEY (Trainning_Class_id) REFERENCES Trainning_Class(Trainning_Class_id)
);

ALTER TABLE Trainnes
ADD COLUMN VTI_Account VARCHAR(50) NOT NULL UNIQUE KEY;

-- Question 1 --

USE trainner3;

SET foreign_key_checks = 0;


INSERT INTO       Trainnes   (    Full_Name        ,    Birth_Date      ,  Gender   ,  ET_IQ  , ET_Gmath, ET_English , Trainning_Class_id , 	Evaluation_Notes 	    ,  		VTI_Account )
VALUES                      ( 'Nguyễn Tuyết Mai'   ,   '1998-11-29'     , 'Male'    ,    7    ,    7    ,      10    , 			2         ,		'Tiếp thu nhanh' 	, 	'mai.nguyentuyet@vti.com.vn'	),   
                            ( 'Đoàn Ngọc Hải'      ,   '1996-04-12'     , 'Unknown' ,    9    ,    9    ,      50    , 			5         ,		 'Cố gắng'      	, 	'hai.doanngoc@vti.com.vn'  	 	),   
							( 'Phạm Văn Bách'      ,   '1995-05-13'     , 'Female'  ,    16   ,    18   ,      30    , 			8         ,		 'Cố gắng'    	    , 	'bach.phamvan@vti.com.vn' 	 	),   
						    ( 'Đinh Gia Tuân'      ,   '1997-11-17'     , 'Male'    ,    15   ,    10   ,      42    ,          10        ,		 'Cố gắng'	        , 	'tuan.dinhgia@vti.com.vn'	 	),   
                            ( 'Trần Thanh Xuân'    ,   '1996-09-10'     , 'Unknown' ,    17   ,    18   ,      39    ,           1        ,		 'Tiếp thu nhanh'   , 	'tran.thanhxuan@vti.com.vn'	    ),   
                            ( 'Phan Văn Nho'       ,   '1995-12-12'     , 'Female'  ,    14   ,    19   ,      36    ,           9        ,		 'Tiếp thu nhanh'	, 	'nho.phanvan@vti.com.vn'		),   
                            ( 'Phạm Thị Tuyết'     ,   '1996-09-19'     , 'Male'    ,    7    ,    12    ,     15    ,           7        ,		 ' Chăm học'     	, 	'tuyet.phamthi@vti.com.vn'  	),   
                            ( 'Vũ Kim Oanh'        ,   '1994-12-19'     , 'Female'  ,    16   ,    15   ,      39    ,           3        ,		 'Chăm học'    	    , 	'oanh.vukim@vti.com.vn'		    ),   
                            ( 'Nguyễn Văn Vân'     ,   '1996-09-20'     , 'Male'    ,    13   ,    19   ,      38    ,           4        ,		 'Lười học'  	    , 	'van.nguyenvan@vti.com.vn'		),   
                            ( 'Đinh Công Duy'      ,   '1994-1228'      , 'Unknown' ,    11   ,    17   ,      33    ,           6        ,		 'Kém'	            ,	'duy.dinhcong@vti.com.vn'		);   
     


    
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
SELECT 		MONTH(Birth_Date), GROUP_CONCAT(Full_Name)
FROM		Trainnes 
GROUP BY 	MONTH(Birth_Date);

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT 		* ,LENGTH(Full_Name)
FROM    	 Trainnes 
WHERE   	 LENGTH(Full_Name) = (	SELECT 	MAX(LENGTH(Full_Name)) 
									FROM 	Trainnes); 

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau: 
			--  ET_IQ + ET_Gmath>=20
			--  ET_IQ>=8
			--  ET_Gmath>=8
			--  ET_English>=18 --
SELECT 		 *
FROM 		Trainnes
WHERE 		(ET_IQ + ET_Gmath) >= 20 
	AND 	ET_IQ >= 8
    AND 	ET_Gmath >= 8 
    AND 	ET_English >= 18;

  -- Question 5: xóa thực tập sinh có Trainee_ID = 3
DELETE 
FROM		Trainnes
WHERE 		Trainee_ID = 3; 

-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "tester". Hãy cập nhật thông tin vào database
UPDATE 		Trainnes
SET  		Trainning_Class_id = 2
WHERE 		Trainee_ID = 5;





 




