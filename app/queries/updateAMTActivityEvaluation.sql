UPDATE public.amtactivityevaluation
   SET equipment=${equipment}, materials=${materials}, registration=${registration}, 
       timeend=${timeend}, activityexecution=${activityexecution}, hosts=${hosts},
       facilitators=${facilitators}, presentation=${presentation}, activities=${activities},
       organizationstandingpresentation=${organizationstandingpresentation}, actualstarttime=${actualstarttime}, 
       actualendtime=${actualendtime}, anp=${anp}, person1ea=${person1ea}, person1loa=${person1loa},
       person1iitskoa=${person1iitskoa}, person1iomwm=${person1iomwm}, person2ea=${person2ea},
       person2loa=${person2loa}, person2iitskoa=${person2iitskoa}, person2iomwm=${person2iomwm},
       status=3, dateevaluated=now()
 WHERE activiy=${activity};
