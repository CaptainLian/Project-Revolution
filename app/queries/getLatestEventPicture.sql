SELECT MAX("submissionID"),*
  FROM "PostProjectProposalEventPicture"
 WHERE "GOSMActivity" = ${gosmid}
 GROUP BY "submissionID","id","GOSMActivity","sequence"