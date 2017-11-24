SELECT id, strategies, to_char(G.targetdatestart, 'Mon DD, YYYY') AS startdate, status
  FROM ((SELECT *, 0 as status
  		  FROM gosmactivity
 		 WHERE id NOT IN(SELECT GOSMACTIVITY
		 				   FROM PROJECTPROPOSAL))
 UNION (SELECT *, status as status
 		  FROM gosmactivity
 		 WHERE id IN(SELECT GOSMACTIVITY
	      			   FROM PROJECTPROPOSAL))) G
 WHERE gosm=${gosm};