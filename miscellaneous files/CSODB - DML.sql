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
TRUNCATE TABLE OrganizationType CASCADE;
INSERT INTO OrganizationType (id, description)
                      VALUES (1, 'Special Interest');
INSERT INTO OrganizationType (id, description)
                      VALUES (2, 'Professional Organization');
INSERT INTO OrganizationType (id, description)
                      VALUES (3, 'Socio-civic and Religious');
INSERT INTO OrganizationType (id, description)
                      VALUES (4, 'Professional Organization Group');

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
                VALUES (1, 'Pending');
INSERT INTO GOSMStatus (id, name)
                VALUES (2, 'Approved');
INSERT INTO GOSMStatus (id, name)
                VALUES (3, 'Denied');

TRUNCATE TABLE StudentOrganization CASCADE;
INSERT INTO StudentOrganization (id, college, organizationType, acronym, name, description)
                         VALUES (1, 'CCS', 2, 'LSCS', 'La Salle Computer Society', E'Best organization in CCS, because it\'s the only organization in CCS');
TRUNCATE TABLE GOSM CASCADE;
INSERT INTO GOSM (startYear, endYear, StudentOrganization)
          VALUES (2016, 2017, 1);
TRUNCATE TABLE GOSMActivities CASCADE;
INSERT INTO GOSMActivities (startYear, endYear, studentOrganization, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, peopleInCharge, activityNature, activityType, isRelatedToOrganizationNature, budget)
                    VALUES (2016, 2017, 1, 'Goal Mo to', '{"Objectives", "mo", "to"}', 'Strategy mo to', 'description mo to', 'measure mo to', '2017-8-30', '2017-8-31', '{"In charge si acoe"}', 1, 1, false, 69.699);
INSERT INTO GOSMActivities (startYear, endYear, studentOrganization, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, peopleInCharge, activityNature, activityType, isRelatedToOrganizationNature, budget)
                    VALUES (2016, 2017, 1, 'Goal Mo to', '{"Objectives", "mo", "to"}', 'Strategy mo to', 'description mo to', 'measure mo to', '2017-8-30', '2017-8-31', '{"In charge si acoe"}', 1, 1, false, 69.699);

TRUNCATE TABLE Account CASCADE;
INSERT INTO Account (email, idNumber, password, firstname, middlename, lastname, contactNumber)
             VALUES ('juliano_laguio@dlsu.edu.ph', 11445955, '1234', 'Lian', 'Blanco', 'Laguio', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, dateCreated, dateModified)
             VALUES ('markus_flores@dlsu.edu.ph', 11445955, '1234', 'Markus', 'Flores', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber)
             VALUES ('dominique_dagunton@dlsu.edu.ph', 11445955, '1234', 'Dominique', 'Dagunton', '+63 9228474849');
INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber)
             VALUES ('neil_capistrano@dlsu.edu.ph', 11445955, '1234', 'Neil', 'Capistrano', '+63 9228474849');