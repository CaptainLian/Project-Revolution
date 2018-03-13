-- TODO: optimizable query
SELECT G.id, G.strategies, to_char(G.targetdatestart, 'Mon DD, YYYY') AS startdate, G.status
  FROM ((SELECT GA.*, 0 as status
  		  FROM gosmactivity GA JOIN GOSMACTIVITYPROJECTHEAD GAPH
  		  						 ON GAPH.ACTIVITYID=GA.ID
 		 WHERE GAPH.idnumber = ${idnumber}
 		   AND id NOT IN(SELECT GOSMACTIVITY
		 				   FROM PROJECTPROPOSAL))
 UNION (SELECT GA.*, P.status as status
 		  FROM gosmactivity GA JOIN PROJECTPROPOSAL P
 		  						 ON GA.ID=P.GOSMACTIVITY
 		  					   JOIN GOSMACTIVITYPROJECTHEAD GAPH
 		  					     ON GAPH.ACTIVITYID=GA.ID
 		 WHERE GAPH.idnumber = ${idnumber})) G
   JOIN GOSM
     ON g.gosm = gosm.id
 WHERE g.gosm=${gosm}
   AND gosm.status = 3;