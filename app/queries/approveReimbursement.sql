UPDATE public."PostProjectReimbursementSignatory"
   SET status=1, datesigned=NOW()
 WHERE reimbursement=${reimbursement}
   AND signatory=${idnumber};
