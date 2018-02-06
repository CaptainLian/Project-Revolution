WITH "SignatoryType" AS (
    WITH "AccountSignatories" AS (
        SELECT *
          FROM ProjectProposalSignatory pps
         WHERE pps.GOSMActivity = 1
           AND pps.signatory = 1111111
    )
    SELECT pps.type
      FROM "AccountSignatories" pps LEFT JOIN SignatoryType st
                                           ON pps.type = st.id
     WHERE st.lineup = (SELECT MIN(st.lineup)
                          FROM SignatoryType st
                         WHERE id IN (SELECT pps.type
                                        FROM "AccountSignatories" pps))
  ORDER BY pps.type DESC
     LIMIT 1
)
UPDATE ProjectProposalSignatory
   SET status = 2
 WHERE GOSMActivity = 1
   AND signatory = 3333333
   AND type = (SELECT type FROM "SignatoryType");
/*
	0 - unsigned
	1 - accept
	2- pend
	3 - deny
	4 - force signed
*/

