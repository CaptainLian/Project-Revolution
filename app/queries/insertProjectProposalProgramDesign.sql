INSERT INTO projectproposalprogramdesign (projectproposal, dayid, date, starttime, endtime, activity, activitydescription, personincharge)
	                              VALUES (${projectProposal}, ${dayID}, ${date}, ${startTime}, ${endTime}, ${activity}, ${activityDescription}, ${personInCharge});

UPDATE projectproposal
   SET isProgramDesignComplete=true
 WHERE id=${projectProposal};	                              