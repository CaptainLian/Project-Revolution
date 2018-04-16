SELECT PP.GOSMACTIVITY AS ID, GA.STRATEGIES, AV.NAME, TO_CHAR(PPP.DATE,'Mon DD, YYYY') AS DATE, PP.VENUE as VENUEID, TO_CHAR(PPP.DATE+PPP.STARTTIME,'HH12:MI AM') AS TIME , SO.Acronym
  FROM PROJECTPROPOSAL PP JOIN GOSMACTIVITY GA
                            ON PP.GOSMACTIVITY = GA.ID
      					  JOIN "ActivityVenue" AV      					  
                            ON PP.VENUE = AV.ID
    					  JOIN (SELECT *
                              FROM ProjectProposalProgramDesign
                             WHERE SEQUENCE = 1
                             )  PPP
    					  	ON PP.ID = PPP.PROJECTPROPOSAL
    			    RIGHT JOIN AMTACTIVITYEVALUATION AAE
    			            ON GA.ID = AAE.ACTIVITY
                    JOIN GOSM G
                           ON G.ID = GA.GOSM
                        JOIN Studentorganization SO
                          ON SO.ID = G.Studentorganization

WHERE ((GA.ACTIVITYTYPE = 2
   OR GA.ACTIVITYNATURE =1
   OR GA.ACTIVITYTYPE = 3) 
  AND AAE.EVALUATOR = ${idNumber}
  AND AAE.STATUS = 1)
  AND GA.ID IN (SELECT ACTIVITY 
                  FROM AMTACTIVITYEVALUATION 
                 WHERE STATUS = 1 
                   AND (DATERESERVED >= (SELECT DATESTART
                                 FROM TERM
                                WHERE NOW() >= DATESTART
                                  AND NOW() <= DATEEND ) 
                   AND DATERESERVED <= (SELECT DATEEND
                                 FROM TERM
                                WHERE NOW() >= DATESTART
                                  AND NOW() <= DATEEND )  )
                  AND EVALUATOR = ${idNumber})
GROUP BY  PP.GOSMACTIVITY, GA.STRATEGIES, AV.NAME, PPP.DATE, PPP.STARTTIME, SO.Acronym