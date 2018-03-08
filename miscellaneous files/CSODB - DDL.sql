DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP EXTENSION IF EXISTS "pgcrypto" CASCADE;
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE OR REPLACE FUNCTION trigger_auto_reject()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        RETURN NULL;
    END;
$trigger$ LANGUAGE plpgsql;

/**
$1 is the NEW data
NEW.GOSMActivity should be $1.GOSMActivity when using this function
*/
CREATE OR REPLACE FUNCTION "trigger_before_insert_increment_sequence"(/* "param_TableName" TEXT, "param_TableAcronym" TEXT, "param_Where" TEXT */)
RETURNS TRIGGER AS
$trigger$
    BEGIN
	    EXECUTE format ('SELECT COALESCE(MAX(sequence) + 1, 1)
	                       FROM %I %I
	                      WHERE (%s);', TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT NEW."sequence"
	    USING NEW;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;

/**
$1 is the NEW data
NEW.GOSMActivity should be $1.GOSMActivity when using this function
*/
CREATE OR REPLACE FUNCTION "trigger_before_insert_sequence_versioning"(/* "param_TableName" TEXT, "param_TableAcronym" TEXT, "param_Where" TEXT */)
RETURNS TRIGGER AS
$trigger$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            EXECUTE format('SELECT COALESCE(MAX(%I."submissionID") + 1, 1)
                              FROM %I %I
                             WHERE (%s);',
                             TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
            INTO NEW."submissionID"
            USING NEW;

        ELSE
            EXECUTE format('SELECT COALESCE(MAX(%I."sequence") + 1, 1)
                              FROM %I %I
                             WHERE (%s)
                               AND %I."submissionID" = $1."submissionID";',
                            TG_ARGV[1],  TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
            INTO NEW."sequence"
            USING NEW;
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;

/**
$1 is the NEW data
NEW.GOSMActivity should be $1.GOSMActivity when using this function
*/
CREATE OR REPLACE FUNCTION "trigger_after_update_signatory_completion"(/* "param_signatoryTable" (0)TEXT, "param_signatoryTableAcronym" (1)TEXT, "param_signatoryWhere" (2)TEXT, "param_parentTable" (3)TEXT, "param_parentTableAcronym" (4)TEXT, "param_parentWhere" (5)TEXT */)
RETURNS TRIGGER AS
$trigger$
    DECLARE
        numSignNeeded INTEGER;
        numPend INTEGER;
        numApprove INTEGER;
        newStatus SMALLINT DEFAULT 0;
    BEGIN
        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s)
                           AND %I.status = 1;',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
        INTO STRICT numApprove
        USING NEW;

        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s)
                           AND %I.status = 2;',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
        INTO STRICT numPend
        USING NEW;

        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s);',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT numSignNeeded
        USING NEW;

        /* All has signed */
        IF numSignNeeded = numApprove THEN
            newStatus := 1;
        /* This person pended or a pend exists */
	    ELSEIF NEW.status = 2 OR numPend > 0 THEN
             newStatus := 2;
	    END IF;

        EXECUTE format('UPDATE %I %I
                           SET status = $2
                         WHERE (%s);',
            TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
        USING NEW, newStatus;

        RETURN NEW;
    END
$trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "trigger_after_insert_finance_signatories"(/* "param_particularTable" (0)TEXT, "param_particularTableAcronym" (1)TEXT, "param_particularWhere" (2)TEXT, "param_signatoryTable" (3)TEXT, "param_columnInsert" (4)TEXT, "param_columnInsertValue" (5)TEXT */)
RETURNS TRIGGER AS
$trigger$
    DECLARE
        totalExpense NUMERIC(12, 2);
    BEGIN
        EXECUTE format('SELECT SUM(ppe.unitCost*ppe.quantity)
	                      FROM ProjectProposalExpenses ppe
	                     WHERE ppe.id IN (SELECT %I.particular
	                                        FROM %I %I
	                                       WHERE (%s));', TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT totalExpense
        USING NEW;

        IF totalExpense > 5000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 4 ORDER BY a.idNumber DESC LIMIT 1), 3)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
        END IF;

	    IF totalExpense > 50000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 5 ORDER BY a.idNumber DESC LIMIT 1), 4)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
        END IF;

	    IF totalExpense > 250000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 6 ORDER BY a.idNumber DESC LIMIT 1), 5)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
	    END IF;

        RETURN NEW;
    END
$trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "trigger_after_delete_finance_signatories"(/* "param_particularTable" (0)TEXT, "param_particularTableAcronym" (1)TEXT, "param_particularWhere" (2)TEXT, "param_signatoryTable" (3)TEXT, "param_signatoryTableAcronym" (4)TEXT, "param_deleteWhere" (5)TEXT */)
RETURNS TRIGGER AS
$trigger$
    DECLARE
        totalExpense NUMERIC(12, 2);
    BEGIN
        EXECUTE format('SELECT SUM(ppe.unitCost*ppe.quantity)
	                      FROM ProjectProposalExpenses ppe
	                     WHERE ppe.id IN (SELECT %I.particular
	                                        FROM %I %I
	                                       WHERE (%s));', TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT totalExpense
        USING NEW;

        IF totalExpense <= 5000.00 THEN
            EXECUTE format('DELETE FROM %I %I
                                  WHERE (%s)
                                    AND %I.type = 3;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
            USING NEW;
        END IF;

	    IF totalExpense <= 50000.00 THEN
        EXECUTE format('DELETE FROM %I %I
                              WHERE (%s)
                                AND %I.type = 4;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
        USING NEW;
        END IF;

	    IF totalExpense <= 250000.00 THEN
            EXECUTE format('DELETE FROM %I %I
                                  WHERE (%s)
                                    AND %I.type = 5;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
            USING NEW;
	    END IF;

        RETURN NEW;
    END
$trigger$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "signatory_get_to_sign_per_account"("signatoryTable" TEXT, "signatoryTableAcronym" TEXT, "signatoryTableColumn" TEXT, "parentTable" TEXT, "parentTableAcronym" TEXT)
RETURNS TABLE (
    idNumber INTEGER,
    "numSign" BIGINT
) AS
$function$
    BEGIN
        RETURN QUERY EXECUTE format(
            'SELECT %I.signatory AS idNumber, COUNT(%I.id) AS "numSign"
               FROM %I %I
              WHERE %I."status" = 0
                AND %I.%I IN (SELECT %I.id
                                FROM %I %I
                               WHERE %I."GOSMActivity" IN (SELECT ga.id
                                                             FROM "GOSMActivity_get_current_term_activity_ids"() ga))
            GROUP BY %I.signatory;',
        "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTable", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableColumn", "parentTableAcronym", "parentTable", "parentTableAcronym", "parentTableAcronym", "signatoryTableAcronym");
    END;
$function$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "PreAct_finance_get_organization"("uniqueID" INTEGER, "table" TEXT, "tableAcronym" TEXT)
RETURNS INTEGER AS
$function$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
        EXECUTE format(
            'SELECT g.studentOrganization
               FROM GOSM g
              WHERE g.id = (SELECT ga.GOSM
                              FROM GOSMActivity ga
                             WHERE ga.id = (SELECT %I."GOSMActivity"
                                              FROM %I %I
                                             WHERE %I.id = $1));',
             "tableAcronym", "table", "tableAcronym", "tableAcronym")
             INTO STRICT "var_organizationID"
             USING "uniqueID";

        RETURN "var_organizationID";
    END;
$function$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "trigger_after_insert_finance_signatories_initial"(/* "table" (0)TEXT, "tableAcronym" (1)TEXT, "signatoryTable" (2)TEXT, "signatoryTableColumn" (3)TEXT, "signatoryFunction" (4)TEXT */)
RETURNS TRIGGER AS
$trigger$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_finance_get_organization"(NEW."id", TG_ARGV[0], TG_ARGV[1]);
        organizationPresident = organization_get_president(organization);

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                    VALUES ($1."id", %I($2), 0);',
            TG_ARGV[2], TG_ARGV[3], TG_ARGV[4]
        ) USING NEW, organization;

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                    VALUES ($1."id", $2, 1);',
            TG_ARGV[2], TG_ARGV[3]
        ) USING NEW, organizationPresident;

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                     VALUES ($1."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);',
            TG_ARGV[2], TG_ARGV[3]
        ) USING NEW;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;

/*
    Helpful functions
*/
CREATE OR REPLACE FUNCTION system_get_current_term_id()
RETURNS INTEGER AS
$function$
    DECLARE
        termID INTEGER;
    BEGIN
        SELECT id INTO termID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN termID;
    END;
$function$ LANGUAGE plpgsql STABLE;


CREATE OR REPLACE FUNCTION system_get_current_year_id()
RETURNS INTEGER AS
$function$
    DECLARE
        yearID INTEGER;
    BEGIN
        SELECT id INTO yearID
          FROM SchoolYear
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN yearID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION organization_get_highest_role_id(param_organization INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT oro.id INTO roleID
          FROM OrganizationRole oro
         WHERE oro.masterRole IS NULL
           AND oro.organization = param_organization
      ORDER BY oro.rank ASC
         LIMIT 1;

        RETURN roleID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION organization_get_president(param_organization INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        presidentID INTEGER;
    BEGIN
        SELECT oo.idNumber INTO presidentID
          FROM OrganizationOfficer oo
         WHERE oo.yearID = system_get_current_year_id()
           AND oo.role = (SELECT oro.id
                            FROM OrganizationRole oro
                           WHERE oro.masterRole IS NULL
                             AND oro.organization = param_organization
                        ORDER BY oro.rank ASC
                           LIMIT 1);

        RETURN presidentID;
    END;
$function$ LANGUAGE plpgsql STABLE;

    CREATE OR REPLACE FUNCTION organization_get_role_id_above_account(param_IDNumber INTEGER, param_organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT oro.masterRole INTO roleID
          FROM OrganizationRole oro
         WHERE oro.organization = param_organizationID
           AND oro.id = (SELECT oo.role
                           FROM OrganizationOfficer oo
                          WHERE oo.idNumber = param_IDNumber
                            AND oo.yearID = system_get_current_year_id());
        RETURN roleID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION organization_get_officers_with_role_id(roleID INTEGER)
RETURNS TABLE (
    idNumber INTEGER
) AS
$function$
    BEGIN
        RETURN QUERY SELECT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.role = roleID
                        AND oo.yearID = system_get_current_year_id();
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION organization_get_treasurer_signatories(organizationID INTEGER)
RETURNS TABLE (
    idNumber INTEGER
) AS
$function$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 11)
                        AND oo.role/10000 = organizationID;
    END;
$function$ STABLE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION organization_get_documentation_signatories(organizationID INTEGER)
RETURNS TABLE (
    idNumber INTEGER
) AS
$function$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 12)
                        AND oo.role/10000 = organizationID;
    END;
$function$ STABLE LANGUAGE plpgsql;

 CREATE OR REPLACE FUNCTION cso_get_first_phase_signatories()
 RETURNS TABLE (
     idNumber INTEGER
 ) AS
 $function$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 13)
                         AND oo.role/10000 = 0;
     END;
 $function$ STABLE LANGUAGE plpgsql;

 CREATE OR REPLACE FUNCTION cso_get_second_phase_signatories()
 RETURNS TABLE (
     idNumber INTEGER
 ) AS
 $function$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 14)
                         AND oo.role/10000 = 0;
     END;
 $function$ STABLE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "GOSMActivity_get_organization"(GOSMActivityID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        organizationID INTEGER;
    BEGIN
        SELECT studentOrganization INTO organizationID
          FROM GOSM
         WHERE id = (SELECT GOSM
                       FROM GOSMActivity
                      WHERE id = GOSMActivityID);

        RETURN organizationID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "GOSMActivity_get_current_term_activity_ids"()
RETURNS TABLE (
    id INTEGER
) AS
$function$
    BEGIN
        RETURN QUERY SELECT ga.id
                       FROM GOSMActivity ga
                      WHERE GOSM IN (SELECT g.id
                                       FROM GOSM g
                                       WHERE termId = system_get_current_term_id());
    END;
$function$ LANGUAGE plpgsql STABLE;

/* SIGNATORY FUNCTIONS */
CREATE OR REPLACE FUNCTION "PPR_get_number_to_sign_per_account"()
RETURNS TABLE (
    idNumber INTEGER,
    "numSign" BIGINT
) AS
$function$
    BEGIN
        RETURN QUERY SELECT signatory AS idNumber, COUNT(pprs.id) AS "numSign"
                       FROM ProjectProposalSignatory pprs
                      WHERE status = 0
                        AND GOSMActivity IN (SELECT id
                                             FROM "GOSMActivity_get_current_term_activity_ids"())
                   GROUP BY pprs.signatory;
    END;
$function$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "PPR_get_organization_next_treasurer_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$function$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "PPR_get_organization_next_immediate_supervisor_signatory"(preparedBy INTEGER, organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        immediateSupervisorRoleID INTEGER;
        immediateSupervisorID INTEGER;
    BEGIN
        immediateSupervisorRoleID = "organization_get_role_id_above_account"(preparedBy, organizationID);

         WITH "OrganizationImmediateSupervisorNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM "organization_get_officers_with_role_id"(immediateSupervisorRoleID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                                  ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO immediateSupervisorID
            FROM "OrganizationImmediateSupervisorNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN immediateSupervisorID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PPR_get_organization_next_documentation_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        documentationID INTEGER;
    BEGIN
         WITH "OrganizationDocumentationNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_documentation_signatories(organizationID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                         ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO documentationID
           FROM "OrganizationDocumentationNumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN documentationID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PPR_get_cso_next_first_phase_signatory"()
RETURNS INTEGER AS
$function$
    DECLARE
        csoOfficerID INTEGER;
    BEGIN
         WITH "CSONumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM cso_get_first_phase_signatories() ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO csoOfficerID
           FROM "CSONumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN csoOfficerID;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PPR_get_cso_next_second_phase_signatory"()
RETURNS INTEGER AS
$function$
    DECLARE
        csoOfficerID INTEGER;
    BEGIN
         WITH "CSONumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM cso_get_second_phase_signatories() ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                 ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO csoOfficerID
           FROM "CSONumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN csoOfficerID;
    END;
$function$ LANGUAGE plpgsql STABLE;


CREATE OR REPLACE FUNCTION "PPR_get_GOSMActivity_id_from_PPRID"(param_PPRID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        var_GOSMActivity INTEGER;
    BEGIN
         SELECT GOSMActivity INTO var_GOSMActivity
           FROM ProjectProposal
          WHERE id = param_PPRID;

        RETURN var_GOSMActivity;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "system_get_functionality_id"(param_sequenceID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        var_FunctionalityID INTEGER;
    BEGIN
         SELECT id INTO var_FunctionalityID
           FROM Functionality
          WHERE id%100 = param_sequenceID;

        RETURN var_FunctionalityID;
    END;
$function$ LANGUAGE plpgsql STABLE;

/* PRE ACTIVITY DIRECT PAYMENT */
CREATE OR REPLACE FUNCTION "PreAct_DirectPayment_get_organization"("param_DPID" INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
         SELECT g.studentOrganization INTO "var_organizationID"
           FROM GOSM g
          WHERE g.id = (SELECT ga.GOSM
                          FROM GOSMActivity ga
                         WHERE ga.id = (SELECT paca."GOSMActivity"
                                          FROM "PreActivityDirectPayment" paca
                                         WHERE paca.id = "param_DPID"));

        RETURN "var_organizationID";
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PreAct_DirectPayment_get_number_to_sign_per_account"()
RETURNS TABLE (
    idNumber INTEGER,
    "numSign" BIGINT
) AS
$function$
    BEGIN
        RETURN QUERY SELECT preca.signatory AS idNumber, COUNT(preca.id) AS "numSign"
                       FROM "PreActivityDirectPaymentSignatory" preca
                      WHERE preca."status" = 0
                        AND preca."directPayment" IN (SELECT paca.id
                                                        FROM "PreActivityDirectPayment" paca
                                                       WHERE paca."GOSMActivity" IN (SELECT ga.id
                                                                                       FROM "GOSMActivity_get_current_term_activity_ids"() ga))
                   GROUP BY preca.signatory;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PreAct_DirectPayment_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$function$ LANGUAGE plpgsql STABLE;

/* PRE ACTIVITY CASH ADVANCE */
CREATE OR REPLACE FUNCTION "PreAct_CashAdvance_get_organization"("param_CAID" INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
         SELECT g.studentOrganization INTO "var_organizationID"
           FROM GOSM g
          WHERE g.id = (SELECT ga.GOSM
                          FROM GOSMActivity ga
                         WHERE ga.id = (SELECT paca."GOSMActivity"
                                          FROM "PreActivityCashAdvance" paca
                                         WHERE paca.id = "param_CAID"));

        RETURN "var_organizationID";
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PreActCashAdvance_get_number_to_sign_per_account"()
RETURNS TABLE (
    idNumber INTEGER,
    "numSign" BIGINT
) AS
$function$
    BEGIN
        RETURN QUERY SELECT preca.signatory AS idNumber, COUNT(preca.id) AS "numSign"
                       FROM "PreActivityCashAdvanceSignatory" preca
                      WHERE preca."status" = 0
                      AND preca."cashAdvance" IN (SELECT paca.id
                                                    FROM "PreActivityCashAdvance" paca
                                                   WHERE paca."GOSMActivity" IN (SELECT ga.id
                                                                                   FROM "GOSMActivity_get_current_term_activity_ids"() ga))
                   GROUP BY preca.signatory;
    END;
$function$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION "PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PreActCashAdvance_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$function$ LANGUAGE plpgsql STABLE;

/* Book Transfer */
CREATE OR REPLACE FUNCTION "PreAct_BookTransfer_get_organization_next_treasurer_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "signatory_get_to_sign_per_account"('PreActivityBookTransferSignatory', 'pabts', 'bookTransfer', 'PreActivityBookTransfer', 'pabt') n
                                                                                     ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO treasurerID
           FROM "OrganizationTreasurerNumSign" ot
       ORDER BY "numSign" ASC, ot.idNumber DESC
          LIMIT 1;

        RETURN treasurerID;
    END;
$function$ LANGUAGE plpgsql STABLE;


/* Post Project Reimbursment */
CREATE OR REPLACE FUNCTION "PostAct_Reimbursement_get_organization_next_treasurer_signatory"(organizationID INTEGER)
RETURNS INTEGER AS
$function$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "signatory_get_to_sign_per_account"('PostProjectReimbursementSignatory', 'pprs', 'reimbursement', 'PostProjectReimbursement', 'ppr') n
                                                                                     ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO treasurerID
           FROM "OrganizationTreasurerNumSign" ot
       ORDER BY "numSign" ASC, ot.idNumber DESC
          LIMIT 1;

        RETURN treasurerID;
    END;
$function$ LANGUAGE plpgsql STABLE;

/*
EXTREMELY DANGEROUS FUNCTION
SQL INJECTION POSSIBLE EXPLOITABLE
 */
CREATE OR REPLACE FUNCTION "system_get_next_finance_signatory"("signatoryTable" TEXT, "signatoryTableAcronym" TEXT, "where" TEXT)
RETURNS INTEGER AS
$function$
    DECLARE
        signatoryID INTEGER;
    BEGIN
        EXECUTE format(
            'SELECT *
              FROM %I %I LEFT JOIN "FinanceSignatoryType" "fst"
                                ON %I."type" = "fst"."id"
             WHERE %I."status" = 0
               AND (%s)
          ORDER BY "fst"."lineup" ASC
             LIMIT 1;',
        "signatoryTable", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableAcronym", "where"
        ) INTO signatoryID;

        RETURN signatoryID;
    END;
$function$ LANGUAGE plpgsql STABLE;
/*
    Helpful functions end
*/

DROP TABLE IF EXISTS AccountType CASCADE;
CREATE TABLE AccountType (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
INSERT INTO AccountType(id, name)
VALUES (0, 'Admin'),
       (1, 'Student Account'),
       (2, 'Faculty Adviser Account'),
       (3, 'Director of S-Life'),
       (4, 'Dean of Student Affairs'),
       (5, 'Vice President for Lasallian Mission'),
       (6, 'President');

DROP TABLE IF EXISTS "AccountStatus" CASCADE;
CREATE TABLE "AccountStatus" (
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "AccountStatus" ("id", "name")
                     VALUES (   0, 'Active'),
                            (   1, 'Disabled si Neil'),
                            (   2, 'Deleted'),
                            (   3, 'Virgin Account');

DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
    idNumber INTEGER,
    email VARCHAR(255) NULL UNIQUE,
    type SMALLINT REFERENCES AccountType(id) DEFAULT 1,
    status SMALLINT REFERENCES "AccountStatus"("id") DEFAULT 3,
    password CHAR(60) NOT NULL,
    salt CHAR(29),
    firstname VARCHAR(45),
    middlename VARCHAR(45),
    lastname VARCHAR(45),
    contactNumber VARCHAR(16),
    privatekey TEXT,
    publickey TEXT,
    path_profilePicture TEXT,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateModified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    passwordExpiration TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (idNumber)
);
    /* Account Table Triggers */
CREATE OR REPLACE FUNCTION trigger_before_insert_Account()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

        NEW.dateCreated = CURRENT_TIMESTAMP;
        NEW.dateModified = NEW.dateCreated;
        NEW.passwordExpiration = NEW.dateCreated + (INTERVAL '3 MONTH');
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Account
    BEFORE INSERT ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Account();

CREATE OR REPLACE FUNCTION trigger_before_update_Account()
RETURNS trigger AS
$trigger$
    BEGIN
        IF OLD.password <> NEW.password THEN
            SELECT gen_salt('bf') INTO NEW.salt;
            SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

            NEW.passwordExpiration = CURRENT_TIMESTAMP + (INTERVAL '3 MONTH');
        END IF;

        NEW.dateModified = CURRENT_TIMESTAMP;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_Account
    BEFORE UPDATE ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_update_Account();

    /* Account Table Triggers End */

    /* Account Notifications */
DROP TABLE IF EXISTS "AccountNotificationStatus" CASCADE;
CREATE TABLE "AccountNotificationStatus" (
  "id" SMALLINT,
  "name" VARCHAR(45),

  PRIMARY KEY ("id")
);
INSERT INTO "AccountNotificationStatus"("id", "name")
                                VALUES (   0, 'Sent/Unseen'),
                                       (   1, 'Seen'),
                                       (   2, 'Opened'),
                                       (   3, 'Deleted');

DROP TABLE IF EXISTS "AccountNotification" CASCADE;
CREATE TABLE "AccountNotification" (
  "id" SERIAL NOT NULL UNIQUE,
  "account" INTEGER REFERENCES Account(idNumber),
  "sequence" INTEGER NOT NULL DEFAULT -1,
  "status" SMALLINT REFERENCES "AccountNotificationStatus"("id") DEFAULT 0,
  "date" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "title" TEXT,
  "description" TEXT,
  "details" JSON,

  PRIMARY KEY ("account", "sequence")
);
CREATE TRIGGER "before_insert_AccountNotification"
    BEFORE INSERT ON "AccountNotification"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_increment_sequence"('AccountNotification', 'an', 'an."account" = $1."account"');

DROP TABLE IF EXISTS SchoolYear CASCADE;
CREATE TABLE SchoolYear (
    id INTEGER UNIQUE,
    startYear SMALLINT,
    endYear SMALLINT,
    dateStart DATE NOT NULL,
    dateEnd DATE NOT NULL,

    PRIMARY KEY (startYear, endYear),
    CONSTRAINT start_end_year_value CHECK(startYear < endYear)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_SchoolYear()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id := (NEW.startYear*10000) + NEW.endYear;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_SchoolYear
    BEFORE INSERT ON SchoolYear
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_SchoolYear();

DROP TABLE IF EXISTS Term CASCADE;
CREATE TABLE Term (
    id INTEGER UNIQUE,
    schoolYearID INTEGER REFERENCES SchoolYear(id),
    number INTEGER,
    dateStart DATE NOT NULL,
    dateEnd DATE NOT NULL,

    PRIMARY KEY (schoolYearID, number),
    CONSTRAINT number_min_value CHECK(number >= 1),
    CONSTRAINT number_max_value CHECK(number <= 3),
    CONSTRAINT date_start_end_value CHECK (dateStart <= dateEnd)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_Term()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id := (NEW.schoolYearID*10) + NEW.number;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Term
    BEFORE INSERT ON Term
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Term();

DROP TABLE IF EXISTS College CASCADE;
CREATE TABLE College (
    shortAcronym CHAR(3),
    fullAcronym VARCHAR(20),
    name VARCHAR(60),

    PRIMARY KEY (shortAcronym)
);
INSERT INTO College (shortAcronym, fullAcronym, name)
             VALUES ('CED', 'BAGCED', 'Br. Andrew Gonzalez FSC College of Education'),
                    ('CCS', NULL, 'College of Computer Studies'),
                    ('COL', NULL, 'College of Law'),
                    ('CLA', NULL, 'College of Liberal Arts'),
                    ('COS', null, 'College of Science'),
                    ('COE', 'GCOE', 'Gokongwei College of Engineering'),
                    ('COB', 'RVRCOB', 'Ramon V. del Rosario College of Business'),
                    ('SOE', null, 'School of Economics');

DROP TABLE IF EXISTS ActivityType CASCADE;
CREATE TABLE ActivityType (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO ActivityType (id, name)
                  VALUES (0, 'Competition'),
                         (1, 'Distribution'),
                         (2, 'General Assembly'),
                         (3, 'Seminar/Workshop'),
                         (4, 'Publicity/Awareness Campaign'),
                         (5, 'Meetings'),
                         (6, 'Spiritual Activity'),
                         (7, 'Recruitment/Audition'),
                         (8, 'Recreation'),
                         (9, 'Others');

/* Activity Requirements */
DROP TABLE IF EXISTS DocumentAttachmentRequirement CASCADE;
CREATE TABLE DocumentAttachmentRequirement (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY(id)
);
INSERT INTO DocumentAttachmentRequirement (id, name)
                                   VALUES (0, 'Mechanics'),
                                          (1, 'Letter for use of Different Venues in Campus'),
                                          (2, 'Sample Design'),
                                          (3, 'Venue Reservation Ticket'),
                                          (4, 'Credentials of Speaker'),
                                          (5, 'Sample Publicity'),
                                          (6, 'Agenda'),
                                          (7, 'LSPO Form'),
                                          (8, 'Sample Application Form'),
                                          (9, 'Informal Quotation'),
                                          (10, 'Estimated List of Participants'),
                                          (11, 'Mechanics of Competition');

DROP TABLE IF EXISTS ActivityAttachmentRequirement CASCADE;
CREATE TABLE ActivityAttachmentRequirement (
    id SERIAL,
    activityType INTEGER REFERENCES ActivityType(id),
    attachment SMALLINT REFERENCES DocumentAttachmentRequirement(id),
    optional BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (activityType, attachment)
);
DROP TABLE IF EXISTS PreActivityAttachmentRequirement CASCADE;
CREATE TABLE PreActivityAttachmentRequirement (

    PRIMARY KEY (activityType, attachment),
    CONSTRAINT PreActivityAttachmentRequirement_ActivityType_fkey FOREIGN KEY (activityType) REFERENCES ActivityType(id),
    CONSTRAINT PreActivityAttachmentRequirement_DocumentAttachmentRequirement_fkey FOREIGN KEY (attachment) REFERENCES DocumentAttachmentRequirement(id)
) INHERITS (ActivityAttachmentRequirement);
INSERT INTO PreActivityAttachmentRequirement (activityType, attachment, optional)
VALUES (0, 0, FALSE),
       (0, 1, FALSE),
       (1, 2, FALSE),
       (2, 3, FALSE),
       (3, 3, FALSE),
       (3, 4, FALSE),
       (4, 3, FALSE),
       (4, 5, FALSE),
       (5, 3, FALSE),
       (5, 6, FALSE),
       (6, 3, FALSE),
       (6, 7,  TRUE),
       (7, 3, FALSE),
       (7, 8, FALSE),
       (7, 0, FALSE),
       (8, 3, FALSE),
       (9, 3, FALSE);

DROP TABLE IF EXISTS PostActivityAttachmentRequirement CASCADE;
CREATE TABLE PostActivityAttachmentRequirement (

    PRIMARY KEY (activityType, attachment),
    CONSTRAINT PostActivityAttachmentRequirement_ActivityType_fkey FOREIGN KEY (activityType) REFERENCES ActivityType(id),
    CONSTRAINT PostActivityAttachmentRequirement_DocumentAttachmentRequirement_fkey FOREIGN KEY (attachment) REFERENCES DocumentAttachmentRequirement(id)
) INHERITS (ActivityAttachmentRequirement);
/* Activity Requirements End */

DROP TABLE IF EXISTS ActivityNature CASCADE;
CREATE TABLE ActivityNature (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO ActivityNature (id, name)
                    VALUES ( 1, 'Academic'),
                           ( 2, 'Special Interest'),
                           ( 3, 'Departmental Initiative'),
                           ( 4, 'Fundraising'),
                           ( 5, 'Community Development'),
                           ( 6, 'Organizational Development'),
                           ( 7, 'Issue Advocacy'),
                           ( 8, 'Lasallian Formation/Spiritual Growth'),
                           ( 9, 'Outreach');

/* Organizations */
/*
DROP SEQUENCE IF EXISTS organization_id_sequence;
CREATE SEQUENCE organization_id_sequence INCREMENT BY 1
MINVALUE 0 NO MAXVALUE START WITH 0 NO CYCLE;
*/
DROP TABLE IF EXISTS OrganizationNature CASCADE;
CREATE TABLE OrganizationNature (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,
    acronym VARCHAR(10),

    PRIMARY KEY(id)
);
INSERT INTO OrganizationNature (id, name, acronym)
                         VALUES (1, 'Special Interest', 'SPIN'),
                                (2, 'Professional Organization', 'PROF'),
                                (3, 'Socio-civic and Religious', 'SCORE'),
                                (4, 'Professional Organization Group', 'PROG');

DROP TABLE IF EXISTS OrganizationCluster CASCADE;
CREATE TABLE OrganizationCluster (
    id SMALLINT,
    name VARCHAR(128) NOT NULL,
    acronym VARCHAR(20),

    PRIMARY KEY(id)
);
INSERT INTO OrganizationCluster (id, name, acronym)
                         VALUES (1, 'Alliance of Science Organizations', 'ASO'),
                                (2, 'Alliance of Special Interest and Socio-Civic Organizations', 'ASPIRE'),
                                (3, 'College of Liberal Arts Professional Organizations', 'CAP12'),
                                (4, 'Engineering Alliance Geared Towards Excellence', 'ENGAGE'),
                                (5, 'Alliance of Professional Organizations of Business and Economics', 'PROBE');

DROP TABLE IF EXISTS OrganizationStatus CASCADE;
CREATE TABLE OrganizationStatus (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY(id)
);
INSERT INTO OrganizationStatus (id, name)
                        VALUES ( 0, 'Active'),
                               ( 1, 'Suspended'),
                               ( 3, 'Dissolved');

DROP TABLE IF EXISTS StudentOrganization CASCADE;
CREATE TABLE StudentOrganization (
    /*
      NOTE: UNIMPLEMENTED
      Transaction ID Format:
      NNSSS

      N = nature
      S = unique sequence
    */
    id INTEGER UNIQUE,
    name VARCHAR(128),
    status SMALLINT REFERENCES StudentOrganization(id) DEFAULT 0,
    cluster SMALLINT REFERENCES OrganizationCluster(id),
    nature SMALLINT REFERENCES OrganizationNature(id),
    college CHAR(3) REFERENCES College(shortAcronym),
    acronym VARCHAR(20) UNIQUE,
    description TEXT,
    funds NUMERIC(16, 2) NOT NULL DEFAULT 0.0,
    operationalFunds NUMERIC(16, 2) NOT NULL DEFAULT 0.0,
    depositoryFunds NUMERIC(16, 2) NOT NULL DEFAULT 0.0,
    depositryFunds NUMERIC(16, 2) NOT NULL DEFAULT 0.0,
    path_profilePicture TEXT,
    accountNumber CHAR(7),

    PRIMARY KEY (id)
);
INSERT INTO StudentOrganization (id, acronym, name, description, path_profilePicture)
                         VALUES (0, 'CSO', 'Council of Student Organizations', NULL, '\plugins\images\cso.png');

DROP TABLE IF EXISTS OrganizationFacultyAdviser CASCADE;
CREATE TABLE OrganizationFacultyAdviser (
    id SERIAL NOT NULL UNIQUE,
    organization INTEGER REFERENCES StudentOrganization(id),
    faculty INTEGER REFERENCES Account(idNumber),
	yearID INTEGER REFERENCES SchoolYear(id) DEFAULT system_get_current_year_id(),

	PRIMARY KEY(organization, faculty, yearID)
);
    /* Organization Structure */
DROP TABLE IF EXISTS OrganizationRole CASCADE;
CREATE TABLE OrganizationRole (
  /*
    Transaction ID Format:
    OOOSSSS

    O = student organization sequence
    S = unique sequence
  */
	id INTEGER UNIQUE DEFAULT - 1,
	organization INTEGER REFERENCES StudentOrganization(id) ON UPDATE CASCADE,
	sequence INTEGER DEFAULT -1,
	name VARCHAR(100),
	shortname VARCHAR(16),
	rank INTEGER,
	uniquePosition BOOLEAN NOT NULL DEFAULT FALSE,
	masterRole INTEGER REFERENCES OrganizationRole(id) ON DELETE CASCADE ON UPDATE CASCADE,
    home_url TEXT,

	PRIMARY KEY (organization, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_OrganizationRole()
RETURNS trigger AS
$trigger$
    BEGIN
      SELECT COALESCE(MAX(id%10000) + 1, 0) INTO NEW.id
        FROM OrganizationRole;

      NEW.id = (NEW.organization%1000)*10000 + NEW.id;

      SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
        FROM OrganizationRole
      WHERE organization = NEW.organization;
      return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_OrganizationRole
    BEFORE INSERT ON OrganizationRole
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_OrganizationRole();


INSERT INTO OrganizationRole (organization, name, shortname, uniquePosition, masterRole, rank)
                      VALUES
                      		 -- 0
                      		 ( 0, 'Chairperson', 'Chair', TRUE, NULL, 0),
                      		 /* Executive board */
                             -- 1
                             ( 0, 'Executive Vice Chairperson for Internals',                     'EVC - Interals',  TRUE, 0, 10),
                             -- 2
                             ( 0, 'Executive Vice Chairperson for Externals',                     'EVC - Externals', TRUE, 0, 10),
                             -- 3
                             ( 0, 'Executive Vice Chairperson for Activities and Documentations', 'EVC - AND',       TRUE, 0, 10),
                             -- 4
                             ( 0, 'Executive Vice Chairperson for Finance',                       'EVC - Finance',   TRUE, 0, 10),

                             /* Activity Documentations and Management */
                             -- 5
                             ( 0, 'Vice Chairperson for Activity Documentations and Management',            'VC - AND',  TRUE, 2, 20),
                             -- 6
                             ( 0, 'Associate Vice Chairperson for Activity Documentations and Management', 'AVC - AND', FALSE, 5, 30),
                             -- 7
                             ( 0, 'Associate for Activity Documentations and Management',                  'AVC - AND', FALSE, 6, 40),

                             /* Activity Monitoring Team */
                             -- 8
                             ( 0, 'Vice Chairperson for Activity Monitoring Team',            'VC - AMT',  TRUE, 2, 20),
                             -- 9
                             ( 0, 'Associate Vice Chairperson for Activity Monitoring Team', 'AVC - AMT', FALSE, 9, 30),
                             -- 10
                             ( 0, 'Associate for Activity Monitoring Team',                    'A - AMT', FALSE, 10, 40),

                             /* Activity Processing and Screening */
                             -- 11
                             ( 0, 'Vice Chairperson for Activity Processing and Screening',            'VC - APS',  TRUE, 2, 20),
                             -- 12
                             ( 0, 'Associate Vice Chairperson for Activity Processing and Screening', 'AVC - APS', FALSE, 11, 30),
                             -- 13
                             ( 0, 'Associate Activity Processing and Screening',                        'A - APS', FALSE, 12, 40),

                             /* Finance */
                             -- 14
                             ( 0, 'Vice Chairperson for Finance',            'VC - Finance',  TRUE, 2, 20),
                             -- 15
                             ( 0, 'Associate Vice Chairperson for Finance', 'AVC - Finance', FALSE, 14, 30),
                             -- 16
                             ( 0, 'Associate for Finance',                    'A - Finance', FALSE, 15, 40),

                             /* Publicity and Productions */
                             -- 17
                             ( 0, 'Vice Chairperson for Publicity and Productions',            'VC - PNP',  TRUE, 3, 20),
                             -- 18
                             ( 0, 'Associate Vice Chairperson for Publicity and Productions', 'AVC - PNP', FALSE, 18, 30),
                             -- 19
                             ( 0, 'Associate for Publicity and Productions',                    'A - PNP', FALSE, 19, 40),

                             /* Organizational Research and Analysis */
                             -- 20
                             ( 0, 'Vice Chairperson for Organizational Research and Analysis',            'VC - OrgRes', TRUE, 2, 20),
                             -- 21
                             ( 0, 'Associate Vice Chairperson for Organizational Research and Analysis', 'AVC - OrgRes', FALSE, 21, 30),
                             -- 22
                             ( 0, 'Associate for Organizational Research and Analysis',                    'A - OrgRes', FALSE, 22, 40);

DROP TABLE IF EXISTS OrganizationOfficer CASCADE;
CREATE TABLE OrganizationOfficer (
	idNumber INTEGER REFERENCES Account(idNumber),
	role INTEGER REFERENCES OrganizationRole(id),
	yearID INTEGER REFERENCES SchoolYear(id),
	dateAssigned TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        isActive BOOLEAN DEFAULT TRUE,

	PRIMARY KEY(idNumber, role, yearID)
);

DROP TABLE IF EXISTS "OrganizationMember" CASCADE;
CREATE TABLE "OrganizationMember" (
    "id" SERIAL UNIQUE,
	"idNumber" INTEGER,
	"yearID" INTEGER REFERENCES SchoolYear(id),
	"dateAdded" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

	PRIMARY KEY("idNumber", "yearID")
);

    /* Organization Structure End */
	/* Access Control*/
DROP TABLE IF EXISTS FunctionalityDomain CASCADE;
CREATE TABLE FunctionalityDomain (
  id SMALLINT,
  name VARCHAR(45),

  PRIMARY KEY (id)
);
INSERT INTO FunctionalityDomain (id, name)
                         VALUES (0, 'Administrative'),
                                (1, 'CSO'),
                                (2, 'Organization'),
                                (3, 'Faculty Adviser'),
                                (4, 'SLIFE'),
                                (5, 'Accouning');

DROP TABLE IF EXISTS FunctionalityCategory CASCADE;
CREATE TABLE FunctionalityCategory (
  /*
    Transaction ID Format:
    DDSS

    D = functionality sequence ID
    S = unique sequence
  */
  id INTEGER,
  name VARCHAR(45),
  domain SMALLINT REFERENCES FunctionalityDomain (id) ON UPDATE CASCADE,

  PRIMARY KEY (id)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_FunctionalityCategory()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(id%100) + 1, 0) INTO NEW.id
          FROM FunctionalityCategory;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_FunctionalityCategory
    BEFORE INSERT ON FunctionalityCategory
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_FunctionalityCategory();

CREATE OR REPLACE FUNCTION trigger_before_update_FunctionalityCategory()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id = OLD.id%100;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_FunctionalityCategory
    BEFORE UPDATE ON FunctionalityCategory
    FOR EACH ROW WHEN ((OLD.domain <> NEW.domain) OR (OLD.domain IS NULL))
    EXECUTE PROCEDURE trigger_before_update_FunctionalityCategory();

INSERT INTO FunctionalityCategory (id, name, domain)
                           VALUES (0,  'Website Configuration', 0),
                                  (1,  'Organization Structure Management', 0),
                                  (2,  'Account Management', 0),
                                  (3,  'Manage Organizations List', 0),
                                  -- CSO
                                  (104,  'Activity Processing', 1),
                                  (105,  'Finance', 1),
                                  (106,  'Publicity and Productions', 1),
                                  (107,  'Activity Monitoring', 1),
                                  (108,  'Activity Documentation', 1),
                                  (109,  'Organizational Research', 1),
                                  -- Student Organization
                                  (210, 'Publicity/Creatives/Productions', 2),
                                  (211, 'Activity Processing & Documentations', 2),
                                  (212, 'Submit Financial Documents', 2),
                                  (213, 'Cancel Financial Documents', 2),
                                  (214, 'Organization Management', 2);

DROP TABLE IF EXISTS Functionality CASCADE;
CREATE TABLE Functionality (
  /*
    Transaction ID Format:
    CCCSSS

    C = category ID
    S = unique sequence
  */
    id INTEGER,
    name VARCHAR (100),
    category INTEGER REFERENCES FunctionalityCategory (id) ON UPDATE CASCADE,

    PRIMARY KEY (id)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_Functionality()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(id%1000) + 1, 0) INTO NEW.id
          FROM Functionality;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_Functionality
    BEFORE INSERT ON Functionality
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_Functionality();

CREATE OR REPLACE FUNCTION trigger_before_update_Functionality()
RETURNS trigger AS
$trigger$
    BEGIN
        NEW.id = OLD.id%1000;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_Functionality
    BEFORE UPDATE ON Functionality
    FOR EACH ROW WHEN ((OLD.category <> NEW.category) OR (OLD.category IS NULL))
    EXECUTE PROCEDURE trigger_before_update_Functionality();

INSERT INTO Functionality (id, name, category)
                -- NUMBER ONE RULE IN THIS TABLE, NEVER UPDATE, DELETE, OR CHANGE THE NUMBERS OR THE SYSTEM DIES
                   VALUES (211000, 'Submit GOSM'                        , 211),
                          (211001, 'Resubmit GOSM'                      , 211),
                          (104002, 'Evaluate GOSM'                      , 104),
                          (104003, 'Evaluate Project Proposal'          , 104),
                          (108004, 'Evaluate Activity (AMT)'            , 108),
                          (106005, 'View Publicity Material'            , 106),
                          (109006, 'Submit Activity Research Form (ARF)', 109), -- Evaluate Activity
                          (214007, 'Modify Organizational Structure'    , 214),
                          (003008, 'Manage Organizations'               ,   3),
                          (211009, 'View Project Head Dashboard'        , 211),
                          (211010, 'View APS Report'                    , 211),
                          -- PPR Signing
                          (211011, 'Sign Project Proposal as Treasurer'     , 211),
                          (211012, 'Sign Project Proposal as Documentations', 211),
                          (104013, 'Sign Project Proposal CSO Phase - 1'    , 104),
                          (104014, 'Sign Project Proposal CSO Phase - 2'    , 104),
                          (211015, 'Force Sign Project Proposal'            , 211),
                          -- Publicity
                          (210016, 'Submit Publicity Material'              , 210),
                          (106017, 'Evaluate Publicity Material'            , 106),
                          -- Finance
                          (212018, 'Submit Financial Documents'             , 212),
                          -- Signatory for Org
                          (212019, 'Sign Financial Document Phase' , 212),
                          (108020, 'Evaluate Post Project'         , 108),
                          (212021, 'Evaluate Financial Documents'             , 212),
                          (212022, 'Auto-approve Financial Documents'         , 212),
                          -- Account Management
                          (  2023, 'Account Management', 2),
                          -- PPR Signing (President)
                          (211024, 'Sign Project Proposal as President', 211),
                          -- Finance Signatory
                          -- mistakes were made in the design of ACLs, the two ACLS can be compressed into a single ACL
                          -- But for sanity and backwards compatability, they're retained
                          (211025, 'View/Submit Financial Documents as President', 211),
                          (211026, 'View/Submit Financial Documents as Treasurer', 211),

                          (214027, 'Submit Officer Survey Form', 214),

                          (104028, 'Submit Not in GOSM Activities',  104);

DROP TABLE IF EXISTS OrganizationAccessControl CASCADE;
CREATE TABLE OrganizationAccessControl (
	role INTEGER REFERENCES OrganizationRole (id),
	functionality INTEGER REFERENCES Functionality (id) ON UPDATE CASCADE,
	isAllowed BOOLEAN NOT NULL DEFAULT FALSE,

	PRIMARY KEY (role, functionality)
);
/* CSO Defaults */
INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                               VALUES -- Evaluate GOSM Activity
                                      (    0,        104002,      TRUE),
                                      (    1,        104002,      TRUE),
                                      (    2,        104002,      TRUE),
                                      (    3,        104002,      TRUE),
                                      (    4,        104002,      TRUE),
                                      -- Evaluate Project Proposal
                                      (   11,        104003,      TRUE),
                                      (   12,        104003,      TRUE),
                                      (   13,        104003,      TRUE),
                                      -- Evaluate Activity (AMT)
                                      (    8,        108004,      TRUE),
                                      (    9,        108004,      TRUE),
                                      (   10,        108004,      TRUE),
                                      -- Submit Activity Research Form (ARF)/ Evaluate Activity (OrgRes)
                                      (   20,        109006,      TRUE),
                                      (   21,        109006,      TRUE),
                                      (   22,        109006,      TRUE),
                                      -- Modify Organizational Structure
                                      (    0,        214007,      TRUE),
                                      -- Manage Organizations
                                      (    1,        003008,      TRUE),
                                      (    2,        003008,      TRUE),
                                      (    3,        003008,      TRUE),
                                      (    4,        003008,      TRUE),
                                      (    5,        003008,      TRUE),
                                      (   21,        003008,      TRUE),
                                      -- SIGN PPR
                                      (   13,        104013,      TRUE),
                                      (   12,        104014,      TRUE),
                                      -- Evaluate Publicity Material
                                      (   17,        106017,      TRUE),
                                      (   18,        106017,      TRUE),
                                      (   19,        106017,      TRUE),
                                      -- Evaluate Publicity Material
                                      (    5,        108020,      TRUE),
                                      (    6,        108020,      TRUE),
                                      (    7,        108020,      TRUE),
                                      -- Account Management
                                      (    2,          2023,      TRUE),
                                      (   21,          2023,      TRUE);

/* Organization Default Structure */

CREATE OR REPLACE FUNCTION "trigger_after_insert_StudentOrganization_ACL"()
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
        joRoleID INTEGER;
    BEGIN
        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'President', 'P', TRUE, NULL, 0)
        RETURNING id INTO presidentRoleID;

        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                       VALUES (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 0)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 7)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 15)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 19)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 21)), TRUE),
                                              -- Sign PPR as President
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 24)), TRUE),
                                              -- Sign Finance Transaction as President
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 25)), TRUE),
                                              -- Submit Officer Survey Form
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Executive Secretariat','ES', TRUE, presidentRoleID, 10)
        RETURNING id INTO executiveSecretariatRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'External Executive Vice President', 'E-EVP', TRUE, presidentRoleID, 10)
        RETURNING id INTO eevpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Internal Executive Vice President', 'I-EVP',TRUE, presidentRoleID, 10)
        RETURNING id INTO ievpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Vice President of Documentations', 'VP-D', TRUE, executiveSecretariatRoleID, 20)
        RETURNING id INTO vpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Sign PPR as Documentation
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 12)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Associate Vice President of Documentations', 'AVP-D', FALSE, vpdRoleID, 30)
        RETURNING id INTO avpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Vice President of Finance', 'VP-F', TRUE, ievpRoleID, '/Organization/treasurer/dashboard', 20)
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
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 22)), TRUE),
                                              -- Sign Finance Transaction as Treasurer
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 26)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Associate Vice President of Finance', 'AVP-F',FALSE, vpfRoleID, '/Organization/treasurer/dashboard', 30)
        RETURNING id INTO avpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE),
                                              -- Sign Finance Transaction as Treasurer
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 26)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, rank)
                             VALUES (      NEW.id, 'Junior Officer', 'JO', FALSE, 40)
        RETURNING id INTO joRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                       VALUES (joRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE);
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_insert_StudentOrganization_ACL"
    AFTER INSERT ON StudentOrganization
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_StudentOrganization_ACL"();

