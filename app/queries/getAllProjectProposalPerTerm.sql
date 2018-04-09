SELECT G.studentorganization, PPR.status, GA.isingosm, PPR.timespended, GA.id as gosmactivity
  FROM PROJECTPROPOSAL PPR JOIN GOSMACTIVITY GA
			     ON PPR.GOSMACTIVITY=GA.ID
			   JOIN GOSM G
			     ON GA.GOSM=G.ID
 WHERE G.TERMID=${termID};
