SELECT a.idNumber, firstname || ' ' || lastname AS name, contactNumber
FROM GOSMActivityProjectHead ph LEFT JOIN Account a
ON ph.idNumber = a.idNumber
WHERE activityID = ${activityID};
