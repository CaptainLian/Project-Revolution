WITH "CurrentTermPPR" AS (
    SELECT ppr.GOSMActivity
      FROM ProjectProposal ppr
      WHERE GOSMActivity IN (SELECT id
                               FROM GOSMActivity ga
                              WHERE ga.GOSM IN (SELECT id
                                                  FROM GOSM g
                                                 WHERE g.termID = system_get_current_term_id()
                                                   AND g.status = 3))
  ORDER BY id ASC
),"AccountToSign" AS ( /* The minimum type of the user to sign PPRs */
    SELECT DISTINCT pps.GOSMActivity AS GOSMActivity, status
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st
                                               ON pps.type = st.id
     WHERE pps.signatory = ${idNumber}
       AND pps.GOSMActivity IN (SELECT GOSMActivity FROM "CurrentTermPPR")
)
SELECT pp.GOSMActivity, to_char(pp.actualDateStart, 'Mon DD, YYYY') AS actualDateStart, ga.strategies, pp.status
  FROM (SELECT pp.actualDateStart, pp.GOSMActivity, ats.status
          FROM ProjectProposal PP RIGHT JOIN "AccountToSign" ATS
                                          ON PP.GOSMActivity = ATS.GOSMActivity) pp LEFT JOIN GOSMActivity ga
                                                                       ON pp.GOSMActivity = ga.id;