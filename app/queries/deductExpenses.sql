UPDATE STUDENTORGANIZATION 
   SET DEPOSITORYFUNDS=((SELECT DEPOSITORYFUNDS
			  			  FROM STUDENTORGANIZATION
			 			 WHERE ID=${studentOrganization}
			 			 LIMIT 1)-${expenses})
 WHERE ID=${studentOrganization};