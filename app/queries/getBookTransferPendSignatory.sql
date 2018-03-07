SELECT PABTS.id, PABTS."bookTransfer", PABTS.signatory, PABTS.type, PABTS.status, PABTS.comments, PABTS."sectionsToEdit", 
       PABTS.document, PABTS."digitalSignature", PABTS."dateSigned", A.firstname, A.lastname,
       to_char(PABTS."dateSigned", 'MonthDD, YYYY') AS datesigned
  FROM public."PreActivityBookTransferSignatory" PABTS JOIN ACCOUNT A
  														  ON PABTS.signatory=A.idnumber
 WHERE PABTS."bookTransfer"=${id}
   AND PABTS.status=2;

