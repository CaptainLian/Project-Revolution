SELECT COUNT(GA.id) as related
  FROM GOSMACTIVITY GA JOIN GOSM G
		      ON G.ID=GA.GOSM
 WHERE isrelatedtoorganizationnature=true
   AND G.studentorganization=${org}
GROUP BY GA.GOSM;