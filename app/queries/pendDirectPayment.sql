UPDATE public."PreActivityDirectPaymentSignatory"
   SET  status=2, "sectionsToEdit"=${sections}, comments=${explain} 
 WHERE signatory=${signatory}
   AND "directPayment"=${directPayment};
