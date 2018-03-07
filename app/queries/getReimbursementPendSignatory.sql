SELECT PPRES.id, PPRES.reimbursement, PPRES.signatory, PPRES.type, PPRES.status, PPRES.comments, PPRES.sectionstoedit, 
       PPRES.document, PPRES.digitalsignature, PPRES.datesigned, A.firstname, A.lastname,
       to_char(PPRES."datesigned", 'MonthDD, YYYY') AS datesigned
  FROM public."PostProjectReimbursementSignatory" PPRES JOIN ACCOUNT A
  														  ON PPRES.signatory=A.idnumber
 WHERE PPRES."reimbursement"=${id}
   AND PPRES.status=2;
;
