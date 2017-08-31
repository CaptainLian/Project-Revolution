SELECT g.studentOrganization AS id, s.name, to_char(g.dateCreated, 'Mon DD YYYY') as dateCreated, gs.name AS status
  FROM GOSM g LEFT JOIN GOSMStatus gs
                     ON g.status = gs.id
              LEFT JOIN StudentOrganization s
                     ON g.studentOrganization = s.id;