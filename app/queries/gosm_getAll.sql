SELECT g.id, so.name AS organization, g.dateSubmitted, gs.name AS status
  FROM GOSM g LEFT JOIN StudentOrganization so
                      ON g.studentOrganization = so.id
               LEFT JOIN GOSMStatus gs
                       ON g.status = gs.id
 WHERE g.termID = (SELECT id
                      FROM Term
                     WHERE CURRENT_DATE BETWEEN dateStart AND dateEnd);