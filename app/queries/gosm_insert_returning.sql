INSERT INTO GOSM(termID, studentOrganization)
	   VALUES (${termID}, ${studentOrganization})
RETURNING id;