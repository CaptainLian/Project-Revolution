INSERT INTO public."MemberSurveyForm"(
            "termID", "organizationID", field1, field2, field3, field4, field5, 
            field6, field7, field8, field9, field10, field11, 
            field12, field13)
    VALUES (system_get_current_term_id(), ${organizationid}, ${field1}, ${field2}, ${field3}, 
            ${field4}, ${field5}, ${field6}, ${field7}, ${field8}, ${field9}, ${field10},
            ${field11}, ${field12}, ${field13});
