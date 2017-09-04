INSERT INTO GOSMACTIVITIES (startYear, endYear, studentOrganization, goals,	objectives, strategies, description, 
							measures, targetDateStart, targetDateEnd, peopleInCharge, activityNature,
							activityType, activityTypeOtherDescription, isRelatedToOrganizationNature, budget) 
	   VALUES (${startYear}, ${endYear}, ${studentOrganization}, ${goals}, ${objectives}, ${strategies}, ${description}, 
				${measures}, ${targetDateStart}, ${targetDateEnd}, ${peopleInCharge}, ${activityNature},
				${activityType}, ${activityTypeOtherDescription}, ${isRelatedToOrganizationNature}, ${budget});