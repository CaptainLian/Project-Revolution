INSERT INTO public.amtactivityevaluation(
            activity, venue, equipment, materials, registration, timeend, 
            hosts, presentation, activities, organizationstandingpresentation, 
            actualstarttime, actualendtime, anp, person1ea, person1loa, person1iitskoa, 
            person1iomwm, person2ea, person2loa, person2iitskoa, person2iomwm, 
            comments1, comments2, comments3, suggestions1, suggestions2, 
            suggestions3)
    VALUES (${activity}, ${venue}, ${equipment}, ${materials}, ${registration}, ${timeend}, 
            ${hosts}, ${presentation}, ${activities}, ${organizationstandingpresentation}, 
            ${actualstarttime}, ${actualendtime}, ${anp}, ${person1ea}, ${person1loa}, ${person1iitskoa}, 
            ${person1iomwm}, ${person2ea}, ${person2loa}, ${person2iitskoa}, ${person2iomwm}, 
            ${comments1}, ${comments2}, ${comments3}, ${suggestions1}, ${suggestions2}, 
            ${suggestions3});
