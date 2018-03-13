INSERT INTO public."PreActivityCashAdvance"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", justification, purpose, status,"filename","filenameToShow")
    VALUES (${gosmactivity}, ${submittedBy}, 
            NOW(), ${justification}, ${purpose}, 0,${filename}, ${filenameToShow})
RETURNING id;
