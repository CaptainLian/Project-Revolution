UPDATE ProjectProposalSignatory
   SET status = 1,
       document = ${document},
       digitalSignature = ${digitalSignature},
       dateSigned = CURRENT_TIMESTAMP
 WHERE GOSMActivity = ${activityID}
   AND signatory = ${idNumber};
