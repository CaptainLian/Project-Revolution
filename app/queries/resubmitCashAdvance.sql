UPDATE public."PreActivityCashAdvance"
   SET "submittedBy"=${submittedby}, 
       "dateSubmitted"=NOW(), purpose=${purpose}, justification=${justification}, 
       status=0, "filename" = ${filename}, "filenameToShow"=${filenameToShow}
 WHERE id=${id};
