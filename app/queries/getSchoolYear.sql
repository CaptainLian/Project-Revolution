SELECT * FROM TERM T 
		WHERE T.ENDYEAR = (SELECT ENDYEAR FROM TERM 
                          					ORDER BY 1 DESC
                          					LIMIT 1)
		 ORDER BY 4 DESC 
         LIMIT 1;