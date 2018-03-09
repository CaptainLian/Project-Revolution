SELECT G.studentorganization, PPR.gosmactivity, PPR.actualdatestart, PPRS.datesigned, GA.targetdatestart, GA.isingosm,
		GA.isrelatedtoorganizationnature as isrelatedtoorganization
  FROM PROJECTPROPOSAL PPR JOIN (SELECT GOSMACTIVITY, MAX(TYPE), DATESIGNED
				 				   FROM PROJECTPROPOSALSIGNATORY
								  GROUP BY GOSMACTIVITY, DATESIGNED) PPRS
			     ON PPR.ID=PPRS.GOSMACTIVITY
			   JOIN GOSMACTIVITY GA
			     ON GA.ID=PPR.GOSMACTIVITY
			   JOIN GOSM G
			     ON G.ID=GA.GOSM
 WHERE PPR.STATUS=3
   AND G.TERMID=system_get_current_term_id();
