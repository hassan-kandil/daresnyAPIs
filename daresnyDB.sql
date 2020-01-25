CREATE TABLE user (
    UID int NOT NULL AUTO_INCREMENT,
    Fname varchar(255) NOT NULL,
    Lname varchar(255),
    BDate DATE,
    Email varchar(255) UNIQUE NOT NULL,
    Pass VARCHAR(255),
    PhoneNo VARCHAR(255),
    isAdmin int DEFAULT 0,
    LCID int,
    PRIMARY KEY (UID)
);

CREATE TABLE LearningCenter (
    LCID int NOT NULL AUTO_INCREMENT,
    LCname varchar(255) NOT NULL,
    Logo int,
    Description TEXT,
    Email varchar(255) UNIQUE,
    PhoneNo VARCHAR(255),
    PRIMARY KEY (LCID)
);


CREATE TABLE Address (
    ADDID int NOT NULL AUTO_INCREMENT,
    Street varchar(255),
    BuildingNo varchar(255),
    FloorNo varchar(255),
    AptNo varchar(255),
    City varchar(255),
    Area varchar(255),
    Longtitude varchar(255),
    Latitude varchar(255),
    LCID int NOT NULL,
    PRIMARY KEY (ADDID)
);

CREATE TABLE Category (
    CatName varchar(255) NOT NULL,
    CatImage int,
    PRIMARY KEY (CatName)
);

CREATE TABLE Course (
    CID int NOT NULL AUTO_INCREMENT,
    CourseName varchar(255) NOT NULL,
    CourseImage int,
    Price DOUBLE(8,2),
    RegFees DOUBLE(8,2),
    StDate VARCHAR(255),
    EndDate VARCHAR(255),
    Description TEXT,
    Video VARCHAR(255),
    LCID int NOT NULL,
    CatName varchar(255),
    PRIMARY KEY (CID)
);


CREATE TABLE CourseSchedule(
    CID int NOT NULL,
    Day varchar(255) NOT NULL,
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (CID) REFERENCES Course(CID),
    PRIMARY KEY (CID,Day)
);


ALTER TABLE Address
ADD CONSTRAINT FK_LCID
FOREIGN KEY (LCID) REFERENCES LearningCenter(LCID);



ALTER TABLE Course
ADD CONSTRAINT FK_CatName
FOREIGN KEY (CatName) REFERENCES Category(CatName);


ALTER TABLE Course
ADD CONSTRAINT FK_LCID_Course
FOREIGN KEY (LCID) REFERENCES LearningCenter(LCID);

ALTER TABLE user
ADD CONSTRAINT FK_LCID_User
FOREIGN KEY (LCID) REFERENCES LearningCenter(LCID);



CREATE TABLE UserCourse (
    UID int NOT NULL,
    CatName varchar(255) NOT NULL,

    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CatName) REFERENCES Category(CatName),
    PRIMARY KEY(UID,CatName)

);

CREATE TABLE UserCategory(
    UID int NOT NULL,
    CatName varchar(255) NOT NULL,

    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CatName) REFERENCES Category(CatName),
    PRIMARY KEY(UID,CatName)

);

CREATE TABLE Instructor(
    INSTID int NOT NULL,
    Fname VARCHAR(255),
    Lname VARCHAR(255),
    Bio TEXT,
    PRIMARY KEY(INSTID)
);



CREATE TABLE CourseInstructor (
    CID int NOT NULL,
    INSTID int NOT NULL,

    FOREIGN KEY (CID) REFERENCES Course(CID),
    FOREIGN KEY (INSTID) REFERENCES Instructor(INSTID),
    PRIMARY KEY(CID,INSTID)

);



INSERT INTO category (CatName) VALUES ("Programming");
INSERT INTO category (CatName) VALUES ("Engineering");
INSERT INTO category (CatName) VALUES ("Language");
INSERT INTO category (CatName) VALUES ("Science");
INSERT INTO category (CatName) VALUES ("Programming");
INSERT INTO category (CatName) VALUES ("Business");
INSERT INTO category (CatName) VALUES ("Music");
INSERT INTO category (CatName) VALUES ("Graphic Design");
INSERT INTO category (CatName) VALUES ("Cooking");



INSERT INTO `learningcenter`(`LCname`, `Logo`, `Description`, `Email`, `PhoneNo`) 
VALUES ("ABC Center","abc-center.svg","ABC Center teaches graphic design courses.","abc-center@live.com","0122321332");

INSERT INTO `learningcenter`(`LCname`, `Logo`, `Description`, `Email`, `PhoneNo`) 
VALUES ("IDE Academy","ide-academy.png","IDE Academy teaches programming courses","ide-academy@gmail.com","0122329332");

INSERT INTO `learningcenter`(`LCname`, `Logo`, `Description`, `Email`, `PhoneNo`) 
VALUES ("Finoon","Finoon.png","Finoon teaches music courses.","finoon@live.com","0122327332");

INSERT INTO `learningcenter`(`LCname`, `Logo`, `Description`, `Email`, `PhoneNo`) 
VALUES ("English Training Center","ESL.png","ESL teaches english courses.","esl@live.com","0128989892");

INSERT INTO `course`(`CourseName`, `CourseImage`, `Price`, `RegFees`, `StDate`, `EndDate`, `Description`, `Video`, `LCID`, `CatName`) 
VALUES ("PhotoShop- Beginners Course- Basic Designs","adobephotoshop.jpg",2500,1000,'2020-02-11',"2020-03-11","This is a beginners photoshop course","video.avi",1,"Graphic Design");


INSERT INTO `course`(`CourseName`, `CourseImage`, `Price`, `RegFees`, `StDate`, `EndDate`, `Description`, `Video`, `LCID`, `CatName`) 
VALUES ("Frontend Development Course","frontend-development.png",3500,1500,'2020-03-11',"2020-05-11","This is a front end development course","video.avi",2,"Programming");


CREATE VIEW CourseDuration(CourseName, CourseImage, Price, RegFees, StDate, EndDate, Description, Video, LCID, CatName, Duration)
AS 
    (SELECT CourseName, CourseImage, Price, RegFees, StDate, EndDate, Description, Video, LCID, CatName, DATEDIFF(day, StDate, EndDate)
    FROM Course );

INSERT INTO LearningCenter (LCname, Description,Email,PhoneNo) VALUES ("Abdo's lc under her boat","Not an ugly place actually nice","myhat@yourhat.com","1234532");
INSERT INTO Address (Street, BuildingNo,FloorNo,City,Area,LCID) VALUES ("MOHAMMED","7","6","cAIRO","New Cairo",1);
