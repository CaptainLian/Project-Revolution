UPDATE "PostProjectProposal"
   SET "status" = ${status},
   		"sectionsToBeEdited" = ${sections},
   		"comments" = ${comments}
 WHERE "GOSMActivity" = ${gosmid}