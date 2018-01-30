INSERT INTO Account (
				idNumber, 
				email, 
				type, 
				password, 
				firstname, 
				middlename, 
				lastname, 
				contactNumber, 
				publicKey, 
				privateKey
			)
             VALUES (
             	${idNumber}, 
             	${email}, 
             	${type}, 
             	${password}, 
             	${firstname}, 
             	${middlename}, 
             	${lastname}, 
             	${contactNumber}, 
             	${publicKey}, 
             	${privateKey}
             );