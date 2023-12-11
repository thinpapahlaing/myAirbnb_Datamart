-- Drop the schema 'myAirbnb' if it exists
DROP SCHEMA IF EXISTS `myAirbnb` ;

-- Create the 'myAirbnb' schema with utf8mb4 character set and utf8mb4_unicode_ci collation
CREATE SCHEMA IF NOT EXISTS `myAirbnb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

-- Use the 'myAirbnb' schema
USE `myAirbnb` ;



-- Drop the table 'Users' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Users` ;

-- Create the 'Users' table to store user information
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Users` (
	`UserID` INT AUTO_INCREMENT,
    `First_Name` VARCHAR(45) NOT NULL,
    `Last_Name` VARCHAR(45) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `Gender` ENUM('Male', 'Female') NOT NULL,
    `Profile_Picture` VARCHAR(255) NOT NULL,
    `Phone_Number` VARCHAR(30) NOT NULL,
    `Date_Of_Birth` DATE NOT NULL,
    `Bank_Account` VARCHAR(50) NOT NULL,
    `Registration_Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `User_Type` ENUM('Host', 'Guest') NOT NULL,
    `Password` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`UserID`)
);



-- Drop the table 'Languages' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Languages` ;

-- Create the 'Languages' table to store various languages that can be spoken by users 
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Languages` (
	`LanguageID` INT AUTO_INCREMENT,
    `Language` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`LanguageID`)
);



