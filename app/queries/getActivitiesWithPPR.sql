SELECT COUNT(id) AS Activities
		FROM GOSMACTIVITY
        WHERE GOSM=${gosm}
        AND id IN (SELECT GOSMACTIVITY 
                   			FROM PROJECTPROPOSAL);