DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
DROP EXTENSION IF EXISTS "pgcrypto" CASCADE;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE OR REPLACE FUNCTION trigger_auto_reject()
RETURNS trigger AS
$trigger$
    BEGIN
        RETURN NULL;
    END;
$trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_auto_reject()
RETURNS trigger AS
$trigger$
    BEGIN
        RETURN NULL;
    END;
$trigger$ LANGUAGE plpgsql;

/*
    Helpful functions
*/
CREATE OR REPLACE FUNCTION system_get_current_term_id()
RETURNS INTEGER AS
$function$
    DECLARE
        termID INTEGER;
    BEGIN
        SELECT id INTO termID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN termID;
    END;
$function$ STABLE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION system_get_current_year_id()
RETURNS INTEGER AS
$function$
    DECLARE
        yearID INTEGER;
    BEGIN
        SELECT schoolYearID INTO yearID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN yearID;
    END;
$function$ STABLE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION organization_get_highest_role_id(organization INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT id INTO roleID
          FROM OrganizationRole
         WHERE masterRole IS NULL
         ORDER BY sequence ASC
         LIMIT 1;

        RETURN roleID;
    END;
$function$ STABLE LANGUAGE plpgsql;
/*
    Helpful functions end
*/

DROP TABLE IF EXISTS AccountType CASCADE;
CREATE TABLE AccountType (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
INSERT INTO AccountType(id, name)
VALUES (0, 'Admin'),
       (1, 'Student Account'),
       (2, 'Faculty Adviser Account'),
       (3, 'SLIFE Account'),
       (4, 'Accounting Account');

DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
    idNumber INTEGER,
    email VARCHAR(255) NULL UNIQUE,
    type SMALLINT REFERENCES AccountType(id),
    password CHAR(60) NOT NULL,
    salt CHAR(29),
    firstname VARCHAR(45),
    middlename VARCHAR(45),
    lastname VARCHAR(45),
    contactNumber VARCHAR(16),
    privatekey TEXT,
    publickey TEXT,
    path_profilePicture TEXT,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateModified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idNumber)
);
    /* Account Table Triggers */
CREATE OR REPLACE FUNCTION trigger_before_insert_Account()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

        NEW.dateCreated = CURRENT_TIMESTAMP;
        NEW.dateModified = NEW.dateCreated;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Account
    BEFORE INSERT ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Account();

CREATE OR REPLACE FUNCTION trigger_before_update_Account()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;
        NEW.dateModified = CURRENT_TIMESTAMP;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_Account
    BEFORE UPDATE ON Account
    FOR EACH ROW WHEN (crypt(NEW.password, OLD.salt) <> OLD.password)
    EXECUTE PROCEDURE trigger_before_update_Account();

CREATE OR REPLACE FUNCTION trigger_before_update_Account2()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.dateModified = CURRENT_TIMESTAMP;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_Account2
BEFORE UPDATE ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_update_Account2();
    /* Account Table Triggers End */

