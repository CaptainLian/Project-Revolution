SELECT * FROM TERM T 
		WHERE EXTRACT (YEAR FROM T.dateEnd) = (SELECT EXTRACT (YEAR FROM dateEnd) FROM TERM 
                          					ORDER BY 1 DESC
                          					LIMIT 1)
		 ORDER BY 4 DESC 
         LIMIT 1;