-- FORMS
    /* GOSM RELATED*/
DROP TABLE IF EXISTS GOSMStatus CASCADE;
CREATE TABLE GOSMStatus (
    id SMALLINT,
    name VARCHAR(45),

    PRIMARY KEY (id)
);
INSERT INTO GOSMStatus (id, name)
                VALUES (1, 'Created'),
                       (2, 'For Approval'),
                       (3, 'Approved'),
                       (4, 'Pending'),
                       (5, 'Denied');

DROP TABLE IF EXISTS GOSM CASCADE;
CREATE TABLE GOSM (
    /*
      Transaction ID Format:
      OOOSSSSS

      O = organization ID
      S = unique sequence
    */
    id INTEGER UNIQUE,
    termID INTEGER,
    studentOrganization INTEGER REFERENCES StudentOrganization(id) ON UPDATE CASCADE,
    status SMALLINT NOT NULL REFERENCES GOSMStatus(id) DEFAULT 1,
    dateCreated TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dateSubmitted TIMESTAMP WITH TIME ZONE,
    dateStatusModified TIMESTAMP WITH TIME ZONE,
    preparedBy INTEGER REFERENCES Account(idNumber),
    statusEvaluator INTEGER REFERENCES Account(idNumber),
    comments TEXT,

    PRIMARY KEY (termID, studentOrganization)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSM()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(id%100000) + 1, 1) INTO NEW.id
          FROM GOSM;

        NEW.id = (NEW.studentOrganization*100000) + NEW.id;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_GGOSM
    BEFORE INSERT ON GOSM
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_GOSM();

