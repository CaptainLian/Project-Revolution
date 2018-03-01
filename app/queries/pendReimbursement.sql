UPDATE public."PostProjectReimbursementSignatory"
   SET status=2, datesigned=NOW()
 WHERE reimbursement=${reimbursement}
   AND signatory=${idnumber};
