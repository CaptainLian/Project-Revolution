SELECT PABT.id, PABT."GOSMActivity", PABT."submissionID", PABT."sequenceID", PABT."submittedBy", 
       PABT."dateSubmitted", PABT.status, PABT."transferAccount",
       (PPE.quantity*PPE.unitcost) as amount, PPE.material
  FROM public."PreActivityBookTransfer" PABT JOIN "PreActivityBookTransferParticular" PABTP
										       ON PABT.id=PABTP."bookTransfer"
										     JOIN PROJECTPROPOSALEXPENSES PPE
										       ON PABTP."particular"=PPE.ID
 WHERE PABT.id=${id};
;
