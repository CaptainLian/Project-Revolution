UPDATE GOSMACTIVITY
	SET goals=${goals}, objectives=${objectives}, strategies=${strategies}, description=${description}, measures=${measures}, targetdatestart=${targetDateStart}, targetdateend=${targetDateEnd}, activitynature=${activityNature}, activitytype=${activityType}, activitytypeotherdescription=${activityTypeOtherDescription}, isrelatedtoorganizationnature=${isRelatedToOrganizationNature}, budget=${budget}
	WHERE id=${id}
	RETURNING id;