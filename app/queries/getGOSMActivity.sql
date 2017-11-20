SELECT GA.id, GA.strategies, AN.name, to_char(GA.targetdatestart, 'Mon DD, YYYY') AS startdate, 
	   to_char(GA.targetdateend, 'Mon DD, YYYY') AS enddate, GA.activitynature AS activitynature 
  FROM GOSMACTIVITY GA JOIN ACTIVITYNATURE AN
	   						  ON GA.ACTIVITYNATURE=AN.ID
 WHERE GA.ID=${gosmactivity};