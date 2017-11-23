/* Subqueries */
WITH ProjectHeads AS (
	SELECT idNumber
	FROM GOSMActivityProjectHead
	WHERE activityID = ${gosmid}
), Accounts AS (
	SELECT * 
	 FROM Account
	 WHERE idNumber IN ( SELECT idNumber
	 	                   FROM ProjectHeads )
)

/* MAIN Query */
SELECT ph.idNumber, a.firstname || ' ' || a.lastname AS name, contactNumber
  FROM  ProjectHeads ph LEFT JOIN Account a
                               ON ph.idNumber = a.idNumber;