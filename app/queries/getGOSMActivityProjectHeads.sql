SELECT * 
  FROM ACCOUNT
 WHERE IDNUMBER IN (SELECT IDNUMBER
	  			   FROM GOSMACTIVITYPROJECTHEAD
	  			  WHERE ACTIVITYID=${gosmactivity});