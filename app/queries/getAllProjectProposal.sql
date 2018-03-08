SELECT G.studentorganization, PPR.status, GA.isingosm, PPR.timespended
  FROM PROJECTPROPOSAL PPR JOIN GOSMACTIVITY GA
			     ON PPR.GOSMACTIVITY=GA.ID
			   JOIN GOSM G
			     ON GA.GOSM=G.ID
 WHERE G.TERMID=system_get_current_term_id();
