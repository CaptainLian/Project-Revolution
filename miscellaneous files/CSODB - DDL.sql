-- START TRANSACTION;

DROP EXTENSION IF EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TABLE IF EXISTS SchoolYear CASCADE;
CREATE TABLE SchoolYear (
    id SERIAL UNIQUE NOT NULL,
    startYear INTEGER,
    endYear INTEGER,
    
    PRIMARY KEY (startYear, endYear),
    CONSTRAINT endyear_startyear_value CHECK(endYear < startYear)
);

DROP TABLE IF EXISTS Term CASCADE;
CREATE TABLE Term (
    id SERIAL,
    number INTEGER,
    dateStart DATE,
    dateEnd DATE,
    schoolYear INTEGER REFERENCES SchoolYear(id),

    PRIMARY KEY (id),
    CONSTRAINT number_min_value CHECK(number >= 1),
    CONSTRAINT number_max_value CHECK(number <= 3)
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

DROP TABLE IF EXISTS OrganizationType CASCADE;
CREATE TABLE OrganizationType (
    id SERIAL,
    description VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS Organization CASCADE;
CREATE TABLE Organization (
    id SERIAL,
    organizationTypeID INTEGER NOT NULL REFERENCES OrganizationType(id),
    acronym VARCHAR(20),
    name VARCHAR(60),
    description TEXT,

    PRIMARY KEY (id)
);
DROP TABLE IF EXISTS ProfessionalOrganizationGroup CASCADE;
CREATE TABLE ProfessionalOrganizationGroup (
    college CHAR(3) REFERENCES College(shortAcronym)
) INHERITS (Organization);
DROP TABLE IF EXISTS ProfessionalOrganization CASCADE;
CREATE TABLE ProfessionalOrganization (
    organizationGroup INTEGER REFERENCES Organization(id)
) INHERITS (Organization);

-- FORMS
	/* GOSM RELATED*/
DROP TABLE IF EXISTS GOSM CASCADE;
CREATE TABLE GOSM (
    schoolYear INTEGER REFERENCES SchoolYear(id),
    studentOrganization INTEGER REFERENCES Organization(id),
    goals TEXT,
    objectives TEXT,
    description TEXT,
    measures TEXT,
    targetDateStart DATE,
    targetDateEnd DATE,
    peopleInCharge VARCHAR(60)[],
    activityNature VARCHAR(45),
    activityType VARCHAR(45),
    isRelatedToOrganizationNature BOOLEAN,
    budget NUMERIC(16, 4),

    PRIMARY KEY (schoolYear, studentOrganization)
);
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
    organization INTEGER REFERENCES Organization(id),
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
    CHECK(startTime > endTime)
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
    id SERIAL,
    description VARCHAR(45),

    PRIMARY KEY (id)
);
DROP TABLE IF EXISTS SpecialApproval CASCADE;
CREATE TABLE SpecialApproval (
    id SERIAL,
    dateSubmmited TIMESTAMP WITH TIME ZONE,
    submissionType INTEGER NOT NULL REFERENCES SpecialApprovalType(id),
    requestingOrganization INTEGER NOT NULL REFERENCES Organization(id),
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