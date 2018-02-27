SELECT PABT.id, PABT."GOSMActivity", PABT."submissionID", PABT."sequenceID", PABT."submittedBy", 
       PABT."dateSubmitted", PABT.status, PABT."transferAccount",
       to_char(PABT."dateSubmitted", 'MonthDD, YYYY') AS submissiondate, 
       to_char(PABT."dateSubmitted", 'HH:MI PM') AS submittime, GA.strategies, SO.name as organization,
       A.firstname, A.lastname, SO.id as orgid
  FROM public."PreActivityBookTransfer" PABT JOIN ACCOUNT A
  											   ON PABT."submittedBy"=A.IDNUMBER
		  									 JOIN GOSMACTIVITY GA
		  									   ON GA.ID=PABT."GOSMActivity"
		  									 JOIN GOSM G
		  									   ON G.ID=GA.GOSM
		  									 JOIN STUDENTORGANIZATION SO
		  									   ON SO.ID=G.STUDENTORGANIZATION
 WHERE PABT.id=${id};
