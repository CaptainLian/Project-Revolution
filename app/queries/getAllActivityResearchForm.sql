SELECT ARF."GOSMActivity", ARF.sequence, ARF."positionInOrganization", ARF."IUTPOTA", 
       ARF."TASMI", ARF."IFIDTA", ARF."TAWWP", ARF."TOUMTGTTA", ARF.field6, ARF.field7, ARF."WWWITA", 
       ARF."FAC", ARF."EFFA", ARF."dateSubmitted"
  FROM public."ActivityResearchForm" ARF JOIN GOSMACTIVITY GA
					   ON ARF."GOSMActivity"=GA.id
					 JOIN GOSM G
					   ON GA.GOSM=G.id
 WHERE G.termid=system_get_current_term_id();
