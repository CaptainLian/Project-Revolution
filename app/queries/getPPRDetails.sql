SELECT AN.NAME AS nature, AT.NAME AS type, GA.STRATEGIES AS strategies, SO.NAME AS orgname, av.name AS venue,
	   PP.ENMP AS enmp, PP.ENP AS enp, GA.OBJECTIVES AS objectives, PP.CONTEXT1 AS context1, PP.CONTEXT2 AS context2,
	   PP.CONTEXT3 AS context3, PP.ID as id, PP.SOURCEFUNDOTHER as sourcefundother, PP.SOURCEFUNDPARTICIPANTFEE AS sourcefundparticipantfee,
	   PP.SOURCEFUNDORGANIZATIONAL, PP.ACCUMULATEDOPERATIONALFUNDS as accumulatedoperationalfunds,
	   PP.ACCUMULATEDDEPOSITORYFUNDS AS accumulateddepositoryfunds, PP.ORGANIZATIONFUNDOTHERSOURCE AS organizationfundothersource
  FROM PROJECTPROPOSAL PP JOIN GOSMACTIVITY GA
			    ON PP.GOSMACTIVITY=GA.ID
			  JOIN GOSM G
			    ON G.ID=GA.GOSM
			  JOIN STUDENTORGANIZATION SO
			    ON G.STUDENTORGANIZATION=SO.ID
			  JOIN ACTIVITYTYPE AT
			    ON GA.ACTIVITYTYPE=AT.ID
			  JOIN ACTIVITYNATURE AN
			    ON GA.ACTIVITYNATURE=AN.ID
             JOIN "ActivityVenue" av
               ON pp.venue = av.id
WHERE GA.id=${gosmactivity}
