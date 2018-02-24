SELECT so.id, so.acronym, so.path_profilePicture
  FROM (SELECT (role/10000) AS organization, dateAssigned
          FROM OrganizationOfficer
         WHERE yearID = system_get_current_year_id() 
         AND idNumber = ${idNumber}) oo LEFT JOIN StudentOrganization so
                                               ON oo.organization = so.id
ORDER BY so.id DESC, oo.dateAssigned DESC;