CREATE OR REPLACE FUNCTION trigger_before_update_GOSM_status()
RETURNS trigger AS
$trigger$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
        END CASE;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_GOSM_status
    BEFORE UPDATE ON GOSM
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE trigger_before_update_GOSM_status();

CREATE OR REPLACE FUNCTION trigger_after_update_GOSM_studentOrganization()
RETURNS trigger AS
$trigger$
    DECLARE
      newID INTEGER DEFAULT 0;
    BEGIN
        newID = NEW.studentOrganization*100000 + (OLD.id%100000);

        UPDATE GOSM
           SET id = newID
        WHERE id = OLD.id;
        NEW.id = newID;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_update_GOSM_studentOrganization
    AFTER UPDATE ON GOSM
    FOR EACH ROW WHEN (OLD.studentOrganization <> NEW.studentOrganization)
    EXECUTE PROCEDURE trigger_after_update_GOSM_studentOrganization();

DROP TABLE IF EXISTS GOSMActivity CASCADE;
CREATE TABLE GOSMActivity (
    id SERIAL UNIQUE,
    GOSM INTEGER REFERENCES GOSM(id) ON UPDATE CASCADE,
    sequence INTEGER NOT NULL DEFAULT -1,
    goals VARCHAR(255) NOT NULL,
    objectives VARCHAR(255)[] NOT NULL,
    strategies VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    measures VARCHAR(255) NOT NULL,
    targetDateStart DATE,
    targetDateEnd DATE,
    activityNature SMALLINT REFERENCES ActivityNature(id),
    activityType SMALLINT REFERENCES ActivityType(id),
    activityTypeOtherDescription VARCHAR(45),
    isRelatedToOrganizationNature BOOLEAN NOT NULL,
    budget NUMERIC(12, 2) NOT NULL DEFAULT 0.0,
    comments TEXT,
    isInGOSM BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (GOSM, sequence),
    CONSTRAINT targetdate_start_end_value CHECK(targetDateStart <= targetDateEnd)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_GOSMActivity()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(id) + 1, 1) INTO STRICT NEW.sequence
          FROM GOSMActivity
         WHERE GOSM = NEW.GOSM;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_GOSMActivity
    BEFORE INSERT ON GOSMActivity
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_GOSMActivity();

DROP TABLE IF EXISTS GOSMActivityProjectHead CASCADE;
CREATE TABLE GOSMActivityProjectHead (
    idNumber INTEGER REFERENCES Account(idNumber),
    activityID INTEGER REFERENCES GOSMActivity (id),

    PRIMARY KEY (idNumber, activityID)
);
    /* END GOSM */

    /* Project Proposal */
DROP TABLE IF EXISTS "VenueSize" CASCADE;
CREATE TABLE "VenueSize" (
	"id" SMALLINT,
	"name" VARCHAR(45) NOT NULL,

	PRIMARY KEY(id)
);
INSERT INTO "VenueSize" ("id", "name")
               VALUES ( 0, 'Small'),
                      ( 1, 'Mediume'),
                      ( 2, 'Large');

DROP TABLE IF EXISTS "RateType" CASCADE;
CREATE TABLE "RateType" (
	"id" SMALLINT,
	"name" VARCHAR(45),

	PRIMARY KEY("id")
);
INSERT INTO "RateType" ("id", "name")
VALUES (0, 'Per hour'),
       (1, 'Per person'),
       (2, 'Per use'),
       (3, 'Per person, per use'),
       (4, 'Per Dominique');

DROP TABLE IF EXISTS "Building" CASCADE;
CREATE TABLE "Building" (
	"id" SMALLINT,
	"name" VARCHAR(45) NOT NULL,

	PRIMARY KEY("id")
);

