SELECT PPRE.id, PPRE."GOSMActivity", PPRE."submissionID", PPRE.sequence, PPRE."nameOfEstablishment", 
       PPRE.amount, PPRE."paymentBy", PPRE."foodExpense", PPRE."NUCAODP", PPRE."delayedProcessing", 
       PPRE.filenames, PPRE."filenamesToShow", PPRE."idNumber" as submittedBy, 
       PPRE."dateCreated" as dateSubmitted, PPRE.status,
       (PPE.quantity*PPE.unitcost) as amount, PPE.material
  FROM public."PostProjectReimbursement" PPRE JOIN "PostProjectReimbursementParticular" PPREP
										       ON PPRE.id=PPREP."reimbursement"
										     JOIN PROJECTPROPOSALEXPENSES PPE
										       ON PPREP."particular"=PPE.ID
 WHERE PPRE.id=${id};
