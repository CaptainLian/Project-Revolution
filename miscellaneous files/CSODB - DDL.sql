DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
DROP EXTENSION IF EXISTS "pgcrypto" CASCADE;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS AccountType CASCADE;
CREATE TABLE AccountType (
    id INTEGER,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
    idNumber INTEGER,
    email VARCHAR(255) NULL UNIQUE,
    type INTEGER REFERENCES AccountType(id),
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
    id SERIAL UNIQUE,
    startYear INTEGER,
    endYear INTEGER,

    PRIMARY KEY (startYear, endYear),
    CONSTRAINT start_end_year_value CHECK(startYear < endYear)
);
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

/* Activity Requirements */
DROP TABLE IF EXISTS ActivityRequirement CASCADE;
CREATE TABLE ActivityRequirement (
    id SERIAL UNIQUE,
    activityType INTEGER,
    sequence INTEGER DEFAULT -1,
    name VARCHAR(100) NOT NULL,

    PRIMARY KEY (activityType, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ActivityRequirement()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ActivityRequirement
         WHERE activityType = NEW.activityType;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ActivityRequirement
    BEFORE INSERT ON ActivityRequirement
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ActivityRequirement();


DROP TABLE IF EXISTS PreActivityRequirement CASCADE;
CREATE TABLE PreActivityRequirement (
    PRIMARY KEY (activityType, sequence)
) INHERITS (ActivityRequirement);
CREATE OR REPLACE FUNCTION trigger_before_insert_PreActivityRequirement()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM PreActivityRequirement
         WHERE activityType = NEW.activityType;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_PreActivityRequirement
    BEFORE INSERT ON PreActivityRequirement
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_PreActivityRequirement();


DROP TABLE IF EXISTS PostActivityRequirement CASCADE;
CREATE TABLE PostActivityRequirement (
    PRIMARY KEY (activityType, sequence)
) INHERITS (ActivityRequirement);
CREATE OR REPLACE FUNCTION trigger_before_insert_PostActivityRequirement()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM PostActivityRequirement
         WHERE activityType = NEW.activityType;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_PostActivityRequirement
    BEFORE INSERT ON PostActivityRequirement
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_PostActivityRequirement();
/* Activity Requirements End */

DROP TABLE IF EXISTS ActivityNature CASCADE;
CREATE TABLE ActivityNature (
    id INTEGER,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);

/* Organizations */
/*
DROP SEQUENCE IF EXISTS organization_id_sequence;
CREATE SEQUENCE organization_id_sequence INCREMENT BY 1
MINVALUE 0 NO MAXVALUE START WITH 0 NO CYCLE;
*/
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
    funds NUMERIC(16, 4) DEFAULT 0.0,
    facultyAdviser INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (id)
);

    /* Organization Structure */
DROP TABLE IF EXISTS OrganizationPosition CASCADE;
CREATE TABLE OrganizationPosition (
    id SERIAL,
    name VARCHAR(100),

    PRIMARY KEY(id)
);
DROP TABLE IF EXISTS OrganiationStructure CASCADE;
CREATE TABLE OrganiationStructure (
    id SERIAL UNIQUE,
    organization INTEGER REFERENCES StudentOrganization (id),
    position INTEGER REFERENCES OrganizationPosition (id),
    rank INTEGER,
    uniquePosition BOOLEAN NOT NULL,
    masterPosition INTEGER REFERENCES OrganiationStructure (id),

    PRIMARY KEY (organization, position)
);
DROP TABLE IF EXISTS OrganizationOfficer CASCADE;
CREATE TABLE OrganizationOfficer (
    idNumber INTEGER,
    position INTEGER,
    yearID INTEGER,
    dateAssigned TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (idNumber, position, yearID)
);
    /* Organization Structure End */
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
    dateStatusModified TIMESTAMP WITH TIME ZONE, 
    preparedBy INTEGER REFERENCES Account(idNumber),
    statusModifier INTEGER REFERENCES Account(idNumber),
    comments TEXT,

    PRIMARY KEY (termID, studentOrganization)
);
CREATE OR REPLACE FUNCTION trigger_before_update_GOSM()
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
CREATE TRIGGER before_update_GGOSM
    BEFORE UPDATE ON GOSM
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE trigger_before_update_GOSM();

