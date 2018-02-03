INSERT INTO public."PreActivityCashAdvance"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", justification, status)
    VALUES (${gosmactivity}, ${submittedBy}, 
            NOW(), ${justification}, 0)
RETURNING id;
