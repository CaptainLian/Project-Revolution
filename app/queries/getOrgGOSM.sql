SELECT *, to_char(dateSubmitted, 'YYYY-MM-DD') AS orggosmsubmitted
  FROM GOSM
 WHERE termID = ${termID}
   AND studentOrganization = ${studentOrganization};