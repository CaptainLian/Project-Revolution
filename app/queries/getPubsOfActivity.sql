SELECT *
  FROM "ActivityPublicity" 
 WHERE "GOSMActivity" = ${gosmid}
   -- AND "submissionID" = (SELECT MAX("submissionID")
   -- 	 					   FROM "ActivityPublicity"
   -- 	 					  WHERE "GOSMActivity" = ${gosmid}
   -- 	 					   )