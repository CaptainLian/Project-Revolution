SELECT GA.Strategies as activityname, GA.Budget, SUM(PPRE.quantity*PPRE.unitcost) as expenses,
		COUNT(PPRE.id) as particulars, GA.isrelatedtoorganizationnature
  FROM ((SELECT PADPP."particular" as particular, 1 as type
	  	   FROM "PreActivityDirectPaymentParticular" PADPP JOIN "PreActivityDirectPayment" PADP
							    							 ON PADPP."directPayment"=PADP.id
	 	  WHERE PADP.status=1)
	 
 UNION (SELECT PADPP."particular" as particular, 2 as type
		  FROM "PreActivityCashAdvanceParticular" PADPP JOIN "PreActivityCashAdvance" PADP
							  						      ON PADPP."cashAdvance"=PADP.id
	 	 WHERE PADP.status=1)
	 
 UNION (SELECT PADPP."particular" as particular, 3 as type
	  	  FROM "PreActivityBookTransferParticular" PADPP JOIN "PreActivityBookTransfer" PADP
							 							   ON PADPP."bookTransfer"=PADP.id
	 	  WHERE PADP.status=1)) U JOIN PROJECTPROPOSALEXPENSES PPRE
						 		    ON PPRE.id=U.particular
				 				  JOIN PROJECTPROPOSAL PP
				   					ON PPRE.PROJECTPROPOSAL=PP.ID
				 				  JOIN GOSMACTIVITY GA
				   					ON GA.ID=PP.GOSMACTIVITY
				 				  JOIN GOSM G
				   					ON GA.GOSM=G.ID
WHERE G.studentorganization=${studentOrganization}
  AND G.TERMID=${termID}
GROUP BY GA.ID, GA.strategies, GA.budget, GA.isrelatedtoorganizationnature;

