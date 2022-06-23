-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.

INSERT INTO Mother (mothername, motherbirth, motherid, motheremail, motheraddress, motherphone, motherprofession) VALUES
('Victoria Gutierrez', DATE'1997-01-01', 'vicg0000', 'victoriagutierrez@gmail.com', '832 Latin Street', 5141231234, 'Professor'),
('Margaux Gagnon', DATE'1987-05-27', 'marg0000', 'mariongirard@hotmail.com', '513 Bishop Street', 5143216785, 'Politician'),
('Pauline Marois', DATE'1980-02-18', 'paum0000', 'paulinemarois@yahoo.com', '9499 Rue Cote-des-Neiges', 5143115446, 'Banker'),
('Jane Chen', DATE'1995-09-16', 'janc0000', 'janechen@gmail.com', '2121 Rue Cote-Ste-Catherine', 5147775546, 'Human Resources Lead'),
('Marie Jose Boisvert', DATE'1996-03-02', 'mjb00000', 'mjboisvert@gmail.com', '9456 Rue Peel', 5148886457, 'Software Developer'),
('Alice Kim', DATE'1995-10-05', 'alik0000', 'alicekim@gmail.com', '110 University Street', 5143324987, 'Artist');

INSERT INTO father (fathername, fatherbirth, fatherid, fatheremail, fatheraddress, fatherphone, fatherprofession) VALUES
('Denis Coderre', DATE'2000-10-02', 'denc0000', 'deniscoderre@rocketmail.com', '832 Latin Street', 514514514, 'Gamer'),
('Justin Trudeau', DATE'1995-10-02', 'just0000' , 'justintrudeau@gmail.com', '513 Bishop Street', 5141564875, 'Salesperson'),
('Francois Legault', DATE'1999-10-02', 'fral0000' , 'francoislegault@hotmail.com', '9499 Rue Cote-des-Neiges', 5148013245, 'Gamer'),
('Pascal Huot', DATE'1985-10-02', 'pash0000', 'pascalhuot@rocketmail.com', '456 Blob Street', 5148351204, 'Professor'),
('Christian Tanaka', DATE'1990-10-02', 'chrt0000' , 'christiantanaka@yahoo.com', '456 Westmount Street', 5143649572, 'Professor');

INSERT INTO facility (facilityaddress, facilityName) VALUES
('133 Hospital Street', 'Hopital Jean-René'),
('4122 Clinic Street', 'Hopital Jean-Pierre'),
('8492 Doctor Street', 'Lac-Saint-Louis'),
('1342 Nurse Street', 'Clinic St-Laurent'),
('88 Professor Street', 'Hopital Ste-Justine'),
('661 Lifesaver Street', 'Hopital Victoria'),
('8890 Intern Street', 'Hopital Martine'),
('903 Rue Medecin', 'Clinic du Lac');

INSERT INTO communityclinic (facilityaddress) VALUES
('133 Hospital Street'),
('4122 Clinic Street'),
('8492 Doctor Street'),
('1342 Nurse Street'),
('903 Rue Medecin');

INSERT INTO birthingcenter (facilityaddress) VALUES
('88 Professor Street'),
('661 Lifesaver Street'),
('8890 Intern Street');

INSERT INTO midwife (practitionerid, email, name, midwifephone, facilityaddress) VALUES
('midw0000', 'eve@mail.mcgill.ca', 'Eve', 5149465214, '133 Hospital Street'),
('midw0001', 'sophie@mail.mcgill.ca', 'Sophie', 5140231548, '8890 Intern Street'),
('midw0002', 'lucy@mail.mcgill.ca', 'Lucy', 5148621547, '8492 Doctor Street'),
('midw0003', 'guillaine@mail.mcgill.ca', 'Guillaine', 5147215486, '88 Professor Street'),
('midw0004', 'mariongirard@mail.mcgill.ca', 'Marion Girard', 5143205167, '661 Lifesaver Street');

