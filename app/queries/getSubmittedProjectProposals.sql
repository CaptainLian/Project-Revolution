SELECT GA.STRATEGIES, S.NAME AS ORGNAME, AN.NAME AS NATURE, ATY.NAME AS TYPE, P.VENUE, P.ENMP, P.ENP
		FROM PROJECTPROPOSAL P JOIN GOSMACTIVITY GA
        						  ON P.GOSMACTIVITY=GA.ID
                                JOIN GOSM G
                                  ON GA.GOSM=G.ID
                                JOIN STUDENTORGANIZATION S
                                  ON G.STUDENTORGANIZATION=S.ID
                                JOIN ACTIVITYNATURE AN
                                  ON GA.ACTIVITYNATURE=AN.ID
                                JOIN ACTIVITYTYPE ATY
                                  ON GA.ACTIVITYTYPE=ATY.ID
       WHERE P.STATUS=1
       LIMIT 1;