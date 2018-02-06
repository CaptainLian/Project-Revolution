SELECT EXISTS(SELECT * 
                FROM GOSM
               WHERE termID = system_get_current_term_id()
                 AND studentOrganization = ${studentOrganization}
                 -- SAFE CODING YEAH
                 AND status <> 1
                 AND status <> 3
                 AND status <> 4
                 AND status <> 5) AS "exists";
