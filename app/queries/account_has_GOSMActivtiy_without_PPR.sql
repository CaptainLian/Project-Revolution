SELECT EXISTS(SELECT DISTINCT activityID AS GOSMActivity
                FROM GOSMActivityProjectHead
               WHERE idNumber = ${idNumber}
                 AND activityID NOT IN (SELECT GOSMActivity
                                          FROM ProjectProposal
                                         WHERE GOSMActivity IN (SELECT id
                                                                  FROM GOSMActivity
                                                                 WHERE GOSM IN (SELECT id
                                                                                  FROM GOSM
                                                                                 WHERE studentOrganization = ${organizationID}
                                                                                   AND termID = system_get_current_term_id()))
                                           AND (status = 1 OR status = 4))) AS exists;
