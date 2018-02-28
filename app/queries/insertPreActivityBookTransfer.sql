INSERT INTO public."PreActivityBookTransfer"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", status, "transferAccount")
    VALUES (${gosmactivity}, ${submittedby}, NOW(), 0, ${transferaccount})
RETURNING id;
