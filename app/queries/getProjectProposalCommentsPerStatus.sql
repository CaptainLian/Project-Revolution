SELECT GA.STRATEGIES, PPS.COMMENTS, A.FIRSTNAME, A.LASTNAME, to_char(PPS.DATESIGNED, 'MonthDD, YYYY') AS datesigned,
       to_char(PP.actualdatestart, 'MonthDD, YYYY') AS actualdatestart, GA.id as gosmactivity
  FROM PROJECTPROPOSAL PP JOIN GOSMACTIVITY GA 
  							ON PP.GOSMACTIVITY=GA.ID
  						  JOIN gosmactivityprojecthead GAPH
  						    ON GAPH.ACTIVITYID=GA.ID
  						  JOIN GOSM G
  						    ON GA.GOSM=G.ID
                JOIN PROJECTPROPOSALSIGNATORY PPS
                  ON GA.ID=PPS.GOSMACTIVITY
                JOIN ACCOUNT A
                  ON PPS.SIGNATORY=A.IDNUMBER
 WHERE G.STUDENTORGANIZATION=${studentorganization}
   AND GAPH.IDNUMBER=${idnumber}
   AND PPS.STATUS=${status}
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