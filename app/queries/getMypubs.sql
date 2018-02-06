SELECT *
  FROM "ActivityPublicity"
 WHERE "GOSMActivity" = ${gosmid}
   AND "status" <> 4
   -- AND "submittedBy" = ${idNumber}