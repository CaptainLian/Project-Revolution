SELECT id, strategies, to_char(G.targetdatestart, 'Mon DD, YYYY') AS startdate, status
  FROM ((SELECT *, 0 as status
  		  FROM gosmactivity
 		 WHERE id NOT IN(SELECT GOSMACTIVITY
		 				   FROM PROJECTPROPOSAL))
 UNION (SELECT GA.*, P.status as status
 		  FROM gosmactivity GA JOIN PROJECTPROPOSAL P
 		  						 ON GA.ID=P.GOSMACTIVITY)) G
 WHERE gosm=${gosm};