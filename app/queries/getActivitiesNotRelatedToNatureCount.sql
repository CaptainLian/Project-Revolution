SELECT COUNT(GA.id) as norelated
  FROM GOSMACTIVITY GA JOIN GOSM G
		      ON G.ID=GA.GOSM
 WHERE isrelatedtoorganizationnature=false
   AND G.studentorganization=${org}
GROUP BY GA.GOSM;