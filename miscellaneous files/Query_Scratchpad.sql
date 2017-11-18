
WITH "CurrentTermPPR" AS (
    SELECT id 
      FROM GOSMActivity
     WHERE GOSM IN (SELECT id 
                      FROM GOSM
                     WHERE termID = system_get_current_term_id())
  ORDER BY id ASC
),"AccountToSign" AS ( /* The minimum type of the user to sign PPRs */
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st 
                                               ON pps.type = st.id
     WHERE pps.signatory = 3333333
       AND pps.GOSMActivity IN (SELECT id FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
), "ProjectProposalCurrentLineup" AS ( /* The actual minimum type of each PPR*/
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st
                                               ON pps.type = st.id
     WHERE GOSMActivity IN (SELECT id FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
)
-- This is the list of ProjectProposals the user can currently sign
SELECT ppcl.GOSMActivity
  FROM "ProjectProposalCurrentLineup" ppcl INNER JOIN "AccountToSign" ats
                                                  ON ppcl.GOSMActivity = ats.GOSMActivity
                                                 AND ppcl.lineup = ats.lineup;