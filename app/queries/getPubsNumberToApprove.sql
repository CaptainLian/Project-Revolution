  SELECT COUNT(AP."GOSMActivity") AS COUNT
    FROM "ActivityPublicity" AP JOIN PROJECTPROPOSAL PP
  							      ON AP."GOSMActivity" = PP.GOSMACTIVITY
  							    JOIN GOSMACTIVITY GA
 								  ON PP.GOSMACTIVITY = GA.ID
   WHERE AP."status" = 0
