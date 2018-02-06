UPDATE "PostProjectProposal"
   SET  "isOtherFinanceDocumentsCompleted" = ${status}
 WHERE "GOSMActivity" = ${gosmid}