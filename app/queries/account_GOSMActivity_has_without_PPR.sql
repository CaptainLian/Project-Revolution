-- HAS GOSM Activity without PPR
WITH "CurrentTermGOSMActivity" AS (
    SELECT *
      FROM GOSMActivity ga
     WHERE ga.GOSM IN (SELECT id
                         FROM GOSM g
                        WHERE g.termID = system_get_current_term_id()
                          AND g.status = 3)
      AND ga.id IN (SELECT gaph.activityID
                      FROM GOSMActivityProjectHead gaph
                     WHERE gaph.idNumber = ${idNumber})
)
SELECT EXISTS(SELECT *
                FROM "CurrentTermGOSMActivity" ctga
               WHERE ctga.id NOT IN (SELECT ppr.GOSMActivity
                                       FROM ProjectProposal ppr
                                      WHERE ppr.GOSMActivity IN (SELECT id
                                                                  FROM "CurrentTermGOSMActivity")
                                        AND ppr.status <> 1 AND ppr.status <> 4)) AS exists;
