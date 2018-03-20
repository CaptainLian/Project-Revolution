SELECT *
  FROM STUDENTORGANIZATION SO
 WHERE SO.ID IN ( SELECT G.STUDENTORGANIZATION 
                    FROM GOSMACTIVITY GA JOIN PROJECTPROPOSAL PP
                  			                   ON GA.ID=PP.GOSMACTIVITY
                                         JOIN GOSM G
                                           ON GA.GOSM=G.ID
                   WHERE PP.STATUS=3
                     AND (GA.ACTIVITYTYPE=3 OR GA.ACTIVITYTYPE=0 OR GA.ACTIVITYTYPE=2)
                     AND GA.ID IN (SELECT GOSMACTIVITY 
                  		   FROM PROJECTPROPOSAL 
                       		  WHERE (ACTUALDATESTART >= (SELECT DATESTART
                  					       FROM TERM
                     				              WHERE NOW() >= DATESTART
                  						AND NOW() <= DATEEND ) 
                     		    AND ACTUALDATEEND <= (SELECT DATEEND
                     				   	    FROM TERM
                     					   WHERE NOW() >= DATESTART
                     				             AND NOW() <= DATEEND )  )  )  );