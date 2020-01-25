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



INSERT INTO LearningCenter (LCname, Description,Email,PhoneNo) VALUES ("Abdo's lc under her boat","Not an ugly place actually nice","myhat@yourhat.com","1234532");
INSERT INTO Address (Street, BuildingNo,FloorNo,City,Area,LCID) VALUES ("MOHAMMED","7","6","cAIRO","New Cairo",1);

INSERT INTO Address(BuildingNo, Street, Area, City, LCID)
VALUES 
( "8", 
  "Street 9",
  "Maadi",
  "Cairo",
  1
),
( "22", 
  "Street 90",
  "5th Settlement",
  "Cairo"
  2
),
( "32", 
  "Khalifa ElMamoun",
  "Nasr City",
  "Cairo"
  3
),
( "4", 
  "Haram Street",
  "Haram",
  "Giza",
  4
);