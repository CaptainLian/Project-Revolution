SELECT *,TO_CHAR("targetPostingDate", 'Mon DD, YYYY') as tdate, TO_CHAR("dateChecked", 'Mon DD, YYYY') as ddate
  FROM "ActivityPublicity" 
 WHERE "id" = ${id}