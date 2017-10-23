WITH student_officership AS (
    SELECT *
      FROM OrganizationOfficer
     WHERE idNumber = 11445955
), student_organizations AS (
	SELECT DISTINCT organization
	  FROM OrganizationRole
	 WHERE id IN (SELECT role 
		            FROM student_officership)
)
SELECT *
 FROM StudentOrganization
WHERE id IN (SELECT organization
	           FROM student_organizations);