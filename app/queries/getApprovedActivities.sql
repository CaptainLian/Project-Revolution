SELECT G.studentorganization, PPR.gosmactivity, to_char(PPR.actualdatestart, 'YYYY-MM-DD') AS actualdatestart,
	   to_char(PPRS.datesigned, 'YYYY-MM-DD') AS datesigned, to_char(GA.targetdatestart, 'YYYY-MM-DD') AS targetdatestart,
	    GA.isingosm,
		GA.isrelatedtoorganizationnature as isrelatedtoorganizationnature, GA.activitynature
  FROM PROJECTPROPOSAL PPR JOIN (SELECT GOSMACTIVITY, MAX(DATESIGNED) as DATESIGNED
				 				   FROM PROJECTPROPOSALSIGNATORY
				 				  WHERE STATUS=1
				 				  GROUP BY 1) PPRS
			     ON PPR.ID=PPRS.GOSMACTIVITY
			   JOIN GOSMACTIVITY GA
			     ON GA.ID=PPR.GOSMACTIVITY
			   JOIN GOSM G
			     ON G.ID=GA.GOSM
 WHERE PPR.STATUS=3
   AND G.TERMID=${termID};
