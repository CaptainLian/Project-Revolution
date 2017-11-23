SELECT GA.ID as gosmactivity, GA.STRATEGIES, SO.NAME, SO.ID as organizationid, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate 
  FROM GOSMACTIVITY GA JOIN PROJECTPROPOSAL PP
			                   ON GA.ID=PP.GOSMACTIVITY
		                   JOIN GOSM G
		                     ON GA.GOSM=G.ID
		                   JOIN STUDENTORGANIZATION SO
		                     ON G.STUDENTORGANIZATION=SO.ID
 WHERE PP.ISEXPENSE=true
   AND PP.STATUS=3
   AND GA.ID IN (SELECT GOSMACTIVITY 
		               FROM PROJECTPROPOSAL 
     		          WHERE (ACTUALDATESTART >= (SELECT DATESTART
				                              	       FROM TERM
   				                                    WHERE NOW() >= DATESTART
				                                    		AND NOW() <= DATEEND ) 
   		              AND ACTUALDATEEND <= (SELECT DATEEND
   				                            	    FROM TERM
   					                               WHERE NOW() >= DATESTART
   				                                   AND NOW() <= DATEEND )  )  );