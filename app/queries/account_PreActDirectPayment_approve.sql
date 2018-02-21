UPDATE "PreActivityDirectPaymentSignatory"
   SET "status" = 1,
       "document" = ${document},
       "digitalSignature" = ${digitalSignature},
       "dateSigned" = CURRENT_TIMESTAMP,
       "comments" = NULL,
       "sectionsToEdit" = NULL,
 WHERE "directPayment" = ${directPayment}
   AND "signatory" = ${idNumber};
