TRUNCATE TABLE College CASCADE;
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('CED', 'BAGCED', 'Br. Andrew Gonzalez FSC College of Education');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('CCS', NULL, 'College of Computer Studies');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('COL', NULL, 'College of Law');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('CLA', NULL, 'College of Liberal Arts');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('COS', null, 'College of Science');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('COE', 'GCOE', 'Gokongwei College of Engineering');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('COB', 'RVRCOB', 'Ramon V. del Rosario College of Business');
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('SOE', null, 'School of Economics');

/* Organization Data */
TRUNCATE TABLE OrganizationNature CASCADE;
INSERT INTO OrganizationNature (id, name, acronym)
                      VALUES (1, 'Special Interest', 'SPIN');
INSERT INTO OrganizationNature (id, name, acronym)
                      VALUES (2, 'Professional Organization', 'PROF');
INSERT INTO OrganizationNature (id, name, acronym)
                      VALUES (3, 'Socio-civic and Religious', 'SCORE');
INSERT INTO OrganizationNature (id, name, acronym)
                      VALUES (4, 'Professional Organization Group', 'PROG');
TRUNCATE TABLE OrganizationCluster CASCADE;
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (1, 'Alliance of Science Organizations', 'ASO');
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (2, 'Alliance of Special Interest and Socio-Civic Organizations', 'ASPIRE');
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (3, 'College of Liberal Arts Professional Organizations', 'CAP12');
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (4, 'Engineering Alliance Geared Towards Excellence', 'ENGAGE');
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (5, 'Alliance of Professional Organizations of Business and Economics', 'PROBE');

