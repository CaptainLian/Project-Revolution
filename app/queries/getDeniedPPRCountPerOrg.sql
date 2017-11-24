SELECT COUNT(PP.ID)
FROM GOSM G JOIN GOSMACTIVITY GA
	      ON G.ID = GA.GOSM
	    JOIN PROJECTPROPOSAL PP
	      ON GA.ID = PP.GOSMACTIVITY
WHERE G.STUDENTORGANIZATION = ${org}
  AND PP.STATUS = 1
GROUP BY PP.ID;