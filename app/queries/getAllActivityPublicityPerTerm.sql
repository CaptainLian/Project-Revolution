SELECT *, AP.status as publicitystatus
  FROM "ActivityPublicity" AP JOIN GOSMACTIVITY GA
				ON AP."GOSMActivity"=GA.id
			      JOIN GOSM G
			        ON GA.GOSM=G.id
 WHERE G.TERMID=${termID};