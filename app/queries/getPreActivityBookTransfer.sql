SELECT PABT.id, PABT."GOSMActivity", PABT."submissionID", PABT."sequence", PABT."submittedBy", 
       PABT."dateSubmitted", PABT.status, PABT.establishment,
       to_char(PABT."dateSubmitted", 'MonthDD, YYYY') AS submissiondate, 
       to_char(PABT."dateSubmitted", 'HH:MI PM') AS submittime, GA.strategies, SO.name as organization,
       A.firstname, A.lastname, SO.id as orgid, BTE.name as establishmentname
  FROM public."PreActivityBookTransfer" PABT JOIN ACCOUNT A
  											   ON PABT."submittedBy"=A.IDNUMBER
		  									 JOIN GOSMACTIVITY GA
		  									   ON GA.ID=PABT."GOSMActivity"
		  									 JOIN GOSM G
		  									   ON G.ID=GA.GOSM
		  									 JOIN STUDENTORGANIZATION SO
		  									   ON SO.ID=G.STUDENTORGANIZATION
		  									 JOIN "BookTransferEstablishment" BTE
		  									   ON PABT.establishment=BTE.id
 WHERE PABT.id=${id};
