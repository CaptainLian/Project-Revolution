
DROP TABLE IF EXISTS VenueSize CASCADE;
CREATE TABLE VenueSize (
	id SMALLINT,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS RateType CASCADE;
CREATE TABLE RateType (
	id SMALLINT,
	name VARCHAR(45),

	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Building CASCADE;
CREATE TABLE Building (
	id SMALLINT,
	name VARCHAR(50) NOT NULL,
	code VARCHAR(2),

	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS ActivityVenue CASCADE;
CREATE TABLE ActivityVenue (
	id SERIAL,
	name VARCHAR (60),
	capacity INTEGER,
	size SMALLINT REFERENCES VenueSize(id),
	rate NUMERIC(16, 4),
	rateType SMALLINT REFERENCES RateType(id),
	Building SMALLINT REFERENCES Building(id),

	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS OrganizationFacultyAdviser CASCADE;
CREATE TABLE OrganizationFacultyAdviser (
	organization INTEGER,
	adviser INTEGER,
	yearID INTEGER,

	PRIMARY KEY(organization, adviser, yearID)
);

DROP TABLE IF EXISTS SignatoryType CASCADE;
CREATE TABLE SignatoryType (
	id SMALLINT,
	name VARCHAR(45) NOT NULL,

	PRIMARY KEY (id)
);
INSERT INTO SignatoryType (id, name)
                   VALUES ( 0, 'Project Head'),
                   		  ( 1, 'Treasurer/Finance'),
                   		  ( 2, 'Immediate Superior'),
                   		  ( 3, 'President'),
                   		  ( 4, 'Faculty Adviser');

DROP TABLE IF EXISTS ProjectProposalSignatory CASCADE;
CREATE TABLE ProjectProposalSignatory (
	projectProposal INTEGER,
	signatory INTEGER,
	type SMALLINT NOT NULL REFERENCES SignatoryType(id),
	document bjson,
	digitalSignature TEXT,
	dateSigned TIMESTAMP WITH TIME ZONE,

	PRIMARY KEY(projectProposal)
);