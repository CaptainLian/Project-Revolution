SELECT PACA.id, PACA."GOSMActivity", PACA."submissionID", PACA.sequence, PACA."submittedBy", 
       PACA."dateSubmitted", PACA.purpose, PACA.justification, PACA."evaluatedBy", PACA.status,
       (PPE.quantity*PPE.unitcost) as amount, PPE.material,
       PPE.id as expenseid, PPE.projectProposal, PPE.material, PPE.quantity, PPE.unitcost, PPE.type, ET.NAME
  FROM "PreActivityCashAdvance" PACA JOIN "PreActivityCashAdvanceParticular" PACAP
				       ON PACA.id=PACAP."cashAdvance"
				     JOIN PROJECTPROPOSALEXPENSES PPE
				       ON PACAP."particular"=PPE.ID
				     JOIN EXPENSETYPE ET
				       ON PPE.TYPE=ET.ID
 WHERE PACA.id=${id};
