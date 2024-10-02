USE bbms;

CREATE USER 'bbms'@'%' IDENTIFIED BY 'bbms@123';
GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE, 
      CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, 
      EXECUTE, EVENT, TRIGGER, LOCK TABLES 
ON *.* TO 'bbms'@'%';

ALTER USER 'bbms'@'%' IDENTIFIED WITH mysql_native_password BY 'bbms@123';

-- Creating the user_details table
CREATE TABLE `user_details` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `userFName` VARCHAR(30) NOT NULL,
  `userAge` INT NOT NULL,
  `userGender` CHAR(1) NOT NULL,
  `userBloodGroup` VARCHAR(5) NOT NULL,
  `userPhone` BIGINT NOT NULL,
  `userMail` VARCHAR(35) DEFAULT NULL,
  `userPlace` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -- Creating the user_login table
-- CREATE TABLE `user_login` (
--   `user_id` INT NOT NULL,
--   `userUserName` VARCHAR(15) NOT NULL,
--   `userPassword` VARCHAR(15) NOT NULL,
--   PRIMARY KEY (`user_id`, `userUserName`),
--   UNIQUE KEY `userUserName_UNIQUE` (`userUserName`),
--   CONSTRAINT `user_login_id` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the user_health table
CREATE TABLE `user_health` (
  `user_id` INT NOT NULL,
  `userVitals` VARCHAR(10) DEFAULT NULL,
  `userHeight` INT DEFAULT NULL,
  `userWeight` INT DEFAULT NULL,
  `userStatus` VARCHAR(5) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id_health` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the emp_details table
-- CREATE TABLE `emp_details` (
--   `emp_id` INT NOT NULL AUTO_INCREMENT,
--   `empName` VARCHAR(45) NOT NULL,
--   `empMail` VARCHAR(45) NOT NULL,
--   `empPhone` VARCHAR(12) NOT NULL,
--   `empAddress` VARCHAR(70) NOT NULL,
--   PRIMARY KEY (`emp_id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -- -- Creating the emp_login table
-- CREATE TABLE `emp_login` (
--   `emp_id` INT NOT NULL,
--   `userName` VARCHAR(15) NOT NULL,
--   `password` VARCHAR(15) NOT NULL,
--   PRIMARY KEY (`emp_id`),
--   UNIQUE KEY `userName_UNIQUE` (`userName`),
--   CONSTRAINT `emp_login_id` FOREIGN KEY (`emp_id`) REFERENCES `emp_details` (`emp_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the blood_stocks table
CREATE TABLE `blood_stocks` (
  `b_id` INT NOT NULL AUTO_INCREMENT,
  `blood_group` VARCHAR(5) NOT NULL,
  `unit` INT NOT NULL,
  PRIMARY KEY (`b_id`, `blood_group`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the user_request table
CREATE TABLE `user_request` (
  `user_id` INT NOT NULL,
  `req_id` INT NOT NULL AUTO_INCREMENT,
  `blood_group` VARCHAR(5) NOT NULL,
  `unit` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`req_id`),
  KEY `user_id_request_idx` (`user_id`),
  CONSTRAINT `user_id_request` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -- Inserting dummy data into the emp_details table
-- INSERT INTO `emp_details` (`emp_id`, `empName`, `empMail`, `empPhone`, `empAddress`) VALUES 
-- (1, 'Anand', 'anand123@gmail.com', '9854765214', 'Kannur'),
-- (2, 'Arya', 'arya199@hotmail.com', '9644712385', 'Kannur'),
-- (3, 'Revathi', 'rev23@gmail.com', '6282478945', 'Kozhikode'),
-- (4, 'Sanoop', 'san00p92@gmail.com', '9447545896', 'Kasargode');

-- -- Inserting details into the emp_login table
-- INSERT INTO `emp_login` (`emp_id`, `userName`, `password`) VALUES 
-- (1, 'anand', 'anand@123'),
-- (2, 'arya', 'arya@123'),
-- (3, 'revathi', 'revathi@123'),
-- (4, 'sanoop', 'sanoop@123');

-- Inserting some dummy data into the user_details table
INSERT INTO `user_details` (`user_id`, `userFName`, `userAge`, `userGender`, `userBloodGroup`, `userPhone`, `userMail`, `userPlace`) VALUES 
(1, 'Ron', 24, 'M', 'O+ve', 9847561245, 'ronroy@gmail.com', 'Payyanur'),
(2, 'Sajan', 34, 'M', 'B-ve', 9647524561, 'sajank@hotmail.com', 'Kannur'),
(3, 'Sheethal', 26, 'F', 'O+ve', 6247285479, 'sheethalkumar@gmail.com', 'Kandoth'),
(4, 'Anirudh', 22, 'M', 'O+ve', 9854766524, 'ani@gmail.com', 'Kannur'),
(5, 'Arathi', 30, 'F', 'B+ve', 6287458479, 'arathi17@gmail.com', 'Kasargode'),
(6, 'Ajoy', 20, 'M', 'AB-ve', 9854756418, 'ajoyk@gmail.com', 'Kannur'),
(7, 'Sherya', 33, 'F', 'AB-ve', 9847512457, 'shreyasheyas@gmail.com', 'Kannur'),
(8, 'Rajan', 44, 'M', 'A+ve', 6814754718, 'rajankayyil@gmail.com', 'Payyanur'),
(9, 'Manohar', 38, 'M', 'A-ve', 9857462541, 'manoharraj@gmail.com', 'Payyanur'),
(10, 'Anaina', 23, 'F', 'A-ve', 9847516842, 'anaina@gmail.com', 'Kannur'),
(11, 'Arundathi', 20, 'F', 'O+ve', 6847125489, 'arundathi@gmail.com', 'Kannur'),
(12, 'Lakshmi', 30, 'F', 'A+ve', 6282478514, 'lakshmikirshna@gmail.com', 'Payynur'),
(13, 'Akash', 22, 'M', 'Pnull', 9857489576, 'akashaja@gmail.com', 'Kannur'),
(14, 'Zidan', 30, 'M', 'B+ve', 6821478596, 'mzidan@gmail.com', 'Payyanur'),
(15, 'Akshay', 32, 'M', 'B+ve', 9685745219, 'akshayaj@gmail.com', 'Payyanur');

-- -- Inserting dummy data into the user_login table
-- INSERT INTO `user_login` (`user_id`, `userUserName`, `userPassword`) VALUES 
-- (1, 'ron', 'ron@123'),
-- (2, 'sajan', 'sajan@123'),
-- (3, 'sheethal', 'sheethal@123'),
-- (4, 'anirudh', 'anirudh@123'),
-- (5, 'arathi', 'arathi@123'),
-- (6, 'ajoy', 'ajoy@123'),
-- (7, 'shreya', 'shreya@123'),
-- (8, 'rajan', 'rajan@123'),
-- (9, 'manohar', 'manohar@123'),
-- (10, 'anaina', 'anaina@123'),
-- (11, 'arundathi', 'arundathi@123'),
-- (12, 'lakshmi', 'lakshmi@123'),
-- (13, 'akash', 'akash@123'),
-- (14, 'zidan', 'zidan@123'),
-- (15, 'akshay', 'akshay@123');

-- Adding dummy data to the user_health table
INSERT INTO `user_health` (`user_id`) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15);

INSERT INTO `blood_stocks` (`blood_group`, `unit`) VALUES
('O+ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'O+ve')),
('B-ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'B-ve')),
('B+ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'B+ve')),
('AB-ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'AB-ve')),
('A+ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'A+ve')),
('A-ve', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'A-ve')),
('Pnull', (SELECT COUNT(*) FROM user_details WHERE userBloodGroup = 'Pnull'));


