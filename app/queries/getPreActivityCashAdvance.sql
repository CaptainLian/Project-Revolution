SELECT PACA.id, PACA."GOSMActivity", PACA."submissionID", PACA.sequence, PACA."submittedBy", 
       PACA."dateSubmitted", PACA.purpose, PACA.justification, PACA."evaluatedBy", PACA.status,
       to_char(PACA."dateSubmitted", 'MonthDD, YYYY') AS submissiondate, 
       to_char(PACA."dateSubmitted", 'HH:MI PM') AS submittime, GA.strategies, SO.name as organization,
       A.firstname, A.lastname, SO.id as orgid, PACA."filename", PACA."filenameToShow"
  FROM "PreActivityCashAdvance" PACA JOIN ACCOUNT A
  									   ON PACA."submittedBy"=A.IDNUMBER
  									 JOIN GOSMACTIVITY GA
  									   ON GA.ID=PACA."GOSMActivity"
  									 JOIN GOSM G
  									   ON G.ID=GA.GOSM
  									 JOIN STUDENTORGANIZATION SO
  									   ON SO.ID=G.STUDENTORGANIZATION
 WHERE PACA.id=${id};
