SELECT PADPS.id, PADPS.signatory
  FROM "PreActivityDirectPaymentSignatory" PADPS 
 WHERE PADPS.status=0
   AND PADPS."directPayment"=${id}
 ORDER BY PADPS.id asc
 LIMIT 1;