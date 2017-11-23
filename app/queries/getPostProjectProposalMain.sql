SELECT TO_CHAR(PP.ACTUALDATESTART, 'Mon DD, YYYY') AS DATESTART,TO_CHAR(PP.ACTUALDATEEND, 'Mon DD, YYYY') AS DATEEND,
	   PPP."isBriefContextCompleted", PPP."isOtherFinanceDocumentsCompleted", PPP."isFinanceDocumentCompleted",
	   GA.STRATEGIES, GA.ID, PPP."status", PPP."comments", PPP."sectionsToBeEdited"
  FROM "PostProjectProposal" PPP JOIN GOSMACTIVITYPROJECTHEAD GAP
   			    				   ON PPP."GOSMActivity" = GAP.activityID
   			    				 JOIN PROJECTPROPOSAL PP
 								   ON PPP."GOSMActivity" = PP.GOSMACTIVITY
 								 JOIN GOSMACTIVITY GA
 								   ON PP.GOSMACTIVITY = GA.ID
 WHERE GAP.IDNUMBER = ${idNumber}
   AND GA.ID = ${gosmid}
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