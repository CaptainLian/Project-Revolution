SELECT EXISTS(SELECT *
                FROM GOSMActivityProjectHead gaph
               WHERE gaph.activityID IN (SELECT id
                                           FROM GOSMActivity
                                          WHERE GOSM IN (SELECT id
                                                           FROM GOSM
                                                          WHERE termID = system_get_current_term_id()))
                 AND idNumber = ${idNumber});
