-- START TRANSACTION;

DROP EXTENSION IF EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS Term CASCADE;
CREATE TABLE Term (
    startYear INTEGER,
    endYear INTEGER,
    number INTEGER,
    dateStart DATE NOT NULL,
    dateEnd DATE NOT NULL,
    

    PRIMARY KEY (startYear, endYear, number),
    CONSTRAINT number_min_value CHECK(number >= 1),
    CONSTRAINT number_max_value CHECK(number <= 3),
    CONSTRAINT start_end_year_value CHECK(endYear > startYear),
    CONSTRAINT date_start_end_value CHECK (dateEnd > dateStart)
);

DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
    studentID INTEGER,
    password CHAR(128) NOT NULL,
    firstname VARCHAR(45),
    middlename VARCHAR(45),
    lastname VARCHAR(45),
    contactNumber VARCHAR(16),
    email VARCHAR(255),
    dateCreated TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (studentID)
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

DROP TABLE IF EXISTS OrganizationType CASCADE;
CREATE TABLE OrganizationType (
    id INTEGER,
    description VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS StudentOrganization CASCADE;
CREATE TABLE StudentOrganization (
    id SERIAL,
    college CHAR(3) REFERENCES College(shortAcronym),
    organizationTypeID INTEGER NOT NULL REFERENCES OrganizationType(id),
    acronym VARCHAR(20),
    name VARCHAR(60),
    description TEXT,

    PRIMARY KEY (id)
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
    startYear INTEGER,
    endYear INTEGER,
    studentOrganization INTEGER REFERENCES StudentOrganization(id),
    status INTEGER NOT NULL REFERENCES GOSMStatus(id) DEFAULT 1,
    dateFiled DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (startYear, endYear, studentOrganization),
    CONSTRAINT start_end_year_value CHECK(endYear > startYear)
);

DROP TABLE IF EXISTS GOSMActivities CASCADE;
CREATE TABLE GOSMActivities (
    id INTEGER,
    startYear INTEGER,
    endYear INTEGER,
    studentOrganization INTEGER,
    goals VARCHAR(45) NOT NULL,
    objectives VARCHAR(45)[] NOT NULL,
    strategies VARCHAR(45) NOT NULL,
    description VARCHAR(255) NOT NULL,
    measures VARCHAR(45) NOT NULL,
    targetDateStart DATE NOT NULL,
    targetDateEnd DATE,
    peopleInCharge VARCHAR(60)[] NOT NULL,
    activityNature INTEGER REFERENCES ActivityNature(id),
    activityType INTEGER REFERENCES ActivityType(id),
    activityTypeOtherDescription VARCHAR(45) NULL,
    isRelatedToOrganizationNature BOOLEAN NOT NULL,
    budget NUMERIC(16, 4) NOT NULL,

    FOREIGN KEY (startYear, endYear, studentOrganization) REFERENCES GOSM(startYear, endYear, studentOrganization),
    PRIMARY KEY (id, startYear, endYear, studentOrganization),
    CONSTRAINT start_end_year_value CHECK(endYear > startYear),
    CONSTRAINT targetdate_start_end_value CHECK(targetDateEnd > targetDateStart)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSMActivities()
RETURNS trigger AS
$trigger_before_insert_GOSMActivities$
    BEGIN
        SELECT MAX(id) + 1 INTO STRICT NEW.id
          FROM GOSMActivities
         WHERE startYear = NEW.startYear
           AND endYear = NEW.endYear
           AND studentOrganization = NEW.studentOrganization;
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
    id SERIAL,
    dateSubmitted TIMESTAMP,
    activityTitle VARCHAR(45),
    ENP INTEGER,
    ENMP INTEGER,
    activityType VARCHAR(45),
    activityNature VARCHAR(45),
    targetDate DATE,
    venue TEXT,
    projectHeads VARCHAR(60)[],
    contactNumber VARCHAR(16),
    objectives TEXT[],
    accumulatedOperationalFunds NUMERIC(16, 4),
    accumulatedDepositoryFunds NUMERIC(16, 4),
    organization INTEGER REFERENCES StudentOrganization(id),
    financeSignatory INTEGER REFERENCES Account(studentID),
    preparedBy INTEGER REFERENCES Account(studentID),

    PRIMARY KEY (id)
);
-- TODO: TRIGGER FOR ID
DROP TABLE IF EXISTS ProjectProposalProgramDesign CASCADE;
CREATE TABLE ProjectProposalProgramDesign (
    projectProposalID INTEGER REFERENCES ProjectProposal(id),
    id INTEGER,
    startTime TIME WITH TIME ZONE,
    endTime TIME WITH TIME ZONE,
    activity TEXT,
    activityDescription TEXT,
    personInCharge VARCHAR(60)[],

    PRIMARY KEY (projectProposalID, id),
    CHECK(endTime > startTime)
);
-- TODO: TRIGGER FOR ID
DROP TABLE IF EXISTS ProjectProposalProjectedIncome CASCADE;
CREATE TABLE ProjectProposalProjectedIncome (
    projectProposalID INTEGER REFERENCES ProjectProposal(id),
    id INTEGER,
    item VARCHAR(30) NOT NULL,
    quantity INTEGER NOT NULL,
    sellingPrice NUMERIC(16, 4) NOT NULL,

    PRIMARY KEY (projectProposalID, id)
);
-- TODO: TRIGGER FOR ID
DROP TABLE IF EXISTS ProjectProposalExpenses CASCADE;
CREATE TABLE ProjectProposalExpenses (
    projectProposalID INTEGER REFERENCES ProjectProposal(id),
    id INTEGER,
    material VARCHAR(30) NOT NULL,
    quantity INTEGER NOT NULL,
    unitCost NUMERIC(16, 4) NOT NULL,

    PRIMARY KEY (projectProposalID, id)
);
-- TODO: TRIGGER FOR ID
DROP TABLE IF EXISTS ProjectProposalSourceFunds CASCADE;
CREATE TABLE ProjectProposalSourceFunds (
    projectProposalID INTEGER REFERENCES ProjectProposal(id),
    id INTEGER,
   	name VARCHAR (45),
   	amount NUMERIC(16, 4),

    PRIMARY KEY (projectProposalID, id)
);
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
    submittedBy INTEGER NOT NULL REFERENCES Account(studentID),
    president INTEGER NOT NULL REFERENCES Account(studentID),
    datePresidentSigned TIMESTAMP WITH TIME ZONE,
    approvalSignatory INTEGER NOT NULL REFERENCES Account(studentID),
    dateApprovalSignatorySigned TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (id)
);
	/* END SPECIAL APPROVAL SLIP */
-- END FORMS 
-- COMMIT;