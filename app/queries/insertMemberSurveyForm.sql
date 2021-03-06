INSERT INTO public."MemberSurveyForm"(
            "termID", member, "organizationID", field1, field2, field3, 
            field4, field5, field6, field7, field8, field9, field10, field11, 
            field12, field13)
    VALUES (system_get_current_term_id(), (SELECT "id"
    	                                     FROM "OrganizationMember"
    	                                    WHERE "idNumber" = ${idnumber}
    	                                      AND "yearID" = system_get_current_year_id()
    	                                      AND "organization" = ${organizationid}), ${organizationid}, ${field1}, ${field2}, ${field3}, 
            ${field4}, ${field5}, ${field6}, ${field7}, ${field8}, ${field9}, ${field10},
            ${field11}, ${field12}, ${field13});
