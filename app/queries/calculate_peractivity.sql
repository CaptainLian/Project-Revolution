SELECT AVG("IUTPOTA") AS first, AVG("TASMI") AS SECOND, AVG("IFIDTA") as THIRD,
	   	AVG("TAWWP") AS FOURTH, AVG("TOUMTGTTA") AS FIFTH
  FROM "ActivityResearchForm"
 WHERE "GOSMActivity" = ${gosmid}
 GROUP BY "GOSMActivity"


 -- SELECT COUNT("IUTPOTA") AS countfirst,"IUTPOTA", COUNT("TASMI") AS countsecond,"TASMI", COUNT("IFIDTA") as countthird, "IFIDTA",
	--    	COUNT("TAWWP") AS countfourth,"TAWWP", COUNT("TOUMTGTTA") AS countfifth,"TOUMTGTTA"
 --  FROM "ActivityResearchForm"
 -- WHERE "GOSMActivity" = 1
 -- GROUP BY "GOSMActivity","IUTPOTA","TASMI","IFIDTA","TAWWP","TOUMTGTTA"