INSERT INTO parent (motherid, fatheremail, attendedsession, motherblood, fatherblood, parentid, primarymidwife, backupmidwife) VALUES
('vicg0000', 'deniscoderre@rocketmail.com', TRUE, 'AB-', 'O-', 100, 'midw0000', NULL),
('vicg0000', 'deniscoderre@rocketmail.com', TRUE, 'AB-', 'O-', 101, 'midw0003', NULL),
('marg0000', 'justintrudeau@gmail.com', TRUE, 'O+', 'O+', 102, 'midw0001', 'midw0004'),
('paum0000', 'francoislegault@hotmail.com', TRUE, 'A+', 'A-', 103, 'midw0002', 'midw0004'),
('janc0000', NULL, True, 'A-', NULL, 104, 'midw0003', 'midw0004'),
('mjb00000', NULL, True, 'AB-', NULL, 105, 'midw0000', NULL),
('alik0000', NULL, True, 'B+', NULL, 106, 'midw0003', 'midw0004'),
('paum0000', 'pascalhuot@rocketmail.com', TRUE, 'A+', 'AB+', 107, 'midw0002', NULL),
('mjb00000', 'christiantanaka@yahoo.com', True, 'AB-', 'O+', 108, 'midw0002', NULL);

INSERT INTO infosession (sessionkey, language, sessiondate, sessiontime, host) VALUES
(200, 'French', DATE'2020-05-30', TIME '13:00', 'midw0000'),
(201, 'French', DATE'2021-12-05', TIME '13:00', 'midw0001'),
(202, 'English', DATE'2021-11-25', TIME '10:00', 'midw0001'),
(203, 'Spanish', DATE'2021-12-13', TIME '9:00', 'midw0003'),
(204, 'French', DATE'2021-09-12', TIME '14:00', 'midw0003'),
(205, 'French', DATE'2021-10-27', TIME '14:00', 'midw0004');

INSERT INTO sessionregistration (sessionkey, parentid) VALUES
(200, 100),
(201, 101),
(201, 102),
(201, 104),
(201, 105),
(202, 102),
(202, 104),
(203, 103),
(203, 106),
(204, 105),
(204, 104),
(201, 107),
(202, 108);

INSERT INTO appointment (appointmentid, appointmentdate, appointmenttime, midwife, parentid) VALUES
(300, DATE'2021-11-24', TIME'13:00', 'midw0000', 105),
(301, DATE'2021-11-24', TIME'14:00', 'midw0002', 103),
(302, DATE'2021-11-24', TIME'15:00', 'midw0003', 104),
(303, DATE'2021-11-24', TIME'16:00', 'midw0003', 101),
(304, DATE'2021-12-13', TIME'09:00', 'midw0000', 105),
(305, DATE'2021-12-13', TIME'10:00', 'midw0002', 103),
(306, DATE'2021-12-13', TIME'11:00', 'midw0003', 104),
(307, DATE'2022-01-08', TIME'10:00', 'midw0000', 105),
(308, DATE'2022-01-09', TIME'10:00', 'midw0004', 103),
(309, DATE'2022-01-10', TIME'11:00', 'midw0004', 104),
(310, DATE'2022-02-24', TIME'13:00', 'midw0003', 101),
(311, DATE'2022-02-24', TIME'14:00', 'midw0001', 102),
(312, DATE'2022-03-05', TIME'15:00', 'midw0003', 101),
(313, DATE'2022-03-21', TIME'09:00', 'midw0004', 102),
(314, DATE'2022-03-24', TIME'16:00', 'midw0004', 102),
(315, DATE'2022-03-28', TIME'10:00', 'midw0003', 106),
(316, DATE'2022-04-20', TIME'10:00', 'midw0003', 106),
(317, DATE'2022-05-08', TIME'10:00', 'midw0001', 102),
(318, DATE'2022-05-09', TIME'10:00', 'midw0004', 106),
(319, DATE'2022-06-10', TIME'11:00', 'midw0003', 106),
(320, DATE'2020-07-28', TIME'10:00', 'midw0004', 100),
(321, DATE'2020-08-30', TIME'10:00', 'midw0004', 100),
(322, DATE'2020-09-15', TIME'10:00', 'midw0004', 100),
(323, DATE'2022-06-15', TIME'11:00', 'midw0002', 107),
(324, DATE'2022-07-01', TIME'9:00', 'midw0002', 107),
(325, DATE'2022-07-21', TIME'14:00', 'midw0002', 107),
(326, DATE'2022-06-13', TIME'11:00', 'midw0002', 108),
(327, DATE'2022-07-02', TIME'12:00', 'midw0002', 108),
(328, DATE'2022-07-20', TIME'13:00', 'midw0002', 108);

