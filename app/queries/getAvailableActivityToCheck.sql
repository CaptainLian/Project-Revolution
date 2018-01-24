-- SELECT PP.GOSMACTIVITY AS ID, GA.STRATEGIES, AV.NAME, TO_CHAR(PPP.DATE,'Mon DD, YYYY') AS DATE, CONCAT(TO_CHAR(PPP.DATE+PPP.STARTTIME,'HH12:MI AM'),' - ',TO_CHAR(PPP.DATE+PPP.ENDTIME,'HH12:MI AM')) AS TIME, PP.VENUE as VENUEID
--   FROM PROJECTPROPOSAL PP  JOIN GOSMACTIVITY GA
--                             ON PP.GOSMACTIVITY = GA.ID
--       					   JOIN "ActivityVenue" AV      					  
--                             ON PP.VENUE = AV.ID
--     					   LEFT JOIN ProjectProposalProgramDesign PPP
--     					  	ON PP.ID = PPP.PROJECTPROPOSAL

-- WHERE ((GA.ACTIVITYTYPE = 2
--    OR GA.ACTIVITYNATURE =1) 
--   AND PP.STATUS=3)
--   AND GA.ID  IN (SELECT ACTIVITY
--                       FROM AMTACTIVITYEVALUATION
--                      WHERE STATUS <>3 )
--   AND GA.ID  IN (SELECT ACTIVITY
--                       FROM AMTACTIVITYEVALUATION
--                      WHERE STATUS = 0 )
--  GROUP BY GA.ID
SELECT PP.GOSMACTIVITY AS ID, GA.STRATEGIES, AV.NAME, TO_CHAR(PPP.DATE,'Mon DD, YYYY') AS DATE, PP.VENUE as VENUEID
  FROM PROJECTPROPOSAL PP  JOIN GOSMACTIVITY GA
                            ON PP.GOSMACTIVITY = GA.ID
                   JOIN "ActivityVenue" AV                  
                            ON PP.VENUE = AV.ID
                 LEFT JOIN ProjectProposalProgramDesign PPP
                  ON PP.ID = PPP.PROJECTPROPOSAL

WHERE ((GA.ACTIVITYTYPE = 2
   OR GA.ACTIVITYNATURE =1) 
  AND PP.STATUS=3)
  AND GA.ID  IN (SELECT ACTIVITY
                      FROM AMTACTIVITYEVALUATION
                     WHERE STATUS <>3 )
  AND GA.ID  IN (SELECT ACTIVITY
                      FROM AMTACTIVITYEVALUATION
                     WHERE STATUS = 0 )
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
  GROUP BY  PP.GOSMACTIVITY, GA.STRATEGIES, AV.NAME, PPP.DATE;