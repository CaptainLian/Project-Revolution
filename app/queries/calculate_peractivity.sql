-- SELECT AVG("IUTPOTA") AS first, AVG("TASMI") AS SECOND, AVG("IFIDTA") as THIRD,
-- 	   	AVG("TAWWP") AS FOURTH, AVG("TOUMTGTTA") AS FIFTH
--   FROM "ActivityResearchForm"
--  WHERE "GOSMActivity" = ${gosmid}
--  GROUP BY "GOSMActivity"


 -- SELECT COUNT("IUTPOTA") AS countfirst,"IUTPOTA", COUNT("TASMI") AS countsecond,"TASMI", COUNT("IFIDTA") as countthird, "IFIDTA",
	--    	COUNT("TAWWP") AS countfourth,"TAWWP", COUNT("TOUMTGTTA") AS countfifth,"TOUMTGTTA"
 --  FROM "ActivityResearchForm"
 -- WHERE "GOSMActivity" = ${gosmid}
 -- GROUP BY "GOSMActivity","IUTPOTA","TASMI","IFIDTA","TAWWP","TOUMTGTTA"

 	(	SELECT COUNT("IUTPOTA"), "IUTPOTA", 1 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "IUTPOTA" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid}
	  GROUP BY "GOSMActivity","IUTPOTA")

	 UNION ALL

	 (	SELECT COUNT("TASMI"), "TASMI", 2 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "TASMI" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid}
	  GROUP BY "GOSMActivity","TASMI"
	  )
 	
 	UNION ALL
	 
	 (	SELECT COUNT("IFIDTA"), "IFIDTA", 3 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "IFIDTA" IS NOT NULL
	  	 AND "GOSMActivity" = ${gosmid}
	  GROUP BY "GOSMActivity","IFIDTA")

	   UNION ALL
	 
	 (	SELECT COUNT("TAWWP"), "TAWWP", 4 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "TAWWP" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid}
	  GROUP BY "GOSMActivity","TAWWP")

	   UNION ALL
	 
	 (	SELECT COUNT("TOUMTGTTA"), "TOUMTGTTA", 5 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "TOUMTGTTA" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid} 
	  GROUP BY "GOSMActivity","TOUMTGTTA")

	  
	   UNION ALL
	 
	 (	SELECT COUNT("field6"), "field6", 6 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "field6" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid} 
	  GROUP BY "GOSMActivity","field6")
 

	   UNION ALL
	 
	 (	SELECT COUNT("field7"), "field7", 7 AS TEST
	  	  FROM "ActivityResearchForm"
	  	 WHERE "field7" IS NOT NULL
	  	 AND "GOSMActivity" =  ${gosmid} 
	  GROUP BY "GOSMActivity","field7")

	  ORDER BY TEST, "IUTPOTA" DESC