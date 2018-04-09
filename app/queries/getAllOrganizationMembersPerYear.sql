SELECT id, "idNumber", organization, "yearID", "dateAdded"
  FROM public."OrganizationMember"
 WHERE "yearID" = (SELECT schoolyearID 
		     		 FROM TERM 
		  		    WHERE id=${termID});
