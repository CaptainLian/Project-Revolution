SELECT ARF."GOSMActivity", ARF.sequence, ARF."positionInOrganization", ARF."IUTPOTA", 
       ARF."TASMI", ARF."IFIDTA", ARF."TAWWP", ARF."TOUMTGTTA", ARF.field6, ARF.field7, ARF."WWWITA", 
       ARF."FAC", ARF."EFFA", ARF."dateSubmitted", G.studentorganization
  FROM public."ActivityResearchForm" ARF JOIN GOSMACTIVITY GA
					   ON ARF."GOSMActivity"=GA.id
					 JOIN GOSM G
					   ON GA.GOSM=G.id
 WHERE G.termid=${termID};
