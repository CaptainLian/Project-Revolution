  SELECT AP."GOSMActivity" as GOSMID, 
    FROM "ActivityPublicity" AP JOIN PROJECTPROPOSAL PP
  							    ON AP."GOSMActivity" = PP.GOSMACTIVITY
   WHERE AP."status" = 0
GROUP BY AP."GOSMActivity"		