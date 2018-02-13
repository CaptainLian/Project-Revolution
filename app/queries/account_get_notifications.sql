SELECT "id", "sequence", "status", to_char("date", 'Mon DD, YYYY HH12:MI AM') AS "date", "title", "description", "details"
  FROM "AccountNotification"
 WHERE "account" = ${idNumber}
   AND "status" <> 3
ORDER BY "date" DESC
LIMIT 5;
