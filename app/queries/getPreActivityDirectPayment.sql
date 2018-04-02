SELECT PADP.id, 
       PADP."GOSMActivity", 
       PADP."submissionID", 
       PADP.sequence, 
       PADP."submittedBy", 
       PADP."dateSubmitted", 
       PADP."reasonForDelayedPRSProcessing", 
       PADP."evaluatedBy", 
       PADP.status,
       to_char(PADP."dateSubmitted", 'MonthDD, YYYY') AS submissiondate, 
       to_char(PADP."dateSubmitted", 'HH:MI PM') AS submittime, 
       GA.strategies, SO.name as organization,
       A.firstname, 
       A.lastname, 
       SO.id as orgid, 
       PADP."galsFilename", 
       PADP."galsfilenameToShow", 
       PADP."fqFilename", 
       PADP."fqfilenameToShow", 
       PADP."rofFilename",
       PADP."rofFilenameToShow"
  FROM "PreActivityDirectPayment" PADP JOIN ACCOUNT A
  									   ON PADP."submittedBy"=A.IDNUMBER
  									 JOIN GOSMACTIVITY GA
  									   ON GA.ID=PADP."GOSMActivity"
  									 JOIN GOSM G
  									   ON G.ID=GA.GOSM
  									 JOIN STUDENTORGANIZATION SO
  									   ON SO.ID=G.STUDENTORGANIZATION
 WHERE PADP.id=${id};
