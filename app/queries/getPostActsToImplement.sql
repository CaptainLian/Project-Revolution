SELECT * 
  FROM "PostProjectProposal" PPP JOIN GOSMACTIVITYPROJECTHEAD GAP
   			    ON PPP."GOSMActivity" = GAP.activityID
 WHERE GAP.IDNUMBER = ${idNumber}
   -- AND  PPP."GOSMActivity" IN (SELECT GA.ID 
   -- 				  FROM GOSMACTIVITY GA JOIN GOSM G
   -- 				    					 ON  GA.GOSM = G.ID   				 
   -- 				   AND (DATECREATED >= (SELECT DATESTART
   -- 				   						   FROM TERM
   -- 				   						  WHERE NOW() >= DATESTART
   -- 				   						    AND NOW() <= DATEEND ) 
   -- 				   AND DATECREATED <= (SELECT DATEEND
   -- 				   						   FROM TERM
   -- 				   						  WHERE NOW() >= DATESTART
   -- 				   						    AND NOW() <= DATEEND )  )  );