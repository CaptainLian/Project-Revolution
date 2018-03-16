UPDATE public."PreActivityBookTransferSignatory"
   SET status=2, "dateSigned"=NOW(),sectionsToEdit=${sections}, comments=${explain} 
 WHERE "bookTransfer"=${booktransfer}
   AND signatory=${idnumber};
