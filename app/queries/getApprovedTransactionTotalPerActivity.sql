SELECT T.gosmactivity, SUM(transactions) as approvedtotal
  FROM ((SELECT PACA."GOSMActivity" as gosmactivity, COUNT(PACA.id) as transactions
	 	   FROM "PreActivityCashAdvance" PACA JOIN GOSMACTIVITY GA
					    					    ON PACA."GOSMActivity"=GA.ID
					   						  JOIN GOSM G
					 					        ON GA.GOSM=G.ID
		  WHERE G.TERMID=system_get_current_term_id()	
		    AND PACA.status=1
		  GROUP BY PACA."GOSMActivity")
 UNION (SELECT PADP."GOSMActivity" as gosmactivity, COUNT(PADP.id) as transactions
	  	  FROM "PreActivityDirectPayment" PADP JOIN GOSMACTIVITY GA
												 ON PADP."GOSMActivity"=GA.ID
					   				  	       JOIN GOSM G
					 					       	 ON GA.GOSM=G.ID
	 	 WHERE G.TERMID=system_get_current_term_id()
	 	   AND PADP.status=1	
	 	 GROUP BY PADP."GOSMActivity")
 UNION (SELECT PABT."GOSMActivity" as gosmactivity, COUNT(PABT.id) as transactions
	  	  FROM "PreActivityBookTransfer" PABT JOIN GOSMACTIVITY GA
												 ON PABT."GOSMActivity"=GA.ID
					   				  	       JOIN GOSM G
					 					       	 ON GA.GOSM=G.ID
	 	 WHERE G.TERMID=system_get_current_term_id()
	 	   AND PABT.status=1	
	 	 GROUP BY PABT."GOSMActivity")
 UNION (SELECT PPRE."GOSMActivity" as gosmactivity, COUNT(PPRE.id) as transactions
	  	  FROM "PostProjectReimbursement" PPRE JOIN GOSMACTIVITY GA
												 ON PPRE."GOSMActivity"=GA.ID
					   				  	       JOIN GOSM G
					 					       	 ON GA.GOSM=G.ID
	 	 WHERE G.TERMID=system_get_current_term_id()
	 	   AND PPRE.status=1	
	 	 GROUP BY PPRE."GOSMActivity")) T	 
GROUP BY T.gosmactivity;