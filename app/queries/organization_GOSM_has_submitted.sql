SELECT EXISTS(SELECT * 
                FROM GOSM
               WHERE termID = system_get_current_term_id()
                 AND studentOrganization = ${studentOrganization}
                 AND status <> 1) AS "exists";
