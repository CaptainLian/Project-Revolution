SELECT g.id AS GOSMID, so.id AS organizationID, so.name AS organization, to_char(g.dateSubmitted, 'Mon DD, YYYY') AS dateSubmitted, gs.name AS status
  FROM GOSM g LEFT JOIN StudentOrganization so
                      ON g.studentOrganization = so.id
               LEFT JOIN GOSMStatus gs
                       ON g.status = gs.id
 WHERE g.termID = (SELECT id
                      FROM Term
                     WHERE CURRENT_DATE BETWEEN dateStart AND dateEnd)
 AND g.status <> 1;