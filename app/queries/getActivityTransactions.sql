SELECT * --  0 approval is to be signed by current user
  FROM ((SELECT PADP.id as id, PADP."GOSMActivity" as gosmactivity, 0 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PADP.status, 0 as approval, PADP."submittedBy" as submittedby
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
  	   GROUP BY PADP."GOSMActivity", PP.ACTUALDATESTART, PADP.STATUS, PADP.id, PADP."submittedBy")     

UNION (SELECT PADP.id as id, PADP."GOSMActivity" as gosmactivity, 1 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PADP.status, 1 as approval, PADP."submittedBy" as submittedby
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
  	   GROUP BY PADP."GOSMActivity", PP.ACTUALDATESTART, PADP.STATUS, PADP.id, PADP."submittedBy") 

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 2 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status, 0 as approval, PACA."submittedBy" as submittedby
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
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id, PACA."submittedBy")

UNION (SELECT PACA.id as id, PACA."GOSMActivity" as gosmactivity, 3 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PACA.status, 1 as approval, PACA."submittedBy" as submittedby
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
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id, PACA."submittedBy")
----------------------------------------------------------------------------------------------
UNION (SELECT PABT.id as id, PABT."GOSMActivity" as gosmactivity, 4 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PABT.status, 0 as approval, PABT."submittedBy" as submittedby
	   	   FROM "PreActivityBookTransfer" PABT JOIN "PreActivityBookTransferParticular" PABTP
	   	   										  ON PABT.id=PABTP."bookTransfer"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PABTP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PABT."GOSMActivity"=${gosmactivity}
  	        AND PABT.id IN (SELECT PABTSI."bookTransfer"
  	        				  FROM "PreActivityBookTransferSignatory" PABTSI
  	        				 WHERE PABTSI.signatory=${idnumber}
  	        				   AND PABTSI.id IN (SELECT MIN(PABTS.id)
  	        				   					   FROM "PreActivityBookTransferSignatory" PABTS JOIN "PreActivityBookTransfer" PABTR
  	        				   					   												   ON PABTR.id=PABTS."bookTransfer"
  	        				   					  WHERE PABTS.status=0
  	        				   					    AND PABTR."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PABTS."bookTransfer"))
  	   GROUP BY PABT."GOSMActivity", PP.ACTUALDATESTART, PABT.STATUS, PABT.id, PABT."submittedBy")     

UNION (SELECT PABT.id as id, PABT."GOSMActivity" as gosmactivity, 5 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PABT.status, 1 as approval, PABT."submittedBy" as submittedby
	   	   FROM "PreActivityBookTransfer" PABT JOIN "PreActivityBookTransferParticular" PABTP
	   	   										  ON PABT.id=PABTP."bookTransfer"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PABTP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PABT."GOSMActivity"=${gosmactivity}
  	        AND PABT.id NOT IN (SELECT PABTSI."bookTransfer"
  	        				  FROM "PreActivityBookTransferSignatory" PABTSI
  	        				 WHERE PABTSI.signatory=${idnumber}
  	        				   AND PABTSI.id IN (SELECT MIN(PABTS.id)
  	        				   					   FROM "PreActivityBookTransferSignatory" PABTS JOIN "PreActivityBookTransfer" PABTR
  	        				   					   												   ON PABTR.id=PABTS."bookTransfer"
  	        				   					  WHERE PABTS.status=0
  	        				   					    AND PABTR."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PABTS."bookTransfer"))
  	   GROUP BY PABT."GOSMActivity", PP.ACTUALDATESTART, PABT.STATUS, PABT.id, PABT."submittedBy")

UNION (SELECT PPRE.id as id, PPRE."GOSMActivity" as gosmactivity, 6 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PPRE.status, 0 as approval, PPRE."submittedBy" as submittedby
	   	   FROM "PostProjectReimbursement" PPRE JOIN "PostProjectReimbursementParticular" PPREP
	   	   										  ON PPRE.id=PPREP."reimbursement"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PPREP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PPRE."GOSMActivity"=${gosmactivity}
  	        AND PPRE.id IN (SELECT PPRESI."reimbursement"
  	        				  FROM "PostProjectReimbursementSignatory" PPRESI
  	        				 WHERE PPRESI.signatory=${idnumber}
  	        				   AND PPRESI.id IN (SELECT MIN(PPRES.id)
  	        				   					   FROM "PostProjectReimbursementSignatory" PPRES JOIN "PostProjectReimbursement" PPREM
  	        				   					   													ON PPREM.id=PPRES."reimbursement"
  	        				   					  WHERE PPRES.status=0
  	        				   					    AND PPREM."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PPRES."reimbursement"))
  	   GROUP BY PPRE."GOSMActivity", PP.ACTUALDATESTART, PPRE.STATUS, PPRE.id, PPRE."submittedBy")

UNION (SELECT PPRE.id as id, PPRE."GOSMActivity" as gosmactivity, 7 as transaction, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate, SUM(PPE.quantity*PPE.unitcost) as amount, PPRE.status, 1 as approval, PPRE."submittedBy" as submittedby
	   	   FROM "PostProjectReimbursement" PPRE JOIN "PostProjectReimbursementParticular" PPREP
	   	   										  ON PPRE.id=PPREP."reimbursement"
	   	   										JOIN PROJECTPROPOSALEXPENSES PPE
	   	   										  ON PPREP.particular=PPE.id
												JOIN PROJECTPROPOSAL PP
												  ON PPE.PROJECTPROPOSAL=PP.ID
	 	  WHERE PPRE."GOSMActivity"=${gosmactivity}
  	        AND PPRE.id NOT IN (SELECT PPRESI."reimbursement"
  	        				  FROM "PostProjectReimbursementSignatory" PPRESI
  	        				 WHERE PPRESI.signatory=${idnumber}
  	        				   AND PPRESI.id IN (SELECT MIN(PPRES.id)
  	        				   					   FROM "PostProjectReimbursementSignatory" PPRES JOIN "PostProjectReimbursement" PPREM
  	        				   					   													ON PPREM.id=PPRES."reimbursement"
  	        				   					  WHERE PPRES.status=0
  	        				   					    AND PPREM."GOSMActivity"=${gosmactivity}
  	        				   				   GROUP BY PPRES."reimbursement"))
  	   GROUP BY PPRE."GOSMActivity", PP.ACTUALDATESTART, PPRE.STATUS, PPRE.id, PPRE."submittedBy")	) U
ORDER BY approval ASC, startdate ASC;