SELECT gosmactivity, COUNT(transactions) as transactiontotal
  FROM ((SELECT PACA."GOSMActivity" as gosmactivity, PACA.id as transactions
	 	   FROM "PreActivityCashAdvance" PACA JOIN GOSMACTIVITY GA
					    					    ON PACA."GOSMActivity"=GA.ID
					   						  JOIN GOSM G
					 					        ON GA.GOSM=G.ID
		  WHERE G.TERMID=system_get_current_term_id())
 UNION (SELECT PADP."GOSMActivity" as gosmactivity, PADP.id as transactions
	  	  FROM "PreActivityDirectPayment" PADP JOIN GOSMACTIVITY GA
												 ON PADP."GOSMActivity"=GA.ID
					   				  	       JOIN GOSM G
					 					       	 ON GA.GOSM=G.ID
	 	 WHERE G.TERMID=system_get_current_term_id()	)	) T	 
GROUP BY gosmactivity;