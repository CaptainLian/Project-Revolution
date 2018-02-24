UPDATE public."PreActivityDirectPaymentSignatory"
   SET status=1
 WHERE signatory=${signatory}
   AND "directPayment"=${directPayment};
