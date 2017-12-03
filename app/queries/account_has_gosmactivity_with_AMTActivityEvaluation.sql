SELECT EXISTS(SELECT *
                FROM GOSMActivityProjectHead
               WHERE idNumber = ${idNumber}
                 AND activityID IN (SELECT id
                                      FROM GOSMActivity
                                      -- Current Term GOSM
                                     WHERE GOSM IN (SELECT id 
                                                      FROM GOSM
                                                     WHERE termID = system_get_current_term_id()
                                                       AND studentOrganization = ${organizationID})
                                        AND id IN (SELECT activity
                                                     FROM AMTActivityEvaluation))) AS "exists";
