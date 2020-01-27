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

CREATE TABLE UserCourseExtraInfo(
     UID int NOT NULL,
    CID int NOT NULL,
    KLevel varchar(255),
    Area  varchar(255),
    City varchar(255),
    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CID) REFERENCES Course(CID),
    PRIMARY KEY(UID,CID)
);

CREATE TABLE LearningCenter (
    LCID int NOT NULL AUTO_INCREMENT,
    LCname varchar(255) NOT NULL,
    Logo VARCHAR(255),
    Description TEXT,
    Email varchar(255) UNIQUE,
    PhoneNo VARCHAR(255),
    CatName VARCHAR(255),
    FOREIGN KEY (CatName) REFERENCES Category(CatName),
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
    CatImage varchar(255),
    PRIMARY KEY (CatName)
);

CREATE TABLE Course (
    CID int NOT NULL AUTO_INCREMENT,
    CourseName varchar(255) NOT NULL,
    CourseImage varchar(255),
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
    StartTime VARCHAR(255),
    EndTime VARCHAR(255),
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



CREATE TABLE UserEnrollsCourse (
    UID int NOT NULL,
    CID int NOT NULL,
    Enrolls int DEFAULT 0,

    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CID) REFERENCES Course(CID),
    PRIMARY KEY(UID,CID)

);
CREATE TABLE UserEnrollsCourse (
    UID int NOT NULL,
    CID int NOT NULL,
    Likes int DEFAULT 0,

    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CID) REFERENCES Course(CID),
    PRIMARY KEY(UID,CID)

);

CREATE TABLE UserCategory(
    UID int NOT NULL,
    CatName varchar(255) NOT NULL,

    FOREIGN KEY (UID) REFERENCES user(UID),
    FOREIGN KEY (CatName) REFERENCES Category(CatName),
    PRIMARY KEY(UID,CatName)

);

CREATE TABLE Instructor(
    INSTID int NOT NULL AUTO_INCREMENT,
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


CREATE VIEW CourseDuration(CourseName, CourseImage, Price, RegFees, StDate, EndDate, Description, Video, LCID, CatName, Duration)
AS 
    (SELECT CourseName, CourseImage, Price, RegFees, StDate, EndDate, Description, Video, LCID, CatName, DATEDIFF(day, StDate, EndDate)
    FROM Course );

CREATE VIEW CourseLearningCenter
(CID, CourseName, CourseImage, Price, RegFees, StDate, EndDate, Description, Video, LCID, CatName, LCname, LClogo ,PhoneNo, Email)
AS 
(SELECT CID, CourseName, CourseImage, Price, RegFees, StDate, EndDate, C.Description, Video, C.LCID, C.CatName, LCname, Logo, PhoneNo, Email
FROM Course C, LearningCenter LC
WHERE C.LCID = LC.LCID);


