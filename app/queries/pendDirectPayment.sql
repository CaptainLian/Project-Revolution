UPDATE public."PreActivityDirectPaymentSignatory"
   SET  status=2, "sectionsToEdit"=${sections}, comments=${explain}, "dateSigned"=NOW()
 WHERE signatory=${signatory}
   AND "directPayment"=${directPayment};
