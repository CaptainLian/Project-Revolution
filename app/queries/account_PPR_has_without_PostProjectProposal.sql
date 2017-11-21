WITH "CurrentTermPPR" AS (
    SELECT * 
      FROM ProjectProposal ppr
     WHERE ppr.GOSMActivity IN (SELECT id
                                  FROM GOSMActivity ga
                                 WHERE ga.GOSM IN (SELECT id
                                                     FROM GOSM
                                                    WHERE termID = system_get_current_term_id()
                                   AND status  = 3))
       AND ppr.GOSMActivity IN (SELECT gaph.activityID
                                  FROM GOSMActivityProjectHead gaph
                                 WHERE gaph.idNumber = ${idNumber})
       AND ppr.status = 3
       AND CURRENT_DATE >= ppr.actualDateEnd
)
SELECT EXISTS(SELECT *
                FROM "CurrentTermPPR" ppr
               WHERE ppr.GOSMActivity NOT IN (SELECT ppp."GOSMActivity"
                                                FROM "PostProjectProposal" ppp
                                               WHERE ppp."GOSMActivity" IN (SELECT ppr.GOSMActivity
                                                                              FROM "CurrentTermPPR" ppr)
                                                 AND ppp.status <> 3)) AS exists;