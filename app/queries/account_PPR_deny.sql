-- TODO: revert to earlier code
UPDATE ProjectProposalSignatory
   SET status = 3,
       comments = ${comments}
 WHERE GOSMActivity = ${activityID}
   AND signatory = ${idNumber};
