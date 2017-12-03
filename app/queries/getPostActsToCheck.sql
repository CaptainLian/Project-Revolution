SELECT TO_CHAR(PP.actualDateStart,'Mon DD, YYYY') as ddate,* 
  FROM "PostProjectProposal" PPP JOIN PROJECTPROPOSAL PP
  							       ON PPP."GOSMActivity" = PP.GOSMActivity
  							     JOIN GOSMACTIVITY GA
  							       ON PP.GOSMACTIVITY = GA.ID
 WHERE PPP."status" = 3