INSERT INTO AMTACTIVITYEVALUATION 
			(ACTIVITY,EVALUATOR,DATERESERVED,VENUE)
	 VALUES (${activity},${idNumber},now(),${venue}) 
	     ON CONFLICT (ACTIVITY) DO UPDATE 
							    SET STATUS = 1, 
							        EVALUATOR = ${idNumber},
							        DATERESERVED = now()


