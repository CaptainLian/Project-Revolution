INSERT INTO public."PreActivityBookTransfer"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", status)
    VALUES (${gosmactivity}, ${submittedby}, NOW(), 0)
RETURNING id;
