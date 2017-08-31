SELECT
	idNumber,
	email,
	password,
	salt
FROM 
	Account
WHERE 
	idNumber = ${idNumber},
 OR email = ${email};