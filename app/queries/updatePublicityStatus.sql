UPDATE "ActivityPublicity"
   SET "status" = ${status},
   	   "comments" = ${comment},
   	   "checkedBy" = ${idNumber},
   	   "dateChecked" = now(),
   	   "revisionReason"= ${revision}
 WHERE "id" = ${id}
