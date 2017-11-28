SELECT TO_CHAR(PPR.actualdatestart,'Mon DD, YYYY') AS ADATE, *
  FROM "ActivityResearchForm" ARF JOIN PROJECTPROPOSAL PPR 
  									ON ARF."GOSMActivity" = PPR.GOSMActivity
  								  JOIN GOSMActivity GA
  								    ON ARF."GOSMActivity" = GA.ID
 WHERE GA.ID = ${gosmid}