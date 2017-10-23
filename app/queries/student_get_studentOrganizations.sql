SELECT id, name, path_profilePicture
  FROM StudentOrganization
 WHERE id IN (SELECT DISTINCT (role/10000)
                      FROM OrganizationOfficer
                     WHERE idNumber = ${idNumber})
