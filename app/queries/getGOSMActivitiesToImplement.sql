SELECT id, strategies, to_char(G.targetdatestart, 'Mon DD, YYYY') AS startdate, status
  FROM ((SELECT GA.*, 0 as status
  		  FROM gosmactivity GA JOIN GOSMACITVITYPROJECTHEAD GAPH
 		 WHERE GAPH.idnumber = ${idnumber}
 		   AND id NOT IN(SELECT GOSMACTIVITY
		 				   FROM PROJECTPROPOSAL))
 UNION (SELECT GA.*, P.status as status
 		  FROM gosmactivity GA JOIN PROJECTPROPOSAL P
 		  						 ON GA.ID=P.GOSMACTIVITY
 		  					   JOIN GOSMAC GAPH
 		 WHERE GAPH.idnumber = ${idnumber})) G
 WHERE gosm=${gosm};