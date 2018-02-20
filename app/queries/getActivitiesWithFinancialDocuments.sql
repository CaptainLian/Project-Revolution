SELECT GA.ID as gosmactivity, GA.STRATEGIES, SO.NAME, SO.ID as organizationid, to_char(PP.ACTUALDATESTART, 'MonthDD, YYYY') AS startdate 
  FROM GOSMACTIVITY GA JOIN PROJECTPROPOSAL PP
			                   ON GA.ID=PP.GOSMACTIVITY
		                   JOIN GOSM G
		                     ON GA.GOSM=G.ID
		                   JOIN STUDENTORGANIZATION SO
		                     ON G.STUDENTORGANIZATION=SO.ID
 WHERE PP.ISEXPENSE=true
   AND PP.STATUS=3
   AND G.TERMID=system_get_current_term_id();