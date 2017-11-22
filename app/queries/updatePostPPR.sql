UPDATE "PostProjectProposal"
   SET "status" = ${status},
   		"sections" = ${sections},
   		"comments" = ${comments}
 WHERE "GOSMActivity" = ${gosmid}