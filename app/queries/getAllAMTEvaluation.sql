SELECT activity, venue, equipment, materials, registration, timeend, 
       activityexecution, hosts, facilitators, presentation, activities, 
       organizationstandingpresentation, timestart, actualstarttime, 
       actualendtime, anp, person1ea, person1loa, person1iitskoa, person1iomwm, 
       person2ea, person2loa, person2iitskoa, person2iomwm, comments1, 
       comments2, comments3, suggestions1, suggestions2, suggestions3, 
       evaluator, AMTE.status, datereserved, dateevaluated, G.studentorganization
  FROM public.amtactivityevaluation AMTE JOIN GOSMACTIVITY GA
					                       ON AMTE.activity=GA.ID
					                     JOIN GOSM G
					                       ON GA.GOSM=G.ID
                                         JOIN ACTIVITYTYPE AT
                                           ON GA.ACTIVITYTYPE=AT.ID
 WHERE G.TERMID=system_get_current_term_id();
