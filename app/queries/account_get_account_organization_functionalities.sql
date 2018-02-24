SELECT role/10000 AS "organization", role, functionality%1000 AS "functionalitySequence", isAllowed AS "isAllowed"
  FROM OrganizationAccessControl
 WHERE role IN (SELECT role
                  FROM OrganizationOfficer
                 WHERE idNumber = ${idNumber}
                   AND yearID = system_get_current_year_id());