INSERT INTO notes (notedate, notetime, noteid, appointmentid, info) VALUES
(DATE'2021-11-24', TIME'13:00', 400300, 300, 'Everything going well'),
(DATE'2021-12-13', TIME'9:00', 400304, 304, 'Everything going well'),
(DATE'2021-12-13', TIME'9:30', 401304, 304, 'Performed blood test and ultrasound'),
(DATE'2022-01-08', TIME'10:00', 400307, 307, 'Slight nausea'),

(DATE'2021-11-24', TIME'14:00', 400301, 301, 'Everything going well'),
(DATE'2021-12-13', TIME'10:00', 400305, 305, 'Everything going well'),
(DATE'2021-12-13', TIME'10:30', 401305, 305, 'Performed blood test'),
(DATE'2022-01-09', TIME'10:00', 400308, 308, 'Performed ultrasound'),

(DATE'2021-11-24', TIME'15:00', 400302, 302, 'Everything going well'),
(DATE'2021-12-13', TIME'11:00', 400306, 306, 'Everything going well'),
(DATE'2021-12-13', TIME'11:30', 401306, 306, 'Performed blood test and ultrasound'),
(DATE'2022-01-10', TIME'11:00', 400309, 309, 'Severe nausea'),

(DATE'2021-11-24', TIME'16:00', 400303, 303, 'Everything going well'),
(DATE'2022-02-24', TIME'13:00', 400310, 310, 'Slight nausea'),
(DATE'2022-02-24', TIME'13:30', 401310, 310, 'Performed blood test and ultrasound'),
(DATE'2022-03-05', TIME'15:00', 400312, 312, 'Everything going well'),

(DATE'2022-02-24', TIME'14:00', 400311, 311, 'Everything going well'),
(DATE'2022-03-21', TIME'9:00', 400313, 313, 'Everything going well'),
(DATE'2022-03-21', TIME'9:30', 401313, 313, 'Performed blood test and ultrasound'),
(DATE'2022-03-24', TIME'16:00', 400314, 314, 'Loss of appetite'),
(DATE'2022-05-08', TIME'10:00', 400317, 317, 'Medium nausea'),

(DATE'2022-03-14', TIME'10:00', 400315, 315, 'Everything going well'),
(DATE'2022-04-20', TIME'10:00', 400316, 316, 'Everything going well'),
(DATE'2022-05-09', TIME'10:00', 400318, 318, 'Everything going well'),
(DATE'2022-05-09', TIME'10:30', 401318, 318, 'Performed blood test'),
(DATE'2022-06-10', TIME'11:00', 400319, 319, 'Performed ultrasound'),

(DATE'2020-07-28', TIME'10:00', 400320, 320, 'Everything going well'),
(DATE'2020-07-28', TIME'10:30', 401320, 320, 'Performed blood test'),
(DATE'2020-08-30', TIME'10:00', 400321, 321, 'Everything going well'),
(DATE'2020-09-15', TIME'10:00', 400322, 322, 'Performed ultrasound'),

(DATE'2022-06-15', TIME'11:00', 400323, 323, 'Everything going well'),
(DATE'2022-07-01', TIME'9:00', 401324, 324, 'Performed blood test'),
(DATE'2022-07-01', TIME'9:30', 400324, 324, 'Everything going well'),
(DATE'2022-07-21', TIME'14:00', 400325, 325, 'Performed ultrasound'),

(DATE'2022-06-13', TIME'11:00', 400326, 326, 'Performed ultrasound'),
(DATE'2022-07-02', TIME'12:00', 401327, 327, 'Performed blood test'),
(DATE'2022-07-02', TIME'12:30', 400327, 327, 'Loss of appetite'),
(DATE'2022-07-20', TIME'13:00', 400328, 328, 'High nausea');


INSERT INTO technician (technicianid, name, technicianphone) VALUES
('tech0000', 'Jack', 5143214862),
('tech0001', 'John', 5143157486),
('tech0002', 'Jean', 5142678950),
('tech0003', 'Juan', 5140001468),
('tech0004', 'Jacopo', 5142223334);

INSERT INTO medicaltestsample (testkey, dateprescribed, datesample, datelabwork, type, appointmentid, technicianid, result) VALUES
('test0000', DATE'2021-12-13', DATE'2021-12-13', DATE'2021-12-14', 'Parent blood iron test', 304, 'tech0000', 'Parent blood test: mother is AB- (Normal iron level), father is unknown'),
('test0001', DATE'2021-12-13', DATE'2021-12-13', DATE'2021-12-14', 'Ultrasound', 304, 'tech0000', 'Baby is a male'),

