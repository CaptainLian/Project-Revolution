
SELECT COUNT(PP.ID) AS num
  FROM PROJECTPROPOSAL PP JOIN GOSMACTIVITY GA 
  							ON PP.GOSMACTIVITY=GA.ID
  						  JOIN gosmactivityprojecthead GAPH
  						    ON GAPH.ACTIVITYID=GA.ID
  						  JOIN GOSM G
  						    ON GA.GOSM=G.ID
 WHERE G.STUDENTORGANIZATION=${studentorganization}
   AND GAPH.IDNUMBER=${idnumber}
   AND GA.ID IN (SELECT GOSMACTIVITY 
             	   FROM PROJECTPROPOSAL 
             	  WHERE (ACTUALDATESTART >= (SELECT DATESTART
                                       		   FROM TERM
                                  		      WHERE NOW() >= DATESTART
                                           		AND NOW() <= DATEEND ) 
               		AND ACTUALDATEEND <= (SELECT DATEEND
                    	                    FROM TERM
                         	               WHERE NOW() >= DATESTART
                              		         AND NOW() <= DATEEND )  )  )
 GROUP BY PP.ID;