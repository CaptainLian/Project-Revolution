SELECT A.firstname, A.lastname, a.idnumber, ORL.name as role
  FROM "PreActivityCashAdvance" PADP JOIN ACCOUNT A
									   ON PADP."submittedBy"=A.idnumber
									 JOIN GOSMACTIVITY GA
								       ON GA.ID=PADP."GOSMActivity"
								     JOIN GOSM G
								       ON G.ID=GA.GOSM
								     JOIN ORGANIZATIONOFFICER OOFF
								       ON A.IDNUMBER=OOFF.IDNUMBER
								     JOIN ORGANIZATIONROLE ORL
								       ON ORL.ID=OOFF.ROLE AND ORL.ORGANIZATION=G.STUDENTORGANIZATION 
 WHERE PADP.id=${id}
   AND OOFF.YEARID=system_get_current_year_id();	