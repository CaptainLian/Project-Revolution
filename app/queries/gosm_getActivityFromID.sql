SELECT at.name AS type, an.name AS nature, to_char(targetDateStart, 'Mon DD, YYYY') AS startdate, to_char(targetDateEnd, 'Mon DD, YYYY')  AS endDate
  FROM GOSMActivity ga LEFT JOIN ActivityNature an
			                        ON ga.activityNature = an.id
			                 LEFT JOIN ActivityType at
			                        ON ga.activityType = at.id
 WHERE ga.id = ${activityID};
