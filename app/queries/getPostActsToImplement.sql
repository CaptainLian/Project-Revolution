SELECT GA.STRATEGIES AS STRATEGIES, PPP.STATUS as STATUS, GA.ID AS ID, TO_CHAR(PP.actualdatestart,'Mon DD, YYYY') as startdate
  FROM "PostProjectProposal" PPP JOIN GOSMACTIVITYPROJECTHEAD GAP
   			    				   ON PPP."GOSMActivity" = GAP.activityID
   			    				 JOIN PROJECTPROPOSAL PP
 								   ON PPP."GOSMActivity" = PP.GOSMACTIVITY
 								 JOIN GOSMACTIVITY GA
 								   ON PP.GOSMACTIVITY = GA.ID
 WHERE GAP.IDNUMBER = ${idNumber}

   AND PP.status = 3

   AND  PPP."GOSMActivity" IN (SELECT GA.ID 
   				  FROM GOSMACTIVITY GA JOIN GOSM G
   				    					 ON  GA.GOSM = G.ID   				 
   				   AND (DATECREATED >= (SELECT DATESTART
   				   						   FROM TERM
   				   						  WHERE NOW() >= DATESTART
   				   						    AND NOW() <= DATEEND ) 
   				   AND DATECREATED <= (SELECT DATEEND
   				   						   FROM TERM
   				   						  WHERE NOW() >= DATESTART
   				   						    AND NOW() <= DATEEND )  )  );