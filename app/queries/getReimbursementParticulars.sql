SELECT PPRE.id, PPRE."GOSMActivity", PPRE."submissionID", PPRE.sequence, PPRE."justificationFDPP", 
       PPRE."justificationFNUCADP", 
       PPRE.filenames, PPRE."filenamesToShow", PPRE."submittedBy" as submittedBy, 
       PPRE."dateCreated" as dateSubmitted, PPRE.status, PPE.unitcost, PPE.quantity,
       (PPE.quantity*PPE.unitcost) as amount, PPE.material
  FROM public."PostProjectReimbursement" PPRE JOIN "PostProjectReimbursementParticular" PPREP
										       ON PPRE.id=PPREP."reimbursement"
										     JOIN PROJECTPROPOSALEXPENSES PPE
										       ON PPREP."particular"=PPE.ID
 WHERE PPRE.id=${id};
