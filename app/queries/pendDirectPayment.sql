UPDATE public."PreActivityDirectPaymentSignatory"
   SET  status=2 
 WHERE signatory=${signatory}
   AND "directPayment"=${directPayment};
