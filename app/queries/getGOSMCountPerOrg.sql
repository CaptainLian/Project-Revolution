SELECT COUNT(GA.id) as gosm
  FROM GOSMACTIVITY GA JOIN GOSM G
  						 ON GA.GOSM=G.ID
 WHERE G.STUDENTORGANIZATION=${org}
 GROUP BY GA.GOSM;