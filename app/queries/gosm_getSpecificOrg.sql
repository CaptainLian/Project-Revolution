SELECT *
FROM GOSMActivities
WHERE endYear = (SELECT MAX(endYear)
                  FROM GOSM
                 WHERE studentOrganization = ${organization})
AND studentOrganization = ${organization};
