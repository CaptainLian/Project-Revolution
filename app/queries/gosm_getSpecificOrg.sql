SELECT g.studentOrganization, g.dateCreated, gs.name
  FROM GOSM g LEFT JOIN GOSMStatus gs
                     ON g.status = gs.id
 WHERE g.startYear = ${startYear}
   AND g.endYear = ${endYear}
   AND g.studentOrganization = ${organizationID};