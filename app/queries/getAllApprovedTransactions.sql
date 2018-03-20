SELECT to_char(U."dateSigned", 'YYYY-MM-DD') as datesigned, to_char(PP."actualdatestart", 'YYYY-MM-DD') as datestart,
		GA.budget, U.transactionid, U.particulars
  FROM ((SELECT PADP.id as transactionid, PADP."GOSMActivity" as gosmactivity, 1 as type,
		PADPS."dateSigned", COUNT(PADPP."particular") as particulars
		  FROM "PreActivityDirectPayment" PADP JOIN (SELECT "directPayment", MAX(type), "dateSigned"
												       FROM "PreActivityDirectPaymentSignatory" 
						      						  GROUP BY "directPayment", "dateSigned") PADPS
						 						 ON PADP.id=PADPS."directPayment"
					       					   JOIN "PreActivityDirectPaymentParticular" PADPP
					         					 ON PADP.id=PADPP."directPayment"
	 	WHERE PADP.status=1
	    GROUP BY PADP.id, PADP."GOSMActivity", PADPS."dateSigned")
						 
UNION (SELECT PADP.id as transactionid, PADP."GOSMActivity" as gosmactivity, 2 as type,
		PADPS."dateSigned", COUNT(PADPP."particular") as particulars
		  FROM "PreActivityCashAdvance" PADP JOIN (SELECT "cashAdvance", MAX(type), "dateSigned"
						 					         FROM "PreActivityCashAdvanceSignatory" 
						      						GROUP BY "cashAdvance", "dateSigned") PADPS
						 					   ON PADP.id=PADPS."cashAdvance"
					       					 JOIN "PreActivityCashAdvanceParticular" PADPP
					         				   ON PADP.id=PADPP."cashAdvance"
	 	WHERE PADP.status=1
	 	GROUP BY PADP.id, PADP."GOSMActivity", PADPS."dateSigned")

UNION (SELECT PADP.id as transactionid, PADP."GOSMActivity" as gosmactivity, 1 as type,
		PADPS."dateSigned", COUNT(PADPP."particular") as particulars
	  	FROM "PreActivityBookTransfer" PADP JOIN (SELECT "bookTransfer", MAX(type), "dateSigned"
						       						FROM "PreActivityBookTransferSignatory" 
						      					   GROUP BY "bookTransfer", "dateSigned") PADPS
						 					  ON PADP.id=PADPS."bookTransfer"
					       					JOIN "PreActivityBookTransferParticular" PADPP
					         				  ON PADP.id=PADPP."bookTransfer"
	 	WHERE PADP.status=1
	 	GROUP BY PADP.id, PADP."GOSMActivity", PADPS."dateSigned")) U JOIN GOSMACTIVITY GA
				  ON U.gosmactivity=GA.id
				JOIN GOSM G
				  ON GA.GOSM=G.id
				JOIN PROJECTPROPOSAL PP
				  ON GA.id=PP.GOSMACTIVITY
WHERE G.studentorganization=${studentOrganization}
  AND G.TERMID=system_get_current_term_id();				 