SELECT COUNT(GA.id) as related
  FROM GOSMACTIVITY GA JOIN GOSM G
		      ON G.ID=GA.GOSM
 WHERE isrelatedtoorganizationnature=true
   AND G.studentorganization=${org}
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