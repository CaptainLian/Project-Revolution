UPDATE "PreActivityCashAdvanceSignatory"
   SET "status" = 1,
       "document" = ${document},
       "digitalSignature" = ${digitalSignature},
       "dateSigned" = CURRENT_TIMESTAMP,
       "comments" = NULL,
       "sectionsToEdit" = NULL,
 WHERE "cashAdvance" = ${cashAdvance}
   AND "signatory" = ${idNumber};
