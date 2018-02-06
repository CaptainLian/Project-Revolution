SELECT AVG("IUTPOTA") AS first, AVG("TASMI") AS SECOND, AVG("IFIDTA") as THIRD,
	   	AVG("TAWWP") AS FOURTH, AVG("TOUMTGTTA") AS FIFTH
  FROM "ActivityResearchForm"
 WHERE "GOSMActivity" = ${gosmid}
 GROUP BY "GOSMActivity"