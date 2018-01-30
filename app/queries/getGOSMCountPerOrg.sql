SELECT COUNT(GA.id) as gosm
  FROM GOSMACTIVITY GA JOIN GOSM G
  						 ON GA.GOSM=G.ID
 WHERE G.STUDENTORGANIZATION=${org}
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