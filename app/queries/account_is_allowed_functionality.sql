SELECT * FROM OrganizationAccessControl
WHERE role IN (SELECT role
                 FROM OrganizationOfficer
                WHERE idNumber = ${idNumber})
   AND (functionality%1000) = ${functionalitySequence}
   AND role/10000 = ${organizationSequence};