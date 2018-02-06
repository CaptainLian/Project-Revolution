INSERT INTO "ActivityPublicity" ("GOSMActivity","modeOfDistribution","targetPostingDate",
			"submittedBy","status","filename","filenameToShow","description")
  	 VALUES (${gosmid},${mod},${tpd},${sb},${status},${filename},${filenameToShow},${ds}) RETURNING id