INSERT INTO GOSMACTIVITIES (startYear, endYear, studentOrganization, goals,	objectives, description, 
							measures, targetDateStart, targetDateEnd, peopleInCharge, activityNature,
							activityType, activityTypeOthersDescription, isRelatedToOrganization, budget) 
	   VALUES (${startYear}, ${endYear}, ${studentOrganization}, ${goals}, ${objectives}, ${description}, 
				${measures}, ${targetDateStart}, ${targetDateEnd}, ${peopleInCharge}, ${activityNature},
				${activityType}, ${activityTypeOthersDescription}, ${isRelatedToOrganization}, ${budget});