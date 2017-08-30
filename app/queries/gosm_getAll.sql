SELECT g.studentOrganization AS id, s.name, g.dateCreated, gs.name AS status
  FROM GOSM g LEFT JOIN GOSMStatus gs
                     ON g.status = gs.id
              LEFT JOIN StudentOrganization s
                     ON g.studentOrganization = s.id;