-- HAS approved PPR 
SELECT EXISTS (SELECT *
                 FROM ProjectProposal
                WHERE GOSMActivity IN (SELECT id
                                         FROM GOSMActivity
                                        WHERE GOSM IN (SELECT id
                                                         FROM GOSM
                                                        WHERE termID = system_get_current_term_id()))
   AND GOSMActivity IN (SELECT activityID 
                          FROM GOSMActivityProjectHead gaph
                         WHERE gaph.idNumber = ${idNumber})
   AND status = 3) AS exists;

