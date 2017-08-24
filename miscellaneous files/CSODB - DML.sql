TRUNCATE TABLE SchoolYear CASCADE;
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (1, 2014, 2015);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (2, 2015, 2016);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (3, 2016, 2017);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (4, 2017, 2018);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (5, 2018, 2019);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (6, 2019, 2020);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (7, 2020, 2021);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (8, 2021, 2022);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (9, 2022, 2023);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (10, 2023, 2024);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (11, 2024, 2025);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (12, 2025, 2026);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (13, 2026, 2027);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (14, 2027, 2028);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (15, 2028, 2029);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (16, 2029, 2030);
INSERT INTO SchoolYear (id, endYear, startYear)
                VALUES (17, 2030, 2031);

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