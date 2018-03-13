SELECT PPRES.id, PPRES.signatory
  FROM "PostProjectReimbursementSignatory" PPRES
 WHERE PPRES.status=0
   AND PPRES."reimbursement"=${id}
 ORDER BY PPRES.id asc
 LIMIT 1;
