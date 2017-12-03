SELECT *
  FROM "PostProjectProposalExpense"
 WHERE "GOSMActivity" = ${gosmid}
  AND "submissionID" in (SELECT max("submissionID")
						  FROM "PostProjectProposalExpense"
						 WHERE "GOSMActivity" = ${gosmid})