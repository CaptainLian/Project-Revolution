SELECT AVG(venue) as venue, AVG(equipment) as equipment, AVG(materials) as materials,
       AVG(registration) as registration, AVG(timeend) as timeend, 
       AVG(activityexecution) as activityexecution, AVG(hosts) as hosts, AVG(facilitators) as facilitators,
       AVG(presentation) as presentation, AVG(activities) as activities, 
       AVG(organizationstandingpresentation) as organizationstandingpresentation, AVG(timestart) as timestart,
       AVG((person1ea+person2ea)/2) as personea, AVG((person1loa + person2loa)/2) as personloa, 
       AVG((person1iitskoa+person2iitskoa)/2) as personiitskoa, AVG((person1iomwm+person2iomwm)/2) as personiomwm, 
       G.studentorganization
  FROM public.amtactivityevaluation AMTE JOIN GOSMACTIVITY GA
                                           ON AMTE.activity=GA.ID
                                         JOIN GOSM G
                                           ON GA.GOSM=G.ID
 WHERE AMTE.status=3 
   AND G.studentorganization=${studentOrganization}
   AND G.TERMID=system_get_current_term_id()
 GROUP BY G.studentorganization;
