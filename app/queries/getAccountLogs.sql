SELECT *
  FROM "audit_Account" AA JOIN "AccountEvent" AE
			   ON AA.EVENT=AE.ID
			 JOIN ACCOUNT A
			   ON AA.ID=A.IDNUMBER
