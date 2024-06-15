CREATE TABLE Student (
    ID_Student VARCHAR(50) NOT NULL,
    Student_Name VARCHAR(150) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Address VARCHAR(150) NOT NULL,
    ID_Card VARCHAR(15) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
	CONSTRAINT pk_Student PRIMARY KEY (ID_Student)
);

CREATE TABLE Teacher (
    ID_Teacher VARCHAR(50) NOT NULL,
    Teacher_Name VARCHAR(150) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Address VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    Major VARCHAR(100) NOT NULL
	CONSTRAINT pk_Teacher PRIMARY KEY (ID_Teacher)
);

CREATE TABLE Subject (
    Subject_Code VARCHAR(50) NOT NULL,
    Subject_Name VARCHAR(150) NOT NULL,
    Term_No INT NOT NULL,
	CONSTRAINT pk_Subject PRIMARY KEY (Subject_Code)
);

CREATE TABLE Category_Test (
    Category VARCHAR(50) NOT NULL,
    Knowledge_and_Skill VARCHAR(255) NOT NULL,
    Note VARCHAR(255) NOT NULL,
    Weight VARCHAR(20) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Part VARCHAR(20) NOT NULL,
    Completion_Criteria VARCHAR(50) NOT NULL,
    LO VARCHAR(50) NOT NULL,
    Grading_Guide VARCHAR(255) NOT NULL,
    Duration VARCHAR(20) NOT NULL,
    Question_Type VARCHAR(20) NOT NULL,
    No_Question INT NOT NULL,
    Subject_Code VARCHAR(50) NOT NULL,
    CONSTRAINT pk_Category_Test PRIMARY KEY (Category),
    CONSTRAINT fk_Category_Test_Subject FOREIGN KEY (Subject_Code) REFERENCES Subject(Subject_Code)
);

CREATE TABLE Components_Points (
    Grade_Item VARCHAR(150) NOT NULL ,
    Weight VARCHAR(20) NOT NULL,
    Value DECIMAL(5, 2) NOT NULL,
    Comment VARCHAR(255),
    Total DECIMAL(5, 2) NOT NULL,
    Subject_Code VARCHAR(50) NOT NULL,
    ID_Student VARCHAR(50) NOT NULL,
    CONSTRAINT pk_Components_Points PRIMARY KEY (Grade_Item),
	CONSTRAINT fk_Components_Points_Subject FOREIGN KEY (Subject_Code) REFERENCES Subject(Subject_Code),
    CONSTRAINT fk_Components_Points_Student FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student)
);


CREATE TABLE Semester (
    Term_Name VARCHAR(150)  NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL
	CONSTRAINT pk_Semester PRIMARY KEY (Term_Name)
);


CREATE TABLE Class (
    ID_Class VARCHAR(50) NOT NULL,
    Major VARCHAR(150) NOT NULL,
    Term_Name VARCHAR(150) NOT NULL,
	CONSTRAINT pk_Class PRIMARY KEY (ID_Class),
    CONSTRAINT fk_Class_Semester FOREIGN KEY (Term_Name) REFERENCES Semester(Term_Name)
);

CREATE TABLE CourseTotal (
    ID_Course_Total INT  NOT NULL,
    Subject_Code VARCHAR(50)  NOT NULL,
    ID_Student VARCHAR(50)  NOT NULL,
    ID_Class VARCHAR(50)  NOT NULL,
	CONSTRAINT pk_CourseTotal PRIMARY KEY (ID_Course_Total),
    CONSTRAINT fk_CourseTotal_Subject FOREIGN KEY (Subject_Code) REFERENCES Subject(Subject_Code),
    CONSTRAINT fk_CourseTotal_Student FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student),
    CONSTRAINT fk_CourseTotal_Class FOREIGN KEY (ID_Class) REFERENCES Class(ID_Class)
);

CREATE TABLE TeacherSubject (
    Teacher_Subject_ID INT NOT NULL,
    Teacher_ID VARCHAR(50) NOT NULL,
    Subject_Code VARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
	CONSTRAINT pk_TeacherSubject PRIMARY KEY (Teacher_Subject_ID),
    CONSTRAINT fk_TeacherSubject_Teacher FOREIGN KEY (Teacher_ID) REFERENCES Teacher(ID_Teacher),
    CONSTRAINT fk_TeacherSubject_Subject FOREIGN KEY (Subject_Code) REFERENCES Subject(Subject_Code)
);

CREATE TABLE StudentSubject (
    Student_Subject_ID INT NOT NULL ,
    ID_Student VARCHAR(50) NOT NULL,
    Subject_Code VARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
	CONSTRAINT pk_StudentSubject PRIMARY KEY ( Student_Subject_ID),
    CONSTRAINT fk_StudentSubject_Student FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student),
    CONSTRAINT fk_StudentSubject_Subject FOREIGN KEY (Subject_Code) REFERENCES Subject(Subject_Code)
);

CREATE TABLE StudentClass (
    Student_Class_ID INT NOT NULL ,
    ID_Student VARCHAR(50) NOT NULL,
    ID_Class VARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
	CONSTRAINT pk_StudentClass PRIMARY KEY (Student_Class_ID),
    CONSTRAINT fk_StudentClass_Teacher FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student),
    CONSTRAINT fk_StudentClass_Class FOREIGN KEY (ID_Class) REFERENCES Class(ID_Class)
);