UPDATE "PreActivityCashAdvanceSignatory"
   SET "status" = 2,
       "comments" = ${comments},
       "sectionsToEdit" = ${sections}
 WHERE "cashAdvance" = ${cashAdvance}
   AND "signatory" = ${idNumber};
