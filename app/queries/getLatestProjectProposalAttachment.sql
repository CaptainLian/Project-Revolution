SELECT *
  FROM PROJECTPROPOSALATTACHMENT PPA LEFT JOIN DOCUMENTATTACHMENTREQUIREMENT DAR
  									   ON PPA.REQUIREMENT = DAR.ID
 WHERE PPA.PROJECTPROPOSAL = (SELECT id 
 	                            FROM PROJECTPROPOSAL
 	                           WHERE GOSMActivity = ${projectId})
   AND PPA.SEQUENCE = (SELECT MAX(SEQUENCE)
   	 				     FROM PROJECTPROPOSALATTACHMENT
   	 			        WHERE PROJECTPROPOSAL =(SELECT id 
 	                            FROM PROJECTPROPOSAL
 	                           WHERE GOSMActivity = ${projectId})
   	 			    )