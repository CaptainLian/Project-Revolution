UPDATE "PostProjectProposal"
   SET "isOtherFinanceDocumentsCompleted" = ${otherFinance},
   		"isBriefContextCompleted" = ${briefContext}
 WHERE "GOSMActivity" = ${gosmid}
