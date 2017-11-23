SELECT GA.STRATEGIES AS TITLE, SO.NAME AS ORG, AT.NAME AS TYPE, AN.NAME AS NATURE, AV."name" as VENUE, GA.OBJECTIVES AS OBJ, 
	   PPP."objectives" as OBJANS, PPP."WATTTWITA" as PA, PPP."WWYGLIETA" AS PB, PPP."HDTATYLCTTDOTP" AS PC, PPP."WATTWWAWCYDTPTFHA" AS PD,
	   PP.ENMP, PP.ENP, PPP."preparedBy", PPP."galsfilename",PPP."GOSMActivity" as id, PPP."ANP", PPP."ANMP"

  FROM PROJECTPROPOSAL PP       JOIN GOSMACTIVITY GA
								 ON PP.GOSMACTIVITY = GA.ID
							   JOIN ACTIVITYNATURE AN
							     ON GA.ACTIVITYNATURE=AN.ID
							   JOIN ACTIVITYTYPE AT
							     ON GA.ACTIVITYTYPE=AT.ID
							   JOIN GOSM G
							     ON G.ID=GA.GOSM
							   JOIN STUDENTORGANIZATION SO
							     ON SO.ID=G.STUDENTORGANIZATION
							   JOIN "PostProjectProposal" PPP
							     ON PP.GOSMACTIVITY = PPP."GOSMActivity"
							   JOIN "ActivityVenue" AV
							     ON PP.VENUE = AV."id"

WHERE GOSMACTIVITY = ${gosmid}  

