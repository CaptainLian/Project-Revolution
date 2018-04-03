SELECT TO_CHAR(PP.actualDateStart,'Mon DD, YYYY') as ddate, PPP."status" as pstatus,* 
  FROM "PostProjectProposal" PPP JOIN PROJECTPROPOSAL PP
  							       ON PPP."GOSMActivity" = PP.GOSMActivity
  							     JOIN GOSMACTIVITY GA
  							       ON PP.GOSMACTIVITY = GA.ID
 WHERE PPP."status" = 3 OR PPP."status" = 4 OR PPP."status" = 5
 ;