SELECT COUNT(id) AS Activities
		FROM GOSMACTIVITY
        WHERE GOSM=${gosm}
        AND id NOT IN (SELECT GOSMACTIVITY 
                   			FROM PROJECTPROPOSAL);