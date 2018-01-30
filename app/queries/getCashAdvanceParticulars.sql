SELECT PACA.id, PACA."GOSMActivity", PACA."submissionID", PACA.sequence, PACA."submittedBy", 
       PACA."dateSubmitted", PACA.purpose, PACA.justification, PACA."evaluatedBy", PACA.status,
       (PPE.quantity*PPE.unitcost) as amount, PPE.material
  FROM "PreActivityCashAdvance" PACA JOIN "PreActivityCashAdvanceParticular" PACAP
				       ON PACA.id=PACAP."cashAdvance"
				     JOIN PROJECTPROPOSALEXPENSES PPE
				       ON PACAP."particular"=PPE.ID
 WHERE PACA.id=${id};
