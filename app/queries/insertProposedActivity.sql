INSERT INTO GOSMACTIVITIES (GOSM, goals,	objectives, strategies, description, 
							measures, targetDateStart, targetDateEnd, peopleInCharge, activityNature,
							activityType, activityTypeOtherDescription, isRelatedToOrganizationNature, budget) 
	   VALUES (${GOSM}, ${goals}, ${objectives}, ${strategies}, ${description}, 
				${measures}, ${targetDateStart}, ${targetDateEnd}, ${peopleInCharge}, ${activityNature},
				${activityType}, ${activityTypeOtherDescription}, ${isRelatedToOrganizationNature}, ${budget});