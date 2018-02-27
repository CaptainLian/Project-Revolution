SELECT PABTS.id, PABTS.signatory
  FROM "PreActivityBookTransferSignatory" PABTS
 WHERE PABTS.status=0
   AND PABTS."bookTransfer"=${id}
 ORDER BY PABTS.id asc
 LIMIT 1;