('test0010', DATE'2021-12-13', DATE'2021-12-13', DATE'2021-12-14', 'Parent blood iron test', 305, 'tech0001', 'Parent blood test: mother is A+ (Low iron level), father is A- (High iron level)'),
('test0011', DATE'2022-01-09', DATE'2022-01-13', DATE'2022-01-15', 'Ultrasound', 308, 'tech0001', 'Baby is a male'),

('test0020', DATE'2021-12-13', DATE'2021-12-13', DATE'2021-12-15', 'Parent blood iron test', 306, 'tech0001', 'Parent blood test: mother is A- (Low iron level), father is unknown'),
('test0021', DATE'2021-12-13', DATE'2021-12-13', DATE'2021-12-15', 'Ultrasound', 306, 'tech0001', 'Baby is a female'),

('test0030', DATE'2022-02-24', DATE'2022-02-24', DATE'2022-02-25', 'Parent blood iron test', 310, 'tech0002', 'Parent blood test: mother is AB- (Normal iron level), father is O- (Normal iron level)'),
('test0031', DATE'2022-02-24', DATE'2022-02-24', DATE'2022-02-25', 'Ultrasound', 310, 'tech0002', 'Baby is a female'),

('test0040', DATE'2022-03-24', DATE'2022-03-24', DATE'2022-03-27', 'Parent blood iron test', 313, 'tech0004', 'Parent blood test: mother is O+ (High iron level), father is O+ (Normal iron level)'),
('test0041', DATE'2022-03-24', DATE'2022-03-24', DATE'2022-03-27', 'Ultrasound', 313, 'tech0004', 'Twins: female and male'),

('test0050', DATE'2022-05-09', DATE'2022-05-09', DATE'2022-05-09', 'Parent blood iron test', 318, 'tech0002', 'Parent blood test: mother is B+ (Normal iron level), father is unknown'),
('test0051', DATE'2022-06-10', DATE'2022-06-11', DATE'2022-06-12', 'Ultrasound', 319, 'tech0002', 'Baby is a male'),

('test0060', DATE'2020-07-28', DATE'2020-07-28', DATE'2020-07-29', 'Parent blood iron test', 320, 'tech0003', 'Parent blood test: mother is AB- (Low iron level), father is O- (Normal iron level)'),
('test0061', DATE'2020-09-15', DATE'2020-09-16', DATE'2020-09-17', 'Ultrasound', 322, 'tech0003', 'Baby is a male'),

('test0070', DATE'2022-07-01', DATE'2022-07-01', DATE'2022-07-02', 'Parent blood iron test', 324, 'tech0001', 'Parent blood test: mother is A+ (Low iron level), father is AB+ (Normal iron level)'),
('test0071', DATE'2022-07-21', DATE'2022-07-21', DATE'2022-07-23', 'Ultrasound', 325, 'tech0001', 'Twins: 2 females'),

('test0080', DATE'2022-06-13', DATE'2022-06-15', DATE'2022-06-22', 'Ultrasound', 326, 'tech0004', 'Baby is a male'),
('test0081', DATE'2022-07-02', DATE'2022-07-02', DATE'2022-07-03', 'Parent blood iron test', 327, 'tech0004', 'Parent blood test: mother is AB- (Low iron level), father is O+ (Small iron level)'),


('test0002', DATE'2022-02-01', DATE'2022-02-01', DATE'2022-02-01', 'Baby blood iron test', NULL, 'tech0000', 'Baby blood test: AB+'),
('test0012', DATE'2022-02-05', DATE'2022-02-05', DATE'2022-02-05', 'Baby blood iron test', NULL, 'tech0001', 'Baby blood test: O-'),
('test0022', DATE'2022-04-26', DATE'2022-04-26', DATE'2022-04-26', 'Baby blood iron test', NULL, 'tech0001', 'Baby blood test: A-'),
('test0032', DATE'2022-05-02', DATE'2022-05-02', DATE'2022-05-02', 'Baby blood iron test', NULL, 'tech0002', 'Baby blood test: A+'),
('test0042', DATE'2022-06-25', DATE'2022-06-25', DATE'2022-06-25', 'Baby blood iron test', NULL, 'tech0004', 'Baby blood test: B+'),
('test0052', DATE'2022-07-29', DATE'2022-07-29', DATE'2022-07-29', 'Baby blood iron test', NULL, 'tech0002', 'Baby blood test: AB-'),
('test0062', DATE'2020-10-01', DATE'2020-10-01', DATE'2020-10-01', 'Baby blood iron test', NULL, 'tech0003', 'Baby blood test: O+'),
('test0072', DATE'2022-07-26', DATE'2022-07-26', DATE'2022-07-26', 'Baby blood iron test', NULL, 'tech0004', 'Baby blood test: B-');

