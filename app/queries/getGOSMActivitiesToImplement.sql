SELECT id, strategies, to_char(G.targetdatestart, 'Mon DD, YYYY') AS startdate, status
  FROM ((SELECT *, 0 as status
  		  FROM gosmactivity
 		 WHERE id NOT IN(SELECT GOSMACTIVITY
		 				   FROM PROJECTPROPOSAL))
 UNION (SELECT *, 1 as status
 		  FROM gosmactivity
 		 WHERE id IN(SELECT GOSMACTIVITY
	      			   FROM PROJECTPROPOSAL
	      			  WHERE status=1))
 UNION (SELECT *, 2 as status
 		  FROM gosmactivity
 		 WHERE id IN(SELECT GOSMACTIVITY
 		 			   FROM PROJECTPROPOSAL
 		 			  WHERE status=4))) G
 WHERE gosm=${gosm};