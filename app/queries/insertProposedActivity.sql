INSERT INTO GOSMACTIVITY (GOSM, goals,	objectives, strategies, description, 
							measures, targetDateStart, targetDateEnd, activityNature,
							activityType, activityTypeOtherDescription, isRelatedToOrganizationNature, budget) 
	   VALUES (${GOSM}, ${goals}, ${objectives}, ${strategies}, ${description}, 
				${measures}, ${targetDateStart}, ${targetDateEnd}, ${activityNature},
				${activityType}, ${activityTypeOtherDescription}, ${isRelatedToOrganizationNature}, ${budget})
	   RETURNING id as activityID;