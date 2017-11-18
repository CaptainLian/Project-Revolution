﻿WITH "CurrentTermPPR" AS (
    SELECT ppr.GOSMActivity
      FROM ProjectProposal ppr
      WHERE ppr.status = 2
        AND GOSMActivity IN (SELECT id 
                               FROM GOSMActivity ga
                              WHERE ga.GOSM IN (SELECT id 
                                                  FROM GOSM g
                                                 WHERE g.termID = system_get_current_term_id()
                                                   AND g.status = 3))
  ORDER BY id ASC
),"AccountToSign" AS ( /* The minimum type of the user to sign PPRs */
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st 
                                               ON pps.type = st.id
     WHERE pps.signatory = 3333333
       AND pps.GOSMActivity IN (SELECT GOSMActivity FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
), "ProjectProposalCurrentLineup" AS ( /* The actual minimum type of each PPR*/
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st
                                               ON pps.type = st.id
     WHERE GOSMActivity IN (SELECT GOSMActivity FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
), "AccountPPRCanSign" AS (
-- This is the list of ProjectProposals the user can currently sign
SELECT ppcl.GOSMActivity
  FROM "ProjectProposalCurrentLineup" ppcl INNER JOIN "AccountToSign" ats
                                                   ON ppcl.GOSMActivity = ats.GOSMActivity
                                                  AND ppcl.lineup = ats.lineup
)
SELECT pp.actualDateStart, ga.strategies
  FROM (SELECT *
          FROM ProjectProposal 
         WHERE GOSMActivity IN (SELECT GOSMActivity
                                  FROM "AccountPPRCanSign")) pp LEFT JOIN GOSMActivity ga
                                                                       ON pp.GOSMActivity = ga.id;