SELECT PABT.id, PABT."GOSMActivity", PABT."submissionID", PABT."sequence", PABT."submittedBy", 
       PABT."dateSubmitted", PABT.status, PABT.establishment,
       (PPE.quantity*PPE.unitcost) as amount,
       	PPE.id as expenseid, PPE.projectProposal, PPE.material, PPE.quantity, PPE.unitcost, PPE.type, ET.NAME
  FROM public."PreActivityBookTransfer" PABT JOIN "PreActivityBookTransferParticular" PABTP
										       ON PABT.id=PABTP."bookTransfer"
										     JOIN PROJECTPROPOSALEXPENSES PPE
										       ON PABTP."particular"=PPE.ID
										     JOIN EXPENSETYPE ET
				       					 	   ON PPE.TYPE=ET.ID
 WHERE PABT.id=${id};
;
