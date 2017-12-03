INSERT INTO projectproposalprogramdesign (projectproposal, dayid, date, starttime, endtime, activity, activitydescription, personincharge)
	                              VALUES (${projectProposal}, ${dayID}, ${date}, ${startTime}, ${endTime}, ${activity}, ${activityDescription}, ${personInCharge});

UPDATE projectproposal
   SET isProgramComplete=true
 WHERE id=${projectProposal};	                              