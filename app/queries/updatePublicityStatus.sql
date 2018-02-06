UPDATE "ActivityPublicity"
   SET "status" = ${status},
   	   "comments" = ${comment},
   	   "checkedBy" = ${idNumber},
   	   "dateChecked" = now()
 WHERE "id" = ${id}
