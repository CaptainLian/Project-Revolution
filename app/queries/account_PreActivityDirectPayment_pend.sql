-- TODO: revert to earlier code version of account_PreActCashAdvance_pend
UPDATE "PreActivityCashAdvanceSignatory"
   SET "status" = 2,
       "comments" = ${comments},
       "sectionsToEdit" = ${sections}
 WHERE "directPayment" = ${directPayment}
   AND "signatory" = ${idNumber};
