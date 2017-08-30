SELECT g.studentOrganization, g.dateCreated, gs.name AS status
  FROM GOSM g LEFT JOIN GOSMStatus gs
                     ON g.status = gs.id;