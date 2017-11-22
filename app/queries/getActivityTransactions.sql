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
	 GROUP BY PACA."GOSMActivity", PP.ACTUALDATESTART, PACA.STATUS, PACA.id)	) U;