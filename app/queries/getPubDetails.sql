SELECT *,TO_CHAR("targetPostingDate", 'Mon DD, YYYY') as tdate, TO_CHAR("dateChecked", 'Mon DD, YYYY') as ddate
		,CONCAT(A.FIRSTNAME,' ',A.MIDDLENAME,' ',A.LASTNAME) AS FULLNAME
		, APPR."name" as revisionReason, AP.status as status
  FROM "ActivityPublicity" AP LEFT JOIN ACCOUNT A
  								     ON AP."checkedBy" = A.IDNUMBER
  							  LEFT JOIN "ActivityPublicityRevisionReason" as APPR
  							         ON AP."revisionReason" = APPR."id"
 WHERE AP."id" = ${id}