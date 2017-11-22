INSERT INTO public."PreActivityCashAdvance"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", purpose, justification, status)
    VALUES (${gosmactivity}, ${submittedBy}, 
            NOW(), ${purpose}, ${justification}, 0)
RETURNING id;
