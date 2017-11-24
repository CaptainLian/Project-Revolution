SELECT *
  FROM ((SELECT PADP.id as id, PADP."GOSMActivity" as gosmactivity, 0 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, PADP.amount as amount, PADP.status
	   	   FROM "PreActivityDirectPayment" PADP JOIN GOSMACTIVITY GA
												  ON PADP."GOSMActivity"=GA.ID
												JOIN PROJECTPROPOSAL PP
												  ON PP.GOSMACTIVITY=GA.ID
	 	  WHERE GA.ID=${gosmactivity})

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 1 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status
	     FROM "PreActivityCashAdvance" PACA JOIN "PreActivityCashAdvanceParticular" PACAP
							  		          ON PACA.id=PACAP."cashAdvance"
				     						JOIN PROJECTPROPOSALEXPENSES PPE
				       						  ON PACAP.particular=PPE.id
				     						JOIN PROJECTPROPOSAL PP
				       						  ON PPE.PROJECTPROPOSAL=PP.ID

		WHERE PACA."GOSMActivity"=${gosmactivity}
		  AND PACA.id IN (SELECT PACASI."cashAdvance"
		  					FROM "PreActivityCashAdvanceSignatory" PACASI
		  				   WHERE PACASI.signatory=${idnumber}
		  				     AND PACASI.id IN (SELECT MIN(PACAS.id)
							 					 FROM "PreActivityCashAdvanceSignatory" PACAS JOIN "PreActivityCashAdvance" PACAA
											 											        ON PACAA.id=PACAS."cashAdvance"
												WHERE PACAS.status=0
						      					  AND PACAA."GOSMActivity"=${gosmactivity}
						 					 GROUP BY PACAS."cashAdvance"))
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id)

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 2 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status
	     FROM "PreActivityCashAdvance" PACA JOIN "PreActivityCashAdvanceParticular" PACAP
							  		          ON PACA.id=PACAP."cashAdvance"
				     						JOIN PROJECTPROPOSALEXPENSES PPE
				       						  ON PACAP.particular=PPE.id
				     						JOIN PROJECTPROPOSAL PP
				       						  ON PPE.PROJECTPROPOSAL=PP.ID

		WHERE PACA."GOSMActivity"=${gosmactivity}
		  AND PACA.id NOT IN (SELECT PACASI."cashAdvance"
		  					FROM "PreActivityCashAdvanceSignatory" PACASI
		  				   WHERE PACASI.signatory=${idnumber}
		  				     AND PACASI.id IN (SELECT MIN(PACAS.id)
							 					 FROM "PreActivityCashAdvanceSignatory" PACAS JOIN "PreActivityCashAdvance" PACAA
											 											        ON PACAA.id=PACAS."cashAdvance"
												WHERE PACAS.status=0
						      					  AND PACAA."GOSMActivity"=${gosmactivity}
						 					 GROUP BY PACAS."cashAdvance"))
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id)	) U;