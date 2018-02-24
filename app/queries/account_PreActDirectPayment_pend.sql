UPDATE "PreActivityCashAdvanceSignatory"
   SET "status" = 2,
       "comments" = ${comments},
       "sectionsToEdit" = ${sections}
 WHERE "directPayment" = ${directPayment}
   AND "signatory" = ${idNumber};
