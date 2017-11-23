SELECT EXISTS(SELECT *
                FROM OrganizationOfficer oo
               WHERE oo.role IN (SELECT oac.role
                                   FROM OrganizationAccessControl oac
                                  WHERE oac.functionality IN (SELECT id FROM Functionality WHERE id%1000 = 19 OR id%1000 = 20))
                                    AND oo.yearID = system_get_current_year_id()
                                    AND oo.idNumber = ${idNumber}) AS "exists";
