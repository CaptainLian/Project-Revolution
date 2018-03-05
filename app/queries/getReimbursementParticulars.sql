SELECT PPRE.id, PPRE."GOSMActivity", PPRE."submissionID", PPRE.sequence, PPRE."justificationFDPP", 
       PPRE."justificationFNUCADP", 
       PPRE.filenames, PPRE."filenamesToShow", PPRE."submittedBy" as submittedBy, 
       PPRE."dateCreated" as dateSubmitted, PPRE.status, PPE.unitcost, PPE.quantity,
       (PPE.quantity*PPE.unitcost) as amount,
        PPE.id as expenseid, PPE.projectProposal, PPE.material, PPE.quantity, PPE.unitcost, PPE.type, ET.NAME
  FROM public."PostProjectReimbursement" PPRE JOIN "PostProjectReimbursementParticular" PPREP
										       ON PPRE.id=PPREP."reimbursement"
										     JOIN PROJECTPROPOSALEXPENSES PPE
										       ON PPREP."particular"=PPE.ID
										     JOIN EXPENSETYPE ET
				       						   ON PPE.TYPE=ET.ID
 WHERE PPRE.id=${id};
