UPDATE public."PreActivityCashAdvance"
   SET "submittedBy"=${submittedby}, 
       "dateSubmitted"=NOW(), purpose=${purpose}, justification=${justification}, 
       status=0
 WHERE id=${id};
