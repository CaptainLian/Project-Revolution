SELECT *, to_char(dateSubmitted, 'Month DD, YYYY') AS orggosmsubmitted
  FROM GOSM
 WHERE termID = ${termID}
   AND studentOrganization = ${studentOrganization};