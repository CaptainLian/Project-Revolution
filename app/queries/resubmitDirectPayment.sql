UPDATE public."PreActivityDirectPayment"
   SET "dateSubmitted"=NOW(), "reasonForDelayedPRSProcessing"=${reason}, 
       status=0
 WHERE id=${id};
