CREATE OR REPLACE FUNCTION trigger_after_insert_StudentOrganization()
RETURNS trigger AS
$trigger$
    DECLARE
        presidentRoleID INTEGER;
        executiveSecretariatRoleID INTEGER;
        eevpRoleID INTEGER;
        vpdRoleID INTEGER;
        avpdRoleID INTEGER;
        vpfRoleID INTEGER;
        avpfRoleID INTEGER;
        -- Internal Executive Vice President
        ievpRoleID INTEGER;
    BEGIN
        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'President', TRUE, NULL, 0)
        RETURNING id INTO presidentRoleID;
        
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                       VALUES (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 0)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 7)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 15)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 19)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 21)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Executive Secretariat', TRUE, presidentRoleID, 10)
        RETURNING id INTO executiveSecretariatRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'External Executive Vice President', TRUE, presidentRoleID, 10)
        RETURNING id INTO eevpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Internal Executive Vice President', TRUE, presidentRoleID, 10)
        RETURNING id INTO ievpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Vice President of Documentations', TRUE, executiveSecretariatRoleID, 20)
        RETURNING id INTO vpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Sign PPR as Documentation
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 12)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Associate Vice President of Documentations', FALSE, vpdRoleID, 30)
        RETURNING id INTO avpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Vice President of Finance', TRUE, ievpRoleID, '/Organization/treasurer/dashboard', 20)
        RETURNING id INTO vpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Sign PPR as Treasurer
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 11)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 19)), TRUE),
                                              -- Evaluate
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 21)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 22)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Associate Vice President of Finance', FALSE, vpfRoleID, '/Organization/treasurer/dashboard', 30)
        RETURNING id INTO avpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;