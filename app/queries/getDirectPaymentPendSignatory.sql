SELECT PADPS.id, PADPS."directPayment", PADPS.signatory, PADPS.type, PADPS.status, PADPS.comments, PADPS."sectionsToEdit", 
       PADPS.document, PADPS."digitalSignature", PADPS."dateSigned",  A.firstname, A.lastname,
       to_char(PADPS."dateSigned", 'MonthDD, YYYY') AS datesigned
  FROM public."PreActivityDirectPaymentSignatory" PADPS JOIN ACCOUNT A
  														  ON PADPS.signatory=A.idnumber
 WHERE PADPS."directPayment"=${id}
   AND PADPS.status=2;
