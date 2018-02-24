SELECT t.gosmactivity, SUM(t.transactions) as transactiontotal
  FROM ((SELECT PACA."GOSMActivity" as gosmactivity, COUNT(PACA.id) as transactions
	 	   FROM "PreActivityCashAdvance" PACA JOIN GOSMACTIVITY GA
					    					    ON PACA."GOSMActivity"=GA.ID
					   						  JOIN GOSM G
					 					        ON GA.GOSM=G.ID
		  WHERE G.TERMID=system_get_current_term_id()
		  GROUP BY PACA."GOSMActivity")
 UNION (SELECT PADP."GOSMActivity" as gosmactivity, COUNT(PADP.id) as transactions
	  	  FROM "PreActivityDirectPayment" PADP JOIN GOSMACTIVITY GA
												 ON PADP."GOSMActivity"=GA.ID
					   				  	       JOIN GOSM G
					 					       	 ON GA.GOSM=G.ID
	 	 WHERE G.TERMID=system_get_current_term_id()	
	 	 GROUP BY PADP."GOSMActivity")	) T	 
GROUP BY t.gosmactivity;