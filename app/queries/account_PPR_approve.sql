WITH "SignatoryType" AS (
    WITH "AccountSignatories" AS (
        SELECT *
          FROM ProjectProposalSignatory pps
         WHERE pps.GOSMActivity = ${activityID}
           AND pps.signatory = ${idNumber}
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
   SET status = 1,
       document = ${document},
       digitalSignature = digitalSignature,
       dateSign = CURRENT_TIMESTAMP
 WHERE GOSMActivity = ${activityID}
   AND signatory = ${idNumber}
   AND type = (SELECT type FROM "SignatoryType");
