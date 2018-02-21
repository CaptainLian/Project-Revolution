  SELECT signatory AS "idNumber"
    FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st
                                             ON pps.type = st.id
   WHERE pps.status = 0
     AND pps.GOSMActivity = ${activityID}
ORDER BY st.lineup ASC
   LIMIT 1;