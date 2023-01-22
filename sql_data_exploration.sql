-- 1.List all the students who are from Amherst, NY. 
SELECT * FROM STUDENT 
WHERE ZIP =( SELECT ZIP FROM ZIPCODE WHERE ZIPCODE.CITY LIKE ’Amherst’ AND ZIPCODE.STATE LIKE ‘NY’);
 -- OR
SELECT * FROM STUDENT  INNER JOIN ZIPCODE USING (ZIP)
WHERE ZIPCODE.CITY LIKE “AMHERST’
AND ZIPCODE.STATE LIKE ‘NY’;


-- 	2.List courses that are taught by Nina Schorin. 
SELECT COURSE_NO, DESCRIPTION 
FROM COURSE AS C WHERE C.COURSE_NO=
 ( SELECT COURSE_NO FROM SECTION AS S WHERE S.INSTRUCTOR_ID= 
( SELECT INSTRUCTOR_ID FROM INSTRUCTOR AS I WHERE I.FIRST_NAME LIKE ‘Nina’ and I.LAST_NAME LIKE ‘Schorin’ ) ) 
ORDER BY COURSE_NO; 

-- 3.Write a query to remove all students who has no enrollments 
DELETE FROM STUDENT WHERE STUDENT_ID NOT IN (SELECT DISTINCT STUDENT_ID FROM ENROLLMENT);

-- 4.Write a query to list results which is similar to output in the following result set. Note that the query is only for one student.This requires JOIN of 3 tables
SELECT ST.STUDENT_ID, ST.FIRST_NAME, ST.LAST_NAME, ST.PHONE, E.SECTION_ID, G.GRADE_TYPE_CODE, G.GRADE_CODE_OCCURRENCE, G.NUMERIC_GRADE 
FROM STUDENT AS ST INNER JOIN ENROLLMENT AS E USING (STUDENT_ID)
INNER JOIN GRADE AS G USING(STUDENT_ID, SECTION_ID)
WHERE ST.FIRST_NAME LIKE ‘JUDITH’;

-- 5.Provide a script for creation of the VIEW that will present the following information: 
-- Display student id, student name (use the format: <last name>, <first name> in a single column), course no, section id and instructor name (use the format: <last name>, <first name> in a single column). 
-- Sort the results by student id, course no and section id (226 records) 
-- VIEW Name: V_INSTRUCTORS_FOR_SECTION
CREATE VIEW V_INSTRUCTORS_FOR_ SECTION AS 
SELECT S.STUDENT_ID, CONCAT(S.LAST_NAME, ‘,’, S.FIRST_NAME) AS STUDENT_NAME, SE.COURSE_NO,SE.SECTION_ID, CONCAT(I.LAST_NAME, ‘,’, I.FIRST_NAME) AS INSTRUCTOR_NAME 
FROM STUDENT AS S INNER JOIN ENROLLMENT AS E USING (STUDENT_ID) 
INNER JOIN SECTION AS SE USING (SECTION_ID) 
INNER JOIN INSTRUCOTR AS I USING (INSTRUCTOR_ID)
ORDER BY S.STUDENT_ID, SE.COURSE_NO, SE.SECTION_ID







