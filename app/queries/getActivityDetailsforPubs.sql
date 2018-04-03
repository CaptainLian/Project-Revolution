SELECT GA.STRATEGIES, SO.NAME AS ORGNAME , AT.NAME AS TYPENAME, AN.NAME as NATNAME, AV."name" ActivityVenue, PP.ENP, PP.ENMP, PP.ActualDateStart
  FROM GOSMACTIVITY GA JOIN PROJECTPROPOSAL PP 
            						 ON GA.ID = PP.GOSMACTIVITY
          					   JOIN "ActivityVenue" AV
          					     ON PP.VENUE = AV."id"  					
          					   JOIN ACTIVITYTYPE AT
          					     ON GA.ACTIVITYTYPE = AT.ID
          					   JOIN ACTIVITYNATURE AN
          					     ON GA.ACTIVITYNATURE = AN.ID
          					   JOIN GOSM G
          					     ON GA.GOSM = G.ID
          					   JOIN STUDENTORGANIZATION SO
          					     ON G.STUDENTORGANIZATION = SO.ID
WHERE GA.ID = ${gosmid}