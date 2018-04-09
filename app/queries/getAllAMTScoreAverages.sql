SELECT COALESCE (AVG(venue), 0) as venue, COALESCE (AVG(equipment), 0) as equipment, COALESCE (AVG(materials), 0) as materials,
       COALESCE (AVG(registration), 0) as registration, COALESCE (AVG(timeend), 0) as timeend, 
       COALESCE (AVG(activityexecution), 0) as activityexecution, COALESCE (AVG(hosts), 0) as hosts, COALESCE (AVG(facilitators), 0) as facilitators,
       COALESCE (AVG(presentation), 0) as presentation, COALESCE (AVG(activities), 0) as activities, 
       COALESCE (AVG(organizationstandingpresentation), 0) as organizationstandingpresentation, COALESCE (AVG(timestart), 0) as timestart,
       COALESCE (AVG((person1ea+person2ea)/2), 0) as personea, COALESCE (AVG((person1loa + person2loa)/2), 0) as personloa, 
       COALESCE (AVG((person1iitskoa+person2iitskoa)/2), 0) as personiitskoa, COALESCE (AVG((person1iomwm+person2iomwm)/2), 0) as personiomwm, 
       G.studentorganization
  FROM TERM T LEFT JOIN (SELECT * 
                           FROM GOSM 
                          WHERE studentorganization=${studentOrganization}) G
                     ON T.ID=G.TERMID 
              LEFT JOIN GOSMACTIVITY GA
                     ON GA.GOSM=G.ID
              LEFT JOIN (SELECT * 
                           FROM public.amtactivityevaluation AMTE
                          WHERE status=3) AMTE
                     ON AMTE.activity=GA.ID
 WHERE T.ID=${termID}
 GROUP BY G.studentorganization;
