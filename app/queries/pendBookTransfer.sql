UPDATE public."PreActivityBookTransferSignatory"
   SET status=2, "dateSigned"=NOW()
 WHERE "bookTransfer"=${booktransfer}
   AND signatory=${idnumber};
