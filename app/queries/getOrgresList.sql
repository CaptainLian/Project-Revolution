SELECT TO_CHAR(PPR.actualdatestart,'Mon DD, YYYY') AS ADATE, *
  FROM (SELECT COUNT("GOSMActivity") as COUNT, "GOSMActivity"
  		  FROM "ActivityResearchForm"
 	 	GROUP BY "GOSMActivity"	  ) ARF JOIN PROJECTPROPOSAL PPR 
  									      ON ARF."GOSMActivity" = PPR.GOSMActivity
  								   	    JOIN GOSMActivity GA
  								          ON ARF."GOSMActivity" = GA.ID
  								   		JOIN GOSM G
  								   		  ON GA.GOSM = G.ID

 WHERE GA.ID in (SELECT activityID
 				   FROM GOSMACtivityProjectHead
 				  WHERE idNumber = ${idNumber})
 AND G.TERMID = system_get_current_term_id();
 