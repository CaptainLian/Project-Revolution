SELECT PACAS.id, PACAS.signatory
  FROM "PreActivityCashAdvanceSignatory" PACAS
 WHERE PACAS.status=0
   AND PACAS."cashAdvance"=${id}
 ORDER BY PACAS.id asc
 LIMIT 1;
