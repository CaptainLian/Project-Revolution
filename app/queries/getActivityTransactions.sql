SELECT * --  0 approval is to be signed by current user
  FROM ((SELECT PADP.id as id, PADP."GOSMActivity" as gosmactivity, 0 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PADP.status, 0 as approval
	   	   FROM "PreActivityDirectPayment" PADP JOIN "PreActivityDirectPaymentParticular" PADPP
	   	   										  ON PADP.id=PADPP."directPayment"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PADPP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PADP."GOSMActivity"=${gosmactivity}
  	        AND PADP.id IN (SELECT PADPSI."directPayment"
  	        				  FROM "PreActivityDirectPaymentSignatory" PADPSI
  	        				 WHERE PADPSI.signatory=${idnumber}
  	        				   AND PADPSI.id IN (SELECT MIN(PADPS.id)
  	        				   					   FROM "PreActivityDirectPaymentSignatory" PADPS JOIN "PreActivityDirectPayment" PADPI
  	        				   					   													ON PADPI.id=PADPS."directPayment"
  	        				   					  WHERE PADPS.status=0
  	        				   					    AND PADPI."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PADPS."directPayment"))
  	   GROUP BY PADP."GOSMActivity", PP.ACTUALDATESTART, PADP.STATUS, PADP.id)     

UNION (SELECT PADP.id as id, PADP."GOSMActivity" as gosmactivity, 1 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PADP.status, 1 as approval
	   	   FROM "PreActivityDirectPayment" PADP JOIN "PreActivityDirectPaymentParticular" PADPP
	   	   										  ON PADP.id=PADPP."directPayment"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PADPP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PADP."GOSMActivity"=${gosmactivity}
  	        AND PADP.id NOT IN (SELECT PADPSI."directPayment"
  	        				  FROM "PreActivityDirectPaymentSignatory" PADPSI
  	        				 WHERE PADPSI.signatory=${idnumber}
  	        				   AND PADPSI.id IN (SELECT MIN(PADPS.id)
  	        				   					   FROM "PreActivityDirectPaymentSignatory" PADPS JOIN "PreActivityDirectPayment" PADPI
  	        				   					   													ON PADPI.id=PADPS."directPayment"
  	        				   					  WHERE PADPS.status=0
  	        				   					    AND PADPI."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PADPS."directPayment"))
  	   GROUP BY PADP."GOSMActivity", PP.ACTUALDATESTART, PADP.STATUS, PADP.id) 

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 2 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status, 0 as approval
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

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 3 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status, 1 as approval
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
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id)	) U
ORDER BY approval ASC, startdate ASC;