SELECT * FROM Address WHERE LCID=1;


SELECT C.CID, C.CourseName, C.CourseImage, C.CatName, C.Price, C.LCID, C.LCname
FROM CourseLearningCenter C, UserCategory UC 
WHERE C.CatName = UC.CatName
AND UC.UID=37
ORDER BY RAND()
LIMIT 5;
