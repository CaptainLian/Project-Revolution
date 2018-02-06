SELECT *
  FROM "PostProjectProposalEventPicture"
 WHERE "GOSMActivity" = ${gosmid}
  AND "submissionID" in (SELECT max("submissionID")
						  FROM "PostProjectProposalEventPicture"
						 WHERE "GOSMActivity" = ${gosmid})