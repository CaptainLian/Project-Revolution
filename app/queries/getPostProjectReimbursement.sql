SELECT PPRE.id, PPRE."GOSMActivity", PPRE."submissionID", PPRE.sequence, PPRE."nameOfEstablishment", 
       PPRE.amount, PPRE."paymentBy", PPRE."foodExpense", PPRE."NUCAODP", PPRE."delayedProcessing", 
       PPRE.filenames, PPRE."filenamesToShow", PPRE."idNumber" as submittedBy, PPRE."dateCreated" as dateSubmitted, 
       PPRE.status,
       to_char(PPRE."dateCreated", 'MonthDD, YYYY') AS submissiondate, 
       to_char(PPRE."dateCreated", 'HH:MI PM') AS submittime, GA.strategies, SO.name as organization,
       A.firstname, A.lastname, SO.id as orgid
  FROM public."PostProjectReimbursement" PPRE JOIN ACCOUNT A
  											    ON PPRE."idNumber"=A.IDNUMBER
		  									  JOIN GOSMACTIVITY GA
		  									    ON GA.ID=PPRE."GOSMActivity"
		  									  JOIN GOSM G
		  									    ON G.ID=GA.GOSM
		  									  JOIN STUDENTORGANIZATION SO
		  									    ON SO.ID=G.STUDENTORGANIZATION
 WHERE PPRE.id=${id};
