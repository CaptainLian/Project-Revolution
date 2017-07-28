INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('CED', 'BAGCED', 'Br. Andrew Gonzalez FSC College of Education');
INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('CCS', NULL, 'College of Computer Studies');
INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('COL', NULL, 'College of Law');
INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('CLA', NULL, 'College of Liberal Arts');
INSERT INTO college (shortAcronym, fullAcronym, name) 
             VALUES ('COS', null, 'College of Science');
INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('COE', 'GCOE', 'Gokongwei College of Engineering');
INSERT INTO college (shortAcronym, fullAcronym, name) 
             VALUES ('COB', 'RVRCOB', 'Ramon V. del Rosario College of Business');
INSERT INTO college (shortAcronym, fullAcronym, name)
             VALUES ('SOE', null, 'School of Economics');

INSERT INTO organization(acronym, name)
                 VALUES ('PROF', 'Accredited Professional');
INSERT INTO organization(acronym, name)
                 VALUES ('SPIN', 'Special Interest');
INSERT INTO organization(acronym, name)
                 VALUES ('SCORE', 'Socio-civic and Religious');
                 
INSERT INTO studentOrganization(acronym, name, college)
                 VALUES ('LSCS', 'La Salle Computer Society', 'CCS');
  
SELECT *
  FROM organization;