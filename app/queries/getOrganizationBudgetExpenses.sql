SELECT SO.operationalfunds, SO.depositoryfunds, SUM(PPRE.quantity*PPRE.unitcost) as totalexpense,
		COUNT(PPRE.id) as particulars
  FROM GOSM G JOIN GOSMACTIVITY GA
				ON G.id=GA.GOSM
	    	  JOIN PROJECTPROPOSAL PP
	        	ON PP.GOSMACTIVITY=GA.ID
		      JOIN PROJECTPROPOSALEXPENSES PPRE
		        ON PPRE.PROJECTPROPOSAL=PP.ID
		      JOIN STUDENTORGANIZATION SO
		        ON SO.ID=G.studentorganization
WHERE PP.STATUS=3
  AND G.studentorganization=${studentOrganization}
  AND G.TERMID=system_get_current_term_id()
GROUP BY SO.operationalfunds, SO.depositoryfunds;
	        