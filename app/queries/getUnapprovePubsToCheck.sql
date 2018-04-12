  SELECT AP."GOSMActivity" as GOSMID,TO_CHAR(PP.ACTUALDATESTART,' Mon DD, YYYY') as TARGETDATE, GA.STRATEGIES AS TITLE,MAX(AP."submissionID"), AP."status"
    FROM "ActivityPublicity" AP JOIN PROJECTPROPOSAL PP
  							      ON AP."GOSMActivity" = PP.GOSMACTIVITY
  							    JOIN GOSMACTIVITY GA
 								  ON PP.GOSMACTIVITY = GA.ID
 								JOIN GOSM G
 								  ON GA.GOSM = G.ID
   WHERE AP."status" = 0 AND  G.TERMID = system_get_current_term_id()
GROUP BY 1,2,3,5