TRUNCATE TABLE StudentOrganization CASCADE;
INSERT INTO StudentOrganization (id, acronym, name, description)
                 VALUES (0, 'CSO', 'Council of Student Organizations', NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (1, 'Chemsoc', 'Chemistry Society', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (2, 'MC', 'Math Circle', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (3, 'Physoc', 'Physics Society', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (4, 'SV', 'Societas Vitae', 1, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (5, 'LSCS', 'La Salle Computer Society', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (6, 'UNITED', 'Union of Students Inspired Towards Education', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (7, 'ENGLICOM', 'DLSU Filipino & Chinese Organization', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (8, 'ROTARACT', 'ROTARACT Club of DLSU', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (9, 'UNISTO', 'United International Student Organization', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (10, 'AIESEC', 'AIESEC DLSU', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (11, NULL, 'Moo Media', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (12, 'OC', 'Outdoor Club', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (13, 'WG', 'Writer’s Guild', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (14, 'ECO', 'De La Salle University - Environmental Conservation Organization', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (15, 'GAS', 'Gakuen Anime Shoshiki', 2, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (16, 'AMSTUD', 'The Organization for American Studies', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (17, 'BSS', 'Behavioral Sciences Society', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (18, NULL, 'Cultura', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (19, 'DANUM', 'Dalubhasaan ng mga Umuusbong na Mag-aaral ng Araling Pilipino', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (20, 'ESA', 'European Studies Association', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (21, 'Kaunlaran', 'Kapatiran ng Kabataan para sa Kaunlaran', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (22, 'NKK', 'Nihon Kenkyu Kai', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (23, 'Poliscy', 'Political Science Society', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (24, 'DLSU Pilosopo', 'Samahan ng Lasalyanong Pilosopo', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (25, 'SMS', 'Samahan ng mga Mag-aaral sa Sikolohiya', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (26, 'SDH', 'Sociedad De Historia', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (27, 'TeamComm', 'Team Communications', 3, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (28, 'ACCESS', 'Association of Computer Engineering Students', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (29, 'ChEn', 'Chemical Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (30, 'CES', 'Civil Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (31, 'ECES', 'Electronic and Communications Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (32, 'IMES', 'Industrial Management Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (33, 'SME', 'Society of Manufacturing Engineering', 4, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (34, 'AdCreate', 'AdCreate Society', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (35, 'BMS', 'Business Management Society', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (36, 'EconOrg', 'Economics Organization', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (37, 'MaFia', 'Management of Financial Institutions Association', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (38, 'YES', 'Young Entrepreneurs Society', 5, NULL);

INSERT INTO AccountType (id, name)
                 VALUES (0, 'System Administrator');
INSERT INTO AccountType (id, name)
                 VALUES (1, 'SLIFE Officer');
INSERT INTO AccountType (id, name)
                 VALUES (2, 'CSO Officer');
INSERT INTO AccountType (id, name)
                 VALUES (3, 'Organization Officer');

TRUNCATE TABLE ActivityType CASCADE;
INSERT INTO ActivityType (id, name)
                  VALUES (1, 'Academic Contest');
INSERT INTO ActivityType (id, name)
                  VALUES (2, 'Distribution');
INSERT INTO ActivityType (id, name)
                  VALUES (3, 'General Assembly');
INSERT INTO ActivityType (id, name)
                  VALUES (4, 'Seminar/Workshops');
INSERT INTO ActivityType (id, name)
                  VALUES (5, 'Publicity/Awareness Campaign');
INSERT INTO ActivityType (id, name)
                  VALUES (6, 'Meetings');
INSERT INTO ActivityType (id, name)
                  VALUES (7, 'Spiritual Activity');
INSERT INTO ActivityType (id, name)
                  VALUES (8, 'Recruitment/Audition');
INSERT INTO ActivityType (id, name)
                  VALUES (9, 'Recreation');
INSERT INTO ActivityType (id, name)
                  VALUES (10, 'Others');
TRUNCATE TABLE ActivityNature CASCADE;
INSERT INTO ActivityNature (id, name)
                    VALUES (1, 'Academic');
INSERT INTO ActivityNature (id, name)
                    VALUES (2, 'Special Interest');
INSERT INTO ActivityNature (id, name)
                    VALUES (3, 'Departmental Initiative');
INSERT INTO ActivityNature (id, name)
                    VALUES (4, 'Fundraising');
INSERT INTO ActivityNature (id, name)
                    VALUES (5, 'Community Development');
INSERT INTO ActivityNature (id, name)
                    VALUES (6, 'Organizational Development');
INSERT INTO ActivityNature (id, name)
                    VALUES (7, 'Issue Advocacy');
INSERT INTO ActivityNature (id, name)
                    VALUES (8, 'Lasallian Formation/Spiritual Growth');
INSERT INTO ActivityNature (id, name)
                    VALUES (9, 'Outreach');

TRUNCATE TABLE GOSMStatus CASCADE;
INSERT INTO GOSMStatus (id, name)
                VALUES (1, 'Created');
INSERT INTO GOSMStatus (id, name)
                VALUES (2, 'Initial Submission');
INSERT INTO GOSMStatus (id, name)
                VALUES (3, 'Approved');
INSERT INTO GOSMStatus (id, name)
                VALUES (4, 'Pending');
INSERT INTO GOSMStatus (id, name)
                VALUES (5, 'Denied');

TRUNCATE TABLE ProjectProposalStatus CASCADE;
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (1, 'Created');
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (2, 'Initial Submission');
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (3, 'Approved');
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (4, 'Pending');
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (5, 'Denied');

TRUNCATE TABLE Account CASCADE;
INSERT INTO Account (email, idNumber, password, firstname, middlename, lastname, contactNumber)
             VALUES ('juliano_laguio@dlsu.edu.ph', 11445955, '1234', 'Lian', 'Blanco', 'Laguio', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber)
             VALUES ('markus_flores@dlsu.edu.ph', 11445954, '1234', 'Markus', 'Flores', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber)
             VALUES ('dominique_dagunton@dlsu.edu.ph', 11445953, '1234', 'Dominique', 'Dagunton', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber)
             VALUES ('neil_capistrano@dlsu.edu.ph', 11445952, '1234', 'Neil', 'Capistrano', '+63 9228474849');

/* 2015 - 2016 */
TRUNCATE TABLE SchoolYear CASCADE;
TRUNCATE TABLE TERM CASCADE;
INSERT INTO SchoolYear(id, startYear, endYear)
               VALUES (1, 2015, 2016);
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 1, '2015-08-24', '2015-12-08');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 2, '2016-01-06', '2016-04-16');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 3, '2016-05-23', '2016-08-27');

/* 2016 - 2017 */
INSERT INTO SchoolYear(id, startYear, endYear)
               VALUES (2, 2016, 2017);
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 1, '2016-09-12', '2016-12-17');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 2, '2016-01-04', '2016-04-11');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 3, '2017-05-15', '2017-08-19');

/* 2017 - 2018 */
INSERT INTO SchoolYear(id, startYear, endYear)
               VALUES (3, 2017, 2018);
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 1, '2017-09-11', '2017-12-16');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 2, '2018-01-08', '2018-04-21');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 3, '2018-05-24', '2018-08-28');

TRUNCATE TABLE GOSM CASCADE;
INSERT INTO GOSM (termID, studentOrganization)
           VALUES ((SELECT id
                      FROM TERM
                     WHERE CURRENT_DATE BETWEEN dateStart AND dateEnd), 2 );
UPDATE GOSM
   SET status = 2
 WHERE id = 1;

TRUNCATE TABLE GOSMActivity CASCADE;
INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                    VALUES (1, 'Goal Mo to', '{"Objectives", "Mo", "To"}', 'Strategies Mo to', 'Descibe kita', 'Measure mo to :)', '2017-9-6', '2017-9-6', 1, 2, false, 999.99);
TRUNCATE ProjectProposal CASCADE;
INSERT INTO ProjectProposal (GOSMActivity, ENP, ENMP, venue, context, sourceFundOther, sourceFundParticipantFee, sourceFundOrganizational, accumulatedOperationalFunds, accumulatedDepositoryFunds, comments)
                     VALUES (1, 1, 1, 'Venue ito', 'Context kita', 69.69, 69.69, 69.69, 69.69, 69.69, 'Comments ko toh');
UPDATE ProjectProposal
SET status = 2
WHERE id = 1;

TRUNCATE ProjectProposalExpenses CASCADE;
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 1', 7, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 2', 80, 60.0000);
                              
TRUNCATE TABLE GOSMActivityProjectHead CASCADE;
INSERT INTO GOSMActivityProjectHead (idNumber, activityID)
                             VALUES (11445955, 1);
INSERT INTO GOSMActivityProjectHead (idNumber, activityID)
                             VALUES (11445952, 1);