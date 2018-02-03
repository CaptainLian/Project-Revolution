INSERT INTO public."PreActivityDirectPayment"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", "reasonForDelayedPRSProcessing", status)
    VALUES (${gosmactivity}, ${submittedby}, 
            NOW(), ${reason}, 0)
RETURNING id;
