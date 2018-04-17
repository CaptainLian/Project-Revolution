SELECT activity as gosmactivity, GA.strategies as activityname,
       (cast(venue as decimal) + cast(equipment as decimal) + cast(materials as decimal) + cast(registration as decimal) + 
        cast(timeend as decimal) + 
       cast(activityexecution as decimal) + cast(hosts as decimal) + cast(facilitators as decimal) + cast(presentation as decimal) + 
       cast(activities as decimal) + 
       cast(organizationstandingpresentation as decimal) + cast(timestart as decimal) + 
       cast(person1ea as decimal) + cast(person1loa as decimal) + cast(person1iitskoa as decimal) + cast(person1iomwm as decimal) + 
       cast(person2ea as decimal) + cast(person2loa as decimal) + cast(person2iitskoa as decimal) + 
       cast(person2iomwm as decimal)) as amtgrade, 

       evaluator, AMTE.status, datereserved, AT.name as activitytype,
       TO_CHAR(AMTE.dateevaluated,'Mon DD, YYYY') AS dateevaluated,
       G.studentorganization
  FROM public.amtactivityevaluation AMTE JOIN GOSMACTIVITY GA
					                                 ON AMTE.activity=GA.ID
					                               JOIN GOSM G
					                                 ON GA.GOSM=G.ID
                                         JOIN ACTIVITYTYPE AT
                                           ON GA.ACTIVITYTYPE=AT.ID
 WHERE AMTE.status=3
   AND G.studentorganization=${studentOrganization} 
   AND G.TERMID=${termID};
