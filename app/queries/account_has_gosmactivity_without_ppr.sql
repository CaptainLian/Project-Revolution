-- Query to check if the user is a project head of any gosm activity without PPRs
SELECT EXISTS(SELECT *
                FROM GOSMActivityProjectHead
               WHERE idNumber = ${idNumber}
                 AND activityID IN (SELECT id
                                      FROM GOSMActivity
                                     WHERE GOSM IN (SELECT id 
                                                      FROM GOSM
                                                     WHERE termID = system_get_current_term_id()
                                                       AND studentOrganization = ${organizationID})
                                       AND GOSM NOT IN (SELECT GOSMActivity
                                                          FROM ProjectProposal))) AS "exists";