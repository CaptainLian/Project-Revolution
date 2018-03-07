UPDATE public."PreActivityBookTransferSignatory"
   SET status=0, comments=null, 
       "sectionsToEdit"=null, document=null, "digitalSignature"=null, "dateSigned"=null
 WHERE "bookTransfer"=${id};
