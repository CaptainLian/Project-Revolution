SELECT *,TO_CHAR("targetPostingDate", 'Mon DD, YYYY') as tdate, TO_CHAR("dateChecked", 'Mon DD, YYYY') as ddate
		,CONCAT(A.FIRSTNAME,' ',A.MIDDLENAME,' ',A.LASTNAME) AS FULLNAME
  FROM "ActivityPublicity" AP LEFT JOIN ACCOUNT A
  								     ON AP."checkedBy" = A.IDNUMBER
 WHERE AP."id" = ${id}