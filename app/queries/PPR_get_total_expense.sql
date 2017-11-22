SELECT SUM(ppe.unitCost*ppe.quantity)
  FROM ProjectProposalExpenses ppe 
 WHERE ppe.projectProposal = (SELECT ppr.id
                                FROM projectproposal ppr
                               WHERE ppr.GOSMActivity = ${GAID});