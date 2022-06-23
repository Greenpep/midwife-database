-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
CREATE TABLE Mother(
    motherName VARCHAR(30),
    motherBirth DATE,
    motherID CHAR(8) NOT NULL,
    motherEmail VARCHAR(30),
    motherAddress VARCHAR(50),
    motherPhone BIGINT,
    motherProfession VARCHAR(20),
    PRIMARY KEY (motherID)
);

CREATE TABLE Father(
    fatherName VARCHAR(30),
    fatherBirth DATE,
    fatherID CHAR(8),
    fatherEmail VARCHAR(30) NOT NULL,
    fatherAddress VARCHAR(50),
    fatherPhone BIGINT,
    fatherProfession VARCHAR(20),
    PRIMARY KEY (fatherEmail)
);

CREATE TABLE Facility(
    facilityAddress VARCHAR(30) NOT NULL,
    facilityName VARCHAR(30),
    PRIMARY KEY (facilityAddress)
);

CREATE TABLE CommunityClinic(
    facilityAddress VARCHAR(30) NOT NULL,
    PRIMARY KEY (facilityAddress),
    FOREIGN KEY (facilityAddress)
    REFERENCES Facility
);

CREATE TABLE BirthingCenter(
    facilityAddress VARCHAR(30) NOT NULL,
    PRIMARY KEY (facilityAddress),
    FOREIGN KEY (facilityAddress)
    REFERENCES Facility
);

CREATE TABLE MidWife(
    practitionerID CHAR(8) NOT NULL,
    email VARCHAR(30),
    name VARCHAR(30),
    midWifePhone BIGINT,
    facilityAddress VARCHAR(30),
    PRIMARY KEY (practitionerID),
    FOREIGN KEY (facilityAddress)
    REFERENCES Facility
);

CREATE TABLE Parent(
    motherID CHAR(8) NOT NULL,
    fatherEmail VARCHAR(30),
    attendedSession BOOLEAN NOT NULL,
    motherBlood VARCHAR(3),
    fatherBlood VARCHAR(3),
    parentID INT NOT NULL,
    primaryMidwife CHAR(8),
    backupMidwife CHAR(8),
    PRIMARY KEY (parentID),
    FOREIGN KEY (motherID)
    REFERENCES Mother,
    FOREIGN KEY (fatherEmail)
    REFERENCES Father,
    FOREIGN KEY (primaryMidwife)
    REFERENCES MidWife,
    FOREIGN KEY (backupMidwife)
    REFERENCES MidWife
);

CREATE TABLE InfoSession(
    sessionKey INT NOT NULL,
    language VARCHAR(15),
    sessionDate DATE,
    sessionTime TIME,
    host CHAR(8),
    PRIMARY KEY (sessionKey),
    FOREIGN KEY (host)
    REFERENCES MidWife
);

CREATE TABLE SessionRegistration(
    sessionKey INT NOT NULL,
    parentID INT NOT NULL,
    PRIMARY KEY (sessionKey, parentID),
    FOREIGN KEY (sessionKey)
    REFERENCES InfoSession,
    FOREIGN KEY (parentID)
    REFERENCES Parent
);

CREATE TABLE Appointment(
    appointmentID INT NOT NULL,
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL,
    midwife CHAR(8) NOT NULL,
    parentID INT NOT NULL,
    PRIMARY KEY (appointmentID),
    FOREIGN KEY (midwife)
    REFERENCES MidWife,
    FOREIGN KEY (parentID)
    REFERENCES Parent
);

CREATE TABLE Notes(
    noteDate DATE NOT NULL,
    noteTime TIME NOT NULL,
    noteID INT NOT NULL,
    appointmentID INT NOT NULL,
    info VARCHAR (100),
    PRIMARY KEY (noteID),
    FOREIGN KEY (appointmentID)
    REFERENCES Appointment
);

CREATE TABLE Technician(
   technicianID CHAR(8) NOT NULL,
   name VARCHAR(20),
   technicianPhone BIGINT,
   PRIMARY KEY (technicianID)
);

CREATE TABLE MedicalTestSample(
    testKey CHAR(8) NOT NULL,
    dateSample DATE,
    datePrescribed DATE,
    dateLabWork DATE,
    type VARCHAR(50),
    appointmentID INT,
    technicianID CHAR(8) NOT NULL,
    result VARCHAR(100),
    PRIMARY KEY (testKey),
    FOREIGN KEY (appointmentID)
    REFERENCES Appointment,
    FOREIGN KEY (technicianID)
    REFERENCES Technician,
    CHECK ( dateLabWork >= datePrescribed )
);

CREATE TABLE PregnancyInformation(
    pregnancyInfoID CHAR(8) NOT NULL,
    parentID INT NOT NULL,
    numberOfBabies INT,
    pregnancynumber INT NOT NULL,
    birthTimeFrameStart DATE,
    birthTimeFrameEnd DATE,
    PRIMARY KEY (pregnancyInfoID),
    FOREIGN KEY (parentID)
    REFERENCES Parent
);

CREATE TABLE TestResults(
    testKey CHAR(8) NOT NULL,
    pregnancyInfoID CHAR(8) NOT NULL,
    PRIMARY KEY (testKey, pregnancyInfoID),
    FOREIGN KEY (testKey)
    REFERENCES MedicalTestSample,
    FOREIGN KEY (pregnancyInfoID)
    REFERENCES PregnancyInformation
);

CREATE TABLE Baby(
    babyID CHAR(8) NOT NULL,
    babyName VARCHAR(20),
    babyGender VARCHAR(6),
    babyBloodType VARCHAR(3),
    babyBirthDate DATE,
    homeBirth BOOLEAN NOT NULL,
    birthingCenter VARCHAR(30),
    pregnancyInfoID CHAR(8) NOT NULL,
    PRIMARY KEY (babyID),
    FOREIGN KEY (birthingCenter)
    REFERENCES BirthingCenter,
    FOREIGN KEY  (pregnancyInfoID)
    REFERENCES PregnancyInformation
);



