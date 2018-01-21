SELECT "id", "sequence", "date", "status"
  FROM "AccountNotification"
 WHERE "account" = ${idNumber}
   AND "status" <> 3;
