INSERT INTO GOSMACTIVITY (GOSM, goals,	objectives, strategies, description, 
							measures, targetDateStart, targetDateEnd, activityNature,
							activityType, activityTypeOtherDescription, isRelatedToOrganizationNature, budget,isingosm) 
	   VALUES (${GOSM}, ${goals}, ${objectives}, ${strategies}, ${description}, 
				${measures}, ${targetDateStart}, ${targetDateEnd}, ${activityNature},
				${activityType}, ${activityTypeOtherDescription}, ${isRelatedToOrganizationNature}, ${budget}, ${notingosm})
	   RETURNING id as activityID;