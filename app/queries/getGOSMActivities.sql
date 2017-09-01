SELECT *
  FROM GOSMACTIVITIES
 WHERE studentOrganization = ${studentOrganization}
   AND startYear = ${startYear}
	 AND endYear = ${endYear};
