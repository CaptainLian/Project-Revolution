-- START TRANSACTION;
CREATE OR REPLACE FUNCTION array_remove_element_index(anyarray, int)
RETURNS anyarray IMMUTABLE AS
    'SELECT $1[:$2-1] || $1[$2+1:]' LANGUAGE SQL;

/*
CREATE OR REPLACE FUNCTION array_element_contain_null(anyarray)
RETURNS boolean IMMUTABLE AS 
$$
    DECLARE
        elem any;
    BEGIN
        FOREACH elem IN ARRAY $1
        LOOP
            IF elem IS NULL THEN
                return true;
            END IF;
        END LOOP;
        RETURN false;
    END;
$$ LANGUAGE 'plpgsql';
*/

DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS "pgcrypto";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS Term CASCADE;
CREATE TABLE Term (
    id SERIAL UNIQUE,
    startYear INTEGER,
    endYear INTEGER,
    number INTEGER,
    dateStart DATE NOT NULL,
    dateEnd DATE NOT NULL,
    

    PRIMARY KEY (startYear, endYear, number),
    CONSTRAINT number_min_value CHECK(number >= 1),
    CONSTRAINT number_max_value CHECK(number <= 3),
    CONSTRAINT start_end_year_value CHECK(startYear < endYear),
    CONSTRAINT date_start_end_value CHECK (dateStart <= dateEnd)
);

DROP TABLE IF EXISTS College CASCADE;
CREATE TABLE College (
    shortAcronym CHAR(3),
    fullAcronym VARCHAR(20),
    name VARCHAR(60),

    PRIMARY KEY (shortAcronym)
);

