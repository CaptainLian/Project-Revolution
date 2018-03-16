UPDATE public."PreActivityCashAdvanceSignatory"
   SET  status=2,"sectionsToEdit"=${sections}, comments=${explain}  
 WHERE signatory=${signatory}
   AND "cashAdvance"=${cashAdvance};
