SELECT *
  FROM "PreActivityCashAdvanceSignatory" PACA
 WHERE signatory=${idnumber}
   AND PACA.id IN (SELECT MIN(PACAS.id)
					 FROM "PreActivityCashAdvanceSignatory" PACAS 						
				    WHERE PACAS.status=0 
				      AND PACAS."cashAdvance"=${cashadvance}
				 GROUP BY PACAS."cashAdvance");