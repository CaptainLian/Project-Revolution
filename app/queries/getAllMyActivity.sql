SELECT *
  FROM PROJECTPROPOSAL PP JOIN GOSMACTIVITY GA
  							ON PP.gosmactivity = GA.id
  						  JOIN GOSMACTIVITYPROJECTHEAD GAPH
  						    ON GA.ID  = GAPH.ACTIVITYID
 WHERE PP.status = 3
   AND GAPH.idNumber = ${idNumber}