INSERT INTO public."OfficerSurveyForm"(
            "termID", "organizationID", officer, field1, field2, field3, 
            field4, field5, field6, field7, field8, field9)
    VALUES (system_get_current_term_id(), ${organizationid}, ${officer}, ${field1}, ${field2}, ${field3}, 
            ${field4}, ${field5}, ${field6}, ${field7}, ${field8}, ${field9});
