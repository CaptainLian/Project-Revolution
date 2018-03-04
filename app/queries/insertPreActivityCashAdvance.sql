INSERT INTO public."PreActivityCashAdvance"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", justification, purpose, status)
    VALUES (${gosmactivity}, ${submittedBy}, 
            NOW(), ${justification}, ${purpose} 0)
RETURNING id;
