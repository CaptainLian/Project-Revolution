INSERT INTO "ActivityPublicity" ("GOSMActivity","submissionID","modeOfDistribution","targetPostingDate",
			"submittedBy","dateChecked","status","filename","filenameToShow","description")
  	 VALUES (${gosmid},${sid},${mod},${tpd},${sb},now(),${status},${filename},${filenameToShow},${ds})