DROP TABLE IF EXISTS SchoolYear CASCADE;
CREATE TABLE SchoolYear (
    id INTEGER UNIQUE,
    startYear INTEGER,
    endYear INTEGER,

    PRIMARY KEY (startYear, endYear),
    CONSTRAINT start_end_year_value CHECK(startYear < endYear)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_SchoolYear()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id := (NEW.startYear*10000) + NEW.endYear;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_SchoolYear
    BEFORE INSERT ON SchoolYear
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_SchoolYear();

DROP TABLE IF EXISTS Term CASCADE;
CREATE TABLE Term (
    id SERIAL UNIQUE,
    schoolYearID INTEGER REFERENCES SchoolYear(id),
    number INTEGER,
    dateStart DATE NOT NULL,
    dateEnd DATE NOT NULL,

    PRIMARY KEY (schoolYearID, number),
    CONSTRAINT number_min_value CHECK(number >= 1),
    CONSTRAINT number_max_value CHECK(number <= 3),
    CONSTRAINT date_start_end_value CHECK (dateStart <= dateEnd)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_Term()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id := (NEW.schoolYearID*10) + NEW.number;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Term
    BEFORE INSERT ON Term
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Term();

/* REFERENCE TABLES DATA */
/* 2015 - 2016 */
INSERT INTO SchoolYear(startYear, endYear)
               VALUES (2015, 2016);
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

DROP TABLE IF EXISTS College CASCADE;
CREATE TABLE College (
    shortAcronym CHAR(3),
    fullAcronym VARCHAR(20),
    name VARCHAR(60),

    PRIMARY KEY (shortAcronym)
);
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

DROP TABLE IF EXISTS ActivityType CASCADE;
CREATE TABLE ActivityType (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO ActivityType (id, name)
VALUES (0, 'Competition'),
       (1, 'Distribution'),
       (2, 'General Assembly'),
       (3, 'Seminar/Workshop'),
       (4, 'Publicity/Awareness Campaign'),
       (5, 'Meetings'),
       (6, 'Spiritual Activity'),
       (7, 'Recruitment/Audition'),
       (8, 'Recreation'),
       (9, 'Others');

/* Activity Requirements */
DROP TABLE IF EXISTS DocumentAttachmentRequirement CASCADE;
CREATE TABLE DocumentAttachmentRequirement (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY(id)
);
INSERT INTO DocumentAttachmentRequirement (id, name)
VALUES (0, 'Mechanics'),
       (1, 'Letter for use of Different Venues in Campus'),
       (2, 'Sample Design'),
       (3, 'Venue Reservation Ticket'),
       (4, 'Credentials of Speaker'),
       (5, 'Sample Publicity'),
       (6, 'Agenda'),
       (7, 'LSPO Form'),
       (8, 'Sample Application Form');

DROP TABLE IF EXISTS ActivityAttachmentRequirement CASCADE;
CREATE TABLE ActivityAttachmentRequirement (
    id SERIAL,
    activityType INTEGER REFERENCES ActivityType(id),
    attachment SMALLINT REFERENCES DocumentAttachmentRequirement(id),
    optional BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (activityType, attachment)
);
DROP TABLE IF EXISTS PreActivityAttachmentRequirement CASCADE;
CREATE TABLE PreActivityAttachmentRequirement (

    PRIMARY KEY (activityType, attachment),
    CONSTRAINT PreActivityAttachmentRequirement_ActivityType_fkey FOREIGN KEY (activityType) REFERENCES ActivityType(id),
    CONSTRAINT PreActivityAttachmentRequirement_DocumentAttachmentRequirement_fkey FOREIGN KEY (attachment) REFERENCES DocumentAttachmentRequirement(id)
) INHERITS (ActivityAttachmentRequirement);
INSERT INTO PreActivityAttachmentRequirement (activityType, attachment, optional)
VALUES (0, 0, FALSE),
       (0, 1, FALSE),
       (1, 2, FALSE),
       (2, 3, FALSE),
       (3, 4, FALSE),
       (4, 3, FALSE),
       (4, 5, FALSE),
       (5, 3, FALSE),
       (5, 6, FALSE),
       (6, 3, FALSE),
       (6, 7, TRUE),
       (7, 3, FALSE),
       (7, 8, FALSE),
       (7, 0, FALSE),
       (8, 3, FALSE),
       (9, 3, FALSE);

DROP TABLE IF EXISTS PostActivityAttachmentRequirement CASCADE;
CREATE TABLE PostActivityAttachmentRequirement (

    PRIMARY KEY (activityType, attachment),
    CONSTRAINT PostActivityAttachmentRequirement_ActivityType_fkey FOREIGN KEY (activityType) REFERENCES ActivityType(id),
    CONSTRAINT PostActivityAttachmentRequirement_DocumentAttachmentRequirement_fkey FOREIGN KEY (attachment) REFERENCES DocumentAttachmentRequirement(id)
) INHERITS (ActivityAttachmentRequirement);
/* Activity Requirements End */

DROP TABLE IF EXISTS ActivityNature CASCADE;
CREATE TABLE ActivityNature (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
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

/* Organizations */
/*
DROP SEQUENCE IF EXISTS organization_id_sequence;
CREATE SEQUENCE organization_id_sequence INCREMENT BY 1
MINVALUE 0 NO MAXVALUE START WITH 0 NO CYCLE;
*/
DROP TABLE IF EXISTS OrganizationNature CASCADE;
CREATE TABLE OrganizationNature (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,
    acronym VARCHAR(10),

    PRIMARY KEY(id)
);
INSERT INTO OrganizationNature (id, name, acronym)
                         VALUES (1, 'Special Interest', 'SPIN'),
                                (2, 'Professional Organization', 'PROF'),
                                (3, 'Socio-civic and Religious', 'SCORE'),
                                (4, 'Professional Organization Group', 'PROG');

DROP TABLE IF EXISTS OrganizationCluster CASCADE;
CREATE TABLE OrganizationCluster (
    id SMALLINT,
    name VARCHAR(128) NOT NULL,
    acronym VARCHAR(20),

    PRIMARY KEY(id)
);
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (1, 'Alliance of Science Organizations', 'ASO'),
                                (2, 'Alliance of Special Interest and Socio-Civic Organizations', 'ASPIRE'),
                                (3, 'College of Liberal Arts Professional Organizations', 'CAP12'),
                                (4, 'Engineering Alliance Geared Towards Excellence', 'ENGAGE'),
                                (5, 'Alliance of Professional Organizations of Business and Economics', 'PROBE');

DROP TABLE IF EXISTS StudentOrganization CASCADE;
CREATE TABLE StudentOrganization (
    id SERIAL,
    name VARCHAR(128),
    cluster SMALLINT REFERENCES OrganizationCluster(id),
    nature SMALLINT REFERENCES OrganizationNature(id),
    college CHAR(3) REFERENCES College(shortAcronym),
    acronym VARCHAR(20) UNIQUE,
    description TEXT,
    funds NUMERIC(16, 4) DEFAULT 0.0,
    facultyAdviser INTEGER REFERENCES Account(idNumber),
    picture_path TEXT,

    PRIMARY KEY (id)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_StudentOrganization()
RETURNS trigger AS
$trigger$
    DECLARE
      newSequence INTEGER;
    BEGIN
        NEW.id = 0;

        IF NEW.nature IS NOT NULL THEN
          NEW.id = NEW.nature*1000;
        END IF;

        SELECT COALESCE(MAX(id%1000) + 1, 0) INTO newSequence
          FROM StudentOrganization;

        NEW.id = NEW.id + newSequence;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_StudentOrganization
    BEFORE INSERT ON StudentOrganization
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_StudentOrganization();

CREATE OR REPLACE FUNCTION trigger_after_update_StudentOrganization_nature()
RETURNS trigger AS
$trigger$
    DECLARE
      newID INTEGER DEFAULT 0;
    BEGIN
      IF NEW.nature IS NOT NULL THEN
        newID = NEW.nature*1000;
      END IF;

      newID = newID + (OLD.id%1000);

      UPDATE StudentOrganization
         SET id = newID
       WHERE id = OLD.id;
      NEW.id = newID;
      RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_update_StudentOrganization_nature
    AFTER UPDATE ON StudentOrganization
    FOR EACH ROW WHEN ((OLD.nature <> NEW.nature) OR (OLD.nature IS NULL))
    EXECUTE PROCEDURE trigger_after_update_StudentOrganization_nature();

INSERT INTO StudentOrganization (id, acronym, name, description)
                         VALUES (0, 'CSO', 'Council of Student Organizations', NULL);


DROP TABLE IF EXISTS OrganizationFacultyAdviser CASCADE;
CREATE TABLE OrganizationFacultyAdviser (
    id SERIAL NOT NULL UNIQUE,
    organization INTEGER REFERENCES StudentOrganization(id),
    adviser INTEGER REFERENCES Account(idNumber),
	yearID INTEGER REFERENCES SchoolYear(id),

	PRIMARY KEY(organization, adviser, yearID)
);
    /* Organization Structure */
DROP TABLE IF EXISTS OrganizationRole CASCADE;
CREATE TABLE OrganizationRole (
	id INTEGER UNIQUE DEFAULT - 1,
	organization INTEGER REFERENCES StudentOrganization(id) ON UPDATE CASCADE,
	sequence INTEGER DEFAULT -1,
	name VARCHAR(100),
	rank INTEGER,
	uniquePosition BOOLEAN NOT NULL DEFAULT FALSE,
	masterRole INTEGER REFERENCES OrganizationRole(id) ON DELETE CASCADE ON UPDATE CASCADE,

	PRIMARY KEY (organization, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_OrganizationRole()
RETURNS trigger AS
$trigger$
    DECLARE
      newSequence INTEGER DEFAULT 0;
    BEGIN
      SELECT COALESCE(MAX(id%10000) + 1, 0) INTO newSequence
        FROM OrganizationRole;

      NEW.id = (NEW.organization%1000)*10000 + newSequence;

      SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
        FROM OrganizationRole
      WHERE organization = NEW.organization;
      return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_OrganizationRole
    BEFORE INSERT ON OrganizationRole
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_OrganizationRole();
-- 1
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Chairperson', TRUE, NULL);
-- 2
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Executive Vice Chairperson for Internals', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 0));
-- 3
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Executive Vice Chairperson for Externals', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 1));
-- 4
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Executive Vice Chairperson for Activities and Documentation', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 1));
-- 5
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Executive Vice Chairperson for Finance', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 1));
-- 6
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Activity Documentations and Management', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 7
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Activity Documentations and Management', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 6));
-- 8
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate for Activity Documentations and Management', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 7));
-- 9
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Activity Monitoring Team', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 10
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Activity Monitoring Team', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 10));
-- 11
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate for Activity Monitoring Team', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 11));
-- 12
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Activity Processing and Screening', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 13
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Activity Processing and Screening', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 13));
-- 14
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Activity Processing and Screening', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 13));
-- 15
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Finance', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 16
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Finance', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 15));
-- 17
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate for Finance', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 16));
-- 18
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Publicity and Productions', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 19
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Publicity and Productions', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 18));
-- 20
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate for Publicity and Productions', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 19));
-- 21
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Vice Chairperson for Organizational Research and Analysis', TRUE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 3));
-- 22
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate Vice Chairperson for Organizational Research and Analysis', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 23));
-- 23
INSERT INTO OrganizationRole (organization, name, uniquePosition, masterRole)
                      VALUES (           0, 'Associate for Organizational Research and Analysis', FALSE, (SELECT id FROM OrganizationRole WHERE organization = 0 AND sequence = 23));

/* Organization Default Structure */
CREATE OR REPLACE FUNCTION trigger_after_insert_StudentOrganization()
RETURNS trigger AS
$trigger$
    DECLARE
        presidentRoleID INTEGER;
        executiveSecretariatRoleID INTEGER;
        -- Internal Executive Vice President
        ievpRoleID INTEGER;
    BEGIN
        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'President', TRUE, NULL)
        RETURNING id INTO presidentRoleID;

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Executive Secretariat', TRUE, presidentRoleID)
        RETURNING id INTO executiveSecretariatRoleID;

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'External Executive Vice President', TRUE, presidentRoleID);
        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Internal Executive Vice President', TRUE, presidentRoleID)
        RETURNING id INTO ievpRoleID;

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Vice President of Documentations', TRUE, executiveSecretariatRoleID);
        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Associate Vice President of Documentations', FALSE, executiveSecretariatRoleID);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Vice President of Finance', TRUE, ievpRoleID);
        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole)
                             VALUES (NEW.id, 'Associate Vice President of Finance', FALSE, ievpRoleID);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_insert_StudentOrganization
    AFTER INSERT ON StudentOrganization
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_after_insert_StudentOrganization();

DROP TABLE IF EXISTS OrganizationOfficer CASCADE;
CREATE TABLE OrganizationOfficer (
	idNumber INTEGER REFERENCES Account(idNumber),
	role INTEGER REFERENCES OrganizationRole(id),
	yearID INTEGER,
	dateAssigned TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY(idNumber, role, yearID)
);

    /* Organization Structure End */
	/* Access Control*/
DROP TABLE IF EXISTS FunctionalityDomain CASCADE;
CREATE TABLE FunctionalityDomain (
  id SMALLINT,
  name VARCHAR(45),

  PRIMARY KEY (id)
);
INSERT INTO FunctionalityDomain (id, name)
                         VALUES (0, 'Admin'),
                                (1, 'CSO'),
                                (2, 'Organization'),
                                (3, 'Faculty Adviser'),
                                (4, 'SLIFE'),
                                (5, 'Accouning');

DROP TABLE IF EXISTS FunctionalityCategory CASCADE;
CREATE TABLE FunctionalityCategory (
  id SMALLINT,
  name VARCHAR(45),
  domain SMALLINT REFERENCES FunctionalityDomain (id),

  PRIMARY KEY (id)
);
INSERT INTO FunctionalityCategory (id, name, domain)
                           VALUES (0,  'Website Configuration', 0),
                                  (1,  'Organization Structure Management', 0),
                                  (2,  'Account Management', 0),
                                  (3,  'Manage Organizations List', 0),
                                  -- CSO
                                  (4,  'Activity Processing', 1),
                                  (5,  'Finance', 1),
                                  (6,  'Publicity and Publications', 1),
                                  (7,  'Activity Monitoring', 1),
                                  (8,  'Activity Documentation', 1),
                                  (9,  'Organizational Research', 1),
                                  -- Student Organization
                                  (10,  'Publicity/Creatives/Publications', 2),
                                  (11, 'Activity Processiong & Documentations', 2),
                                  (12, 'Submit Financial Documents', 2),
                                  (13, 'Cancel Financial Documents', 2),
                                  (14, 'Organization Management', 2);

DROP TABLE IF EXISTS Functionality CASCADE;
CREATE TABLE Functionality (
	id SMALLINT,
	name VARCHAR (100),
  category SMALLINT REFERENCES FunctionalityCategory (id),

  PRIMARY KEY (id)
);
INSERT INTO Functionality (id, name, category)
                   VALUES (0, 'Time Setting', 0),

                          (1, 'Create Position', 1),
                          (2, 'Edit Position', 1),
                          (3, 'Assign Position', 1),
                          (4, 'Delete Position', 1),
                          (5, 'View Orgaizational Structure', 1),

                          (6, 'Create Organization', 2),
                          (7, 'Edit Organization', 2),
                          (8, 'Delete Organization', 2),
                          (9, 'Assign Evaluator for Publicity Material', 2),
                          (10, 'Evaluate Publicity Material', 6),
                          (11, 'View Publicity Material', 6),

                          -- APS
                          -- Approve, pend, deny
                          (12, 'Evaluate GOSM Activity', 4),
                          -- Approve, pend, deny
                          (13, 'Evaluate Project Proposal', 4),

                          (14, 'Set Organization Treasury Funds', 5),
                          (15, 'Evaluate Financial Documents', 5),
                          (16, 'View Financial Documents', 5),
                          (17, 'View Financial Documents Log', 5),

                          (18, 'View Organization Members', 9),
                          (19, 'View Organizational Struture', 9),
                          (20, 'Survey Results', 9),
                          (21, 'Activity Research Form', 9),

                          (22, 'Assign Evaluator for Activity', 7),
                          (23, 'Evaluate During-Activity', 7),
                          (24, 'View During-Activities to be Evaluated', 7),

                          (25, 'Evaluate Post-Activity', 8),

                          (26, 'Submit Publicity Material', 9),
                          (27, 'Resubmit Publicity Material', 9),
                          (28, 'View Publicity Material', 9),

                          -- Organization Side
                          (29, 'Submit GOSM', 10),
                          (30, 'Resubmit GOSM', 10),
                          (31, 'View GOSM', 10),
                          (32, 'Submit Project Proposal', 10),
                          (33, 'Resubmit Project Proposal', 10),
                          (34, 'View Project Proposal', 10),
                          (35, 'Submit Post-Activity Documents', 10),
                          (36, 'View Post-Activity Documents', 10),

                          (37, 'Request Cash Advance', 12),
                          (38, 'Request Direct Payment', 12),
                          (39, 'Request Book Transfer', 12),
                          (40, 'Request Petty Cash Replenishment', 12),
                          (41, 'Request Reimbursement', 12),
                          (42, 'Request for Petty Cash Turnover', 12),
                          (43, 'Request for Turnover of funds', 12),
                          (44, 'Request for Financial Documents', 12),
                          (45, 'Submit gas expense', 12),

                          (46, 'Cancel Request Cash Advance', 1),
                          (47, 'Cancel Request Direct Payment', 1),
                          (48, 'Cancel Book Transfer', 1),
                          (49, 'Cancel Request Petty Cash Replenishment', 1),
                          (50, 'Cancel Request Reimbursement', 1),
                          (51, 'Request for Cancellation of check', 1),
                          (52, 'Request for Change of Payee', 1),
                          (53, 'Request for Establishment of Petty Cash', 1),

                          (54, 'Create Position', 13),
                          (55, 'Edit Position', 13),
                          (56, 'Assign Position', 13),
                          (57, 'Delete Position', 13);

DROP TABLE IF EXISTS OrganizationAccessControl CASCADE;
CREATE TABLE OrganizationAccessControl (
	role INTEGER REFERENCES OrganizationRole (id),
	functionality SMALLINT REFERENCES Functionality (id),
	isAllowed BOOLEAN NOT NULL DEFAULT FALSE,

	PRIMARY KEY (role, functionality)
);
/*
INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                               VALUES -- Assign Evaluator for Publicity Material
                                      (  18,            22,      TRUE),
                                      -- Evaluate Publicity Material
                                      (  15,            10,      TRUE),
                                      (  16,            10,      TRUE),
                                      -- View Publicity Material
                                      (  18,            28,      TRUE),
                                      (  19,            28,      TRUE),
                                      (  20,            28,      TRUE),
                                      -- View Organization Members
                                      (  21,            18,      TRUE),
                                      (  22,            18,      TRUE),
                                      -- Survey Results
                                      (  21,            20,      TRUE),
                                      (  22,            20,      TRUE),
                                      -- Activity Research Form
                                      (  21,            21,      TRUE),
                                      (  22,            21,      TRUE),
                                      -- Evaluate During-Activity
                                      (  11,            25,      TRUE),
                                      (  22,            25,      TRUE),
                                      (  23,            25,      TRUE),
                                      -- View Activities to be Evaluated
                                      (   9,            24,      TRUE),
                                      (  10,            24,      TRUE),
                                      (  11,            24,      TRUE),
                                      -- Set Organization Treasury Funds
                                      (   6,            14,      TRUE),
                                      -- Evaluate Project Proposal
                                      (  12,            13,      TRUE),
                                      (  13,            13,      TRUE),
                                      (  14,            13,      TRUE),
                                      -- View Organization Structure
                                      (   1,            19,      TRUE),
                                      (   2,            19,      TRUE),
                                      (   3,            19,      TRUE),
                                      (   4,            19,      TRUE),
                                      (   5,            19,      TRUE),
                                      (   6,            19,      TRUE),
                                      (   7,            19,      TRUE),
                                      (   8,            19,      TRUE),
                                      (   9,            19,      TRUE),
                                      (  10,            19,      TRUE),
                                      (  11,            19,      TRUE),
                                      (  12,            19,      TRUE),
                                      (  13,            19,      TRUE),
                                      (  14,            19,      TRUE),
                                      (  15,            19,      TRUE),
                                      (  16,            19,      TRUE),
                                      (  17,            19,      TRUE),
                                      (  18,            19,      TRUE),
                                      (  19,            19,      TRUE),
                                      (  20,            19,      TRUE),
                                      (  21,            19,      TRUE),
                                      (  22,            19,      TRUE),
                                      (  23,            19,      TRUE),
                                      -- View Financial Documents
                                      (  12,            16,      TRUE),
                                      (  13,            16,      TRUE),
                                      (  14,            16,      TRUE),
                                      (   5,            16,      TRUE),
                                      (  15,            16,      TRUE),
                                      (  16,            16,      TRUE),
                                      (  17,            16,      TRUE),
                                      (   6,            16,      TRUE),
                                      (   7,            16,      TRUE),
                                      (   8,            16,      TRUE),
                                      -- View Financial Documents Log
                                      (  15,            17,      TRUE),
                                      -- Evaluate GOSM Activity
                                      (   1,            12,      TRUE),
                                      (   2,            12,      TRUE),
                                      (   3,            12,      TRUE),
                                      (   4,            12,      TRUE),
                                      (   5,            12,      TRUE);
                                      */
	/* Access Control end */

-- FORMS
    /* GOSM RELATED*/
DROP TABLE IF EXISTS GOSMStatus CASCADE;
CREATE TABLE GOSMStatus (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
INSERT INTO GOSMStatus (id, name)
                VALUES (1, 'Created'),
                       (2, 'For Approval'),
                       (3, 'Approved'),
                       (4, 'Pending'),
                       (5, 'Denied');

DROP TABLE IF EXISTS GOSM CASCADE;
CREATE TABLE GOSM (
    id SERIAL UNIQUE,
    termID INTEGER,
    studentOrganization INTEGER REFERENCES StudentOrganization(id) ON UPDATE CASCADE,
    status SMALLINT NOT NULL REFERENCES GOSMStatus(id) DEFAULT 1,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateSubmitted TIMESTAMP WITH TIME ZONE,
    dateStatusModified TIMESTAMP WITH TIME ZONE,
    preparedBy INTEGER REFERENCES Account(idNumber),
    statusModifier INTEGER REFERENCES Account(idNumber),
    comments TEXT,

    PRIMARY KEY (termID, studentOrganization)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSM()
RETURNS trigger AS
$trigger$
    DECLARE
      newSequence INTEGER;
    BEGIN
        NEW.id := NEW.studentOrganization*100000;
        SELECT COALESCE(MAX(id%100000) + 1, 1) INTO newSequence
          FROM GOSM;
        NEW.id := NEW.id + newSequence;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_GGOSM
    BEFORE INSERT ON GOSM
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_GOSM();

CREATE OR REPLACE FUNCTION trigger_before_update_GOSM_status()
RETURNS trigger AS
$trigger$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
        END CASE;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_GOSM_status
    BEFORE UPDATE ON GOSM
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE trigger_before_update_GOSM_status();

CREATE OR REPLACE FUNCTION trigger_after_update_GOSM_studentOrganization()
RETURNS trigger AS
$trigger$
    DECLARE
      newID INTEGER DEFAULT 0;
    BEGIN
        newID = NEW.studentOrganization*100000 + (OLD.id%100000);

        UPDATE GOSM
           SET id = newID
        WHERE id = OLD.id;
        NEW.id = newID;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_update_GOSM_studentOrganization
    AFTER UPDATE ON GOSM
    FOR EACH ROW WHEN (OLD.studentOrganization <> NEW.studentOrganization)
    EXECUTE PROCEDURE trigger_after_update_GOSM_studentOrganization();

DROP TABLE IF EXISTS GOSMActivity CASCADE;
CREATE TABLE GOSMActivity (
    id SERIAL UNIQUE,
    GOSM INTEGER REFERENCES GOSM(id) ON UPDATE CASCADE,
    sequence INTEGER NOT NULL DEFAULT -1,
    goals VARCHAR(255) NOT NULL,
    objectives VARCHAR(255)[] NOT NULL,
    strategies VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    measures VARCHAR(255) NOT NULL,
    targetDateStart DATE,
    targetDateEnd DATE,
    activityNature SMALLINT REFERENCES ActivityNature(id),
    activityType SMALLINT REFERENCES ActivityType(id),
    activityTypeOtherDescription VARCHAR(45),
    isRelatedToOrganizationNature BOOLEAN NOT NULL,
    budget NUMERIC(16, 4) NOT NULL DEFAULT 0.0,
    comments TEXT,

    PRIMARY KEY (GOSM, sequence),
    CONSTRAINT targetdate_start_end_value CHECK(targetDateStart <= targetDateEnd)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSMActivity()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(id) + 1, 1) INTO STRICT NEW.sequence
          FROM GOSMActivity
         WHERE GOSM = NEW.GOSM;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_GOSMActivity
    BEFORE INSERT ON GOSMActivity
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_GOSMActivity();

DROP TABLE IF EXISTS GOSMActivityProjectHead CASCADE;
CREATE TABLE GOSMActivityProjectHead (
    idNumber INTEGER REFERENCES Account(idNumber),
    activityID INTEGER REFERENCES GOSMActivity (id),

    PRIMARY KEY (idNumber, activityID)
);
    /* END GOSM */

    /* Project Proposal */
DROP TABLE IF EXISTS VenueSize CASCADE;
CREATE TABLE VenueSize (
	id SMALLINT,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY(id)
);
INSERT INTO VenueSize (id, name)
               VALUES ( 0, 'Small'),
                      ( 1, 'Mediume'),
                      ( 2, 'Large'),
                      ( 3, 'Lian Sized');
DROP TABLE IF EXISTS RateType CASCADE;
CREATE TABLE RateType (
	id SMALLINT,
	name VARCHAR(45),

	PRIMARY KEY(id)
);
INSERT INTO RateType (id, name)
VALUES (0, 'Per hour'),
       (1, 'Per person'),
       (2, 'Per use'),
       (3, 'Per person, per use'),
       (4, 'Per Dominique');

DROP TABLE IF EXISTS Building CASCADE;
CREATE TABLE Building (
	id SMALLINT,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY(id)
);
INSERT INTO Building (id, name)
              VALUES (0, 'Markus Building');

DROP TABLE IF EXISTS ActivityVenue CASCADE;
CREATE TABLE ActivityVenue (
	id INTEGER,
	name VARCHAR (60),
	capacity INTEGER,
	size SMALLINT REFERENCES VenueSize(id),
	rate NUMERIC(16, 4),
	rateType SMALLINT REFERENCES RateType(id),
	building SMALLINT REFERENCES Building(id),

	PRIMARY KEY (id)
);
INSERT INTO ActivityVenue (id, name, capacity, size, rate, rateType, building)
                   VALUES ( 0, 'Neil Room', 12,  3, 700.43,       4,        0);

DROP TABLE IF EXISTS ProjectProposalStatus CASCADE;
CREATE TABLE ProjectProposalStatus (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (1, 'Created'),
                                  (2, 'For approval'),
                                  (3, 'Approved'),
                                  (4, 'Pending'),
                                  (5, 'Denied');

DROP TABLE IF EXISTS ProjectProposal CASCADE;
CREATE TABLE ProjectProposal (
    id SERIAL UNIQUE,
    GOSMActivity INTEGER REFERENCES GOSMActivity(id),
    status INTEGER NOT NULL REFERENCES ProjectProposalStatus(id) DEFAULT 1,
    ENP INTEGER,
    ENMP INTEGER,
    venue INTEGER REFERENCES ActivityVenue(id),
    context TEXT,
    sourceFundOther NUMERIC(16, 4),
    sourceFundParticipantFee NUMERIC(16, 4),
    sourceFundOrganizational NUMERIC(16, 4),
    accumulatedOperationalFunds NUMERIC(16, 4),
    accumulatedDepositoryFunds NUMERIC(16, 4),
    organizationFundOtherSource NUMERIC(16, 4),
    comments TEXT,
    preparedBy INTEGER REFERENCES Account(idNumber),
    dateCreated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    dateSubmitted TIMESTAMP WITH TIME ZONE,
    dateStatusModified TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (GOSMActivity)
);
CREATE OR REPLACE FUNCTION trigger_before_update_ProjectProposal()
RETURNS trigger AS
$trigger$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved, Pending, Denied */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
        END CASE;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_ProjectProposal
    BEFORE UPDATE ON ProjectProposal
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE trigger_before_update_ProjectProposal();


DROP TABLE IF EXISTS ProjectProposalProgramDesign CASCADE;
CREATE TABLE ProjectProposalProgramDesign (
    id SERIAL UNIQUE,
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    dayID INTEGER,
    date DATE,
    sequence INTEGER,
    startTime TIME WITH TIME ZONE,
    endTime TIME WITH TIME ZONE,
    activity TEXT,
    activityDescription TEXT,
    personInCharge INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (projectProposal, dayID, sequence),
    CHECK(startTime <= endTime)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProgramDesign()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal
           AND dayID = NEW.dayID;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalProgramDesign
    BEFORE INSERT ON ProjectProposalProgramDesign
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProgramDesign();

DROP TABLE IF EXISTS ProjectProposalProgramDesignPersonInCharge CASCADE;
CREATE TABLE ProjectProposalProgramDesignPersonInCharge (
    id SERIAL UNIQUE,
    programDesign INTEGER REFERENCES ProjectProposalProgramDesign(id),
    projectHead INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (programDesign, projectHead)
);



DROP TABLE IF EXISTS ProjectProposalProjectedIncome CASCADE;
CREATE TABLE ProjectProposalProjectedIncome (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    item VARCHAR(45) NOT NULL,
    quantity INTEGER NOT NULL,
    sellingPrice NUMERIC(16, 4) NOT NULL,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProjectedIncome()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProjectedIncome
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalProjectedIncome
    BEFORE INSERT ON ProjectProposalProjectedIncome
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProjectedIncome();

DROP TABLE IF EXISTS ExpenseType CASCADE;
CREATE TABLE ExpenseType (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO ExpenseType (id, name)
                 VALUES (0, 'Others'),
                        (1, 'Food & Accomodation'),
                        (2, 'Venue & Transportation'),
                        (3, 'Honorarium'),
                        (4, 'Cash Prize'),
                        (5, 'Corruption Expense');

DROP TABLE IF EXISTS ProjectProposalExpenses CASCADE;
CREATE TABLE ProjectProposalExpenses (
    id SERIAL NOT NULL UNIQUE,
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    material VARCHAR(45) NOT NULL,
    quantity INTEGER NOT NULL,
    unitCost NUMERIC(16, 4) NOT NULL,
    type SMALLINT NOT NULL REFERENCES ExpenseType(id) DEFAULT 0,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalExpenses()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalExpenses
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalExpenses
    BEFORE INSERT ON ProjectProposalExpenses
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalExpenses();


DROP TABLE IF EXISTS ProjectProposalSourceFunds CASCADE;
CREATE TABLE ProjectProposalSourceFunds (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    name VARCHAR (45),
    amount NUMERIC(16, 4),

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalSourceFunds()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalSourceFunds
    BEFORE INSERT ON ProjectProposalSourceFunds
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalSourceFunds();

DROP TABLE IF EXISTS ProjectProposalAttachment CASCADE;
CREATE TABLE ProjectProposalAttachment (
    id SERIAL UNIQUE,
    projectProposal INTEGER NOT NULL REFERENCES ProjectProposal(id),
    requirement SMALLINT NOT NULL REFERENCES DocumentAttachmentRequirement(id),
    sequence INTEGER NOT NULL DEFAULT -1,
    directory TEXT NOT NULL,

    PRIMARY KEY (projectProposal, requirement, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalAttachment()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalAttachment
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalAttachment
    BEFORE INSERT ON ProjectProposalAttachment
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalAttachment();

DROP TABLE IF EXISTS SignatoryType CASCADE;
CREATE TABLE SignatoryType (
	id SMALLINT,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY (id)
);
INSERT INTO SignatoryType (id, name)
                   VALUES ( 0, 'Project Head'),
                   		  ( 1, 'Treasurer/Finance Officer'),
                   		  ( 2, 'Immediate Superior'),
                   		  ( 3, 'President'),
                   		  ( 4, 'Faculty Adviser'),
                          ( 5, 'Documentation Officer');

DROP TABLE IF EXISTS ProjectProposalSignatory CASCADE;
CREATE TABLE ProjectProposalSignatory (
	GOSMActivity INTEGER REFERENCES ProjectProposal(GOSMActivity),
    sequence INTEGER DEFAULT -1,
	signatory INTEGER,
	type SMALLINT NOT NULL REFERENCES SignatoryType(id),
	document JSONB,
	digitalSignature TEXT,
	dateSigned TIMESTAMP WITH TIME ZONE,

	PRIMARY KEY(GOSMActivity, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalSignatory_sequence()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 0) INTO NEW.sequence
          FROM ProjectProposalSignatory
         WHERE GOSMActivity = NEW.GOSMActivity;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalSignatory_sequence
    BEFORE INSERT ON ProjectProposalSignatory
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalSignatory_sequence();

CREATE OR REPLACE FUNCTION trigger_after_insert_ProjectProposal_signatories()
RETURNS trigger AS
$trigger$
    DECLARE
        organizationPresident INTEGER;
    BEGIN
        -- ALL PROJECT HEADS
        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             SELECT NEW.GOSMActivity, idNumber, 0
               FROM GOSMActivityProjectHead
              WHERE activityID = NEW.GOSMActivity;

        -- TREASURER
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 1);

        -- Immediate Superior of who prepared the PPR
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 1);

         -- Organization President
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 2);

        -- Organization President
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 3);

        -- Faculty Adviser
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 4);

         -- Documentation Officer
        INSERT INTO ProjectProposalSignatory (GOSMActivity, type)
             VALUES (NEW.GOSMActivity, 5);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_insert_ProjectProposal_signatories
    AFTER INSERT ON ProjectProposal
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_after_insert_ProjectProposal_signatories();
    /* End Project Proposal */
    /* END SPECIAL APPROVAL SLIP */
/* Organization Treasurer */
DROP TABLE IF EXISTS ActivityTransaction CASCADE;
CREATE TABLE ActivityTransaction (
    GOSMActivity INTEGER,
    PRS INTEGER,
    reason TEXT,

    PRIMARY KEY (GOSMActivity)
);
DROP TABLE IF EXISTS InformalQuotation CASCADE;
CREATE TABLE InformalQuotation (
    GOSMActivity INTEGER REFERENCES ActivityTransaction(GOSMActivity),
    expense INTEGER REFERENCES ProjectProposalExpenses(id),
    contactPerson VARCHAR(60),
    contactDetails VARCHAR(45),

    PRIMARY KEY(GOSMActivity, expense)
);
/* Organization Treasurer */
    /* AMTActivityEvaluation */
DROP TABLE IF EXISTS AMTActivityEvaluation CASCADE;
CREATE TABLE AMTActivityEvaluation (
  activity INTEGER REFERENCES ProjectProposal (GOSMActivity),
  venue SMALLINT NOT NULL,
  equipment SMALLINT NOT NULL,
  materials SMALLINT NOT NULL,
  registration SMALLINT NOT NULL,
  timeEnd SMALLINT NOT NULL,
  activityExecutionA SMALLINT NOT NULL,
  activityExecutionB SMALLINT NOT NULL,
  hosts SMALLINT NOT NULL,
  facilitators SMALLINT NOT NULL,
  presentation SMALLINT NOT NULL,
  activities SMALLINT NOT NULL,
  organizationStandingPresentation SMALLINT NOT NULL,
  actualStartTime TIME WITH TIME ZONE NOT NULL,
  actualEndTime TIME WITH TIME ZONE NOT NULL,
  ANP INTEGER NOT NULL,
  person1EA SMALLINT NOT NULL,
  person1LOA SMALLINT NOT NULL,
  person1IITSKOA SMALLINT NOT NULL,
  person1IOMWM SMALLINT NOT NULL,
  person2EA SMALLINT NOT NULL,
  person2LOA SMALLINT NOT NULL,
  person2IITSKOA SMALLINT NOT NULL,
  person2IOMWM SMALLINT NOT NULL,
  comments1 TEXT NOT NULL,
  comments2 TEXT NOT NULL,
  comments3 TEXT NOT NULL,
  suggestions1 TEXT NOT NULL,
  suggestions2 TEXT NOT NULL,
  suggestions3 TEXT NOT NULL,

  PRIMARY KEY (activity)
);
-- END FORMS
-- COMMIT;

    /* SESSION TABLE */
DROP TABLE IF EXISTS session CASCADE;
CREATE TABLE IF NOT EXISTS session (
    "sid" varchar NOT NULL COLLATE "default",
    "sess" json NOT NULL,
    "expire" timestamp(6) NOT NULL,

    PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS=FALSE);