DROP TABLE IF EXISTS "ActivityVenue" CASCADE;
CREATE TABLE "ActivityVenue" (
	"id" INTEGER,
	"name" TEXT,
	"capacity" INTEGER,
	"size" SMALLINT REFERENCES "VenueSize"("id"),
	"rate" NUMERIC(12, 2),
	"rateType" SMALLINT REFERENCES "RateType"("id"),
	"building" SMALLINT REFERENCES "Building"("id"),

	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ProjectProposalStatus CASCADE;
CREATE TABLE ProjectProposalStatus (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY (id)
);
INSERT INTO ProjectProposalStatus (id, name)
                           VALUES (1, 'Created'),
                                  (2, 'For approval'),
                                  (3, 'Approved'),
                                  (4, 'Pending'),
                                  (5, 'Denied'),
                                  (6, 'Rescheduled'),
                                  (7, 'Rescheduled Denied');

DROP TABLE IF EXISTS ProjectProposalRescheduleReason CASCADE;
CREATE TABLE ProjectProposalRescheduleReason (
  id SMALLINT,
  name VARCHAR(45) NOT NULL,

  PRIMARY KEY (id)
);
INSERT INTO ProjectProposalRescheduleReason (id, name)
                         VALUES (1, 'Class suspension'),
                                (2, 'Insufficient participnts'),
                                (3, 'Speaker unavailable'),
                                (4, 'Others');

DROP TABLE IF EXISTS ProjectProposal CASCADE;
CREATE TABLE ProjectProposal (
    id SERIAL UNIQUE,
    GOSMActivity INTEGER REFERENCES GOSMActivity(id),
    status INTEGER NOT NULL REFERENCES ProjectProposalStatus(id) DEFAULT 1,

    -- Brief Context
    ENP INTEGER,
    ENMP INTEGER,
    actualDateStart DATE,
    actualDateEnd DATE,
    "venue" INTEGER REFERENCES "ActivityVenue"("id"),
    context1 TEXT,
    context2 TEXT,
    context3 TEXT,

    -- Revenue/Expense on
    isExpense BOOLEAN NOT NULL DEFAULT TRUE,
    sourceFundOther NUMERIC(12, 2),
    sourceFundParticipantFee NUMERIC(12, 2),
    sourceFundOrganizational NUMERIC(12, 2),
    accumulatedOperationalFunds NUMERIC(12, 2),
    accumulatedDepositoryFunds NUMERIC(12, 2),
    organizationFundOtherSource NUMERIC(12, 2),
    comments TEXT,
    preparedBy INTEGER REFERENCES Account(idNumber),
    facultyAdviser INTEGER REFERENCES Account(idNumber),
    dateCreated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    dateSubmitted TIMESTAMP WITH TIME ZONE,
    dateStatusModified TIMESTAMP WITH TIME ZONE,

    -- status
    isAttachmentsComplete BOOLEAN NOT NULL DEFAULT FALSE,
    isBriefContextComplete BOOLEAN NOT NULL DEFAULT FALSE,
    isExpenseComplete BOOLEAN NOT NULL DEFAULT FALSE,
    isProgramComplete BOOLEAN NOT NULL DEFAULT FALSE,

    rescheduleReason SMALLINT REFERENCES ProjectProposalRescheduleReason(id),
    reschedReasonOther TEXT,
    rescheduleDates DATE[],
    reschedRejectReason TEXT,

    timesPended INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (GOSMActivity)
);
CREATE OR REPLACE FUNCTION trigger_before_update_ProjectProposal()
RETURNS trigger AS
$trigger$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved, Pending, Denied */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
            ELSE
              RETURN NEW;
        END CASE;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_update_ProjectProposal
    BEFORE UPDATE ON ProjectProposal
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE trigger_before_update_ProjectProposal();

DROP TABLE IF EXISTS ProjectProposalProgramDesign CASCADE;
CREATE TABLE ProjectProposalProgramDesign (
    id SERIAL UNIQUE,
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    dayID INTEGER,
    sequence INTEGER,
    date DATE,
    startTime TIME WITH TIME ZONE,
    endTime TIME WITH TIME ZONE,
    activity TEXT,
    activityDescription TEXT,
    personInCharge INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (projectProposal, dayID, sequence),
    CHECK(startTime <= endTime)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProgramDesign()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal
           AND dayID = NEW.dayID;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalProgramDesign
    BEFORE INSERT ON ProjectProposalProgramDesign
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProgramDesign();

DROP TABLE IF EXISTS ProjectProposalProgramDesignPersonInCharge CASCADE;
CREATE TABLE ProjectProposalProgramDesignPersonInCharge (
    id SERIAL UNIQUE,
    programDesign INTEGER REFERENCES ProjectProposalProgramDesign(id),
    projectHead INTEGER REFERENCES Account(idNumber),

    PRIMARY KEY (programDesign, projectHead)
);

DROP TABLE IF EXISTS ProjectProposalProjectedIncome CASCADE;
CREATE TABLE ProjectProposalProjectedIncome (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    item VARCHAR(45) NOT NULL,
    quantity INTEGER NOT NULL,
    sellingPrice NUMERIC(12, 2) NOT NULL,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalProjectedIncome()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProjectedIncome
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalProjectedIncome
    BEFORE INSERT ON ProjectProposalProjectedIncome
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalProjectedIncome();


DROP TABLE IF EXISTS ExpenseType CASCADE;
CREATE TABLE ExpenseType (
    id SMALLINT,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO ExpenseType (id, name)
                 VALUES (0, 'Others'),
                        (1, 'Food Expense'),
                        (2, 'Accomodation Expense'),
                        (3, 'Venue Expense'),
                        (4, 'Transport Expense'),
                        (5, 'Honorarium'),
                        (6, 'Cash Prize');

DROP TABLE IF EXISTS "ExpenseTypeAttachmentRequirement" CASCADE;
CREATE TABLE "ExpenseTypeAttachmentRequirement" (
    "expenseType" SMALLINT REFERENCES ExpenseType(id),
    "document" SMALLINT REFERENCES DocumentAttachmentRequirement(id),

    PRIMARY KEY("expenseType", "document")
);
INSERT INTO "ExpenseTypeAttachmentRequirement" ("expenseType", "document")
                                             -- Others
                                        VALUES (0, 9),
                                             -- Food Expense
                                               (1,  9),
                                               (1, 10),
                                             -- Accomodation Expense
                                               (2,  9),
                                               (2, 10),
                                             -- Cash Prize
                                               (6,  11);

DROP TABLE IF EXISTS ProjectProposalExpenses CASCADE;
CREATE TABLE ProjectProposalExpenses (
    "id" SERIAL NOT NULL UNIQUE,
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    material VARCHAR(45) NOT NULL,
    quantity INTEGER NOT NULL,
    unitCost NUMERIC(12, 2) NOT NULL,
    type SMALLINT NOT NULL REFERENCES ExpenseType(id) DEFAULT 0,

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalExpenses()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalExpenses
         WHERE projectProposal = NEW.projectProposal;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalExpenses
    BEFORE INSERT ON ProjectProposalExpenses
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalExpenses();


DROP TABLE IF EXISTS ProjectProposalSourceFunds CASCADE;
CREATE TABLE ProjectProposalSourceFunds (
    projectProposal INTEGER REFERENCES ProjectProposal(id),
    sequence INTEGER,
    name VARCHAR (45),
    amount NUMERIC(12, 2),

    PRIMARY KEY (projectProposal, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalSourceFunds()
RETURNS trigger AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalSourceFunds
    BEFORE INSERT ON ProjectProposalSourceFunds
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalSourceFunds();

DROP TABLE IF EXISTS ProjectProposalAttachment CASCADE;
CREATE TABLE ProjectProposalAttachment (
    id SERIAL UNIQUE,
    projectProposal INTEGER NOT NULL REFERENCES ProjectProposal(id),
    requirement SMALLINT NOT NULL REFERENCES DocumentAttachmentRequirement(id),
    sequence INTEGER NOT NULL DEFAULT -1,
    idNumber INTEGER REFERENCES Account(idNumber),
    filename TEXT,
    filenametoShow TEXT,
    directory TEXT NOT NULL,

    PRIMARY KEY (projectProposal, requirement, sequence)
);
CREATE OR REPLACE FUNCTION trigger_before_insert_ProjectProposalAttachment()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalAttachment
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER before_insert_ProjectProposalAttachment
    BEFORE INSERT ON ProjectProposalAttachment
    FOR EACH ROW
    EXECUTE PROCEDURE trigger_before_insert_ProjectProposalAttachment();

  /* Project Proposal Signatories */
DROP TABLE IF EXISTS SignatoryStatus CASCADE;
CREATE TABLE SignatoryStatus (
  id SMALLINT,
  name VARCHAR(45) NOT NULL,

  PRIMARY KEY(id)
);
INSERT INTO SignatoryStatus (id, name)
                     VALUES ( 0, 'Unsigned'),
                            ( 1, 'Approved'),
                            ( 2, 'Pend'),
                            ( 3, 'Denied'),
                            ( 4, 'Force Signed');
DROP TABLE IF EXISTS SignatoryType CASCADE;
CREATE TABLE SignatoryType (
	"id" SMALLINT,
	"name" VARCHAR(45) NOT NULL,
    "lineup" SMALLINT NOT NULL,

	PRIMARY KEY (id)
);
INSERT INTO SignatoryType ("id", "name", "lineup")
                   VALUES ( 0, 'Project Head', 0),
                          ( 1, 'Treasurer/Finance Officer', 10), -- VP
                          ( 2, 'Immediate Superior', 20), -- 1 step higher
                          ( 3, 'President', 30),
                          ( 4, 'Faculty Adviser', 40), --
                          ( 5, 'Documentation Officer', 50), -- VP
                          ( 6, 'APS - AVC', 60), -- Pwedeng Madami
                          ( 7, 'APS -  VC', 70); --

DROP TABLE IF EXISTS ProjectProposalSignatory CASCADE;
CREATE TABLE ProjectProposalSignatory (
  id SERIAL UNIQUE,
  GOSMActivity INTEGER REFERENCES ProjectProposal(GOSMActivity),
  signatory INTEGER REFERENCES Account(idNumber),
  type SMALLINT NOT NULL REFERENCES SignatoryType(id),
  status SMALLINT NOT NULL REFERENCES SignatoryStatus(id) DEFAULT 0,
  comments TEXT,
  sectionsToEdit VARCHAR(60)[],
  document JSONB,
  digitalSignature TEXT,
  dateSigned TIMESTAMP WITH TIME ZONE,

  CONSTRAINT "pk_ProjectProposalSignatory" PRIMARY KEY(GOSMActivity, signatory, type)
);
CREATE OR REPLACE FUNCTION "trigger_after_update_ProjectProposalSignatory_completion"()
RETURNS TRIGGER AS
$trigger$
    DECLARE
        numSignNeeded INTEGER;
        nature SMALLINT;
        type SMALLINT;
    BEGIN
	IF NEW.status = 1 OR NEW.status = 4 THEN
	    SELECT COUNT(pps.id) INTO numSignNeeded
              FROM ProjectProposalSignatory pps
             WHERE pps.GOSMActivity = NEW.GOSMActivity
               AND status <> 1
               AND status <> 4;

             IF numSignNeeded = 0 THEN
                SELECT ga.activityNature, ga.activityType INTO "nature", "type"
                  FROM GOSMActivity ga
                 WHERE ga.id = NEW.GOSMActivity;

                 IF nature = 1 OR type = 2 THEN
                     INSERT INTO AMTActivityEvaluation (activity, status)
                                                VALUES (NEW.GOSMActivity, 0);
                 END IF;

                UPDATE ProjectProposal
                   SET status = 3
                 WHERE GOSMActivity = NEW.GOSMActivity;
            END IF;
	ELSIF NEW.status = 2 THEN
	    UPDATE ProjectProposal
                SET status = 4
              WHERE GOSMActivity = NEW.GOSMActivity;
        ELSIF NEW.status = 3 THEN
            UPDATE ProjectProposal
               SET status = 5
             WHERE GOSMActivity = NEW.GOSMActivity;
	END IF;


        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER after_update_ProjectProposalSignatory_completion
    AFTER UPDATE ON ProjectProposalSignatory
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE "trigger_after_update_ProjectProposalSignatory_completion"();

    /* Load balancing of Proposals */
CREATE OR REPLACE FUNCTION "trigger_after_insert_ProjectProposal_signatories"()
RETURNS trigger AS
$trigger$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "GOSMActivity_get_organization"(NEW.GOSMActivity);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            SELECT NEW.GOSMActivity, idNumber, 0
              FROM GOSMActivityProjectHead
             WHERE activityID = NEW.GOSMActivity;

         INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
              VALUES (NEW.GOSMActivity, "PPR_get_organization_next_treasurer_signatory"(organization),1);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, "PPR_get_organization_next_immediate_supervisor_signatory"(NEW.preparedBy, organization), 2);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, organization_get_president(organization), 3);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, organization_get_documentation_signatories(organization), 5);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            VALUES (NEW.GOSMActivity, "PPR_get_cso_next_first_phase_signatory"(), 6);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            VALUES (NEW.GOSMActivity, "PPR_get_cso_next_second_phase_signatory"(), 7);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_insert_ProjectProposal_signatories"
    AFTER INSERT ON ProjectProposal
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_ProjectProposal_signatories"();

CREATE OR REPLACE FUNCTION "trigger_after_update_ProjectProposal_signatory_facultyAdviser"()
RETURNS trigger AS
$trigger$
    BEGIN
      IF NEW.facultyAdviser IS NULL THEN
        DELETE FROM ProjectProposalSignatory pps
        WHERE pps.GOSMActivity = NEW.GOSMActivity
          AND pps.signatory = OLD.facultyAdviser
          AND pps.type = 4;
      ELSE
          INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
                                        VALUES (NEW.GOSMActivity, NEW.facultyAdviser, 4)
          ON CONFLICT ON CONSTRAINT "pk_ProjectProposalSignatory"
          DO UPDATE SET signatory = NEW.facultyAdviser;
      END IF;

      RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser"
    AFTER UPDATE ON ProjectProposal
    FOR EACH ROW WHEN ((OLD.facultyAdviser IS NULL AND NEW.facultyAdviser IS NOT NULL) OR (OLD.facultyAdviser IS NOT NULL AND NEW.facultyAdviser IS NULL) OR(OLD.facultyAdviser <> NEW.facultyAdviser))
    EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_facultyAdviser"();

CREATE OR REPLACE FUNCTION "trigger_after_update_ProjectProposal_signatory_immediateSuperior"()
RETURNS trigger AS
$trigger$
    BEGIN
      UPDATE ProjectProposalSignatory
         SET signatory = "PPR_get_organization_next_immediate_supervisor_signatory"(NEW.preparedBy, "GOSMActivity_get_organization"(NEW.GOSMActivity))
       WHERE GOSMActivity = NEW.GOSMActivity
         AND type = 2;
      RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior"
    AFTER UPDATE ON ProjectProposal
    FOR EACH ROW WHEN ((OLD.preparedBy IS NULL) OR (OLD.preparedBy <> NEW.preparedBy))
    EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_immediateSuperior"();

    /* End Load balancing of Proposals */
  /* End of Project Proposal Signatories */
/* End of Project Proposal */

/* Organization Treasurer */
DROP TABLE IF EXISTS "PreActivityDirectPaymentStatus" CASCADE;
CREATE TABLE "PreActivityDirectPaymentStatus" (
  "id" INTEGER,
  "name" VARCHAR(45),

  PRIMARY KEY(id)
);
INSERT INTO "PreActivityDirectPaymentStatus" ("id", "name")
                                      VALUES (0, 'For Approval'),
                                             (1, 'Approved'),
                                             (2, 'Pend'),
                                             (3, 'Denied');
DROP TABLE IF EXISTS "PreActivityDirectPayment" CASCADE;
CREATE TABLE "PreActivityDirectPayment" (
    "id" SERIAL UNIQUE,
    "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
    "submissionID" INTEGER,
    "sequence" INTEGER DEFAULT -1,
    "submittedBy" INTEGER REFERENCES Account(idNumber),
    "dateSubmitted" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "nameOfEstablishment" VARCHAR(60),
    "amount" NUMERIC(12, 2),
    "reasonForDelayedPRSProcessing" TEXT,
    "galsFilename" TEXT,
    "galsfilenameToShow" TEXT,
    "fqFilename" TEXT,
    "fqfilenameToShow" TEXT,
    "rofFilename" TEXT,
    "rofFilenameToShow" TEXT,
    "evaluatedBy" INTEGER REFERENCES Account(idNumber),
    "comments" TEXT,
    "dateEvaluated" TIMESTAMP WITH TIME ZONE,
    "status" SMALLINT REFERENCES "PreActivityDirectPaymentStatus"("id"),

    PRIMARY KEY ("GOSMActivity", "submissionID", "sequence")
);
CREATE OR REPLACE FUNCTION "trigger_before_insert_PreActivityDirectPayment_sequence"()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW.sequence = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PreActivityDirectPayment"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX("sequence") + 1, 1) INTO NEW."sequence"
              FROM "PreActivityDirectPayment"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "before_insert_PreActivityDirectPayment_sequence"
    BEFORE INSERT ON "PreActivityDirectPayment"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_PreActivityDirectPayment_sequence"();

DROP TABLE IF EXISTS "PreActivityDirectPaymentParticular" CASCADE;
CREATE TABLE "PreActivityDirectPaymentParticular" (
    "id" SERIAL UNIQUE,
    "directPayment" INTEGER REFERENCES "PreActivityDirectPaymentParticular"("id"),
    "particular" INTEGER REFERENCES ProjectProposalExpenses(id),

    PRIMARY KEY ("directPayment", "particular")
);

DROP TABLE IF EXISTS "PreActivityCashAdvanceStatus" CASCADE;
CREATE TABLE "PreActivityCashAdvanceStatus" (
  "id" INTEGER,
  "name" VARCHAR(45),

  PRIMARY KEY(id)
);
INSERT INTO "PreActivityCashAdvanceStatus" ("id", "name")
                                    VALUES (0, 'For Approval'),
                                           (1, 'Approved'),
                                           (2, 'Pend'),
                                           (3, 'Denied');

DROP TABLE IF EXISTS "PreActivityCashAdvance" CASCADE;
CREATE TABLE "PreActivityCashAdvance" (
    "id" SERIAL NOT NULL UNIQUE,
    "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
    "submissionID" INTEGER,
    "sequence" INTEGER DEFAULT -1,
    "submittedBy" INTEGER REFERENCES Account(idNumber),
    "dateSubmitted" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "purpose" TEXT,
    "justification" TEXT,
    "evaluatedBy" INTEGER REFERENCES Account(idNumber),
    "status" SMALLINT REFERENCES "PreActivityCashAdvanceStatus"("id"),
    "filename" TEXT,
    "filenameToShow" TEXT,

    PRIMARY KEY ("GOSMActivity", "submissionID", "sequence")
);
/*
CREATE OR REPLACE FUNCTION "trigger_before_insert_PreActivityCashAdvance_sequence"()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW.sequence = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PreActivityCashAdvance"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
        SELECT COALESCE(MAX("sequence") + 1, 1) INTO NEW."sequence"
          FROM "PreActivityCashAdvance"
         WHERE "GOSMActivity" = NEW."GOSMActivity"
           AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
*/
CREATE TRIGGER "before_insert_PreActivityCashAdvance_sequence"
    BEFORE INSERT ON "PreActivityCashAdvance"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_sequence_versioning"('PreActivityCashAdvance', 'paca', '"paca"."GOSMActivity" = $1."GOSMActivity"');

DROP TABLE IF EXISTS "PreActivityCashAdvanceParticular" CASCADE;
CREATE TABLE "PreActivityCashAdvanceParticular" (
    "id" SERIAL UNIQUE,
    "cashAdvance" INTEGER REFERENCES "PreActivityCashAdvance"("id"),
    "particular" INTEGER REFERENCES ProjectProposalExpenses(id),

    PRIMARY KEY ("cashAdvance", "particular")
);

DROP TABLE IF EXISTS "FinanceSignatoryType" CASCADE;
CREATE TABLE "FinanceSignatoryType" (
    "id" INTEGER,
    "name" VARCHAR(45) NOT NULL,
    "lineup" SMALLINT NOT NULL,

    PRIMARY KEY ("id")
);
INSERT INTO "FinanceSignatoryType" ("id", "name", "lineup")
                            VALUES (0, 'Organization Finance/Treasurer', 0),
                                   (1, 'Organization President', 10),
                                   (2, 'Director of S-Life', 20),
                                   (3, 'Dean of Student Affairs', 30),
                                   (4, 'Vice President for Lasallian Mission', 40),
                                   (5, 'President', 50);

DROP TABLE IF EXISTS "PreActivityDirectPaymentSignatory" CASCADE;
CREATE TABLE "PreActivityDirectPaymentSignatory" (
    "id" SERIAL UNIQUE,
    "directPayment" INTEGER REFERENCES "PreActivityDirectPayment"("id"),
    "signatory" INTEGER REFERENCES Account(idNumber),
    "type" SMALLINT NOT NULL REFERENCES "FinanceSignatoryType"("id"),
    "status" SMALLINT NOT NULL REFERENCES SignatoryStatus(id) NOT NULL DEFAULT 0,
    "comments" TEXT,
    "sectionsToEdit" VARCHAR(60)[],
    "document" JSONB,
    "digitalSignature" TEXT,
    "dateSigned" TIMESTAMP WITH TIME ZONE,

    CONSTRAINT "pk_PreActivityDirectPaymentSignatory" PRIMARY KEY("directPayment", "signatory", "type")
);
CREATE OR REPLACE FUNCTION "trigger_after_insert_PreActivityDirectPayment_signatories"()
RETURNS TRIGGER AS
$trigger$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_DirectPayment_get_organization"(NEW."id");
        organizationPresident = organization_get_president(organization);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", "PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organization), 0);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", organizationPresident, 1);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_insert_PreActivityDirectPayment_signatories"
    AFTER INSERT ON "PreActivityDirectPayment"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_PreActivityDirectPayment_signatories"();

CREATE TRIGGER "after_insert_PreActivityDirectPaymentParticular_signatories"
    AFTER INSERT ON "PreActivityDirectPaymentParticular"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_finance_signatories"('PreActivityDirectPaymentParticular', 'pacap', 'pacap."directPayment" = $1."directPayment"', 'PreActivityDirectPaymentSignatory', 'directPayment', '$1."directPayment"');

DROP TABLE IF EXISTS "PreActivityCashAdvanceSignatory" CASCADE;
CREATE TABLE "PreActivityCashAdvanceSignatory" (
    "id" SERIAL UNIQUE,
    "cashAdvance" INTEGER REFERENCES "PreActivityCashAdvance"("id"),
    "signatory" INTEGER REFERENCES Account(idNumber),
    "type" SMALLINT NOT NULL REFERENCES "FinanceSignatoryType"("id"),
    "status" SMALLINT NOT NULL REFERENCES SignatoryStatus(id) DEFAULT 0,
    "comments" TEXT,
    "sectionsToEdit" VARCHAR(60)[],
    "document" JSONB,
    "digitalSignature" TEXT,
    "dateSigned" TIMESTAMP WITH TIME ZONE,

    CONSTRAINT "pk_PreActivityCashAdvanceSignatory" PRIMARY KEY("cashAdvance", "signatory", "type")
);
CREATE OR REPLACE FUNCTION "trigger_after_insert_PreActivityCashAdvance_signatories"()
RETURNS TRIGGER AS
$trigger$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_CashAdvance_get_organization"(NEW."id");
        organizationPresident = organization_get_president(organization);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", "PreActCashAdvance_get_organization_next_treasurer_signatory"(organization), 0);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", organizationPresident, 1);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "after_insert_PreActivityCashAdvance_signatories"
    AFTER INSERT ON "PreActivityCashAdvance"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_PreActivityCashAdvance_signatories"();

CREATE TRIGGER "after_insert_PreActivityCashAdvanceParticular_signatories"
    AFTER INSERT ON "PreActivityCashAdvanceParticular"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_finance_signatories"('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'cashAdvance', '$1."cashAdvance"');

CREATE TRIGGER "after_delete_PreActivityCashAdvanceParticular_signatories"
    AFTER DELETE ON "PreActivityCashAdvanceParticular"
    FOR EACH ROW
    EXECUTE PROCEDURE  "trigger_after_delete_finance_signatories"('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'pacas', 'pacas."cashAdvance" = $1."cashAdvance"');

CREATE TRIGGER "after_update_PreActivityCashAdvanceSignatory_completion"
    AFTER UPDATE ON "PreActivityCashAdvanceSignatory"
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE "trigger_after_update_signatory_completion"('PreActivityCashAdvanceSignatory', 'precas', 'precas."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvance', 'preca', 'preca.id = $1."cashAdvance"');

/* Book Transfer */
DROP TABLE IF EXISTS "PreActivityBookTransferStatus" CASCADE;
CREATE TABLE "PreActivityBookTransferStatus" (
    "id" INTEGER,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "PreActivityBookTransferStatus" ("id", "name")
                                     VALUES (0, 'For Approval'),
                                            (1, 'Approved'),
                                            (2, 'Pend'),
                                            (3, 'Denied');

DROP TABLE IF EXISTS "BookTransferEstablishment" CASCADE;
CREATE TABLE "BookTransferEstablishment" (
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,
    "transferAccount" CHAR(6),

    PRIMARY KEY("id")
);
INSERT INTO "BookTransferEstablishment" ("id", "name")
                                 VALUES (   0, 'Physical Facilities Development Fund'),
                                        (   1, E'Perico\'s Grill'),
                                        (   2, 'La Casita De Roja Restaurant'),
                                        (   3, 'CopyCare Phils.'),
                                        (   4, 'MRU'),
                                        (   5, 'Scoop'),
                                        (   6, 'Animo Bookstore'),
                                        (   7, 'The Store'),
                                        (   8, 'Salikneta');

DROP TABLE IF EXISTS "PreActivityBookTransfer" CASCADE;
CREATE TABLE "PreActivityBookTransfer"(
    "id" SERIAL UNIQUE,
    "GOSMActivity" INTEGER REFERENCES GOSMActivity("id"),
    "submissionID" INTEGER DEFAULT -1,
    "sequence" INTEGER DEFAULT -1,
    "submittedBy" INTEGER REFERENCES Account(idNumber) NOT NULL,
    "dateSubmitted" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" SMALLINT REFERENCES "PreActivityBookTransferStatus"("id") NOT NULL DEFAULT 0,
    "establishment" SMALLINT REFERENCES "BookTransferEstablishment" NOT NULL,

    PRIMARY KEY ("GOSMActivity", "submissionID", "sequence")
);

DROP TABLE IF EXISTS "PreActivityBookTransferParticular" CASCADE;
CREATE TABLE "PreActivityBookTransferParticular" (
    "id" SERIAL UNIQUE,
    "bookTransfer" INTEGER REFERENCES "PreActivityBookTransfer"("id"),
    "particular" INTEGER REFERENCES ProjectProposalExpenses(id),

    PRIMARY KEY ("bookTransfer", "particular")
);

DROP TABLE IF EXISTS "PreActivityBookTransferSignatory" CASCADE;
CREATE TABLE "PreActivityBookTransferSignatory" (
    "id" SERIAL UNIQUE,
    "bookTransfer" INTEGER REFERENCES "PreActivityBookTransfer"("id"),
    "signatory" INTEGER REFERENCES Account(idNumber),
    "type" SMALLINT NOT NULL REFERENCES "FinanceSignatoryType"("id"),
    "status" SMALLINT NOT NULL REFERENCES SignatoryStatus(id) NOT NULL DEFAULT 0,
    "comments" TEXT,
    "sectionsToEdit" VARCHAR(60)[],
    "document" JSONB,
    "digitalSignature" TEXT,
    "dateSigned" TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY ("bookTransfer", "signatory", "type")
);

CREATE TRIGGER "before_insert_PreActivityBookTransfer"
    BEFORE INSERT ON "PreActivityBookTransfer"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_sequence_versioning"('PreActivityBookTransfer', 'pabt', '"pabt"."GOSMActivity" = $1."GOSMActivity"');

CREATE TRIGGER "after_insert_PreActivityBookTransfer_signatories"
    AFTER INSERT ON "PreActivityBookTransfer"
    FOR EACH ROW
    EXECUTE PROCEDURE  "trigger_after_insert_finance_signatories_initial"('PreActivityBookTransfer', 'pabt', 'PreActivityBookTransferSignatory', 'bookTransfer', 'PreAct_BookTransfer_get_organization_next_treasurer_signatory');

CREATE TRIGGER "after_insert_PreActivityBookTransferParticular_signatories"
    AFTER INSERT ON "PreActivityBookTransferParticular"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_finance_signatories"('PreActivityBookTransferParticular', 'pabtp', 'pabtp."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransferSignatory', 'bookTransfer', '$1."bookTransfer"');

CREATE TRIGGER "after_update_PreActivityBookTransferSignatory_completion"
    AFTER UPDATE ON "PreActivityBookTransferSignatory"
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE "trigger_after_update_signatory_completion"('PreActivityBookTransferSignatory', 'pabts', 'pabts."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransfer', 'pabt', 'pabt.id = $1."bookTransfer"');

/* Book Transfer END */
/* Organization Treasurer */
    /* AMTActivityEvaluation */
DROP TABLE IF EXISTS AMTActivityEvaluationStatus CASCADE;
CREATE TABLE AMTActivityEvaluationStatus (
    id INTEGER,
    name VARCHAR(45) NOT NULL,

    PRIMARY KEY(id)
);
INSERT INTO AMTActivityEvaluationStatus (id, name)
                           VALUES ( 0, 'Unassigned Evaluation'),
                                  ( 1, 'Pending Evaluation'),
                                  ( 3, 'Evaluated');

DROP TABLE IF EXISTS AMTActivityEvaluation CASCADE;
CREATE TABLE AMTActivityEvaluation (
    activity INTEGER REFERENCES ProjectProposal (GOSMActivity),
    venue SMALLINT,
    equipment SMALLINT,
    materials SMALLINT,
    registration SMALLINT,
    timeEnd SMALLINT,
    activityExecution SMALLINT,
    hosts SMALLINT,
    facilitators SMALLINT,
    presentation SMALLINT,
    activities SMALLINT,
    organizationStandingPresentation SMALLINT,
    timeStart SMALLINT,
    actualStartTime TIME WITH TIME ZONE,
    actualEndTime TIME WITH TIME ZONE,
    ANP INTEGER,
    person1EA SMALLINT,
    person1LOA SMALLINT,
    person1IITSKOA SMALLINT,
    person1IOMWM SMALLINT,
    person2EA SMALLINT,
    person2LOA SMALLINT,
    person2IITSKOA SMALLINT,
    person2IOMWM SMALLINT,
    comments1 TEXT,
    comments2 TEXT,
    comments3 TEXT,
    suggestions1 TEXT,
    suggestions2 TEXT,
    suggestions3 TEXT,
    evaluator INTEGER REFERENCES Account(idNumber),
    status INTEGER REFERENCES AMTActivityEvaluationStatus(id),
    dateReserved TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    dateEvaluated TIMESTAMP WITH TIME ZONE,

    PRIMARY KEY (activity)
);
-- END FORMS
-- COMMIT;
  /* OrgRes */
DROP TABLE IF EXISTS "ARFOrganizationPosition" CASCADE;
CREATE TABLE "ARFOrganizationPosition" (
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "ARFOrganizationPosition" ("id", "name")
                               VALUES (   0, 'Officer'),
                                      (   1, 'Member'),
                                      (   2, 'Non-member');

DROP TABLE IF EXISTS "ActivityResearchForm" CASCADE;
CREATE TABLE "ActivityResearchForm" (
  "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
  "sequence" INTEGER,
  "positionInOrganization" SMALLINT REFERENCES "ARFOrganizationPosition"("id"),
  "IUTPOTA" SMALLINT,
  "TASMI" SMALLINT,
  "IFIDTA" SMALLINT,
  "TAWWP" SMALLINT,
  "TOUMTGTTA" SMALLINT,
  "WWWITA" TEXT,
  "FAC" TEXT,
  "EFFA" TEXT,
  "dateSubmitted" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY("GOSMActivity", "sequence")
);
CREATE TRIGGER "before_insert_ActivityResearchForm_sequence"
    BEFORE INSERT ON "ActivityResearchForm"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_increment_sequence"('ActivityResearchForm', 'arf', 'arf."GOSMActivity" = $1."GOSMActivity"');

/* ADM */
  /* Post Acts */
DROP TABLE IF EXISTS "PostProjectProposalStatus" CASCADE;
CREATE TABLE "PostProjectProposalStatus" (
  id SMALLINT,
  name VARCHAR(45) NOT NULL,

  PRIMARY KEY(id)
);
INSERT INTO "PostProjectProposalStatus" (id, name)
                                 VALUES ( 0, 'Unopened'),
                                        ( 1, 'Opened'),
                                        ( 2, 'In-progress'),
                                        ( 3, 'For Approval'),
                                        ( 4, 'Approved'),
                                        ( 5, 'Pend');

DROP TABLE IF EXISTS "PostProjectProposal" CASCADE;
CREATE TABLE "PostProjectProposal" (
  "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
  "preparedBy" INTEGER REFERENCES Account(idNumber),
  "status" SMALLINT NOT NULL DEFAULT 0 REFERENCES "PostProjectProposalStatus"("id"),
  "dateCreated" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "ANP" INTEGER,
  "ANMP" INTEGER,
  "objectives" TEXT[],
  "WATTTWITA" TEXT,
  "WWYGLIETA" TEXT,
  "HDTATYLCTTDOTP" TEXT,
  "WATTWWAWCYDTPTFHA" TEXT,
  "galsfilename" TEXT,
  "galsfilenameToShow" TEXT,
  "isBriefContextCompleted" BOOLEAN NOT NULL DEFAULT FALSE,
  "isOtherFinanceDocumentsCompleted" BOOLEAN NOT NULL DEFAULT FALSE,
  "isFinanceDocumentCompleted" BOOLEAN NOT NULL DEFAULT FALSE,
  "isCheckedDP" BOOLEAN NOT NULL DEFAULT FALSE,
  "isCheckedR" BOOLEAN NOT NULL DEFAULT FALSE,
  "isCheckedBT" BOOLEAN NOT NULL DEFAULT FALSE,
  "comments" TEXT,
  "sectionsToBeEdited" VARCHAR(60)[],
  "document" JSONB,
  "checkedByStage1" INTEGER,
  "signatureStage1" TEXT,
  "checkedByStage2" INTEGER,
  "signatureStage2" TEXT,

  PRIMARY KEY("GOSMActivity")
);

DROP TABLE IF EXISTS "PostProjectProposalExpense" CASCADE;
CREATE TABLE "PostProjectProposalExpense" (
  "id" SERIAL UNIQUE,
  "GOSMActivity" INTEGER REFERENCES "PostProjectProposal"("GOSMActivity"),
  "submissionID" INTEGER,
  "sequence" INTEGER NOT NULL DEFAULT -1,
  "particular" VARCHAR(45),
  "establishment" VARCHAR(45),
  "price" NUMERIC(12, 2),
  "filename" TEXT,
  "filenameToShow" TEXT,
  "idNumber" INTEGER REFERENCES Account(idNumber),

  PRIMARY KEY("GOSMActivity", "submissionID", "sequence")
);
CREATE OR REPLACE FUNCTION "trigger_before_insert_PostProjectProposalExpense_sequence"()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectProposalExpense"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectProposalExpense"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "before_insert_PostProjectProposalExpense_sequence"
    BEFORE INSERT ON "PostProjectProposalExpense"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalExpense_sequence"();

DROP TABLE IF EXISTS "PostProjectProposalEventPicture" CASCADE;
CREATE TABLE "PostProjectProposalEventPicture" (
  "id" SERIAL UNIQUE,
  "GOSMActivity" INTEGER REFERENCES "PostProjectProposal"("GOSMActivity"),
  "submissionID" INTEGER,
  "sequence" INTEGER NOT NULL DEFAULT -1,
  "filename" TEXT,
  "filenameToShow" TEXT,
  "description" TEXT,
  "idNumber" INTEGER REFERENCES Account(idNumber),

  PRIMARY KEY("GOSMActivity","submissionID", "sequence")
);
CREATE OR REPLACE FUNCTION "trigger_before_insert_PostProjectProposalEventPicture_sequence"()
RETURNS TRIGGER AS
$trigger$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectProposalEventPicture"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectProposalEventPicture"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "before_insert_PostProjectProposalEventPicture_sequence"
    BEFORE INSERT ON "PostProjectProposalEventPicture"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalEventPicture_sequence"();

DROP TABLE IF EXISTS "PostProjectDirectPaymentPayment" CASCADE;
CREATE TABLE "PostProjectDirectPaymentPayment" (
  id SMALLINT,
  name VARCHAR(45),

  PRIMARY KEY (id)
);
INSERT INTO "PostProjectDirectPaymentPayment" (id, name)
                                 VALUES ( 0, 'Cheque'),
                                        ( 1, 'Book Transfer');

DROP TABLE IF EXISTS "PostProjectDirectPaymentStatus" CASCADE;
CREATE TABLE "PostProjectDirectPaymentStatus" (
   "id" SMALLINT,
   "name" VARCHAR(45),

   PRIMARY KEY ("id")
);
INSERT INTO "PostProjectDirectPaymentStatus" ("id", "name")
                                      VALUES (  0,  'For approval'),
                                             (  1, 'Approved'),
                                             (  2, 'Pend');
DROP TABLE IF EXISTS "PostProjectDirectPayment" CASCADE;
CREATE TABLE "PostProjectDirectPayment" (
  "id" SERIAL NOT NULL UNIQUE,
  "GOSMActivity" INTEGER REFERENCES "PostProjectProposal"("GOSMActivity"),
  "submissionID" INTEGER,
  "sequence" INTEGER DEFAULT -1,
  "nameOfEstablishment" VARCHAR(60),
  "amount" NUMERIC(12, 2),
  "paymentBy" SMALLINT REFERENCES "PostProjectDirectPaymentPayment"("id"),
  "delayedProcessing" TEXT,
  "fqfilename" TEXT,
  "roffilename" TEXT,
  "fqfilenameToShow" TEXT,
  "roffilenameToShow" TEXT,
  "idNumber" INTEGER REFERENCES Account(idNumber),
  "dateCreated" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" SMALLINT REFERENCES "PostProjectDirectPaymentStatus"("id") DEFAULT 0,

  PRIMARY KEY("GOSMActivity", "submissionID", "sequence")
);
CREATE OR REPLACE FUNCTION "trigger_before_insert_PostProjectDirectPayment_sequence"()
RETURNS TRIGGER AS
$trigger$
    BEGIN
         IF NEW."submissionID" IS NULL THEN
             NEW."sequence" = 1;
             SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
               FROM "PostProjectDirectPayment"
              WHERE "GOSMActivity" = NEW."GOSMActivity";
         ELSE
             SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
               FROM "PostProjectDirectPayment"
              WHERE "GOSMActivity" = NEW."GOSMActivity"
                AND "submissionID" = NEW."submissionID";
         END IF;
        RETURN NEW;
    END;
$trigger$ LANGUAGE plpgsql;
CREATE TRIGGER "before_insert_PostProjectDirectPayment_sequence"
    BEFORE INSERT ON "PostProjectDirectPayment"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_PostProjectDirectPayment_sequence"();

DROP TABLE IF EXISTS "PostProjectDirectPaymentParticular" CASCADE;
CREATE TABLE "PostProjectDirectPaymentParticular" (
  "directPayment" INTEGER REFERENCES "PostProjectDirectPayment"("id"),
  "particular" INTEGER REFERENCES ProjectProposalExpenses("id"),

  PRIMARY KEY ("directPayment", "particular")
);

DROP TABLE IF EXISTS "PostProjectReimbursementPayment" CASCADE;
CREATE TABLE "PostProjectReimbursementPayment" (
  "id" INTEGER,
  "name" VARCHAR(45),

  PRIMARY KEY ("id")
);
INSERT INTO "PostProjectReimbursementPayment" (id, name)
                                 VALUES ( 0, 'Payment By Check'),
                                        ( 1, 'Payment By Book Transfer');

DROP TABLE IF EXISTS "PostProjectReimbursementStatus" CASCADE;
CREATE TABLE "PostProjectReimbursementStatus" (
   "id" SMALLINT,
   "name" VARCHAR(45),

   PRIMARY KEY ("id")
);
INSERT INTO "PostProjectReimbursementStatus" ("id", "name")
                                     VALUES  (  0, 'For approval'),
                                             (  1, 'Approved'),
                                             (  2, 'Pend'),
                                             (  3, 'Denied');

DROP TABLE IF EXISTS "PostProjectReimbursement" CASCADE;
CREATE TABLE "PostProjectReimbursement" (
  "id" SERIAL NOT NULL UNIQUE,
  /* Primary Keys */
  "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
  "submissionID" INTEGER DEFAULT -1,
  "sequence" INTEGER DEFAULT -1,

  "justificationFDPP" TEXT,
  "justificationFNUCADP" TEXT,
  "filenames" TEXT[],
  "filenamesToShow" TEXT[],
  "submittedBy" INTEGER REFERENCES Account(idNumber),
  "dateCreated" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" SMALLINT REFERENCES "PostProjectReimbursementStatus"("id") NOT NULL DEFAULT 0,

  PRIMARY KEY("GOSMActivity", "submissionID", "sequence")
);

DROP TABLE IF EXISTS "PostProjectReimbursementParticular" CASCADE;
CREATE TABLE "PostProjectReimbursementParticular" (
    "id" SERIAL NOT NULL UNIQUE,
    "reimbursement" INTEGER REFERENCES "PostProjectReimbursement"("id"),
    "particular" INTEGER REFERENCES ProjectProposalExpenses("id"),

  PRIMARY KEY ("reimbursement", "particular")
);

CREATE TRIGGER "before_insert_PostProjectReimbursement_sequence"
    BEFORE INSERT ON "PostProjectReimbursement"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_sequence_versioning"('PostProjectReimbursement', 'pprojr', '"pprojr"."GOSMActivity" = $1."GOSMActivity"');

DROP TABLE IF EXISTS "PostProjectReimbursementSignatory" CASCADE;
CREATE TABLE "PostProjectReimbursementSignatory" (
    "id" SERIAL UNIQUE NOT NULL,
    "reimbursement" INTEGER REFERENCES "PostProjectReimbursement"("id"),
    "signatory" INTEGER REFERENCES Account(idNumber),
    "type" SMALLINT REFERENCES "FinanceSignatoryType"("id"),
    "status" SMALLINT  REFERENCES SignatoryStatus("id") NOT NULL DEFAULT 0,
    comments TEXT,
    sectionsToEdit VARCHAR(60)[],
    document JSONB,
    digitalSignature TEXT,
    dateSigned TIMESTAMP WITH TIME ZONE
);

CREATE TRIGGER "after_insert_PostProjectReimbursement_signatories"
    AFTER INSERT ON "PostProjectReimbursement"
    FOR EACH ROW
    EXECUTE PROCEDURE  "trigger_after_insert_finance_signatories_initial"('PostProjectReimbursement', 'ppr', 'PostProjectReimbursementSignatory', 'reimbursement', 'PostAct_Reimbursement_get_organization_next_treasurer_signatory');

CREATE TRIGGER "after_insert_PreActivityReimbursementParticular_signatories"
    AFTER INSERT ON "PostProjectReimbursementParticular"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_after_insert_finance_signatories"('PostProjectReimbursementParticular', 'pprp', 'pprp."reimbursement" = $1."reimbursement"', 'PostProjectReimbursementSignatory', 'reimbursement', '$1."reimbursement"');

CREATE TRIGGER "after_update_PreActivityReimbursementSignatory_completion"
    AFTER UPDATE ON "PostProjectReimbursementSignatory"
    FOR EACH ROW WHEN (OLD.status <> NEW.status)
    EXECUTE PROCEDURE "trigger_after_update_signatory_completion"('PostProjectReimbursementSignatory', 'pprs', 'pprs."reimbursement" = $1."reimbursement"', 'PostProjectReimbursement', 'ppr', 'ppr.id = $1."reimbursement"');

DROP TABLE IF EXISTS "PostProjectBookTransferStatus" CASCADE;
CREATE TABLE "PostProjectBookTransferStatus" (
   "id" SMALLINT,
   "name" VARCHAR(45),

   PRIMARY KEY ("id")
);
INSERT INTO "PostProjectBookTransferStatus" ("id", "name")
                                     VALUES (  0, 'For approval'),
                                            (  1, 'Approved'),
                                            (  2, 'Pend'),
                                            (  3, 'Denied');

DROP TABLE IF EXISTS "PostProjectBookTransfer" CASCADE;
CREATE TABLE "PostProjectBookTransfer" (
  "id" SERIAL NOT NULL UNIQUE,
  "GOSMActivity" INTEGER REFERENCES "PostProjectProposal"("GOSMActivity"),
  "submissionID" INTEGER,
  "sequence" INTEGER DEFAULT -1,
  "nameOfEstablishment" VARCHAR(60),
  "amount" NUMERIC(12, 2),
  "purpose" VARCHAR(60),
  "bsfilename" TEXT,
  "bsfilenameToShow" TEXT,
  "idNumber" INTEGER REFERENCES Account(idNumber),
  "dateCreated" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" SMALLINT REFERENCES "PostProjectBookTransferStatus"("id") DEFAULT 0,

  PRIMARY KEY("GOSMActivity", "submissionID", "sequence")
);

DROP TABLE IF EXISTS "PostProjectBookTransferParticular" CASCADE;
CREATE TABLE "PostProjectBookTransferParticular" (
   "bookTransfer" INTEGER REFERENCES "PostProjectBookTransfer"("id"),
   "particular" INTEGER REFERENCES ProjectProposalExpenses(id),

   PRIMARY KEY ("bookTransfer", "particular")
);

CREATE TRIGGER "before_insert_PostProjectBookTransfer_sequence"
    BEFORE INSERT ON "PostProjectBookTransfer"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_sequence_versioning"('PostProjectBookTransfer', 'ppbt', 'ppbt."GOSMActivity" = $1."GOSMActivity"');
  /* Post Acts END*/
/* ADM END */
/* Publicity */
DROP TABLE IF EXISTS "ActivityPublicityMaterial" CASCADE;
CREATE TABLE "ActivityPublicityMaterial"(
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "ActivityPublicityMaterial" ("id", "name")
                                 VALUES (   0, 'Not applicable'),
                                        (   1, 'Tarpualine'),
                                        (   2, 'Banderitas'),
                                        (   3, 'Ticket');

DROP TABLE IF EXISTS "ActivityPublicityModeOfDistribution" CASCADE;
CREATE TABLE "ActivityPublicityModeOfDistribution"(
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "ActivityPublicityModeOfDistribution" ("id", "name")
                                           VALUES (   0, 'Online'),
                                                  (   1, 'Printed');

DROP TABLE IF EXISTS "ActivityPublicityStatus" CASCADE;
CREATE TABLE "ActivityPublicityStatus"(
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "ActivityPublicityStatus" ("id", "name")
                               VALUES (   0, 'For Evaluation'),
                                      (   1, 'Approved'),
                                      (   2, 'Pended'),
                                      (   3, 'Denied'),
                                      (   4, 'Old Version');

DROP TABLE IF EXISTS "ActivityPublicityRevisionReason" CASCADE;
CREATE TABLE "ActivityPublicityRevisionReason"(
    "id" SMALLINT,
    "name" VARCHAR(45) NOT NULL,

    PRIMARY KEY("id")
);
INSERT INTO "ActivityPublicityRevisionReason" ("id", "name")
                               VALUES (   0, 'Unoriginal design'),
                                      (   1, 'Incorrect grammar'),
                                      (   2, 'Incomplete logo'),
                                      (   3, 'Contents not in line with La Sallian Values'),
                                      (   4, 'Old Version');

DROP TABLE IF EXISTS "ActivityPublicity" CASCADE;
CREATE TABLE "ActivityPublicity" (
    "id" SERIAL NOT NULL UNIQUE,
    "GOSMActivity" INTEGER REFERENCES ProjectProposal(GOSMActivity),
    "submissionID" INTEGER,
    "sequence" INTEGER DEFAULT -1,
    "material" SMALLINT REFERENCES "ActivityPublicityMaterial"("id"),
    "modeOfDistribution" SMALLINT REFERENCES "ActivityPublicityModeOfDistribution"("id"),
    "description" TEXT,
    "targetPostingDate" DATE, --me
    "submittedBy" INTEGER REFERENCES Account(idNumber),
    "dateSubmitted" DATE,
    "status" SMALLINT REFERENCES "ActivityPublicityStatus"("id"),
    "checkedBy" INTEGER REFERENCES Account(idNumber),
    "dateChecked" DATE,
    "comments" TEXT,
    "filename" TEXT,
    "filenameToShow" TEXT,
    "revisionReason" SMALLINT REFERENCES "ActivityPublicityRevisionReason"("id"),

    PRIMARY KEY("GOSMActivity", "submissionID", "sequence")
);

CREATE TRIGGER "before_insert_ActivityPublicity_sequence"
    BEFORE INSERT ON "ActivityPublicity"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_sequence_versioning"( 'ActivityPublicity', 'ap', 'ap."GOSMActivity" = $1."GOSMActivity"' );
/* End of Publicity */

DROP TABLE IF EXISTS "OfficerSurveyForm" CASCADE;
CREATE TABLE "OfficerSurveyForm" (
    "id" SERIAL UNIQUE,
    "termID" INTEGER REFERENCES Term(id),
    "organizationID" INTEGER REFERENCES StudentOrganization(id),
    "officer" INTEGER REFERENCES Account(idNumber),
    "field1" SMALLINT NOT NULL,
    "field2" SMALLINT NOT NULL,
    "field3" SMALLINT NOT NULL,
    "field4" SMALLINT NOT NULL,
    "field5" SMALLINT NOT NULL,
    "field6" SMALLINT NOT NULL,
    "field7" SMALLINT NOT NULL,
    "field8" SMALLINT NOT NULL,
    "field9" SMALLINT NOT NULL,

    PRIMARY KEY("termID", "organizationID", "officer")
);

DROP TABLE IF EXISTS "MemberSurveyForm" CASCADE;
CREATE TABLE "MemberSurveyForm" (
    "id" SERIAL UNIQUE,
    "termID" INTEGER REFERENCES Term(id),
    "organizationID" INTEGER REFERENCES StudentOrganization(id),
    "sequence" INTEGER DEFAULT -1,
    "field1" SMALLINT NOT NULL,
    "field2" SMALLINT NOT NULL,
    "field3" SMALLINT NOT NULL,
    "field4" SMALLINT NOT NULL,
    "field5" SMALLINT NOT NULL,
    "field6" SMALLINT NOT NULL,
    "field7" SMALLINT NOT NULL,
    "field8" SMALLINT NOT NULL,
    "field9" SMALLINT NOT NULL,

    PRIMARY KEY("termID", "organizationID", "sequence")
);
CREATE TRIGGER "before_insert_MemberSurveyForm_sequence"
    BEFORE INSERT ON "MemberSurveyForm"
    FOR EACH ROW
    EXECUTE PROCEDURE "trigger_before_insert_increment_sequence"('MemberSurveyForm', 'msf', '(msf."termID" = $1."termID") AND (msf."organizationID" = $1."organizationID")' );

/* SESSION TABLE */
DROP TABLE IF EXISTS session CASCADE;
CREATE TABLE IF NOT EXISTS session (
    "sid" varchar NOT NULL COLLATE "default",
    "sess" JSON NOT NULL,
    "expire" timestamp(6) NOT NULL,

    PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE
)
WITH (OIDS=FALSE);
/* End of SESSION TABLE */

DROP TABLE IF EXISTS "SystemConfiguration" CASCADE;
CREATE TABLE IF NOT EXISTS "SystemConfiguration" (
    "name" VARCHAR(20),
    "value" JSON NOT NULL /*JSON IS USED INSTEAD OF JSONB BECAUSE OF */,
    "description" JSON NOT NULL,

    PRIMARY KEY("name")
);

INSERT INTO "SystemConfiguration"(
    "name",
    "value",
    "description")
VALUES ('PASSWORD',
        '{"EXPIRATION_TIME": {"DAYS": 0, "MONTHS": 3}}'::JSONB::JSON,
        '{"EXPIRATION_TIME": "Contains values on much time a password is before its expiration" }'::JSONB::JSON);

/* Useful views */
CREATE OR REPLACE VIEW "ProjectExpensesWithoutTransaction" AS
SELECT *
  FROM ProjectProposalExpenses ppe
 WHERE ppe.id NOT IN ((SELECT "particular"
                        FROM "PreActivityDirectPaymentParticular")
                       UNION
                      (SELECT "particular"
                         FROM "PreActivityCashAdvanceParticular")
                      UNION
                      (SELECT "particular"
                         FROM "PreActivityBookTransferParticular")
                      UNION
                      (SELECT "particular"
                         FROM "PostProjectReimbursementParticular"));


/*
.___________.    ___      .______       __    __  .______        ___           _______. __  ___  __  .______        ___           _______.
|           |   /   \     |   _  \     |  |  |  | |   _  \      /   \         /       ||  |/  / |  | |   _  \      /   \         /       |
`---|  |----`  /  ^  \    |  |_)  |    |  |  |  | |  |_)  |    /  ^  \       |   (----`|  '  /  |  | |  |_)  |    /  ^  \       |   (----`
    |  |      /  /_\  \   |      /     |  |  |  | |   _  <    /  /_\  \       \   \    |    <   |  | |   _  <    /  /_\  \       \   \
    |  |     /  _____  \  |  |\  \----.|  `--'  | |  |_)  |  /  _____  \  .----)   |   |  .  \  |  | |  |_)  |  /  _____  \  .----)   |
    |__|    /__/     \__\ | _| `._____| \______/  |______/  /__/     \__\ |_______/    |__|\__\ |__| |______/  /__/     \__\ |_______/
 */
