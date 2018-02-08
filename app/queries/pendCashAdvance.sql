UPDATE public."PreActivityCashAdvanceSignatory"
   SET  status=2 
 WHERE signatory=${signatory}
   AND "cashAdvance"=${cashAdvance};
