INSERT INTO public."PreActivityDirectPayment"(
            "GOSMActivity", "submittedBy", 
            "dateSubmitted", "reasonForDelayedPRSProcessing", status,"galsFilename","galsfilenameToShow","fqFilename","fqfilenameToShow","rofFilename","rofFilenameToShow")
    VALUES (${gosmactivity}, ${submittedby}, 
            NOW(), ${reason}, 0, ${galfn},${galfts},${fqfn},${fqfts},${roffn},${roffts})
RETURNING id;
