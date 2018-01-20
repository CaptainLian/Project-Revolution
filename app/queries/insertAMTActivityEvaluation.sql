INSERT INTO AMTACTIVITYEVALUATION 
			(ACTIVITY,EVALUATOR,DATERESERVED,VENUE,STATUS)
	 VALUES (${activity},${idNumber},now(),${venue},${status}) 
	     ON CONFLICT (ACTIVITY) DO UPDATE 
							    SET STATUS = 1, 
							        EVALUATOR = ${idNumber},
							        DATERESERVED = now()


