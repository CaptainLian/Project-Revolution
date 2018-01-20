SELECT  to_char(PP.actualdatestart, 'MM/DD/YYYY') AS "datestart", U.transaction, GA.strategies, U.amount
  FROM 	((SELECT 1 as transaction, PACA.id, (PPRE.quantity*PPRE.unitcost) as amount, PACA."GOSMActivity" as gosmactivity, PACA.status
		    FROM "PreActivityCashAdvance" PACA JOIN "PreActivityCashAdvanceParticular" PACAP
										         ON PACA.id=PACAP."cashAdvance"
					     					   JOIN PROJECTPROPOSALEXPENSES PPRE
					       						 ON PPRE.ID=PACAP."particular")
UNION (SELECT 2 as transaction, PACA.id, (PPRE.quantity*PPRE.unitcost) as amount, PACA."GOSMActivity" as gosmactivity, PACA.status
	  	 FROM "PreActivityDirectPayment" PACA JOIN "PreActivityDirectPaymentParticular" PACAP
									          ON PACA.id=PACAP."directPayment"
					     					JOIN PROJECTPROPOSALEXPENSES PPRE
					       					  ON PPRE.ID=PACAP."particular")
UNION (SELECT 3 as transaction, PACA.id, (PPRE.quantity*PPRE.unitcost) as amount, PACA."GOSMActivity" as gosmactivity, PACA.status
	  	 FROM "PreActivityBookTransfer" PACA JOIN "PreActivityBookTransferParticular" PACAP
									          ON PACA.id=PACAP."bookTransfer"
					     					JOIN PROJECTPROPOSALEXPENSES PPRE
					       					  ON PPRE.ID=PACAP."particular")) U JOIN GOSMACTIVITY GA
										   										  ON GA.ID=U.gosmactivity
										 										JOIN GOSM G
										   										  ON G.ID=GA.GOSM
										 										JOIN PROJECTPROPOSAL PP
										   										  ON GA.ID=PP.GOSMACTIVITY
WHERE U.status=1
  AND G.studentorganization=${studentOrganization}
  AND G.TERMID=system_get_current_term_id();