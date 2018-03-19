INSERT INTO public."PreActivityBookTransfer"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", status, establishment)
    VALUES (${gosmactivity}, ${submittedby}, NOW(), 0, ${transferaccount})
RETURNING id;
