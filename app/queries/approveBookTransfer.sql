UPDATE public."PreActivityBookTransferSignatory"
   SET status=1, "dateSigned"=NOW()
 WHERE "bookTransfer"=${booktransfer}
   AND signatory=${idnumber};
