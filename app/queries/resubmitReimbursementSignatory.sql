UPDATE public."PostProjectReimbursementSignatory"
   SET status=0, comments=null, 
       sectionstoedit=null, document=null, digitalsignature=null, datesigned=null
 WHERE reimbursement=${id};
