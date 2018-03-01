SELECT PACAS.id, PACAS."cashAdvance", PACAS.signatory, PACAS.type, PACAS.status, PACAS.comments, PACAS."sectionsToEdit", 
       PACAS.document, PACAS."digitalSignature", PACAS."dateSigned", A.firstname, A.lastname,
       to_char(PACAS."dateSigned", 'MonthDD, YYYY') AS datesigned
  FROM public."PreActivityCashAdvanceSignatory" PACAS JOIN ACCOUNT A
  														ON PACAS.signatory=A.idnumber
 WHERE PACAS."cashAdvance"=${id}
   AND PACAS.status=2;
