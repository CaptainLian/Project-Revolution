INSERT INTO public."MemberSurveyForm"(
            "termID", "organizationID", field1, field2, field3, field4, field5, 
            field6, field7, field8, field9)
    VALUES (system_get_current_term_id(), ${organizationid}, ${field1}, ${field2}, ${field3}, 
            ${field4}, ${field5}, ${field6}, ${field7}, ${field8}, ${field9});