-- Drop the table 'Users_Languages' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Users_Languages` ;

-- Create the 'Users_Languages' table to store various languages spoken by each user
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Users_Languages` (
	`UserLanguageID` INT AUTO_INCREMENT,
    `Spoken_Ability` ENUM('First Language', 'Second Language') NOT NULL,
    `UserID` INT NOT NULL,
    `LanguageID` INT NOT NULL,
    PRIMARY KEY (`UserLanguageID`, `UserID`, `LanguageID`),
    INDEX `fk_Users_Languages_Users_idx` (`UserID` ASC),
	CONSTRAINT `fk_Users_Languages_Users`
		FOREIGN KEY (`UserID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX `fk_Users_Languages_Languages_idx` (`LanguageID` ASC),
	CONSTRAINT `fk_Users_Languages_Languages`
		FOREIGN KEY (`LanguageID`) REFERENCES `myAirbnb`.`Languages`(`LanguageID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Notification' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Notification` ;

-- Create the 'Notification' table to store user notifications
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Notification` (
	`NotificationID` INT AUTO_INCREMENT,
    `Notification_Text` TEXT NOT NULL,
    `Is_Read` TINYINT NOT NULL,
    `UserID` INT NOT NULL,
    PRIMARY KEY (`NotificationID`),
    INDEX `fk_Notification_Users_idx` (`UserID` ASC),
	CONSTRAINT `fk_Notification_Users`
		FOREIGN KEY (`UserID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Message' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Message` ;

-- Create the 'Message' table to store messages alongside with senders and receivers
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Message` (
	`MessageID` INT AUTO_INCREMENT,
    `Message_Text` TEXT NOT NULL,
    `Sent_time` TIMESTAMP NOT NULL,
    `Is_Read` TINYINT NOT NULL,
    `Read_time` TIMESTAMP DEFAULT NULL,
    `SenderID` INT NOT NULL,
    `ReceiverID` INT NOT NULL,
    PRIMARY KEY (`MessageID`),
    INDEX `fk_Message_SenderID_idx` (`SenderID` ASC),
	CONSTRAINT `fk_Message_SenderID` 
		FOREIGN KEY (`SenderID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX `fk_Message_ReceiverID_idx` (`ReceiverID` ASC),
	CONSTRAINT `fk_Message_ReceiverID`
		FOREIGN KEY (`ReceiverID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'User_Social_Network' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`User_Social_Network` ;

-- Create the 'User_Social_Network' table to store social network information regarding users
CREATE TABLE IF NOT EXISTS `myAirbnb`.`User_Social_Network` (
	`UserSocialNetworkID` INT AUTO_INCREMENT,
    `Social_Platform` VARCHAR(45) NOT NULL,
    `Social_URL` VARCHAR(255) NOT NULL,
    `UserID` INT NOT NULL,
    PRIMARY KEY (`UserSocialNetworkID`),
    INDEX `fk_User_Social_Network_Users_idx` (`UserID` ASC),
	CONSTRAINT `fk_User_Social_Network_Users`
		FOREIGN KEY (`UserID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Host' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Host` ;

-- Create the 'Host' table to store host profiles alongside with host descriptions
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Host` (
	`HostID` INT AUTO_INCREMENT,
    `Host_Description` TEXT NOT NULL,
    `UserID` INT NOT NULL UNIQUE,
    PRIMARY KEY (`HostID`),
    INDEX `fk_Host_Users_idx` (`UserID` ASC),
	CONSTRAINT `fk_Host_Users`
		FOREIGN KEY (`UserID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Host_Review' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Host_Review` ;

-- Create the 'Host_Review' table to store reviews given for hosts
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Host_Review` (
	`HostReviewID` INT AUTO_INCREMENT,
    `Rating` TINYINT NOT NULL,
    `Comment` TEXT,
    `Reviewed_Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `HostID` INT NOT NULL,
    PRIMARY KEY (`HostReviewID`),
    INDEX `fk_Host_Review_Host_idx` (`HostID` ASC),
	CONSTRAINT `fk_Host_Review_Host`
		FOREIGN KEY (`HostID`) REFERENCES `myAirbnb`.`Host`(`HostID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Guest' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Guest` ;

-- Create the 'Guest' table to store guest profiles alongside with guest descriptions
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Guest` (
	`GuestID` INT AUTO_INCREMENT,
    `Guest_Description` TEXT NOT NULL,
    `UserID` INT NOT NULL UNIQUE,
    PRIMARY KEY (`GuestID`),
    INDEX `fk_Guest_Users_idx` (`UserID` ASC),
	CONSTRAINT `fk_Guest_Users`
		FOREIGN KEY (`UserID`) REFERENCES `myAirbnb`.`Users`(`UserID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Guest_Review' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Guest_Review` ;

-- Create the 'Guest_Review' table to store reviews given for guests
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Guest_Review` (
	`GuestReviewID` INT AUTO_INCREMENT,
    `Rating` TINYINT NOT NULL,
    `Comment` TEXT,
    `Reviewed_Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `GuestID` INT NOT NULL,
    PRIMARY KEY (`GuestReviewID`),
    INDEX `fk_Guest_Review_Guest_idx` (`GuestID` ASC),
	CONSTRAINT `fk_Guest_Review_Guest`
		FOREIGN KEY (`GuestID`) REFERENCES `myAirbnb`.`Guest`(`GuestID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Property' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Property` ;

-- Create the 'Property' table to store property information alongside with associated hosts
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Property` (
	`PropertyID` INT AUTO_INCREMENT,
    `Property_Name` VARCHAR(100) NOT NULL,
    `Property_Type` VARCHAR(45) NOT NULL,
    `Property_Description` TEXT NOT NULL,
    `Room_Numbers` INT NOT NULL,
	`Price_Per_Night` DECIMAL(10,2) NOT NULL,
    `Is_There_Kitchen` TINYINT NOT NULL,
    `Is_There_Bathroom` TINYINT NOT NULL,
    `Max_Guests_Allowed` INT NOT NULL,
    `HostID` INT NOT NULL,
    PRIMARY KEY (`PropertyID`),
    INDEX `fk_Property_Host_idx` (`HostID` ASC),
	CONSTRAINT `fk_Property_Host`
		FOREIGN KEY (`HostID`) REFERENCES `myAirbnb`.`Host`(`HostID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Address' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Address` ;

-- Create the 'Address' table to store address information of associated properties
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Address` (
	`AddressID` INT AUTO_INCREMENT,
    `Country_Name` VARCHAR(45) NOT NULL,
    `Country_Code` VARCHAR(3) NOT NULL,
    `City` VARCHAR(45) NOT NULL,
    `Postal_Code` VARCHAR(8) NOT NULL,
    `Street` VARCHAR(100) NOT NULL,
    `Building_Number` VARCHAR(10),
    `PropertyID` INT NOT NULL UNIQUE,
    PRIMARY KEY (`AddressID`),
    INDEX `fk_Address_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Address_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Property_Image' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Property_Image` ;

-- Create the 'Property_Image' table to store images of associated properties
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Property_Image` (
	`PropertyImageID` INT AUTO_INCREMENT,
    `Property_Image` VARCHAR(255) NOT NULL,
    `PropertyID` INT NOT NULL,
    PRIMARY KEY (`PropertyImageID`),
    INDEX `fk_Property_Image_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Property_Image_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Rules' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Rules` ;

-- Create the 'Rules' table to store property rules
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Rules` (
	`RuleID` INT AUTO_INCREMENT,
    `Rule_Description` TEXT NOT NULL,
    PRIMARY KEY (`RuleID`)
);



-- Drop the table 'Property_Rules' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Property_Rules` ;

-- Create the 'Property_Rules' table to store property rules connecting with associated properties
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Property_Rules` (
	`PropertyRuleID` INT AUTO_INCREMENT,
    `PropertyID` INT NOT NULL,
    `RuleID` INT NOT NULL,
    PRIMARY KEY (`PropertyRuleID`, `PropertyID`, `RuleID`),
    INDEX `fk_Property_Rules_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Property_Rules_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX `fk_Property_Rules_Rules_idx` (`RuleID` ASC),
	CONSTRAINT `fk_Property_Rules_Rules`
		FOREIGN KEY (`RuleID`) REFERENCES `myAirbnb`.`Rules`(`RuleID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Available_Periods' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Available_Periods` ;

-- Create the 'Available_Periods' table to store available periods of associated properties
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Available_Periods` (
	`AvailablePeriodsID` INT AUTO_INCREMENT,
    `Start_Date` TIMESTAMP NOT NULL,
    `End_Date` TIMESTAMP NOT NULL,
    `Immediate_Availability` TINYINT NOT NULL,
    `PropertyID` INT NOT NULL,
    PRIMARY KEY (`AvailablePeriodsID`),
    INDEX `fk_Available_Periods_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Available_Periods_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Facility' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Facility` ;

-- Create the 'Facility' table to store Facilities that a property can have
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Facility` (
	`FacilityID` INT AUTO_INCREMENT,
    `Item` VARCHAR(45) NOT NULL,
    `Quantity` INT NOT NULL,
    PRIMARY KEY (`FacilityID`)
);



-- Drop the table 'Property_Facility' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Property_Facility` ;

-- Create the 'Property_Facility' table to store included facilities in a specific property
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Property_Facility` (
    `PropertyFacilityID` INT AUTO_INCREMENT,
    `PropertyID` INT NOT NULL,
    `FacilityID` INT NOT NULL,
    PRIMARY KEY (`PropertyFacilityID`, `PropertyID`, `FacilityID`),
    INDEX `fk_Property_Facility_Property_idx` (`PropertyID` ASC),
    CONSTRAINT `fk_Property_Facility_Property`
        FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    INDEX `fk_Property_Facility_Facility_idx` (`FacilityID` ASC),
    CONSTRAINT `fk_Property_Facility_Facility`
        FOREIGN KEY (`FacilityID`) REFERENCES `myAirbnb`.`Facility`(`FacilityID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Booking' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Booking` ;

-- Create the 'Booking' table to store bookings made by guest in renting properties
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Booking` (
	`BookingID` INT AUTO_INCREMENT,
    `Start_Date` TIMESTAMP NOT NULL,
    `End_Date` TIMESTAMP NOT NULL,
    `Guest_Numbers` INT NOT NULL,
    `Cost` DECIMAL(10,2) NOT NULL,
    `Booking_Made_Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `Booking_Status` ENUM('Reviewing', 'Approved', 'Rejected') NOT NULL DEFAULT 'Reviewing',
    `PropertyID` INT NOT NULL,
    `GuestID` INT NOT NULL,
    PRIMARY KEY (`BookingID`),
    INDEX `fk_Booking_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Booking_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX `fk_Booking_Guest_idx` (`GuestID` ASC),
	CONSTRAINT `fk_Booking_Guest`
		FOREIGN KEY (`GuestID`) REFERENCES `myAirbnb`.`Guest`(`GuestID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Payment' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Payment` ;

-- Create the 'Payment' table to store payment information alongside with associated host and the property for which the payment was made
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Payment` (
	`PaymentID` INT AUTO_INCREMENT,
    `Currency` VARCHAR(10) NOT NULL,
    `Total_Amount` DECIMAL(10,2) NOT NULL,
    `Payment_Date` TIMESTAMP NOT NULL,
    `Payment_Status` ENUM('Success', 'Failed') NOT NULL,
    `BookingID` INT NOT NULL UNIQUE,
    `PropertyID` INT NOT NULL,
    `HostID` INT NOT NULL,
    PRIMARY KEY (`PaymentID`),
	INDEX `fk_Payment_Booking_idx` (`BookingID` ASC),
	CONSTRAINT `fk_Payment_Booking`
		FOREIGN KEY (`BookingID`) REFERENCES `myAirbnb`.`Booking`(`BookingID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    INDEX `fk_Payment_Property_idx` (`PropertyID` ASC),
	CONSTRAINT `fk_Payment_Property`
		FOREIGN KEY (`PropertyID`) REFERENCES `myAirbnb`.`Property`(`PropertyID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX `fk_Payment_Host_idx` (`HostID` ASC),
	CONSTRAINT `fk_Payment_Host`
		FOREIGN KEY (`HostID`) REFERENCES `myAirbnb`.`Host`(`HostID`) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Drop the table 'Property_Review' if it exists
DROP TABLE IF EXISTS `myAirbnb`.`Property_Review` ;

-- Create the 'Property_Review' table to store reviews of properties given by guests
CREATE TABLE IF NOT EXISTS `myAirbnb`.`Property_Review` (
    `PropertyReviewID` INT AUTO_INCREMENT,
    `Rating` TINYINT NOT NULL,
    `Comment` TEXT,
    `Reviewed_Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `GuestID` INT NOT NULL,
    `PropertyID` INT NOT NULL,
    PRIMARY KEY (`PropertyReviewID`),
    INDEX `fk_Property_Review_Guest_idx` (`GuestID` ASC),
    CONSTRAINT `fk_Property_Review_Guest` FOREIGN KEY (`GuestID`)
        REFERENCES `myAirbnb`.`Guest` (`GuestID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    INDEX `fk_Property_Review_Property_idx` (`PropertyID` ASC),
    CONSTRAINT `fk_Property_Review_Property` FOREIGN KEY (`PropertyID`)
        REFERENCES `myAirbnb`.`Property` (`PropertyID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



-- Dummy data of Users table
INSERT INTO `myAirbnb`.`Users` VALUES
(1, 'Cosme', 'Norwood', 'cnorwood0@dropbox.com', 'Male', 'https://unsplash.com/photos/man-wearing-maroon-and-white-fair-isle-top-JyVcAIUAcPM', '+1 433 479 4512', '1981-05-07', '45172478103', '2023-06-25 09:46:03', 'Host', 'uK3(kP%%t'),
(2, 'Pen', 'Coy', 'pcoy1@list-manage.com', 'Male', 'https://unsplash.com/photos/grayscale-photography-of-man-wearing-crew-neck-shirt-jmURdhtm7Ng', '+1 419 406 1915', '1968-11-05', '40536239667', '2023-01-10 10:16:01', 'Guest', 'tP4''o0_|ZkK&Z<W@'),
(3, 'Curry', 'Pollins', 'cpollins2@spotify.com', 'Male', 'https://unsplash.com/photos/bearded-man-taking-a-selfie-kMJp7620W6U', '+1 725 950 4697', '1971-11-07', '20616353967', '2023-09-10 02:30:45', 'Host', 'aG3&ZGv.7iBRYPcf'),
(4, 'Zea', 'Drei', 'zdrei3@kickstarter.com', 'Female', 'https://unsplash.com/photos/woman-in-blue-button-down-shirt-smiling-in-front-of-camera-I1Plc-FAAnQ', '+86 634 323 5474', '1947-03-01', '199128204799', '2023-03-06 17:25:43', 'Guest', 'aP6&A!,=N'),
(5, 'Annalise', 'Krzysztof', 'akrzysztof4@biglobe.ne.jp', 'Female', 'https://unsplash.com/photos/smiling-woman-holding-cheek-B4TjXnI0Y2c', '+1 155 775 5610', '1999-11-26', '1032495639', '2023-05-28 06:05:52', 'Host', 'nJ9@RtU<N&'),
(6, 'Cointon', 'Lightwing', 'clightwing5@theatlantic.com', 'Male', 'https://unsplash.com/photos/man-in-green-knit-cap-and-blue-jacket-ViyA5myhBVw', '+1 307 309 9026', '1981-04-18', '23646433335', '2023-08-23 07:15:13', 'Host', 'qM0!~`WY''\%01'),
(7, 'Elias', 'Harg', 'eharg6@tamu.edu', 'Male', 'https://unsplash.com/photos/man-wearing-white-v-neck-shirt-iFgRcqHznqg', '+63 104 106 3526', '1991-03-26', '443209809444', '2023-02-21 06:48:57', 'Guest', 'gH4(j?Nc&e$'),
(8, 'Saunders', 'Anlay', 'sanlay7@51.la', 'Male', 'https://unsplash.com/photos/man-crossing-both-arms-KIPqvvTOC1s', '+48 967 549 4389', '1979-12-05', 'PL74 6170 0943 8086 7007 6619 8001', '2023-07-01 07:38:39', 'Guest', 'yG2\PlTi8~`Awe'),
(9, 'Berenice', 'Aicken', 'baicken8@clickbank.net', 'Female', 'https://unsplash.com/photos/smiling-woman-in-shallow-focus-photography-_H6wpor9mjs', '+1 532 164 4027', '1972-05-11', '86899654826', '2023-09-18 15:12:55', 'Host', 'uZ9@HA5%Fs\J.'),
(10, 'Newton', 'Whorall', 'nwhorall9@usnews.com', 'Male', 'https://unsplash.com/photos/man-in-gray-crew-neck-shirt-and-blue-denim-jeans-sitting-on-black-chair-V16fvLUU35s', '+84 749 668 6605', '1993-01-15', '5212308136424', '2023-01-09 23:02:52', 'Guest', 'jJ6<a#eN~Fg'),
(11, 'Omar', 'Klima', 'oklimaa@goodreads.com', 'Male', 'https://unsplash.com/photos/man-in-white-crew-neck-shirt-dS6a-NAqbII', '+86 161 834 5360', '1990-08-13', '882704305256', '2023-08-17 01:42:02', 'Guest', 'zE3!|t7g.x'),
(12, 'Alasdair', 'De Domenico', 'adedomenicob@fc2.com', 'Male', 'https://unsplash.com/photos/man-wearing-blue-and-red-collared-shirt-eSjmZW97cH8', '+1 476 326 6760', '1964-07-24', '42100973259', '2023-05-27 06:44:19', 'Host', 'bX2=.*MI''_#m>izJ'),
(13, 'Camala', 'Solleme', 'csollemec@elpais.com', 'Female', 'https://unsplash.com/photos/woman-in-black-white-and-grey-geometric-shirt-smiling-H6AuL8bcRkM', '+44 479 407 4501', '1985-03-25', 'GB18 GLMH 2660 7999 3053 66', '2023-01-14 11:08:54', 'Host', 'eJ6$k%93''tu'),
(14, 'Babita', 'Fewtrell', 'bfewtrelld@about.me', 'Female', 'https://unsplash.com/photos/woman-in-white-tank-top-i5R8hbZFDdc', '+86 635 240 1256', '2004-02-10', '985925605707', '2023-01-09 02:58:55', 'Guest', 'qL1,\IllA=DC'),
(15, 'Stephana', 'Lestrange', 'slestrangee@techcrunch.com', 'Female', 'https://unsplash.com/photos/portrait-photography-of-woman-wearing-crew-neck-top-smiling-z2wyh1Maq8E', '+44 471 691 5464', '1972-07-26', 'GB81 WDSR 0904 0660 4680 52', '2023-08-13 16:22:34', 'Host', 'oM8}flLX7$M_`'),
(16, 'Georgie', 'Ivanishev', 'givanishevf@51.la', 'Female', 'https://unsplash.com/photos/close-up-photo-of-womans-face-with-red-lipstick-MphctUUI9vA', '+266 902 155 2672', '1988-09-07', '5935459654862', '2023-03-26 15:39:12', 'Guest', 'mQ4}uWNRy|'),
(17, 'Evonne', 'Duthie', 'eduthieg@feedburner.com', 'Female', 'https://unsplash.com/photos/girl-in-white-and-black-polka-dot-shirt-K798U9eYDFU', '+65 791 852 7870', '1986-10-22', '3529780852', '2023-07-01 04:44:44', 'Host', 'uQ7|Vr|}Bd'),
(18, 'Ker', 'Cunde', 'kcundeh@elpais.com', 'Male', 'https://unsplash.com/photos/man-holding-starbucks-disposable-cup-g4DgCF90EM4', '+86 302 718 2004', '1989-12-01', '995597078388', '2023-06-06 14:57:21', 'Guest', 'pQ3+_CT>B'),
(19, 'Dallas', 'Hayes', 'dhayesi@japanpost.jp', 'Female', 'https://unsplash.com/photos/woman-wearing-eyeglasses-eY1_nQs9aNI', '+86 159 798 6400', '1950-05-28', '342870681191', '2023-02-20 19:49:46', 'Guest', 'fN9?WisZ%,ziVd'),
(20, 'Benedikta', 'McMearty', 'bmcmeartyj@amazon.co.jp', 'Female', 'https://unsplash.com/photos/woman-in-white-crew-neck-shirt-smiling-IF9TK5Uy-KI', '+61 245 437 6071', '1987-11-08', '5358244243', '2023-09-09 01:51:09', 'Host', 'jP7@tU?6S&'),
(21, 'Eugene', 'Blackburn', 'eblackburn0@us.com', 'Male', 'https://unsplash.com/photos/mans-grey-and-black-shirt-ILip77SbmOE', '+1 345 678 9012', '1995-09-15', '58233074431', '2023-08-28 12:15:00', 'Guest', 'pG5a&T!x'),
(22, 'Lily', 'Wright', 'lwright1@amazon.com', 'Female', 'https://unsplash.com/photos/womans-face-EGVccebWodM', '+1 234 567 8901', '1987-03-18', '83166633022', '2023-09-25 18:30:00', 'Host', 'kN1l%A2?z'),
(23, 'Sebastian', 'Richards', 'srichards2@ustech.com', 'Male', 'https://unsplash.com/photos/man-wearing-white-crew-neck-shirt-outdoor-selective-focus-photography-TMt3JGoVlng', '+54 123 456 7890', '1978-12-07', '9124774701253', '2023-07-14 09:45:00', 'Guest', 'tR4&M^4g'),
(24, 'Scarlett', 'Carter', 'scarter3@gmail.com', 'Female', 'https://unsplash.com/photos/woman-with-blonde-hair-and-red-lipstick-nKZuhvCGGQU', '+1 432 567 8901', '1992-06-23', '3544991171', '2023-03-29 15:20:00', 'Host', 'wJ3$b~fL'),
(25, 'Isaac', 'Alexander', 'ialexander4@gmail.com', 'Male', 'https://unsplash.com/photos/man-in-brown-suit-jacket-6KPUS5tUp3Y', '+1 567 890 1234', '1980-08-30', '42320606007', '2023-08-10 11:10:00', 'Host', 'zK1c*R7v'),
(26, 'Hazel', 'Mitchell', 'hmitchell5@jsclothing.com', 'Female', 'https://unsplash.com/photos/woman-in-black-knit-cap-fq3lYfOK_O0', '+98 345 678 9012', '1993-02-12', '7440296718962468', '2023-05-17 20:30:00', 'Guest', 'xL2d@PpR'),
(27, 'Oliver', 'Baker', 'obaker6@hotmail.com', 'Male', 'https://unsplash.com/photos/man-in-gray-polo-shirt-smiling-QuwQYDBI6sI', '+1 234 567 8901', '1999-11-06', '12596481107', '2023-07-04 08:15:00', 'Host', 'pN3k%Z3m'),
(28, 'Charlotte', 'Williams', 'cwilliams7@postoffice.com', 'Female', 'https://unsplash.com/photos/woman-looking-sideways-leaning-on-white-wall-6W4F62sN_yI', '+1 123 456 7890', '2002-04-17', '9474044423', '2023-09-15 14:25:00', 'Guest', 'vM4g&X1b'),
(29, 'Henry', 'Cooper', 'hcooper8@google.com', 'Male', 'https://unsplash.com/photos/man-in-blue-denim-button-up-jacket-wearing-black-framed-eyeglasses-IVXoVHXqVCY', '+1 432 567 8901', '1997-01-28', '25301321763', '2023-01-12 07:50:00', 'Guest', 'kP5z&A!x'),
(30, 'Amelia', 'Turner', 'aturner9@newsediting.com', 'Female', 'https://unsplash.com/photos/woman-smiling-wearing-denim-jacket-TSZo17r3m0s', '+1 567 890 1234', '1986-05-14', '50997363089', '2023-05-30 19:00:00', 'Host', 'oN6l&M2g'),
(31, 'Eli', 'Scott', 'escott10@gmail.com', 'Male', 'https://unsplash.com/photos/man-in-black-suit-sitting-on-brown-wooden-armchair-GYyI17VgwS4', '+1 345 678 9012', '1988-10-09', '38268837059', '2023-09-09 16:10:00', 'Host', 'pL7d&V4p'),
(32, 'Grace', 'Perez', 'gperez11@foundation.com', 'Female', 'https://unsplash.com/photos/a-woman-in-a-white-shirt-is-posing-for-a-picture-vZurgrIe60w', '+375 234 567 8901', '1973-07-22', '713676366881', '2023-03-15 08:40:00', 'Guest', 'qP8k%S3d'),
(33, 'Mason', 'Gonzalez', 'mgonzalez12@swz.com', 'Male', 'https://unsplash.com/photos/man-in-white-dress-shirt-smiling-5n3JP9WAJTs', '+41 123 456 7890', '1984-12-25', 'CH02 0018 0533 RW42 1I5H 7', '2023-01-31 17:55:00', 'Guest', 'rP9c^F2w'),
(34, 'Zoey', 'Harris', 'zharris13@rhmodels.com', 'Female', 'https://unsplash.com/photos/woman-in-black-shirt-with-purple-hair-RBy6FEQ2DIk', '+1 432 567 8901', '1990-03-03', '7522738434', '2023-09-05 06:30:00', 'Host', 'sP0m*R8l'),
(35, 'Aiden', 'Martin', 'amartin14@dell.com', 'Male', 'https://unsplash.com/photos/man-in-blue-crew-neck-shirt-4uj3iZ5m084', '+1 567 890 1234', '1976-09-20', '15690087432', '2023-04-10 10:20:00', 'Host', 'tP1l^W1b'),
(36, 'Sofia', 'Rodriguez', 'srodriguez15@microsoft.com', 'Female', 'https://unsplash.com/photos/woman-wearing-black-scoop-neck-long-sleeved-shirt-Zz5LQe-VSMY', '+1 345 678 9012', '1982-01-12', '71982274045', '2023-08-12 14:50:00', 'Guest', 'yP2d*V5z'),
(37, 'Jack', 'Lopez', 'jlopez16@walmart.com', 'Male', 'https://unsplash.com/photos/man-in-black-hoodie-standing-kfN-BBbWTWo', '+1 234 567 8901', '2000-06-03', '99041098411', '2023-05-03 08:35:00', 'Host', 'uP3c&Z1b'),
(38, 'Ava', 'Young', 'ayoung17@dutch.com', 'Female', 'https://unsplash.com/photos/woman-in-black-shirt-smiling-lNNHyRbmm0o', '+31 123 456 7890', '1989-12-14', 'NL42 ULIA 0310 8713 53', '2023-09-19 12:15:00', 'Host', 'iP4a^Q2w'),
(39, 'Lucas', 'King', 'lking18@auz.com', 'Male', 'https://unsplash.com/photos/man-in-gray-crew-neck-t-shirt-sitting-on-bed-oRsSeYqJUgY', '+61 432 567 8901', '1977-04-08', '2478622187', '2023-04-26 17:00:00', 'Guest', 'oP5x@Z3z'),
(40, 'Harper', 'Ward', 'hward19@news.com', 'Female', 'https://unsplash.com/photos/woman-in-white-crew-neck-t-shirt-27VZlQY4K-g', '+7 567 890 1234', '1995-03-05', '667689686481', '2023-07-30 11:25:00', 'Guest', 'pP6b*G8l');



-- Dummy data of Languages table
INSERT INTO `myAirbnb`.`Languages` VALUES
(1, 'Arabic'),
(2, 'Burmese'),
(3, 'Chinese'),
(4, 'Dutch'),
(5, 'English'),
(6, 'Filipino'),
(7, 'Finnish'),
(8, 'French'),
(9, 'German'),
(10, 'Hindi'),
(11, 'Italian'),
(12, 'Japanese'),
(13, 'Korean'),
(14, 'Malay'),
(15, 'Norwegian'),
(16, 'Polish'),
(17, 'Portugese'),
(18, 'Russian'),
(19, 'Spanish'),
(20, 'Swedish'),
(21, 'Thai'),
(22, 'Turkish'),
(23, 'Vietnamese');



-- Dummy data of Users_Languages table
INSERT INTO `myAirbnb`.`Users_Languages` VALUES
-- User 1 Spoken Languages
(1, 'First Language', 1, 5), (2, 'Second Language', 1, 19),
-- User 2 Spoken Languages
(3, 'First Language', 2, 5), (4, 'Second Language', 2, 8), 
-- User 3 Spoken Languages
(5, 'First Language', 3, 5), (6, 'Second Language', 3, 8),
-- User 4 Spoken Languages
(7, 'First Language', 4, 3), (8, 'Second Language', 4, 5),
-- User 5 Spoken Languages
(9, 'First Language', 5, 5),
-- User 6 Spoken Languages
(10, 'First Language', 6, 5), (11, 'Second Language', 6, 9),
-- User 7 Spoken Languages
(12, 'Second Language', 7, 5), (13, 'First Language', 7, 6), (14, 'Second Language', 7, 19),
-- User 8 Spoken Languages
(15, 'First Language', 8, 5), (16, 'Second Language', 8, 8),
-- User 9 Spoken Languages
(17, 'First Language', 9, 5),
-- User 10 Spoken Languages
(18, 'Second Language', 10, 3), (19, 'Second Language', 10, 5), (20, 'First Language', 10, 23),
-- User 11 Spoken Languages
(21, 'First Language', 11, 3), (22, 'Second Language', 11, 5),
-- User 12 Spoken Languages
(23, 'First Language', 12, 5),
-- User 13 Spoken Languages
(24, 'First Language', 13, 5),
-- User 14 Spoken Languages
(25, 'First Language', 14, 3), (26, 'Second Language', 14, 5),
-- User 15 Spoken Languages
(27, 'First Language', 15, 5),
-- User 16 Spoken Languages
(28, 'Second Language', 16, 5),
-- User 17 Spoken Languages
(29, 'First Language', 17, 3), (30, 'First Language', 17, 5), (31, 'Second Language', 17, 14),
-- User 18 Spoken Languages
(32, 'First Language', 18, 3), (33, 'Second Language', 18, 5),
-- User 19 Spoken Languages
(34, 'First Language', 19, 3), (35, 'Second Language', 19, 5),
-- User 20 Spoken Languages
(36, 'First Language', 20, 5),
-- User 21 Spoken Languages
(37, 'First Language', 21, 5),
-- User 22 Spoken Languages
(38, 'First Language', 22, 5),
-- User 23 Spoken Languages
(39, 'Second Language', 23, 5), (40, 'Second Language', 23, 17), (41, 'First Language', 23, 19),
-- User 24 Spoken Languages
(42, 'First Language', 24, 5),
-- User 25 Spoken Languages
(43, 'First Language', 25, 5),
-- User 26 Spoken Languages
(44, 'First Language', 26, 1), (45, 'Second Language', 26, 5),
-- User 27 Spoken Languages
(46, 'First Language', 27, 5),
-- User 28 Spoken Languages
(47, 'Second Language', 28, 4), (48, 'First Language', 28, 5),
-- User 29 Spoken Languages
(49, 'First Language', 29, 5), (50, 'Second Language', 29, 11),
-- User 30 Spoken Languages
(51, 'First Language', 30, 5), (52, 'Second Language', 30, 23),
-- User 31 Spoken Languages
(53, 'First Language', 31, 5),
-- User 32 Spoken Languages
(54, 'Second Language', 32, 5), (55, 'Second Language', 32, 9), (56, 'First Language', 32, 18),
-- User 33 Spoken Languages
(57, 'Second Language', 33, 5), (58, 'First Language', 33, 8), (59, 'First Language', 33, 9),
-- User 34 Spoken Languages
(60, 'First Language', 34, 5),
-- User 35 Spoken Languages
(61, 'First Language', 35, 5), (62, 'Second Language', 35, 10),
-- User 36 Spoken Languages
(63, 'First Language', 36, 5), (64, 'Second Language', 36, 22),
-- User 37 Spoken Languages
(65, 'First Language', 37, 5),
-- User 38 Spoken Languages
(66, 'First Language', 38, 4), (67, 'Second Language', 38, 5),
-- User 39 Spoken Languages
(68, 'Second Language', 39, 3), (69, 'First Language', 39, 5),
-- User 40 Spoken Languages
(70, 'Second Language', 40, 5), (71, 'First Language', 40, 18);



-- Dummy data of Notification table
INSERT INTO `myAirbnb`.`Notification` VALUES
(1, 'You have a new message from host.', 1, 2),
(2, 'New event notification.', 1, 6),
(3, 'Account update: Please review your profile.', 0, 10),
(4, 'You received a validation request.', 0, 20),
(5, 'Important system update: Read now.', 1, 17),
(6, 'Check out our latest offers.', 0, 7),
(7, 'Your account has been verified.', 1, 9),
(8, 'Reminder: Upcoming event tomorrow.', 0, 14),
(9, 'New message from your guest.', 1, 1),
(10, 'Action required: Verify your email.', 0, 11),
(11, 'Your received a payment.', 1, 3),
(12, 'Event cancellation notice.', 1, 18),
(13, 'Security alert: Change your password.', 0, 15),
(14, 'You have been awarded a badge.', 0, 12),
(15, 'Event scheduled for next week.', 1, 19),
(16, 'Promotional offer: Save on your next booking.', 0, 4),
(17, 'Booking request accepted.', 1, 8),
(18, 'New feature announcement: Learn more.', 0, 16),
(19, 'Account balance update.', 0, 5),
(20, 'Important notice: Read immediately.', 1, 13);



-- Dummy data of Message table
INSERT INTO `myAirbnb`.`Message` VALUES
-- Message sent by User 10 (Newton Whorall) and received by User 1 (Cosme Norwood)
(1, 'Hello, I have some questions about your property.', '2023-09-20 08:15:00', 1, '2023-09-20 08:20:00', 10, 1),
-- Message sent by User 1 (Cosme Norwood) and received by User 10 (Newton Whorall)
(2, 'Sure, feel free to ask anything!', '2023-09-20 08:30:00', 1, '2023-09-20 08:33:00', 1, 10),
-- Message sent by User 16 (Georgie Ivanishev) and received by User 13 (Camala Solleme)
(3, 'I want to book your property for the weekend.', '2023-09-21 10:00:00', 1, '2023-09-21 10:10:00', 16, 13),
-- Message sent by User 13 (Camala Solleme) and received by User 16 (Georgie Ivanishev)
(4, 'The property is available for the weekend.', '2023-09-21 10:15:00', 1, '2023-09-21 11:00:00', 13, 16),
-- Message sent by User 16 (Georgie Ivanishev) and received by User 13 (Camala Solleme)
(5, 'Great, I would like to proceed with the booking.', '2023-09-21 12:00:00', 1, '2023-09-21 13:00:00', 16, 13),
-- Message sent by User 13 (Camala Solleme) and received by User 16 (Georgie Ivanishev)
(6, 'Booking confirmed for the weekend!', '2023-09-21 13:15:00', 1, '2023-09-21 13:30:00', 13, 16),
-- Message sent by User 4 (Zea Drei) and received by User 5 (Annalise Krzysztof)
(7, 'Did you receive my payment?', '2023-09-22 15:30:00', 1, '2023-09-22 15:35:00', 4, 5),
-- Message sent by User 5 (Annalise Krzysztof) and received by User 4 (Zea Drei)
(8, 'Yes, your payment is received and confirmed.', '2023-09-22 15:45:00', 1, '2023-09-22 15:47:00', 5, 4),
-- Message sent by User 8 (Saunders Anlay) and User by Receiver 13 (Camala Solleme)
(9, 'I have some special requests for my stay.', '2023-09-22 18:00:00', 1, '2023-09-22 18:09:00', 8, 13),
-- Message sent by User 13 (Camala Solleme) and received by User 8 (Saunders Anlay)
(10, 'Of course, please let me know your requests.', '2023-09-22 18:15:00', 1, '2023-09-22 18:30:00', 13, 8),
-- Message sent by User 19 (Dallas Hayes) and received by User 17 (Evonne Duthie)
(11, 'I need to cancel my reservation due to an emergency.', '2023-09-23 09:00:00', 1, '2023-09-23 09:12:00', 19, 17),
-- Message sent by User 17 (Evonne Duthie) and received by User 19 (Dallas Hayes)
(12, 'I am sorry to hear that. We will process your cancellation.', '2023-09-23 09:15:00', 1, '2023-09-23 09:16:00', 17, 19),
-- Message sent by User 2 (Pen Coy) and received by User 1 (Cosme Norwood)
(13, 'I will arrive at 3 PM.', '2023-09-24 13:30:00', 0, NULL, 2, 1),
-- Message sent by User 2 (Pen Coy) and received by User 1 (Cosme Norwood)
(14, 'Can you provide airport pickup?', '2023-09-24 13:45:00', 0, NULL, 2, 1),
-- Message sent by User 7 (Elias Harg) and received by User 17 (Evonne Duthie)
(15, 'Is there a minimum stay requirement?', '2023-09-25 16:30:00', 0, NULL, 7, 17),
-- Message sent by User 10 (Newton Whorall) and received by User 1 (Cosme Norwood)
(16, 'How far is the property from the city center?', '2023-09-25 16:45:00', 0, NULL, 10, 1),
-- Message sent by User 7 (Elias Harg) and received by User 17 (Evonne Duthie)
(17, 'Please send me directions to your place.', '2023-09-26 19:00:00', 0, NULL, 7, 17),
-- Message sent by User 10 (Newton Whorall) and received by User 1 (Cosme Norwood)
(18, 'Do you allow pets?', '2023-09-26 19:15:00', 0, NULL, 10, 1),
-- Message sent by User 11 (Omar Klima) and received by User 5 (Annalise Krzysztof)
(19, 'Hello, how are you?', '2023-09-27 14:00:00', 0, NULL, 11, 5),
-- Message sent by User 11 (Omar Klima) and received by User 5 (Annalise Krzysztof)
(20, 'Do you provide breakfast?', '2023-09-27 14:15:00', 0, NULL, 11, 5);



-- Dummy data of User_Social_Network table
INSERT INTO `myAirbnb`.`User_Social_Network` VALUES
-- Social Network of User 1 (Cosme Norwood)
(1, 'Facebook', 'https://www.facebook.com/cosme.norwood', 1),
-- Social Network of User 2 (Pen Coy)
(2, 'Twitter', 'https://twitter.com/pencoy', 2),
-- Social Network of User 3 (Curry Pollins)
(3, 'Facebook', 'https://www.facebook.com/curry.pollins', 3),
-- Social Network of User 4 (Zea Drei)
(4, 'Facebook', 'https://www.facebook.com/zea.drei', 4),
(5, 'Twitter', 'https://twitter.com/zeadrei', 4),
-- Social Network of User 5 (Annalise Krzysztof)
(6, 'Twitter', 'https://twitter.com/annalisekrzysztof', 5),
(7, 'Instagram', 'https://www.instagram.com/annalisekrzysztof', 5),
-- Social Network of User 6 (Cointon Lightwing)
(8, 'Twitter', 'https://twitter.com/cointonlightwing', 6),
(9, 'Instagram', 'https://www.instagram.com/cointonlightwing', 6),
-- Social Network of User 7 (Elias Harg)
(10, 'Instagram', 'https://www.instagram.com/eliasharg', 7),
-- Social Network of User 8 (Saunders Anlay)
(11, 'Facebook', 'https://www.facebook.com/saunders.anlay', 8),
-- Social Network of User 9 (Berenice Aicken)
(12, 'Instagram', 'https://www.instagram.com/bereniceaicken', 9),
-- Social Network of User 10 (Newton Whorall)
(13, 'Twitter', 'https://twitter.com/newtonwhorall', 10),
(14, 'Instagram', 'https://www.instagram.com/newtonwhorall', 10),
-- Social Network of User 11 (Omar Klima)
(15, 'Facebook', 'https://www.facebook.com/omar.klima', 11),
-- Social Network of User 12 (Alasdair De Domenico)
(16, 'Facebook', 'https://www.facebook.com/alasdair.dedomenico', 12),
(17, 'Twitter', 'https://twitter.com/alasdairdedomenico', 12),
-- Social Network of User 13 (Camala Solleme)
(18, 'Facebook', 'https://www.facebook.com/camala.solleme', 13),
-- Social Network of User 14 (Babita Fewtrell)
(19, 'Facebook', 'https://www.facebook.com/babita.fewtrell', 14),
-- Social Network of User 15 (Stephana Lestrange)
(20, 'Facebook', 'https://www.facebook.com/stephana.lestrange', 15),
(21, 'Instagram', 'https://www.instagram.com/stephanalestrange', 15),
-- Social Network of User 16 (Georgie Ivanishev)
(22, 'Twitter', 'https://twitter.com/georgieivanishev', 16),
(23, 'Instagram', 'https://www.instagram.com/georgieivanishev', 16),
-- Social Network of User 17 (Evonne Duthie)
(24, 'Twitter', 'https://twitter.com/evonneduthie', 17),
-- Social Network of User 18 (Ker Cunde)
(25, 'Instagram', 'https://www.instagram.com/kercunde', 18),
-- Social Network of User 19 (Dallas Hayes)
(26, 'Twitter', 'https://twitter.com/dallashayes', 19),
-- Social Network of User 20 (Benedikta McMearty)
(27, 'Twitter', 'https://twitter.com/benediktamcmearty', 20),
-- Social Network of User 21 (Eugene Blackburn)
(28, 'Facebook', 'https://www.facebook.com/eugene.blackburn', 21),
-- Social Network of User 22 (Lily Wright)
(29, 'Facebook', 'https://www.facebook.com/lily.wright', 22),
-- Social Network of User 23 (Sebastian Richards)
(30, 'Facebook', 'https://www.facebook.com/sebastian.richards', 23),
-- Social Network of User 24 (Scarlett Carter)
(31, 'Instagram', 'https://www.instagram.com/scarlettcarter', 24),
-- Social Network of User 25 (Isaac Alexander)
(32, 'Twitter', 'https://twitter.com/isaacalexander', 25),
(33, 'Instagram', 'https://www.instagram.com/isaacalexander', 25),
-- Social Network of User 26 (Hazel Mitchell)
(34, 'Twitter', 'https://twitter.com/hazelmitchell', 26),
(35, 'Instagram', 'https://www.instagram.com/hazelmitchell', 26),
-- Social Network of User 27 (Oliver Baker)
(36, 'Facebook', 'https://www.facebook.com/oliver.baker', 27),
-- Social Network of User 28 (Charlotte Williams)
(37, 'Twitter', 'https://twitter.com/charlottewilliams', 28),
-- Social Network of User 29 (Henry Cooper)
(38, 'Facebook', 'https://www.facebook.com/henry.cooper', 29),
(39, 'Twitter', 'https://twitter.com/henrycooper', 29),
-- Social Network of User 30 (Amelia Turner)
(40, 'Facebook', 'https://www.facebook.com/amelia.turner', 30),
-- Social Network of User 31 (Eli Scott)
(41, 'Instagram', 'https://www.instagram.com/eliscott', 31),
-- Social Network of User 32 (Grace Perez)
(42, 'Instagram', 'https://www.instagram.com/graceperez', 32),
-- Social Network of User 33 (Mason Gonzalez)
(43, 'Facebook', 'https://www.facebook.com/mason.gonzalez', 33),
(44, 'Instagram', 'https://www.instagram.com/masongonzalez', 33),
-- Social Network of User 34 (Zoey Harris)
(45, 'Twitter', 'https://twitter.com/zoeyharris', 34),
-- Social Network of User 35 (Aiden Martin)
(46, 'Twitter', 'https://twitter.com/aidenmartin', 35),
(47, 'Instagram', 'https://www.instagram.com/aidenmartin', 35),
-- Social Network of User 36 (Sofia Rodriguez)
(48, 'Facebook', 'https://www.facebook.com/sofia.rodriguez', 36),
-- Social Network of User 37 (Jack Lopez)
(49, 'Facebook', 'https://www.facebook.com/jack.lopez', 37),
-- Social Network of User 38 (Ava Young)
(50, 'Facebook', 'https://www.facebook.com/ava.young', 38),
-- Social Network of User 39 (Lucas King)
(51, 'Twitter', 'https://twitter.com/lucasking', 39),
-- Social Network of User 40 (Harper Ward)
(52, 'Facebook', 'https://www.facebook.com/harper.ward', 40);



-- Dummy data of Host table
INSERT INTO `myAirbnb`.`Host` VALUES
-- Host 1 (Cosme Norwood)
(1, 'Cosme Norwood is a friendly and welcoming host who loves to share travel stories and local tips with his guests.', 1),
-- Host 2 (Curry Pollins)
(2, 'Curry Pollins is a warm and accommodating host who enjoys creating a cozy and comfortable environment for travelers.', 3),
-- Host 3 (Annalise Krzysztof)
(3, 'Annalise Krzysztof is a gracious host who takes pride in providing a warm and inviting space for her guests.', 5),
-- Host 4 (Cointon Lightwing)
(4, 'Cointon Lightwing is an amiable host who enjoys meeting people from different parts of the world and ensuring they have a memorable stay.', 6),
-- Host 5 (Berenice Aicken)
(5, 'Berenice Aicken is a kind and attentive host who goes the extra mile to make her guests feel at home.', 9),
-- Host 6 (Alasdair De Domenico)
(6, 'Alasdair De Domenico is a charming host who enjoys making his guests unforgettable moments in his city.', 12),
-- Host 7 (Camala Solleme)
(7, 'Camala Solleme is a hospitable host who takes pleasure in creating a welcoming and comfortable atmosphere for travelers.', 13),
-- Host 8 (Stephana Lestrange)
(8, 'Stephana Lestrange is a delightful host who prides herself on providing a relaxing and enjoyable stay for her guests.', 15),
-- Host 9 (Evonne Duthie)
(9, 'Evonne Duthie is a friendly and considerate host who takes pleasure in offering a warm and inviting home away from home.', 17),
-- Host 10 (Benedikta McMearty)
(10, 'Benedikta McMearty is a warm and welcoming host who enjoys sharing her local knowledge and recommendations with guests.', 20),
-- Host 11 (Lily Wright)
(11, 'Lily Wright is a gracious and accommodating host who ensures her guests have a memorable and enjoyable stay.', 22),
-- Host 12 (Scarlett Carter)
(12, 'Scarlett Carter is a friendly and welcoming host who goes the extra mile to make her guests feel comfortable and at ease.', 24),
-- Host 13 (Isaac Alexander)
(13, 'Isaac Alexander is a warm and charming host who enjoys sharing his love for the city with his guests.', 25),
-- Host 14 (Oliver Baker)
(14, 'Oliver Baker is a delightful host who takes pride in providing a cozy and comfortable space for travelers.', 27),
-- Host 15 (Amelia Turner)
(15, 'Amelia Turner is a hospitable and considerate host who enjoys creating a welcoming and relaxing atmosphere for her guests.', 30),
-- Host 16 (Eli Scott)
(16, 'Eli Scott is a gracious host who ensures his guests have a memorable and enjoyable experience during their stay.', 31),
-- Host 17 (Zoey Harris)
(17, 'Zoey Harris is a friendly and accommodating host who goes out of her way to make her guests feel at home.', 34),
-- Host 18 (Aiden Martin)
(18, 'Aiden Martin is a warm and welcoming host who enjoys sharing his local insights and recommendations with travelers.', 35),
-- Host 19 (Jack Lopez)
(19, 'Jack Lopez is a hospitable host who takes pleasure in providing a comfortable and relaxing space for guests.', 37),
-- Host 20 (Ava Young)
(20, 'Ava Young is a delightful and considerate host who prides herself on offering a warm and inviting home away from home.', 38);



-- Dummy data of Host_Review table
INSERT INTO `myAirbnb`.`Host_Review` VALUES
-- Reviews given to Host 1 (Cosme Norwood)
(1, 5, 'Cosme is an amazing host! He made me feel at home and shared great local tips.', '2023-07-10 15:30:00', 1),
(2, 4, 'Cosme is a friendly host, and his place is cozy and well-maintained.', '2023-08-15 09:45:00', 1),
(3, 5, 'Cosme exceeded my expectations as a host. His hospitality is top-notch!', '2023-09-10 12:15:00', 1),
-- Reviews given to Host 2 (Curry Pollins)
(4, 4, 'Curry is a welcoming host, and his place is in a convenient location.', '2023-09-28 18:20:00', 2),
(5, 5, 'I had a fantastic experience at Curry''s place. He made me feel right at home.', '2023-10-02 10:10:00', 2),
-- Reviews given to Host 3 (Annalise Krzysztof)
(6, 5, 'Annalise is a great host who pays attention to every detail to ensure a pleasant stay.', '2023-06-02 14:45:00', 3),
(7, 4, 'The place of Annalise is lovely, and she is very accommodating. I enjoyed my stay.', '2023-06-12 11:30:00', 3),
-- Reviews given to Host 4 (Cointon Lightwing)
(8, 5, 'The hospitality of Cointon is unmatched, and his home is clean and comfortable.', '2023-09-14 15:25:00', 4),
(9, 5, 'I had a wonderful experience at the place of Cointon. Highly recommended!', '2023-09-20 17:05:00', 4),
-- Reviews given to Host 5 (Berenice Aicken)
(10, 4, 'Berenice is a friendly and accommodating host. Her home is cozy and inviting.', '2023-09-20 19:30:00', 5),
(11, 4, 'Berenice provided a warm and pleasant environment. I enjoyed my stay at her place.', '2023-09-23 08:40:00', 5),
-- Reviews given to Host 6 (Alasdair De Domenico)
(12, 5, 'The place of Alasdair is stylish and comfortable. He was a gracious host!', '2023-06-30 16:55:00', 6),
(13, 4, 'I appreciated Alasdair friendliness and the well-maintained space.', '2023-07-05 09:25:00', 6),
-- Reviews given to Host 7 (Camala Solleme)
(14, 5, 'Camala is a great host who made me feel right at home. Her place is chic and cozy.', '2023-04-25 12:30:00', 7),
(15, 5, 'I had a wonderful stay at Camala accomodation. She is a fantastic host!', '2023-05-01 08:15:00', 7),
-- Reviews given to Host 8 (Stephana Lestrange)
(16, 4, 'Stephana provided a comfortable and relaxing stay. Her place is clean and inviting.', '2023-08-20 11:20:00', 8),
(17, 5, 'I had a fantastic experience at the place of Stephana. She is a warm and welcoming host.', '2023-08-25 10:15:00', 8),
-- Reviews given to Host 9 (Evonne Duthie)
(18, 4, 'Evonne is a welcoming and friendly host. Her home is cozy and well-kept.', '2023-07-15 14:40:00', 9),
(19, 5, 'I enjoyed my stay at the place of Evonne. She went above and beyond to make me comfortable.', '2023-07-20 09:50:00', 9),
-- Reviews given to Host 10 (Benedikta McMearty)
(20, 5, 'Benedikta accomodation is clean and inviting. She is a gracious host who made my stay enjoyable.', '2023-09-15 15:30:00', 10),
(21, 4, 'I had a pleasant experience at this place . Her hospitality is commendable.', '2023-09-20 11:10:00', 10),
-- Reviews given to Host 11 (Lily Wright)
(22, 5, 'Lily is an exceptional host! Her place is stylish and comfortable, and I had a fantastic stay.', '2023-10-01 10:45:00', 11),
(23, 5, 'I couldnot have asked for a better host than Lily. She made my stay memorable.', '2023-10-05 17:25:00', 11),
-- Reviews given to Host 12 (Scarlett Carter)
(24, 4, 'This place is lovely, and she is a welcoming host. I had a comfortable stay.', '2023-04-01 16:45:00', 12),
(25, 4, 'I enjoyed my stay at Scarlett is place. She provided everything I needed for a pleasant visit.', '2023-04-05 13:20:00', 12),
-- Reviews given to Host 13 (Isaac Alexander)
(26, 5, 'Isaac is an attentive and accommodating host. His home is cozy and inviting.', '2023-08-05 10:30:00', 13),
(27, 4, 'I had a great experience at this place. He made sure my stay was enjoyable.', '2023-08-10 08:15:00', 13),
-- Reviews given to Host 14 (Oliver Baker)
(28, 5, 'Oliver is a fantastic host! His place is comfortable, and I had a wonderful stay.', '2023-07-12 14:45:00', 14),
(29, 4, 'I enjoyed my stay at the place Oliver. His hospitality is top-notch.', '2023-07-17 10:10:00', 14),
-- Reviews given to Host 15 (Amelia Turner)
(30, 5, 'Amelia is a welcoming host, and her place is cozy and inviting. I had a pleasant stay.', '2023-05-15 11:20:00', 15),
(31, 5, 'I had a fantastic experience at Amelia accomodation. She made me feel right at home.', '2023-05-20 12:45:00', 15),
-- Reviews given to Host 16 (Eli Scott)
(32, 4, 'Eli provided a comfortable and relaxing stay. His place is clean and well-maintained.', '2023-09-15 14:30:00', 16),
(33, 5, 'I couldnot have asked for a better host than Eli. He made my stay memorable.', '2023-09-20 11:10:00', 16),
-- Reviews given to Host 17 (Zoey Harris)
(34, 4, 'The place of Zoey is lovely, and she is a lovely host. I had a comfortable stay.', '2023-09-01 16:15:00', 17),
(35, 5, 'I had a great experience at this place. She made sure my stay was enjoyable.', '2023-09-05 17:50:00', 17),
-- Reviews given to Host 18 (Aiden Martin)
(36, 5, 'Aiden is an amazing host! His place is comfortable, and I had a fantastic stay.', '2023-04-15 14:30:00', 18),
(37, 4, 'I had a pleasant experience at the rent place. This host friendliness is commendable.', '2023-04-20 11:10:00', 18),
-- Reviews given to Host 19 (Jack Lopez)
(38, 5, 'Jack accomodation is clean and inviting. He is a gracious host who made my stay enjoyable.', '2023-05-15 12:30:00', 19),
(39, 5, 'I had a wonderful experience at the place of Jack. He made me feel right at home.', '2023-05-20 08:40:00', 19),
-- Reviews given to Host 20 (Ava Young)
(40, 4, 'Ava provided a comfortable and relaxing stay. Her place is cozy and well-maintained.', '2023-09-10 16:30:00', 20);



-- Dummy data of Guest table
INSERT INTO `myAirbnb`.`Guest` VALUES
-- Guest 1 (Pen Coy)
(1, 'Pen Coy is a friendly and welcoming guest who enjoys sharing travel stories and experiences with fellow travelers.', 2),
-- Guest 2 (Zea Drei)
(2, 'Zea Drei is an adventurous and open-minded guest who loves exploring new destinations and immersing herself in local culture.', 4),
-- Guest 3 (Elias Harg)
(3, 'Elias Harg is a laid-back and easygoing traveler who appreciates comfortable accommodations and a stress-free journey.', 7),
-- Guest 4 (Saunders Anlay)
(4, 'Saunders Anlay is a travel enthusiast who seeks out unique and off-the-beaten-path experiences in each new place he visits.', 8),
-- Guest 5 (Newton Whorall)
(5, 'Newton Whorall is a nature lover who enjoys outdoor adventures and the beauty of natural landscapes while on the road.', 10),
-- Guest 6 (Omar Klima)
(6, 'Omar Klima is a tech-savvy guest who values modern amenities and a seamless travel experience during his trips.', 11),
-- Guest 7 (Babita Fewtrell)
(7, 'Babita Fewtrell is a solo traveler who appreciates the freedom to explore at her own pace and on her own terms.', 14),
-- Guest 8 (Georgie Ivanishev)
(8, 'Georgie Ivanishev is a culture and arts aficionado who enjoys visiting museums, galleries, and cultural events during her travels.', 16),
-- Guest 9 (Ker Cunde)
(9, 'Ker Cunde is a foodie who enjoys trying local cuisines and delicacies in every place he visits.', 18),
-- Guest 10 (Dallas Hayes)
(10, 'Dallas Hayes is a family traveler who values exploring destinations with loved ones and creating lasting memories.', 19),
-- Guest 11 (Eugene Blackburn)
(11, 'Eugene Blackburn is a friendly and outgoing guest who enjoys making new friends and experiencing the local nightlife.', 21),
-- Guest 12 (Sebastian Richards)
(12, 'Sebastian Richards is a mountain enthusiast who seeks destinations that offer hiking and outdoor exploration.', 23),
-- Guest 13 (Hazel Mitchell)
(13, 'Hazel Mitchell is an art and culture aficionado who enjoys visiting art exhibitions and cultural events during her travels.', 26),
-- Guest 14 (Charlotte Williams)
(14, 'Charlotte Williams is a business traveler who values a comfortable and efficient stay while on work-related trips.', 28),
-- Guest 15 (Henry Cooper)
(15, 'Henry Cooper is an easy-to-please guest who appreciates clean and well-maintained accommodations.', 29),
-- Guest 16 (Grace Perez)
(16, 'Grace Perez is a curious and open-minded guest who enjoys meeting new people and making lasting memories.', 32),
-- Guest 17 (Mason Gonzalez)
(17, 'Mason Gonzalez is an inquisitive traveler who enjoys trying new foods and immersing himself in the local lifestyle.', 33),
-- Guest 18 (Sofia Rodriguez)
(18, 'Sofia Rodriguez is a history buff who takes pleasure in learning about the past and exploring historical landmarks.', 36),
-- Guest 19 (Lucas King)
(19, 'Lucas King is a thrill-seeker who seeks out adrenaline-pumping activities and adventure wherever he goes.', 39),
-- Guest 20 (Harper Ward)
(20, 'Harper Ward is a beach lover who is drawn to coastal destinations and relaxing by the ocean.', 40);



-- Dummy data of Guest_Review table
INSERT INTO `myAirbnb`.`Guest_Review` VALUES
-- Reviews given to Guest 1 (Pen Coy)
(1, 4, 'Pen is a great guest, very respectful and friendly. It was a pleasure to host him.', '2023-07-15 09:30:00', 1),
(2, 5, 'Pen was an excellent guest. He left the place in perfect condition and is very polite.', '2023-07-20 12:45:00', 1),
-- Reviews given to Guest 2 (Zea Drei)
(3, 5, 'Zea is a fantastic guest! She is very considerate and left everything spotless.', '2023-09-20 11:30:00', 2),
(4, 4, 'I enjoyed hosting Zea. She is a responsible guest and easy to communicate with.', '2023-09-25 08:15:00', 2),
-- Reviews given to Guest 3 (Elias Harg)
(5, 5, 'Elias was a great guest. He is very friendly and respectful. Would host again!', '2023-10-02 14:45:00', 3),
(6, 4, 'I had a positive experience hosting Elias. He is a reliable and easygoing guest.', '2023-10-05 10:10:00', 3),
-- Reviews given to Guest 4 (Saunders Anlay)
(7, 4, 'Saunders was a good guest. He respected the property and the rules. No issues.', '2023-07-15 12:45:00', 4),
(8, 5, 'I had a pleasant experience hosting Saunders. He is a responsible and polite guest.', '2023-07-20 09:50:00', 4),
-- Reviews given to Guest 5 (Newton Whorall)
(9, 5, 'Newton is an excellent guest. He is friendly and left the place in great condition.', '2023-09-25 15:30:00', 5),
(10, 4, 'I enjoyed hosting Newton. He is a respectful guest and easy to communicate with.', '2023-09-28 11:10:00', 5),
-- Reviews given to Guest 6 (Omar Klima)
(11, 4, 'Omar was a good guest. He is responsible and followed the house rules. No problems.', '2023-10-15 14:45:00', 6),
(12, 5, 'I had a positive experience hosting Omar. He is a reliable and easygoing guest.', '2023-10-18 10:20:00', 6),
-- Reviews given to Guest 7 (Babita Fewtrell)
(13, 5, 'Babita is a fantastic guest! She is very considerate and respectful of the property.', '2023-08-30 16:55:00', 7),
(14, 4, 'I enjoyed hosting Babita. She is a responsible guest and easy to communicate with.', '2023-09-05 08:25:00', 7),
-- Reviews given to Guest 8 (Georgie Ivanishev)
(15, 5, 'Georgie was an excellent guest. She left the place in perfect condition and is very polite.', '2023-07-25 12:30:00', 8),
(16, 4, 'Georgie is a great guest, very respectful and friendly. It was a pleasure to host her.', '2023-08-02 10:15:00', 8),
-- Reviews given to Guest 9 (Ker Cunde)
(17, 4, 'Ker is a good guest. He respected the property and the rules. No issues.', '2023-09-10 15:30:00', 9),
(18, 5, 'I had a pleasant experience hosting Ker. He is a responsible and polite guest.', '2023-09-15 11:10:00', 9),
-- Reviews given to Guest 10 (Dallas Hayes)
(19, 5, 'Dallas was a great guest. She is very friendly and left everything spotless.', '2023-09-18 14:30:00', 10),
(20, 4, 'I enjoyed hosting Dallas. She is a reliable and easygoing guest.', '2023-09-20 11:20:00', 10),
-- Reviews given to Guest 11 (Eugene Blackburn)
(21, 5, 'Eugene is an excellent guest. He is friendly and left the place in great condition.', '2023-10-01 09:45:00', 11),
(22, 4, 'I had a positive experience hosting Eugene. He is a respectful guest and easy to communicate with.', '2023-10-05 17:25:00', 11),
-- Reviews given to Guest 12 (Sebastian Richards)
(23, 4, 'Sebastian was a good guest. He respected the property and the rules. No problems.', '2023-07-20 16:45:00', 12),
(24, 5, 'I had a pleasant experience hosting Sebastian. He is a responsible and polite guest.', '2023-07-25 13:20:00', 12),
-- Reviews given to Guest 13 (Hazel Mitchell)
(25, 5, 'Hazel is a fantastic guest! She is very considerate and respectful of the property.', '2023-09-15 12:30:00', 13),
(26, 4, 'I enjoyed hosting Hazel. She is a responsible guest and easy to communicate with.', '2023-09-20 08:40:00', 13),
-- Reviews given to Guest 14 (Charlotte Williams)
(27, 5, 'Charlotte was an excellent guest. She left the place in perfect condition and is very polite.', '2023-07-01 10:30:00', 14),
(28, 4, 'Charlotte is a great guest, very respectful and friendly. It was a pleasure to host her.', '2023-07-05 08:15:00', 14),
-- Reviews given to Guest 15 (Henry Cooper)
(29, 4, 'Henry is a good guest. He respected the property and the rules. No issues.', '2023-09-05 16:15:00', 15),
(30, 5, 'I had a positive experience hosting Henry. He is a reliable and easygoing guest.', '2023-09-10 17:50:00', 15),
-- Reviews given to Guest 16 (Grace Perez)
(31, 5, 'Grace is a fantastic guest! She is very considerate and respectful of the property.', '2023-07-01 16:15:00', 16),
(32, 4, 'I enjoyed hosting Grace. She is a responsible guest and easy to communicate with.', '2023-07-05 17:50:00', 16),
-- Reviews given to Guest 17 (Mason Gonzalez)
(33, 5, 'Mason was an excellent guest. He left the place in perfect condition and is very polite.', '2023-09-12 10:30:00', 17),
(34, 4, 'Mason is a great guest, very respectful and friendly. It was a pleasure to host him.', '2023-09-15 08:15:00', 17),
-- Reviews given to Guest 18 (Sofia Rodriguez)
(35, 4, 'Sofia is a good guest. She respected the property and the rules. No issues.', '2023-09-20 16:15:00', 18),
(36, 5, 'I had a positive experience hosting Sofia. She is a reliable and easygoing guest.', '2023-09-25 17:50:00', 18),
-- Reviews given to Guest 19 (Lucas King)
(37, 5, 'Lucas is a fantastic guest! He is very considerate and respectful of the property.', '2023-07-10 10:30:00', 19),
(38, 4, 'I enjoyed hosting Lucas. He is a responsible guest and easy to communicate with.', '2023-07-15 08:15:00', 19),
-- Reviews given to Guest 20 (Harper Ward)
(39, 4, 'Harper was a good guest. She respected the property and the rules. No issues.', '2023-09-10 16:15:00', 20),
(40, 5, 'I had a positive experience hosting Harper. She is a reliable and easygoing guest.', '2023-09-15 17:50:00', 20);



-- Dummy data of Property table
INSERT INTO `myAirbnb`.`Property` VALUES
-- Properties of Host 1 (Cosme Norwood)
(1, 'Cozy Downtown Apartment', 'Apartment', 'A cozy apartment in the heart of the city. Perfect for a weekend getaway.', 1, 100, 1, 1, 2, 1),
(2, 'Luxury Loft with City View', 'Loft', 'A luxurious loft with a stunning view of the city skyline.', 1, 250.25, 1, 1, 2, 1),
-- Properties of Host 2 (Curry Pollins)
(3, 'Spacious Beach House', 'House', 'A spacious beachfront house with a private pool and beach access.', 4, 350.75, 1, 1, 8, 2),
-- Properties of Host 3 (Annalise Krzysztof)
(4, 'Charming Countryside Cottage', 'Cottage', 'A charming cottage in the peaceful countryside. Ideal for nature lovers.', 2, 150, 1, 0, 4, 3),
-- Properties of Host 4 (Cointon Lightwing)
(5, 'Modern City Studio', 'Studio', 'A modern studio apartment with all the amenities you need for a comfortable stay.', 1, 120.89, 1, 1, 2, 4),
-- Properties of Host 5 (Berenice Aicken)
(6, 'Rustic Mountain Cabin', 'Cabin', 'A rustic cabin nestled in the mountains. Perfect for a quiet retreat.', 2, 180, 1, 1, 4, 5),
-- Properties of Host 6 (Alasdair De Domenico)
(7, 'Urban Oasis Penthouse', 'Penthouse', 'A stunning penthouse with an urban oasis on the rooftop. Panoramic city views.', 3, 300, 1, 1, 6, 6),
-- Properties of Host 7 (Camala Solleme)
(8, 'Historic Townhouse', 'Townhouse', 'A historic townhouse in the heart of the old town. Full of character and charm.', 3, 200.67, 1, 1, 6, 7),
-- Properties of Host 8 (Stephana Lestrange)
(9, 'Elegant Villa with Pool', 'Villa', 'An elegant villa with a private pool and beautiful gardens. Ideal for a family vacation.', 5, 400, 1, 1, 10, 8),
-- Properties of Host 9 (Evonne Duthie)
(10, 'Seaside Bungalow', 'Bungalow', 'A cozy seaside bungalow just steps away from the beach. Relax and unwind.', 1, 130.99, 1, 1, 2, 9),
-- Properties of Host 10 (Benedikta McMearty)
(11, 'Downtown Condo with a View', 'Condo', 'A stylish condo in the heart of the city with great views and access to amenities.', 2, 260.78, 1, 1, 4, 10),
-- Properties of Host 11 (Lily Wright)
(12, 'Quaint Historic Cottage', 'Cottage', 'A quaint historic cottage with a beautiful garden. Step back in time.', 2, 140, 1, 1, 4, 11),
-- Properties of Host 12 (Scarlett Carter)
(13, 'Modern Apartment with Balcony', 'Apartment', 'A modern apartment with a balcony for enjoying the city skyline.', 3, 310, 1, 1, 6, 12),
-- Properties of Host 13 (Isaac Alexander)
(14, 'Sunny Beachfront Retreat', 'House', 'A sunny beachfront house perfect for beach lovers. Private beach access.', 3, 280, 1, 1, 6, 13),
-- Properties of Host 14 (Oliver Baker)
(15, 'Downtown Loft with Industrial Flair', 'Loft', 'A downtown loft with an industrial design and great proximity to city attractions.', 1, 220, 1, 1, 2, 14),
-- Properties of Host 15 (Amelia Turner)
(16, 'Cozy Riverside Cabin', 'Cabin', 'A cozy cabin by the riverside. Ideal for a romantic getaway.', 1, 170, 0, 0, 2, 15),
-- Properties of Host 16 (Eli Scott)
(17, 'Luxurious City Penthouse', 'Penthouse', 'A luxurious penthouse in the city with top-of-the-line amenities and services.', 4, 450.55, 1, 1, 8, 16),
-- Properties of Host 17 (Zoey Harris)
(18, 'Artistic Urban Townhouse', 'Townhouse', 'An artistic townhouse in a trendy urban neighborhood. Great for art lovers.', 2, 190.49, 1, 1, 4, 17),
-- Properties of Host 18 (Aiden Martin)
(19, 'Hillside Villa', 'Villa', 'A hillside villa with a private setting and breathtaking hill views.', 3, 320, 1, 1, 6, 18),
-- Properties of Host 19 (Jack Lopez)
(20, 'Secluded Forest Cabin', 'Cabin', 'A secluded cabin in the forest. Enjoy nature and solitude.', 1, 200, 1, 1, 2, 19),
-- Properties of Host 20 (Ava Young)
(21, 'Modern Urban Condo', 'Condo', 'A modern condo in the heart of the city with access to shopping and dining.', 4, 275.95, 1, 1, 8, 20);



-- Dummy data of Address table
INSERT INTO `myAirbnb`.`Address` VALUES
-- Address for Property 1
(1,'United States','US','Albuquerque','87105', 'Homewood Street','10', 1),
-- Address for Property 2
(2,'United States','US','Philadelphia','19191','Ryan Crossing','2E', 2),
-- Address for Property 3
(3,'Canada','CA','Sainte-Adèle','J8B','Nova Pass','55', 3),
-- Address for Property 4
(4,'United States','US','Memphis','38126','87 Grover Road','151', 4),
-- Address for Property 5
(5,'United States','US','Seattle','98148','21 Little Fleur Way','781', 5),
-- Address for Property 6
(6,'Canada','CA','La Ronge','J9P','Dottie Road','3A', 6),
-- Address for Property 7
(7,'Canada','CA','Antigonish','B2G','1 Monterey Alley','55R', 7),
-- Address for Property 8
(8,'United Kingdom','GB','Seaton','LE15','76 Springview Park','9B', 8),
-- Address for Property 9
(9,'United Kingdom','GB','Marston','ST20','60 Memorial Park','32a', 9),
-- Address for Property 10
(10,'Singapore','SG','Singapore','569933','Clemons Drive','7H', 10),
-- Address for Property 11
(11,'Australia','AU','Strawberry Hills','1424','Monica Crossing','63F', 11),
-- Address for Property 12
(12,'United States','US','Dayton','45440','Green Ridge Road','37', 12),
-- Address for Property 13
(13,'United States','US','Decatur','30089','Superior Alley','363', 13),
-- Address for Property 14
(14,'United States','US','Waco','76711','48 Elgar Plaza','28B', 14),
-- Address for Property 15
(15,'United States','US','Hyattsville','20784','Menomonie Circle','62C', 15),
-- Address for Property 16
(16,'United States','US','Dulles','20189','4 Lakewood Drive','74M', 16),
-- Address for Property 17
(17,'United States','US','Reading','19610','Iowa Drive','92Z', 17),
-- Address for Property 18
(18,'United States','US','Brooklyn','11215','Vernon Crossing','147', 18),
-- Address for Property 19
(19,'United States','US','Washington','20220','Memorial Way', NULL, 19),
-- Address for Property 20
(20,'United States','US','Greensboro','27409','1 Ryan Avenue','773', 20),
-- Address for Property 21
(21,'Netherlands','NL','Hoorn','1624','Harbort Junction','6D', 21);



-- Dummy data of Property_Image table
INSERT INTO `myAirbnb`.`Property_Image` VALUES
-- Property Images of Property 1
(1, 'https://unsplash.com/photos/black-car-parked-beside-brown-concrete-building-during-daytime-EWVbiR5rQxE', 1),
(2, 'https://unsplash.com/photos/brown-wooden-bed-frame-with-white-and-brown-bed-linen-umAXneH4GhA', 1),
-- Property Images of Property 2
(3, 'https://unsplash.com/photos/interior-of-a-living-room-XyGvEj587Mc', 2),
(4, 'https://unsplash.com/photos/photo-of-living-room-U-k6XLlml1I', 2),
-- Property Images of Property 3
(5, 'https://unsplash.com/photos/grey-and-brown-wooden-house-during-daytime-qPmKTfyVOBs', 3),
-- Property Images of Property 4
(6, 'https://unsplash.com/photos/a-house-with-a-large-front-yard-at-night-sB9HTRDpzD8', 4),
(7, 'https://unsplash.com/photos/house-with-string-lights-lBKyRwWAiog', 4),
-- Property Images of Property 5
(8, 'https://unsplash.com/photos/white-bed-near-white-window-ABohRftG_Os', 5),
-- Property Images of Property 6
(9, 'https://unsplash.com/photos/brown-wooden-house-covered-with-snow-during-daytime-IPJh0QAvmcM', 6),
-- Property Images of Property 7
(10, 'https://unsplash.com/photos/white-modern-cement-building-under-blue-sky-RFDP7_80v5A', 7),
-- Property Images of Property 8
(11, 'https://unsplash.com/photos/a-brick-building-with-a-sign-on-it-1cTr9qQohgo', 8),
(12, 'https://unsplash.com/photos/a-cobblestone-street-lined-with-red-brick-buildings-INwqPPPdFuo', 8),
-- Property Images of Property 9
(13, 'https://unsplash.com/photos/water-poll-near-house-during-golden-hour-so3wgJLwDxo', 9),
-- Property Images of Property 10
(14, 'https://unsplash.com/photos/white-shed-near-sea-pfiRZTNZIy4', 10),
-- Property Images of Property 11
(15, 'https://unsplash.com/photos/a-city-street-at-night-with-cars-parked-on-the-side-of-the-road-EaNJ_hAOxnM', 11),
-- Property Images of Property 12
(16, 'https://unsplash.com/photos/house-near-trees-f_35Q1DMSlM', 12),
-- Property Images of Property 13
(17, 'https://unsplash.com/photos/a-tall-building-sitting-next-to-a-tree-uxNJklaRIOI', 13),
-- Property Images of Property 14
(18, 'https://unsplash.com/photos/white-and-gray-painted-wooden-house-YG2MysGbT_M', 14),
-- Property Images of Property 15
(19, 'https://unsplash.com/photos/brown-wooden-table-near-green-potted-plant-x6vyL4YKP9c', 15),
-- Property Images of Property 16
(20, 'https://unsplash.com/photos/wooden-house-with-hammock-attached-on-tree-BeHRkALwXIw', 16),
-- Property Images of Property 17
(21, 'https://unsplash.com/photos/beige-couch-and-armchair-tHkJAMcO3QE', 17),
-- Property Images of Property 18
(22, 'https://unsplash.com/photos/green-potted-plant-near-bed-5AwCzQganE8', 18),
-- Property Images of Property 19
(23, 'https://unsplash.com/photos/a-large-building-sitting-on-top-of-a-lush-green-hillside-zxztWY2Qq-4', 19),
-- Property Images of Property 20
(24, 'https://unsplash.com/photos/brown-wooden-house-surrounded-by-green-trees-during-daytime-6kVGxIHriTA', 20),
-- Property Images of Property 21
(25, 'https://unsplash.com/photos/a-tall-brick-building-sitting-next-to-a-tree-uxNJklaRIOI', 21);



-- Dummy data of Rules table
INSERT INTO `myAirbnb`.`Rules` VALUES
(1, 'No smoking allowed'),
(2, 'Pets are allowed'),
(3, 'No parties or events allowed'),
(4, 'No smoking possible'),
(5, 'No pets allowed'),
(6, 'Smoking is allowed on the balcony.'),
(7, 'Smoking is allowed only in the garden'),
(8, 'Quiet hours from 10:00 PM to 7:00 AM.'),
(9, 'Guests must remove shoes upon entering.'),
(10, 'All guests must provide valid identification upon check-in.'),
(11, 'Guests are responsible for any damages to the property.'),
(12, 'Guests must dispose of trash in designated bins.'),
(13, 'Guests should follow recycling guidelines.'),
(14, 'No unauthorized guests allowed on the property.'),
(15, 'Please conserve energy by turning off lights and appliances when not in use.'),
(16, 'Do not rearrange or move furniture without host permission.'),
(17, 'Strictly adhere to the designated parking spaces.'),
(18, 'Fireworks and open flames are not permitted on the property.'),
(19, 'No commercial photography or filming.'),
(20, 'Guests are allowed to use bicycles from the parking area of the property.');



-- Dummy data of Property_Rules table
INSERT INTO `myAirbnb`.`Property_Rules` VALUES
-- Property Rules for Property 1
(1, 1, 1), (2, 1, 11), (3, 1, 16), (4, 1, 17),
-- Property Rules for Property 2
(5, 2, 2), (6, 2, 9), (7, 2, 11), (8, 2, 16),
-- Property Rules for Property 3
(9, 3, 3), (10, 3, 11), (11, 3, 12), (12, 3, 13), (13, 3, 16), (14, 3, 17), (15, 3, 18),
-- Property Rules for Property 4
(16, 4, 4), (17, 4, 11), (18, 4, 16),
-- Property Rules for Property 5
(19, 5, 5), (20, 5, 9), (21, 5, 11), (22, 5, 16),
-- Property Rules for Property 6
(23, 6, 2), (24, 6, 11), (25, 6, 15), (26, 6, 17), (27, 6, 19),
-- Property Rules for Property 7
(28, 7, 1), (29, 7, 9), (30, 7, 11), (31, 7, 12), (32, 7, 16),
-- Property Rules for Property 8
(33, 8, 2), (34, 8, 8), (35, 8, 9), (36, 8, 10), (37, 8, 11), (38, 8, 14), (39, 8, 17), (40, 8, 19),
-- Property Rules for Property 9
(41, 9, 3), (42, 9, 11), (43, 9, 12), (44, 9, 16), (45, 9, 18),
-- Property Rules for Property 10
(46, 10, 1), (47, 10, 11), (48, 10, 12), (49, 10, 16),
-- Property Rules for Property 11
(50, 11, 2), (51, 11, 11), (52, 11, 16), (53, 11, 20),
-- Property Rules for Property 12
(54, 12, 6), (55, 12, 8), (56, 12, 11), (57, 12, 16), (58, 12, 19),
-- Property Rules for Property 13
(59, 13, 5), (60, 13, 11), (61, 13, 16), (62, 13, 17),
-- Property Rules for Property 14
(63, 14, 1), (64, 14, 11), (65, 14, 12), (66, 14, 13), (67, 14, 16), (68, 14, 20),
-- Property Rules for Property 15
(69, 15, 2), (70, 15, 11), (71, 15, 16),
-- Property Rules for Property 16
(72, 16, 1), (73, 16, 11), (74, 16, 16),
-- Property Rules for Property 17
(75, 17, 5), (76, 17, 9), (77, 17, 11), (78, 17, 16), (79, 17, 17), (80, 17, 20),
-- Property Rules for Property 18
(81, 18, 7), (82, 18, 11), (83, 18, 16),
-- Property Rules for Property 19
(84, 19, 2), (85, 19, 11), (86, 19, 12), (87, 19, 16),
-- Property Rules for Property 20
(88, 20, 1), (89, 20, 11), (90, 20, 13), (91, 20, 15), (92, 20, 16),
-- Property Rules for Property 21
(93, 21, 2), (94, 21, 11), (95, 21, 16);



-- Dummy data of Available_Periods table
INSERT INTO `myAirbnb`.`Available_Periods` VALUES
-- Availability Periods for Property 1
(1, '2023-09-26 00:00:00', '2023-10-10 23:59:59', 1, 1),
(2, '2023-10-20 00:00:00', '2023-10-31 23:59:59', 1, 1),
-- Availability Period for Property 2
(3, '2023-09-26 00:00:00', '2023-10-25 12:00:00', 1, 2),
-- Availability Period for Property 3
(4, '2023-09-26 00:00:00', '2023-10-30 23:59:59', 0, 3),
-- Availability Periods for Property 4
(5, '2023-09-26 00:00:00', '2023-10-10 23:59:59', 0, 4),
(6, '2023-10-20 00:00:00', '2023-10-31 23:59:59', 0, 4),
-- Availability Period for Property 5
(7, '2023-09-26 00:00:00', '2023-10-21 23:59:59', 1, 5),
-- Availability Period for Property 6
(8, '2023-09-26 00:00:00', '2023-10-15 23:59:59', 0, 6),
-- Availability Periods for Property 7
(9, '2023-09-26 00:00:00', '2023-10-10 23:59:59', 1, 7),
(10, '2023-10-20 00:00:00', '2023-10-31 23:59:59', 1, 7),
-- Availability Periods for Property 8
(11, '2023-09-26 00:00:00', '2023-10-10 23:59:59', 1, 8),
(12, '2023-10-21 00:00:00', '2023-10-30 23:59:59', 1, 8),
-- Availability Period for Property 9
(13, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 9),
-- Availability Period for Property 10
(14, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 10),
-- Availability Period for Property 11
(15, '2023-09-26 00:00:00', '2023-10-25 12:59:59', 1, 11),
-- Availability Period for Property 12
(16, '2023-09-26 00:00:00', '2023-10-23 18:30:00', 1, 12),
-- Availability Period for Property 13
(17, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 13),
-- Availability Period for Property 14
(18, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 1, 14),
-- Availability Period for Property 15
(19, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 1, 15),
-- Availability Period for Property 16
(20, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 16),
-- Availability Period for Property 17
(21, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 1, 17),
-- Availability Period for Property 18
(22, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 18),
-- Availability Period for Property 19
(23, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 1, 19),
-- Availability Period for Property 20
(24, '2023-09-26 00:00:00', '2023-10-26 22:45:00', 0, 20),
-- Availability Period for Property 21
(25, '2023-09-26 00:00:00', '2023-10-31 23:59:59', 0, 21);



-- Dummy data of Facility table
INSERT INTO `myAirbnb`.`Facility` VALUES
(1, 'Wi-Fi', 2),
(2, 'Large Windows', 3),
(3, 'Parking Space', 1),
(4, 'Air Conditioning', 3),
(5, 'Oven', 1),
(6, 'Gym', 1),
(7, 'Hot Tub', 2),
(8, 'TV', 1),
(9, 'Balcony', 3),
(10, 'Washer/Dryer', 3),
(11, 'Pet-Friendly space', 1),
(12, 'Fireplace', 2),
(13, 'Breakfast', 1),
(14, 'Garden', 1),
(15, 'Game Room', 1),
(16, 'BBQ Area', 1),
(17, 'Meeting Room', 1),
(18, 'Bicycle Rental', 2),
(19, 'Spa', 1),
(20, 'Ferry', 2);



-- Dummy data of Property_Facility table
INSERT INTO `myAirbnb`.`Property_Facility` VALUES
-- Property 1 Facilities
(1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), (5, 1, 5),
-- Property 2 Facilities
(6, 2, 6), (7, 2, 7), (8, 2, 8), (9, 2, 9), (10, 2, 10),
-- Property 3 Facilities
(11, 3, 1), (12, 3, 3), (13, 3, 5), (14, 3, 11), (15, 3, 12),
-- Property 4 Facilities
(16, 4, 4), (17, 4, 5), (18, 4, 7), (19, 4, 8), (20, 4, 12),
-- Property 5 Facilities
(21, 5, 1), (22, 5, 9), (23, 5, 10), (24, 5, 12), (25, 5, 13),
-- Property 6 Facilities
(26, 6, 1), (27, 6, 2), (28, 6, 3), (29, 6, 4), (30, 6, 5),
-- Property 7 Facilities
(31, 7, 6), (32, 7, 7), (33, 7, 8), (34, 7, 9), (35, 7, 10),
-- Property 8 Facilities
(36, 8, 1), (37, 8, 2), (38, 8, 3), (39, 8, 4), (40, 8, 5),
-- Property 9 Facilities
(41, 9, 1), (42, 9, 7), (43, 9, 8), (44, 9, 9), (45, 9, 10),
-- Property 10 Facilities
(46, 10, 11), (47, 10, 12), (48, 10, 13), (49, 10, 14), (50, 10, 15),
-- Property 11 Facilities
(51, 11, 1), (52, 11, 16), (53, 11, 17), (54, 11, 18), (55, 11, 19),
-- Property 12 Facilities
(56, 12, 2), (57, 12, 7), (58, 12, 20),
-- Property 13 Facilities
(59, 13, 3), (60, 13, 6), (61, 13, 8), (62, 13, 12), (63, 13, 15),
-- Property 14 Facilities
(64, 14, 4), (65, 14, 9), (66, 14, 14), (67, 14, 18), (68, 14, 20),
-- Property 15 Facilities
(69, 15, 5), (70, 15, 10), (71, 15, 11), (72, 15, 16), (73, 15, 19),
-- Property 16 Facilities
(74, 16, 2), (75, 16, 7), (76, 16, 13),
-- Property 17 Facilities
(77, 17, 1), (78, 17, 3), (79, 17, 9), (80, 17, 12), (81, 17, 18),
-- Property 18 Facilities
(82, 18, 5), (83, 18, 6), (84, 18, 8), (85, 18, 15),
-- Property 19 Facilities
(86, 19, 10), (87, 19, 12), (88, 19, 14), (89, 19, 20),
-- Property 20 Facilities
(90, 20, 1), (91, 20, 4), (92, 20, 8), (93, 20, 13),
-- Property 21 Facilities
(94, 21, 2), (95, 21, 6), (96, 21, 11), (97, 21, 16), (98, 21, 17);



-- Dummy data of Booking table
INSERT INTO `myAirbnb`.`Booking` VALUES
-- Made a Booking by Guest 5 (Newton Whorall) for Property 1
(1, '2023-09-28 08:00:00', '2023-10-08 08:00:00', 2, 1100, '2023-09-21 08:00:00', 'Approved', 1, 5), 
-- Made a Booking by Guest 1 (Pen Coy) for Property 2
(2, '2023-10-21 06:00:00', '2023-10-31 06:00:00', 1, 2752.75, '2023-10-15 00:00:00', 'Approved', 2, 1),
-- Made a Booking by Guest 8 (Georgie Ivanishev) for Property 3
(3, '2023-09-26 14:10:00', '2023-09-28 14:10:00', 5, 771.65, '2023-09-20 17:15:00', 'Approved', 3, 8),
-- Made a Booking by Guest 2 (Zea Drei) for Property 4
(4, '2023-09-27 04:00:00', '2023-10-06 04:00:00', 3, 1485, '2023-09-22 22:20:00', 'Approved', 4, 2),
-- Made a Booking by Guest 6 (Omar Klima) for Property 4
(5, '2023-10-22 11:45:00', '2023-10-25 11:45:00', 4, 495, '2023-10-17 09:30:00', 'Approved', 4, 6),
-- Made a Booking by Guest 10 (Dallas Hayes) for Property 5
(6, '2023-09-29 23:30:00', '2023-10-13 23:30:00', 2, 1861.71, '2023-09-23 11:23:00', 'Approved', 5, 10),
-- Made a Booking by Guest 19 (Lucas King) for Property 6
(7, '2023-09-28 04:15:00', '2023-10-09 04:15:00', 3, 2178, '2023-09-24 13:05:00', 'Approved', 6, 19),
-- Made a Booking by Guest 15 (Henry Cooper) for Property 7
(8, '2023-10-03 13:20:00', '2023-10-19 13:20:00', 5, 5280, '2023-09-28 02:45:00', 'Approved', 7, 15),
-- Made a Booking by Guest 4 (Saunders Anlay) for Property 8
(9, '2023-09-27 10:25:00', '2023-10-07 10:25:00', 6, 2207.67, '2023-09-19 20:35:00', 'Approved', 8, 4),
-- Made a Booking by Guest 8 (Georgie Ivanishev) for Property 8
(10, '2023-10-23 16:30:00', '2023-10-28 16:30:00', 4, 1103.69, '2023-10-14 17:25:00', 'Approved', 8, 8),
-- Made a Booking by Guest 9 (Ker Cunde) for Property 9
(11, '2023-10-12 02:45:00', '2023-10-22 02:45:00', 10, 4400, '2023-10-05 10:11:00', 'Approved', 9, 9),
-- Made a Booking by Guest 10 (Dallas Hayes) for Property 10
(12, '2023-10-15 17:50:00', '2023-10-21 17:50:00', 1, 864.53, '2023-10-13 07:07:00', 'Approved', 10, 10),
-- Made a Booking by Guest 16 (Grace Perez) for Property 11
(13, '2023-09-26 12:00:00', '2023-10-01 12:00:00', 1, 1434.29, '2023-09-18 09:00:00', 'Approved', 11, 16),
-- Made a Booking by Guest 7 (Babita Fewtrell) for Property 12
(14, '2023-09-29 05:30:00', '2023-10-19 05:30:00', 3, 3080, '2023-09-25 21:40:00', 'Approved', 12, 7),
-- Made a Booking by Guest 18 (Sofia Rodriguez) for Property 13
(15, '2023-09-30 20:35:00', '2023-10-10 20:35:00', 6, 3410, '2023-09-24 12:17:00', 'Approved', 13, 18),
-- Made a Booking by Guest 13 (Hazel Mitchell) for Property 14
(16, '2023-10-27 15:00:00', '2023-10-30 15:00:00', 5, 924, '2023-10-16 03:50:00', 'Approved', 14, 13),
-- Made a Booking by Guest 20 (Harper Ward) for Property 15
(17, '2023-10-02 22:10:00', '2023-10-08 22:10:00', 2, 1452, '2023-09-27 05:55:00', 'Approved', 15, 20),
-- Made a Booking by Guest 3 (Elias Harg) for Property 16
(18, '2023-09-27 21:30:00', '2023-10-02 21:30:00', 2, 935, '2023-09-22 14:38:00', 'Approved', 16, 3),
-- Made a Booking by Guest 17 (Mason Gonzalez) for Property 17
(19, '2023-10-15 03:15:00', '2023-10-19 03:15:00', 7, 1982.42, '2023-10-07 23:42:00', 'Approved', 17, 17),
-- Made a Booking by Guest 11 (Eugene Blackburn) for Property 18
(20, '2023-10-20 14:20:00', '2023-10-26 14:20:00', 4, 1257.23, '2023-10-10 18:33:00', 'Approved', 18, 11),
-- Made a Booking by Guest 12 (Sebastian Richards) for Property 19
(21, '2023-10-03 11:50:00', '2023-10-10 11:50:00', 6, 2464, '2023-09-29 22:45:00', 'Approved', 19, 12),
-- Made a Booking by Guest 2 (Zea Drei) for Property 20
(22, '2023-10-10 10:25:00', '2023-10-18 10:25:00', 1, 1760, '2023-10-01 10:09:00', 'Approved', 20, 2),
-- Made a Booking by Guest 5 (Newton Whorall) for Property 20
(23, '2023-10-23 01:45:00', '2023-10-27 01:45:00', 3, 880, '2023-10-22 02:08:00', 'Rejected', 20, 5),
-- Made a Booking by Guest 14 (Charlotte Williams) for Property 21
(24, '2023-09-30 23:10:00', '2023-10-12 23:10:00', 8, 3642.54, '2023-09-21 04:25:00', 'Approved', 21, 14),
-- Made a Booking by Guest 8 (Georgie Ivanishev) for Property 21
(25, '2023-10-15 07:30:00', '2023-10-19 07:30:00', 6, 1214.18, '2023-10-13 12:55:00', 'Approved', 21, 8),
-- Made a Booking by Guest 2 (Zea Drei) for Property 21
(26, '2023-10-24 15:20:00', '2023-10-29 15:20:00', 7, 1517.71, '2023-10-22 17:05:00', 'Reviewing', 21, 2);



-- Dummy data of Payment table
INSERT INTO `myAirbnb`.`Payment` VALUES
-- Payment made to HostID 1 (Cosme Norwood) for Booking ID 1
(1, 'USD', 1000, '2023-09-29 08:00:00', 'Success', 1, 1, 1),
-- Payment made to HostID 1 (Cosme Norwood) for Booking ID 2
(2, 'USD', 2502.5, '2023-10-22 06:00:00', 'Success', 2, 2, 1),
-- Payment made to HostID 2 (Curry Pollins) for Booking ID 3
(3, 'CAD', 701.5, '2023-09-27 14:10:00', 'Success', 3, 3, 2),
-- Payment made to HostID 3 (Annalise Krzysztof) for Booking ID 4
(4, 'USD', 1350, '2023-09-28 04:00:00', 'Success', 4, 4, 3),
-- Payment made to HostID 3 (Annalise Krzysztof) for Booking ID 5
(5, 'USD', 450, '2023-10-23 11:45:00', 'Success', 5, 4, 3),
-- Payment made to HostID 4 (Cointon Lightwing) for Booking ID 6
(6, 'USD', 1692.46, '2023-09-30 23:30:00', 'Success', 6, 5, 4),
-- Payment made to HostID 5 (Berenice Aicken) for Booking ID 7
(7, 'USD', 1980, '2023-09-29 04:15:00', 'Success', 7, 6, 5),
-- Payment made to HostID 6 (Alasdair De Domenico) for Booking ID 8
(8, 'CAD', 4800, '2023-10-04 13:20:00', 'Success', 8, 7, 6),
-- Payment made to HostID 7 (Camala Solleme) for Booking ID 9
(9, 'GBP', 2006.7, '2023-09-28 10:25:00', 'Success', 9, 8, 7),
-- Payment made to HostID 7 (Camala Solleme) for Booking ID 10
(10, 'GBP', 1003.35, '2023-10-24 16:30:00', 'Success', 10, 8, 7),
-- Payment made to HostID 8 (Stephana Lestrange) for Booking ID 11
(11, 'GBP', 4000, '2023-10-11 02:45:00', 'Success', 11, 9, 8),
-- Payment made to HostID 9 (Evonne Duthie) for Booking ID 12
(12, 'SGD', 785.94, '2023-10-16 17:50:00', 'Success', 12, 10, 9),
-- Payment made to HostID 10 (Benedikta McMearty) for Booking ID 13
(13, 'AUD', 1303.9, '2023-09-27 12:00:00', 'Success', 13, 11, 10),
-- Payment made to HostID 11 (Lily Wright) for Booking ID 14
(14, 'USD', 2800, '2023-09-30 05:30:00', 'Success', 14, 12, 11),
-- Payment made to HostID 12 (Scarlett Carter) for Booking ID 15
(15, 'USD', 3100, '2023-10-01 20:35:00', 'Success', 15, 13, 12),
-- Payment made to HostID 13 (Isaac Alexander) for Booking ID 16
(16, 'USD', 840, '2023-10-28 15:00:00', 'Success', 16, 14, 13),
-- Payment made to HostID 14 (Oliver Baker) for Booking ID 17
(17, 'USD', 1320, '2023-10-03 22:10:00', 'Success', 17, 15, 14),
-- Payment made to HostID 15 (Amelia Turner) for Booking ID 18
(18, 'USD', 850, '2023-09-28 21:30:00', 'Success', 18, 16, 15),
-- Payment made to HostID 16 (Eli Scott) for Booking ID 19
(19, 'USD', 1802.2, '2023-10-16 03:15:00', 'Success', 19, 17, 16),
-- Payment made to HostID 17 (Zoey Harris) for Booking ID 20
(20, 'USD', 1142.94, '2023-10-21 14:20:00', 'Success', 20, 18, 17),
-- Payment made to HostID 18 (Aiden Martin) for Booking ID 21
(21, 'USD', 2240, '2023-10-04 11:50:00', 'Success', 21, 19, 18),
-- Payment made to HostID 19 (Jack Lopez) for Booking ID 22
(22, 'USD', 1600, '2023-10-11 10:25:00', 'Success', 22, 20, 19),
-- Payment made to HostID 20 (Ava Young) for Booking ID 24
(23, 'EUR', 3311.4, '2023-10-01 23:10:00', 'Success', 24, 21, 20),
-- Payment made to HostID 20 (Ava Young) for Booking ID 25
(24, 'EUR', 1379.75, '2023-10-16 07:30:00', 'Failed', 25, 21, 20);



-- Dummy data of Property_Review table
INSERT INTO `myAirbnb`.`Property_Review` VALUES
-- Reviews for Property 1 by Guest 5 (Newton Whorall)
(1, 5, 'The apartment was lovely and very clean. Great location!', '2023-10-09 08:00:00', 5, 1),
-- Reviews for Property 2 by Guest 1 (Pen Coy)
(2, 5, 'Luxurious loft with a stunning view. Highly recommended!', '2023-10-31 09:00:00', 1, 2),
-- Reviews for Property 3 by Guest 8 (Georgie Ivanishev)
(3, 5, 'Amazing beach house with a private pool. Great for families.', '2023-09-30 15:20:00', 8, 3),
-- Reviews for Property 4 by Guest 2 (Zea Drei)
(4, 4, 'Charming countryside cottage. Peaceful and relaxing.', '2023-10-07 04:00:00', 2, 4),
-- Reviews for Property 4 by Guest 6 (Omar Klima)
(5, 5, 'Ideal for nature lovers. Would visit again.', '2023-10-25 11:45:00', 6, 4),
-- Reviews for Property 5 by Guest 10 (Dallas Hayes)
(6, 4, 'Great studio apartment in the city. Good value.', '2023-10-14 23:30:00', 10, 5),
-- Reviews for Property 6 by Guest 19 (Lucas King)
(7, 5, 'Rustic cabin in the mountains. Perfect for a retreat.', '2023-10-10 04:15:00', 19, 6),
-- Reviews for Property 7 by Guest 15 (Henry Cooper)
(8, 4, 'Stunning city panorama. Comfortable and luxurious.', '2023-10-20 13:20:00', 15, 7),
-- Reviews for Property 8 by Guest 4 (Saunders Anlay)
(9, 5, 'Historic townhouse with character. Great location!', '2023-10-08 10:25:00', 4, 8),
-- Reviews for Property 8 by Guest 8 (Georgie Ivanishev)
(10, 4, 'Enjoyed the charm and history of the townhouse.', '2023-10-07 12:25:00', 8, 8),
-- Reviews for Property 9 by Guest 9 (Ker Cunde)
(11, 5, 'Elegant villa with a beautiful pool and gardens.', '2023-10-23 02:45:00', 9, 9),
-- Reviews for Property 10 by Guest 10 (Dallas Hayes)
(12, 5, 'Cozy seaside bungalow with beach access. Lovely stay.', '2023-10-22 17:50:00', 10, 10),
-- Reviews for Property 11 by Guest 16 (Grace Perez)
(13, 5, 'Stylish condo in the city. Loved the views!', '2023-10-02 12:00:00', 16, 11),
-- Reviews for Property 12 by Guest 7 (Babita Fewtrell)
(14, 5, 'Quaint historic cottage with a beautiful garden.', '2023-10-20 05:30:00', 7, 12),
-- Reviews for Property 13 by Guest 18 (Sofia Rodriguez)
(15, 5, 'Modern apartment with a great city view. Excellent stay.', '2023-10-11 20:35:00', 18, 13),
-- Reviews for Property 14 by Guest 13 (Hazel Mitchell)
(16, 5, 'Sunny beachfront retreat. Great for beach lovers.', '2023-10-31 15:00:00', 13, 14),
-- Reviews for Property 15 by Guest 20 (Harper Ward)
(17, 5, 'Downtown loft with industrial flair. Unique and stylish.', '2023-10-09 22:10:00', 20, 15),
-- Reviews for Property 16 by Guest 3 (Elias Harg)
(18, 5, 'Cozy riverside cabin. Perfect for a romantic getaway.', '2023-10-03 21:30:00', 3, 16),
-- Reviews for Property 17 by Guest 17 (Mason Gonzalez)
(19, 5, 'Luxurious city penthouse with top-of-the-line amenities.', '2023-10-20 03:15:00', 17, 17),
-- Reviews for Property 18 by Guest 11 (Eugene Blackburn)
(20, 5, 'Artistic urban townhouse in a trendy neighborhood.', '2023-10-27 14:20:00', 11, 18),
-- Reviews for Property 19 by Guest 12 (Sebastian Richards)
(21, 5, 'Hillside villa with breathtaking hill views.', '2023-10-11 11:50:00', 12, 19),
-- Reviews for Property 20 by Guest 2 (Zea Drei)
(22, 5, 'Secluded forest cabin. A nature lover''s dream.', '2023-10-19 10:25:00', 2, 20),
-- Reviews for Property 21 by Guest 14 (Charlotte Williams)
(23, 4, 'Convenient and modern. Great city experience.', '2023-10-13 23:10:00', 14, 21);