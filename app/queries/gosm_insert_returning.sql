INSERT INTO GOSM(termID, studentOrganization, preparedBy)
	   VALUES (${termID}, ${studentOrganization}, ${preparedBy})
RETURNING id;