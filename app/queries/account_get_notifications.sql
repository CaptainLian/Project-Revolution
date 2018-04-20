-- TODO: CHECK IF UNUSED
SELECT "id", "sequence", "status", to_char("date", 'Mon DD, YYYY HH12:MI AM') AS "date", "title", "description", "details", extract(epoch from "date") AS "rawDate"
  FROM "AccountNotification"
 WHERE "account" = ${idNumber}
   AND "status" <> 3
ORDER BY "sequence" DESC;
