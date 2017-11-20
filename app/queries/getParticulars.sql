SELECT PPE.id, PPE.projectProposal, PPE.material, PPE.quantity, PPE.unitcost, PPE.type, ET.NAME
  FROM PROJECTPROPOSALEXPENSES PPE JOIN EXPENSETYPE ET
				     				 ON PPE.TYPE=ET.ID
 WHERE PROJECTPROPOSAL=${projectProposal}
   AND PPE.ID NOT IN (SELECT particular 
			FROM "PreActivityCashAdvanceParticular");