SELECT activity as gosmactivity, venue, equipment, materials, registration, timeend, 
       activityexecution, hosts, facilitators, presentation, activities, 
       organizationstandingpresentation, timestart,
       person1ea, person1loa, person1iitskoa, person1iomwm, 
       person2ea, person2loa, person2iitskoa, person2iomwm, 
        
       evaluator, AMTE.status, datereserved, dateevaluated, G.studentorganization
  FROM public.amtactivityevaluation AMTE JOIN GOSMACTIVITY GA
					                                 ON AMTE.activity=GA.ID
					                               JOIN GOSM G
					                                 ON GA.GOSM=G.ID
 WHERE AMTE.status=3 
   AND G.studentorganization=${studentOrganization} 
   AND G.TERMID=system_get_current_term_id();
