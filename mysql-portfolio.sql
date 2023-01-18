
CREATE TABLE portfolio_project.ZIPCODE
(
ZIP VARCHAR(5) NOT NULL PRIMARY KEY,
CITY VARCHAR(25) NULL,
STATE VARCHAR(2) NULL
);


CREATE TABLE portfolio_project.INSTRUCTOR
(
INSTRUCTOR_ID INT(8) NOT NULL,
SALUTATION VARCHAR(5) NULL CHECK ( SALUTATION IN ('Mr.', 'Ms.', 'Miss', 'Dr.', 'Hon', 'Rev')),
FIRST_NAME VARCHAR(25) NULL,
LAST_NAME VARCHAR(25) NULL,
STREET_ADDRESS VARCHAR(50) NULL,
PHONE VARCHAR(15) NULL UNIQUE,
PRIMARY KEY (INSTRUCTOR_ID),
ZIP VARCHAR(5) NOT NULL,
FOREIGN KEY(ZIP) REFERENCES ZIPCODE(ZIP)
);

CREATE TABLE portfolio_project.STUDENT
(
STUDENT_ID INT(8) NOT NULL PRIMARY KEY,
SALUTATION VARCHAR(5) NULL,
FIRST_NAME  VARCHAR(25) NULL,
LAST_NAME VARCHAR(25) NOT NULL,
STREET_ADDRESS VARCHAR(50) NULL,
ZIP VARCHAR(5) NOT NULL,
PHONE VARCHAR(15) NULL UNIQUE,
EMPLOYER VARCHAR(50) NULL,
REGISTRATION_DATE DATE NOT NULL,
FOREIGN KEY(ZIP) REFERENCES ZIPCODE(ZIP)
);


CREATE TABLE portfolio_project.COURSE
(
COURSE_NO INT(8) NOT NULL PRIMARY KEY,
DESCRIPTION VARCHAR(50) NOT NULL UNIQUE,
COST DECIMAL(9,2) NULL,
PREREQUISITE INT(8) NULL, 
FOREIGN KEY(PREREQUISITE) REFERENCES COURSE (COURSE_NO)
);


CREATE TABLE portfolio_project.SECTION
(
SECTION_ID INT(8) NOT NULL,
COURSE_NO INT(8) NOT NULL,
SECTION_NO INT(3) NOT NULL,
START_DATE_TIME DATETIME NULL,
LOCATION VARCHAR(50) NULL,
INSTRUCTOR_ID INT(8) NOT NULL,
CAPACITY INT(3) NULL,
PRIMARY KEY (SECTION_ID),
FOREIGN KEY (COURSE_NO) REFERENCES COURSE(COURSE_NO),
FOREIGN KEY (INSTRUCTOR_ID) REFERENCES INSTRUCTOR (INSTRUCTOR_ID)
);

CREATE TABLE portfolio_project.ENROLLMENT
(
STUDENT_ID INT(8) NOT NULL,
SECTION_ID INT(8) NOT NULL,
ENROLL_DATE DATE NOT NULL,
FINAL_GRADE INT(3) NULL,
PRIMARY KEY (STUDENT_ID, SECTION_ID),
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID)
);

CREATE TABLE portfolio_project.GRADE_TYPE
(
GRADE_TYPE_CODE CHAR(2) NOT NULL PRIMARY KEY CHECK (GRADE_TYPE_CODE =2 AND GRADE_TYPE_CODE IN (‘FI’, ‘HM’, ‘MT’, ‘PA’, ‘PJ’, ‘QZ’)),
DESCRIPTION VARCHAR(50) NOT NULL
);


CREATE TABLE portfolio_project.GRADE
(
STUDENT_ID INT(8) NOT NULL,
SECTION_ID INT(8) NOT NULL,
GRADE_TYPE_CODE CHAR(2) NOT NULL CHECK (GRADE_TYPE_CODE IN (‘FI’, ‘HM’, ‘MT’, ‘PA’, ‘PJ’, ‘QZ’)) ,
GRADE_CODE_OCCURRENCE INT(3) NOT NULL ,
NUMERIC_GRADE INT(3) NOT NULL,
COMMENTS VARCHAR(200) NULL,
PRIMARY KEY (STUDENT_ID, SECTION_ID, GRADE_TYPE_CODE, GRADE_CODE_OCCURRENCE),
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
FOREIGN KEY (GRADE_TYPE_CODE) REFERENCES GRADE_TYPE(GRADE_TYPE_CODE)
);

CREATE TABLE portfolio_project.GRADE_TYPE_WEIGHT
(
SECTION_ID INT(8) NOT NULL,
GRADE_TYPE_CODE CHAR(2) NOT NULL,
NUMBER_PER_SECTION INT(3) NOT NULL,
PERCENT_OF_FINAL_GRADE INT(3) NOT NULL,
DROP_LOWEST CHAR(1) NOT NULL CHECK (DROP_LOWEST IN (‘Y’, ‘N’)),
PRIMARY KEY (SECTION_ID,GRADE_TYPE_CODE),
FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
FOREIGN KEY (GRADE_TYPE_CODE) REFERENCES GRADE_TYPE(GRADE_TYPE_CODE)
);

CREATE TABLE portfolio_project.GRADE_CONVERSION
(
LETTER_GRADE CHAR(2) NOT NULL PRIMARY KEY,
GRADE_POINT DECIMAL(3,2) NOT NULL, 
MAX_GRADE INT(3) NOT NULL,
MIN_GRADE INT(3) NOT NULL
);