DROP TABLE IF EXISTS ActivityType CASCADE;
CREATE TABLE ActivityType (
	id INTEGER,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS ActivityNature CASCADE;
CREATE TABLE ActivityNature (
    id INTEGER,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);

/* Organizations */
DROP SEQUENCE IF EXISTS organization_id_sequence;
CREATE SEQUENCE organization_id_sequence INCREMENT BY 1
MINVALUE 0 NO MAXVALUE START WITH 0 NO CYCLE;

DROP TABLE IF EXISTS OrganizationNature CASCADE;
CREATE TABLE OrganizationNature (
    id INTEGER,
    name VARCHAR(45) NOT NULL,
    acronym VARCHAR(10),

    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS OrganizationCluster CASCADE;
CREATE TABLE OrganizationCluster (
    id INTEGER,
    name VARCHAR(128) NOT NULL,
    acronym VARCHAR(20),

    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS StudentOrganization CASCADE;
CREATE TABLE StudentOrganization (
    id SERIAL,
    name VARCHAR(128),
    cluster INTEGER REFERENCES OrganizationCluster(id),
    nature INTEGER REFERENCES OrganizationNature(id),
    college CHAR(3) REFERENCES College(shortAcronym),
    acronym VARCHAR(20) UNIQUE,
    description TEXT,

    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
    email VARCHAR(255),
    idNumber INTEGER NULL UNIQUE,
    password CHAR(60) NOT NULL,
    salt CHAR(29),
    firstname VARCHAR(45),
    middlename VARCHAR(45),
    lastname VARCHAR(45),
    contactNumber VARCHAR(16),
    privatekey TEXT,
    publickey TEXT,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateModified TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (email)
);
    /* Account Table Triggers */
CREATE OR REPLACE FUNCTION trigger_before_insert_Account()
RETURNS trigger AS
$trigger_before_insert_Account$
    DECLARE 
        salt CHAR(29);
    BEGIN
        SELECT gen_salt('bf') INTO salt;
        NEW.salt = salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

        NEW.dateCreated = CURRENT_TIMESTAMP;
        NEW.dateModified = NEW.dateCreated;
        return NEW;
    END;
$trigger_before_insert_Account$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Account
    BEFORE INSERT ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Account();

CREATE OR REPLACE FUNCTION trigger_before_update_Account()
RETURNS trigger AS
$trigger_before_update_Account$
    DECLARE 
        salt CHAR(29);
    BEGIN
        SELECT gen_salt('bf') INTO salt;
        NEW.salt = salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;
        NEW.dateModified = CURRENT_TIMESTAMP;
        return NEW;
    END;
$trigger_before_update_Account$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_Account
    BEFORE UPDATE ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_update_Account();
    /* Account Table Triggers End */

    /* Organization Structure */
DROP TABLE IF EXISTS OrganizationPosition CASCADE;
CREATE TABLE OrganizationPosition (
    id INTEGER,
    name VARCHAR(45),

    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS OrganizationOfficer CASCADE;
CREATE TABLE OrganizationOfficer (
    organization INTEGER REFERENCES StudentOrganization(id),
    officerID INTEGER REFERENCES Account(idNumber),
    position INTEGER REFERENCES OrganizationPosition(id),
    dateAssigned TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    

    PRIMARY KEY (organization, officerID)
);
-- FORMS
	/* GOSM RELATED*/
DROP TABLE IF EXISTS GOSMStatus CASCADE;
CREATE TABLE GOSMStatus (
    id INTEGER,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
DROP TABLE IF EXISTS GOSM CASCADE;
CREATE TABLE GOSM (
    id SERIAL UNIQUE,
    termID INTEGER,
    studentOrganization INTEGER REFERENCES StudentOrganization(id),
    status INTEGER NOT NULL REFERENCES GOSMStatus(id) DEFAULT 1,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateSubmitted TIMESTAMP WITH TIME ZONE,
    dateRejected TIMESTAMP WITH TIME ZONE,
    dateAccepted TIMESTAMP WITH TIME ZONE,
    datePended TIMESTAMP WITH TIME ZONE,
    comments TEXT,

    PRIMARY KEY (termID, studentOrganization)
);

DROP TABLE IF EXISTS GOSMActivities CASCADE;
CREATE TABLE GOSMActivities (
    id SERIAL UNIQUE,
    GOSM INTEGER,
    sequence INTEGER REFERENCES GOSM(id) DEFAULT -1,
    goals VARCHAR(45) NOT NULL,
    objectives VARCHAR(45)[] NOT NULL,
    strategies VARCHAR(45) NOT NULL,
    description VARCHAR(255) NOT NULL,
    measures VARCHAR(45) NOT NULL,
    targetDateStart DATE,
    targetDateEnd DATE,
    peopleInCharge VARCHAR(60)[] NOT NULL,
    activityNature INTEGER REFERENCES ActivityNature(id),
    activityType INTEGER REFERENCES ActivityType(id),
    activityTypeOtherDescription VARCHAR(45) NULL,
    isRelatedToOrganizationNature BOOLEAN NOT NULL,
    budget NUMERIC(16, 4) NOT NULL,
    comments TEXT,

    PRIMARY KEY (GOSM, sequence),
    CONSTRAINT targetdate_start_end_value CHECK(targetDateStart <= targetDateEnd)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSMActivities()
RETURNS trigger AS
$trigger_before_insert_GOSMActivities$
    BEGIN
        SELECT COALESCE(MAX(id) + 1, 1) INTO STRICT NEW.sequence
          FROM GOSMActivities
         WHERE GOSM = NEW.GOSM;
        return NEW;
    END;
$trigger_before_insert_GOSMActivities$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_GOSMActivities
    BEFORE INSERT ON GOSMActivities
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_GOSMActivities();

	/* END GOSM */

	/* Project Proposal */


DROP TABLE IF EXISTS ProjectProposal CASCADE;
CREATE TABLE ProjectProposal (
    id SERIAL UNIQUE,
    GOSMActivity INTEGER REFERENCES GOSMActivities(id),
    sequence INTEGER DEFAULT -1,
    dateSubmitted TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ENP INTEGER,
    ENMP INTEGER,
    targetDate DATE,
    venue TEXT,
    contactNumber VARCHAR(16),
    accumulatedOperationalFunds NUMERIC(16, 4),
    accumulatedDepositoryFunds NUMERIC(16, 4),
    financeSignatory INTEGER REFERENCES Account(idNumber),
    preparedBy INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (GOSMActivity, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposal()
RETURNS trigger AS
$trigger_before_insert_ProjectProposal$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposal
         WHERE GOSMActivity = NEW.GOSMActivity;
        return NEW;
    END;
$trigger_before_insert_ProjectProposal$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposal
    BEFORE INSERT ON ProjectProposal
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposal();

DROP TABLE IF EXISTS ProjectProposalProgramDesign CASCADE;
CREATE TABLE ProjectProposalProgramDesign (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    startTime TIME WITH TIME ZONE,
    endTime TIME WITH TIME ZONE,
    activity TEXT,
    activityDescription TEXT,
    personInCharge VARCHAR(60)[],

    PRIMARY KEY (projectProposal, sequence),
    CHECK(startTime < endTime)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProgramDesign()
RETURNS trigger AS
$trigger_before_insert_ProjectProposalProgramDesign$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger_before_insert_ProjectProposalProgramDesign$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposal
    BEFORE INSERT ON ProjectProposalProgramDesign
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProgramDesign();


DROP TABLE IF EXISTS ProjectProposalProjectedIncome CASCADE;
CREATE TABLE ProjectProposalProjectedIncome (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    item VARCHAR(30) NOT NULL,
    quantity INTEGER NOT NULL,
    sellingPrice NUMERIC(16, 4) NOT NULL,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProjectedIncome()
RETURNS trigger AS
$trigger_before_insert_ProjectProposalProjectedIncome$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProjectedIncome
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger_before_insert_ProjectProposalProjectedIncome$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalProjectedIncome
    BEFORE INSERT ON ProjectProposalProjectedIncome
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProjectedIncome();


DROP TABLE IF EXISTS ProjectProposalExpenses CASCADE;
CREATE TABLE ProjectProposalExpenses (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    material VARCHAR(30) NOT NULL,
    quantity INTEGER NOT NULL,
    unitCost NUMERIC(16, 4) NOT NULL,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalExpenses()
RETURNS trigger AS
$trigger_before_insert_ProjectProposalExpenses$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalExpenses
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger_before_insert_ProjectProposalExpenses$ LANGUAGE plpgsql;
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
$trigger_before_insert_ProjectProposalSourceFunds$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger_before_insert_ProjectProposalSourceFunds$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposal
    BEFORE INSERT ON ProjectProposalSourceFunds
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalSourceFunds();

	/* End Project Proposal */
	/* SPECIAL APPROVAL SLIP */
DROP TABLE IF EXISTS SpecialApprovalType CASCADE;
CREATE TABLE SpecialApprovalType (
    id INTEGER,
    description VARCHAR(45),

    PRIMARY KEY (id)
);
DROP TABLE IF EXISTS SpecialApproval CASCADE;
CREATE TABLE SpecialApproval (
    id SERIAL,
    dateSubmmited TIMESTAMP WITH TIME ZONE,
    submissionType INTEGER NOT NULL REFERENCES SpecialApprovalType(id),
    requestingOrganization INTEGER NOT NULL REFERENCES StudentOrganization(id),
    activityTitle VARCHAR(45),
    justification TEXT,
    submittedBy INTEGER NOT NULL REFERENCES Account(idNumber),
    president INTEGER NOT NULL REFERENCES Account(idNumber),
    datePresidentSigned TIMESTAMP WITH TIME ZONE,
    approvalSignatory INTEGER NOT NULL REFERENCES Account(idNumber),
    dateApprovalSignatorySigned TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (id)
);
	/* END SPECIAL APPROVAL SLIP */
-- END FORMS 
-- COMMIT;

    /* SESSION TABLE */
CREATE TABLE IF NOT EXISTS session (
    "sid" varchar NOT NULL COLLATE "default",
    "sess" json NOT NULL,
    "expire" timestamp(6) NOT NULL,

    PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS=FALSE);
