UPDATE public."PreActivityCashAdvanceSignatory"
   SET  status=2,"sectionsToEdit"=${sections}, comments=${explain}, "dateSigned"=NOW()  
 WHERE signatory=${signatory}
   AND "cashAdvance"=${cashAdvance};