DROP TABLE IF EXISTS GOSMActivity CASCADE;
CREATE TABLE GOSMActivity (
    id SERIAL UNIQUE,
    GOSM INTEGER REFERENCES GOSM(id),
    sequence INTEGER NOT NULL DEFAULT -1,
    goals VARCHAR(255) NOT NULL,
    objectives VARCHAR(255)[] NOT NULL,
    strategies VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    measures VARCHAR(255) NOT NULL,
    targetDateStart DATE,
    targetDateEnd DATE,
    activityNature INTEGER REFERENCES ActivityNature(id),
    activityType INTEGER REFERENCES ActivityType(id),
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
DROP TABLE IF EXISTS ProjectProposalStatus CASCADE;
CREATE TABLE ProjectProposalStatus (
    id INTEGER,
    name VARCHAR(45),

    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ProjectProposal CASCADE;
CREATE TABLE ProjectProposal (
    id SERIAL UNIQUE,
    GOSMActivity INTEGER REFERENCES GOSMActivity(id),
    status INTEGER NOT NULL REFERENCES ProjectProposalStatus(id) DEFAULT 1,
    ENP INTEGER,
    ENMP INTEGER,
    venue VARCHAR(100),
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
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposal()
RETURNS trigger AS 
$trigger$
    BEGIN
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposal
    AFTER INSERT ON ProjectProposal
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposal();

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
    CHECK(startTime < endTime)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProgramDesign()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal;
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


DROP TABLE IF EXISTS ProjectProposalExpenses CASCADE;
CREATE TABLE ProjectProposalExpenses (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    material VARCHAR(45) NOT NULL,
    quantity INTEGER NOT NULL,
    unitCost NUMERIC(16, 4) NOT NULL,

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
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER DEFAULT -1,
    directory TEXT NOT NULL
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
CREATE TRIGGER before_insert_ProjectProposal
    BEFORE INSERT ON ProjectProposalSourceFunds
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalAttachment();

DROP TABLE IF EXISTS ProjectProposalSignatory CASCADE;
CREATE TABLE ProjectProposalSignatory (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    signatory INTEGER REFERENCES Account(idNumber),
    documentHash BYTEA,
    digitalSignature BYTEA,
    dateSigned TIMESTAMP WITH TIME ZONE
);
    /* End Project Proposal */
    /* END SPECIAL APPROVAL SLIP */
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

DROP TABLE IF EXISTS CONSTANT CASCADE;
CREATE TABLE CONSTANT (
    name VARCHAR(25) PRIMARY KEY
);
DROP TABLE IF EXISTS TEXT_CONSTANT CASCADE;
CREATE TABLE TEXT_CONSTANT (
    value TEXT NOT NUll,

    PRIMARY KEY(name)
) INHERITS (CONSTANT);

DROP TABLE IF EXISTS JSON_CONSTANT CASCADE;
CREATE TABLE JSON_CONSTANT (
    value JSONB NOT NULL,
    
    PRIMARY KEY(name)
) INHERITS (CONSTANT);

/* 
    Helpful functions 
*/
CREATE OR REPLACE FUNCTION getCurrentTermID()  
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

CREATE OR REPLACE FUNCTION getCurrentYearID()  
RETURNS INTEGER AS 
$function$
    DECLARE
        yearID INTEGER;
    BEGIN
        SELECT id INTO yearID
        FROM SchoolYear
        WHERE id = (SELECT id 
                      FROM Term
                     WHERE CURRENT_DATE >= dateStart
                       AND CURRENT_DATE <= dateEnd);

        RETURN termID;
    END;
$function$ STABLE LANGUAGE plpgsql;
/* 
    Helpful functions end 
*/