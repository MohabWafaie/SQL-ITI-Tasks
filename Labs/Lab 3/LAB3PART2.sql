use Day3Task2

CREATE TABLE Instructor (
    ID INT IDENTITY,
    First VARCHAR(50),
    Last VARCHAR(50),
    BD DATE,
    Salary INT default 3000,
    OverTime INT,
    HireDate DATE DEFAULT GETDATE(),
    Address VARCHAR(10),
	Age as(year(getdate())-year(BD)),
	NetSalary as(isnull(Salary,0)+isnull(OverTime,0)) persisted,
    
    CONSTRAINT c1 PRIMARY KEY (ID),
    CONSTRAINT c2 UNIQUE (OverTime),
    CONSTRAINT c3 CHECK (Salary between 1000 and 5000),
    CONSTRAINT c4 CHECK (Address IN ('cairo', 'alex'))
);

CREATE TABLE Course (
    CID INT IDENTITY PRIMARY KEY,
    CName VARCHAR(100),
    Duration INT,

    CONSTRAINT c5 UNIQUE (Duration)
);

CREATE TABLE Lab (
    LID INT IDENTITY,
    CID INT NOT NULL,
    Location VARCHAR(100),
    Capacity INT,

    CONSTRAINT c6 PRIMARY KEY (LID, CID),
    CONSTRAINT c7 FOREIGN KEY (CID) REFERENCES Course(CID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT c8 CHECK (Capacity < 20)
);

-- Junction Table for Teach relationship
CREATE TABLE Teach (
    InstructorID INT NOT NULL,
    CourseID INT NOT NULL,

    CONSTRAINT c9 PRIMARY KEY (InstructorID, CourseID),
    CONSTRAINT c10 FOREIGN KEY (InstructorID) REFERENCES Instructor(ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT c11 FOREIGN KEY (CourseID) REFERENCES Course(CID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
