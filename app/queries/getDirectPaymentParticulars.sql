SELECT PADP.id, PADP."GOSMActivity", PADP."submissionID", PADP.sequence, PADP."submittedBy", 
       PADP."dateSubmitted", PADP."nameOfEstablishment", PADP.amount, PADP."reasonForDelayedPRSProcessing" as justification, 
       PADP.comments, PADP."dateEvaluated", PADP.status,
		 (PPE.quantity*PPE.unitcost) as amount, PPE.material
  FROM "PreActivityDirectPayment" PADP JOIN "PreActivityDirectPaymentParticular" PADPP
  										 ON PADP.id=PADPP."directPayment"
  									   JOIN PROJECTPROPOSALEXPENSES PPE
  									     ON PADPP."particular"=PPE.ID
 WHERE PADP.id=${id};
