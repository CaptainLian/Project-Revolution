SELECT COUNT(PP.ID) as approved
FROM GOSM G JOIN GOSMACTIVITY GA
	      ON G.ID = GA.GOSM
	    JOIN PROJECTPROPOSAL PP
	      ON GA.ID = PP.GOSMACTIVITY
WHERE G.STUDENTORGANIZATION = ${org}
  AND PP.STATUS = 3
  AND GA.ID IN (SELECT GOSMACTIVITY 
              FROM PROJECTPROPOSAL 
             WHERE (ACTUALDATESTART >= (SELECT DATESTART
                                          FROM TERM
                                         WHERE NOW() >= DATESTART
                                           AND NOW() <= DATEEND ) 
               AND ACTUALDATEEND <= (SELECT DATEEND
                                       FROM TERM
                                      WHERE NOW() >= DATESTART
                                      AND NOW() <= DATEEND )  )  )
GROUP BY GA.GOSM;