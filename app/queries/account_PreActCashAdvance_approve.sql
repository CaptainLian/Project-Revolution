UPDATE "PreActivityCashAdvanceSignatory"
   SET "status" = 1,
       "document" = ${document},
       "digitalSignature" = ${digitalSignature},
       "dateSigned" = CURRENT_TIMESTAMP
 WHERE "cashAdvance" = ${activityID}
   AND "signatory" = ${idNumber};