INSERT INTO pregnancyinformation (pregnancyinfoid, parentid, numberofbabies, pregnancynumber, birthtimeframestart, birthtimeframeend) VALUES
('preg0100', 100, 1, 1, DATE'2020-09-29', DATE'2020-10-11'),
('preg0101', 101, 1, 2, DATE'2022-05-01', DATE'2022-05-23'),
('preg0102', 102, 2, 1, DATE'2022-06-21', DATE'2022-07-01'),
('preg0103', 103, 1, 1, DATE'2022-02-05', DATE'2022-03-14'),
('preg0104', 104, 1, 1, DATE'2022-04-21', DATE'2022-05-14'),
('preg0105', 105, 1, 1, DATE'2022-02-01', DATE'2022-02-20'),
('preg0106', 106, 1, 1, DATE'2022-07-25', DATE'2022-08-02'),
('preg0107', 107, 2, 2, DATE'2022-07-25', DATE'2022-08-02'),
('preg0108', 108, 1, 2, DATE'2022-07-22', DATE'2022-08-09');

INSERT INTO testresults (testkey, pregnancyinfoid) VALUES
('test0000', 'preg0105'),
('test0001', 'preg0105'),

('test0010', 'preg0103'),
('test0011', 'preg0103'),

('test0020', 'preg0104'),
('test0021', 'preg0104'),

('test0030', 'preg0101'),
('test0031', 'preg0101'),

('test0040', 'preg0102'),
('test0041', 'preg0102'),

('test0050', 'preg0106'),
('test0051', 'preg0106'),

('test0060', 'preg0100'),
('test0061', 'preg0100'),

('test0070', 'preg0107'),
('test0071', 'preg0107'),

('test0080', 'preg0108'),
('test0081', 'preg0108'),

('test0002', 'preg0105'),
('test0012', 'preg0103'),
('test0022', 'preg0104'),
('test0032', 'preg0101'),
('test0042', 'preg0102'),
('test0052', 'preg0106'),
('test0062', 'preg0100'),
('test0072', 'preg0107');

INSERT INTO baby (babyid, babyname, babygender, babybloodtype, babybirthdate, homebirth, birthingcenter, pregnancyinfoid) VALUES
('baby0000', 'Zackaria', 'Male', 'O+', DATE'2020-10-01', TRUE, NULL, 'preg0100'),
('baby0001', 'Athena', 'Female', 'A+', DATE'2022-05-02', TRUE, NULL, 'preg0101'),
('baby0002', 'Daisy', 'Female', 'B+', DATE'2022-06-25', FALSE, '88 Professor Street', 'preg0102'),
('baby0012', 'David', 'Male', 'B+', DATE'2022-06-25', FALSE, '88 Professor Street', 'preg0102'),
('baby0003', 'Lucian', 'Male', 'O-', DATE'2022-02-05', FALSE, '8890 Intern Street', 'preg0103'),
('baby0004', 'Sophia', 'Female', 'A-', DATE'2022-04-26', FALSE, '88 Professor Street', 'preg0104'),
('baby0005', 'Gaetan', 'Male', 'AB+', DATE'2022-02-01', FALSE, '88 Professor Street', 'preg0105'),
('baby0006', 'Paul', 'Male', 'AB-', DATE'2022-07-29', FALSE, '661 Lifesaver Street', 'preg0106'),
('baby0007', 'Rosalina', 'Female', 'B-', DATE'2022-07-26', TRUE, NULL, 'preg0107'),
('baby0017', 'Rachel', 'Female', 'B-', DATE'2022-07-26', TRUE, NULL, 'preg0107'),
('baby0008', 'Raul', 'Male', 'AB-', NULL, FALSE, '8890 Intern Street', 'preg0108');