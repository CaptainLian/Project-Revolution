--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: GOSMActivity_get_current_term_activity_ids(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "GOSMActivity_get_current_term_activity_ids"() RETURNS TABLE(id integer)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY SELECT ga.id
                       FROM GOSMActivity ga
                      WHERE GOSM IN (SELECT g.id
                                       FROM GOSM g
                                       WHERE termId = system_get_current_term_id());
    END;
$$;


ALTER FUNCTION public."GOSMActivity_get_current_term_activity_ids"() OWNER TO postgres;

--
-- Name: GOSMActivity_get_organization(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "GOSMActivity_get_organization"(gosmactivityid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."GOSMActivity_get_organization"(gosmactivityid integer) OWNER TO postgres;

--
-- Name: PPR_get_GOSMActivity_id_from_PPRID(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        var_GOSMActivity INTEGER;
    BEGIN
         SELECT GOSMActivity INTO var_GOSMActivity
           FROM ProjectProposal
          WHERE id = param_PPRID;

        RETURN var_GOSMActivity;
    END;
$$;


ALTER FUNCTION public."PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer) OWNER TO postgres;

--
-- Name: PPR_get_cso_next_first_phase_signatory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_cso_next_first_phase_signatory"() RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PPR_get_cso_next_first_phase_signatory"() OWNER TO postgres;

--
-- Name: PPR_get_cso_next_second_phase_signatory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_cso_next_second_phase_signatory"() RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PPR_get_cso_next_second_phase_signatory"() OWNER TO postgres;

--
-- Name: PPR_get_number_to_sign_per_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY SELECT signatory AS idNumber, COUNT(pprs.id) AS "numSign"
                       FROM ProjectProposalSignatory pprs
                      WHERE status = 0
                        AND GOSMActivity IN (SELECT id
                                             FROM "GOSMActivity_get_current_term_activity_ids"())
                   GROUP BY pprs.signatory;
    END;
$$;


ALTER FUNCTION public."PPR_get_number_to_sign_per_account"() OWNER TO postgres;

--
-- Name: PPR_get_organization_next_documentation_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_organization_next_documentation_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PPR_get_organization_next_documentation_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PPR_get_organization_next_immediate_supervisor_signatory(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer) OWNER TO postgres;

--
-- Name: PPR_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PPR_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PPR_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreActCashAdvance_get_number_to_sign_per_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PreActCashAdvance_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PreActCashAdvance_get_number_to_sign_per_account"() OWNER TO postgres;

--
-- Name: PreActCashAdvance_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreAct_CashAdvance_get_organization(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "PreAct_CashAdvance_get_organization"("param_CAID" integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."PreAct_CashAdvance_get_organization"("param_CAID" integer) OWNER TO postgres;

--
-- Name: cso_get_first_phase_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cso_get_first_phase_signatories() RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 13)
                         AND oo.role/10000 = 0;
     END;
 $$;


ALTER FUNCTION public.cso_get_first_phase_signatories() OWNER TO postgres;

--
-- Name: cso_get_second_phase_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cso_get_second_phase_signatories() RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 14)
                         AND oo.role/10000 = 0;
     END;
 $$;


ALTER FUNCTION public.cso_get_second_phase_signatories() OWNER TO postgres;

--
-- Name: organization_get_documentation_signatories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_documentation_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 12)
                        AND oo.role/10000 = organizationID;
    END;
$$;


ALTER FUNCTION public.organization_get_documentation_signatories(organizationid integer) OWNER TO postgres;

--
-- Name: organization_get_highest_role_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_highest_role_id(param_organization integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT id INTO roleID
          FROM OrganizationRole
         WHERE masterRole IS NULL
           AND organization = param_organization
         ORDER BY sequence DESC
         LIMIT 1;

        RETURN roleID;
    END;
$$;


ALTER FUNCTION public.organization_get_highest_role_id(param_organization integer) OWNER TO postgres;

--
-- Name: organization_get_officers_with_role_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_officers_with_role_id(roleid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY SELECT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.role = roleID
                        AND oo.yearID = system_get_current_year_id();
    END;
$$;


ALTER FUNCTION public.organization_get_officers_with_role_id(roleid integer) OWNER TO postgres;

--
-- Name: organization_get_president(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_president(organization integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        presidentID INTEGER;
    BEGIN
        SELECT oo.idNumber INTO presidentID
          FROM OrganizationOfficer oo
         WHERE role = organization_get_highest_role_id(organization)
         LIMIT 1;

        RETURN presidentID;
    END;
$$;


ALTER FUNCTION public.organization_get_president(organization integer) OWNER TO postgres;

--
-- Name: organization_get_role_id_above_account(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer) OWNER TO postgres;

--
-- Name: organization_get_treasurer_signatories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_treasurer_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 11)
                        AND oo.role/10000 = organizationID;
    END;
$$;


ALTER FUNCTION public.organization_get_treasurer_signatories(organizationid integer) OWNER TO postgres;

--
-- Name: system_get_current_term_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION system_get_current_term_id() RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        termID INTEGER;
    BEGIN
        SELECT id INTO termID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN termID;
    END;
$$;


ALTER FUNCTION public.system_get_current_term_id() OWNER TO postgres;

--
-- Name: system_get_current_year_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION system_get_current_year_id() RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        yearID INTEGER;
    BEGIN
        SELECT schoolYearID INTO yearID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN yearID;
    END;
$$;


ALTER FUNCTION public.system_get_current_year_id() OWNER TO postgres;

--
-- Name: system_get_functionality_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION system_get_functionality_id(param_sequenceid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        var_FunctionalityID INTEGER;
    BEGIN
         SELECT id INTO var_FunctionalityID
           FROM Functionality
          WHERE id%100 = param_sequenceID;

        RETURN var_FunctionalityID;
    END;
$$;


ALTER FUNCTION public.system_get_functionality_id(param_sequenceid integer) OWNER TO postgres;

--
-- Name: trigger_after_delete_PreActivityCashAdvanceParticular_signatori(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_delete_PreActivityCashAdvanceParticular_signatori"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
	totalExpense NUMERIC(12, 2);
    BEGIN
	SELECT SUM(ppe.unitCost*ppe.quantity) INTO totalExpense
	  FROM ProjectProposalExpenses ppe
	 WHERE ppe.id IN (SELECT pacap.particular
	                    FROM "PreActivityCashAdvanceParticular" pacap
	                   WHERE pacap."cashAdvance" = NEW."cashAdvance");

	IF totalExpense <= 5000.00 THEN
            DELETE FROM "PreActivityCashAdvanceSignatory" pacas
            WHERE pacas."cashAdvance" = OLD."cashAdvance"
              AND pacas."signatory" = (SELECT a.idNumber FROM Account a WHERE a.type = 4 ORDER BY a.idNumber DESC LIMIT 1)
              AND pacas.type = 3;
            
        END IF;
        
	IF totalExpense <= 50000.00 THEN
           DELETE FROM "PreActivityCashAdvanceSignatory" pacas
            WHERE pacas."cashAdvance" = OLD."cashAdvance"
              AND pacas."signatory" = (SELECT a.idNumber FROM Account a WHERE a.type = 5 ORDER BY a.idNumber DESC LIMIT 1)
              AND pacas.type = 4;
        END IF;
        
	IF totalExpense <= 250000.00 THEN
            DELETE FROM "PreActivityCashAdvanceSignatory" pacas
            WHERE pacas."cashAdvance" = OLD."cashAdvance"
              AND pacas."signatory" = (SELECT a.idNumber FROM Account a WHERE a.type = 6 ORDER BY a.idNumber DESC LIMIT 1)
              AND pacas.type = 5;
	END IF;
	
        RETURN NEW;
    END
$$;


ALTER FUNCTION public."trigger_after_delete_PreActivityCashAdvanceParticular_signatori"() OWNER TO postgres;

--
-- Name: trigger_after_insert_PreActivityCashAdvanceParticular_signatori(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_insert_PreActivityCashAdvanceParticular_signatori"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
	totalExpense NUMERIC(12, 2);
    BEGIN
	SELECT SUM(ppe.unitCost*ppe.quantity) INTO totalExpense
	  FROM ProjectProposalExpenses ppe
	 WHERE ppe.id IN (SELECT pacap.particular
	                    FROM "PreActivityCashAdvanceParticular" pacap
	                   WHERE pacap."cashAdvance" = NEW."cashAdvance");

	IF totalExpense > 5000.00 THEN
            INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", "signatory", "type")
                                                   VALUES (NEW."cashAdvance", (SELECT a.idNumber FROM Account a WHERE a.type = 4 ORDER BY a.idNumber DESC LIMIT 1), 3)
            ON CONFLICT DO NOTHING;
        END IF;
        
	IF totalExpense > 50000.00 THEN
            INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", "signatory", "type")
                                                   VALUES (NEW."cashAdvance", (SELECT a.idNumber FROM Account a WHERE a.type = 5 ORDER BY a.idNumber DESC LIMIT 1), 4)
            ON CONFLICT DO NOTHING;
        END IF;
        
	IF totalExpense > 250000.00 THEN
	    INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", "signatory", "type")
                                                   VALUES (NEW."cashAdvance", (SELECT a.idNumber FROM Account a WHERE a.type = 6 ORDER BY a.idNumber DESC LIMIT 1), 5)
            ON CONFLICT DO NOTHING;
	END IF;
	
        RETURN NEW;
    END
$$;


ALTER FUNCTION public."trigger_after_insert_PreActivityCashAdvanceParticular_signatori"() OWNER TO postgres;

--
-- Name: trigger_after_insert_PreActivityCashAdvance_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_insert_PreActivityCashAdvance_signatories"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_after_insert_PreActivityCashAdvance_signatories"() OWNER TO postgres;

--
-- Name: trigger_after_insert_ProjectProposal_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_insert_ProjectProposal_signatories"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_after_insert_ProjectProposal_signatories"() OWNER TO postgres;

--
-- Name: trigger_after_insert_studentorganization(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_after_insert_studentorganization() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 15)), TRUE);

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
                                              -- Sign PPR as Treasurer 212018
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 11)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE);

        INSERT INTO OrganizationRole(organization, name, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Associate Vice President of Finance', FALSE, vpfRoleID, '/Organization/treasurer/dashboard', 30)
        RETURNING id INTO avpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE);

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_after_insert_studentorganization() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposalSignatory_completion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_update_ProjectProposalSignatory_completion"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposalSignatory_completion"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposal_signatory_facultyAdviser(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_update_ProjectProposal_signatory_facultyAdviser"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposal_signatory_facultyAdviser"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposal_signatory_immediateSuperio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_update_ProjectProposal_signatory_immediateSuperio"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      UPDATE ProjectProposalSignatory
         SET signatory = "PPR_get_organization_next_immediate_supervisor_signatory"(NEW.preparedBy, "GOSMActivity_get_organization"(NEW.GOSMActivity))
       WHERE GOSMActivity = NEW.GOSMActivity
         AND type = 2;
      RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposal_signatory_immediateSuperio"() OWNER TO postgres;

--
-- Name: trigger_after_update_gosm_studentorganization(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_after_update_gosm_studentorganization() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.trigger_after_update_gosm_studentorganization() OWNER TO postgres;

--
-- Name: trigger_auto_reject(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_auto_reject() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.trigger_auto_reject() OWNER TO postgres;

--
-- Name: trigger_before_insert_AccountNotification(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_AccountNotification"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1,0) INTO NEW.sequence
          FROM AccountNotification
         WHERE account = NEW.account;

         return NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_AccountNotification"() OWNER TO postgres;

--
-- Name: trigger_before_insert_ActivityPublicity_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_ActivityPublicity_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "ActivityPublicity"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW."sequence"
              FROM "ActivityPublicity"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_ActivityPublicity_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectBookTransfer_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PostProjectBookTransfer_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectBookTransfer"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectBookTransfer"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectBookTransfer_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectDirectPayment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PostProjectDirectPayment_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectDirectPayment_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectProposalEventPicture_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PostProjectProposalEventPicture_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectProposalEventPicture_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectProposalExpense_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PostProjectProposalExpense_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectProposalExpense_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectReimbursement_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PostProjectReimbursement_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectReimbursement"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectReimbursement"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectReimbursement_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PreActivityCashAdvance_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PreActivityCashAdvance_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_before_insert_PreActivityCashAdvance_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PreActivityDirectPayment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_PreActivityDirectPayment_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public."trigger_before_insert_PreActivityDirectPayment_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

        NEW.dateCreated = CURRENT_TIMESTAMP;
        NEW.dateModified = NEW.dateCreated;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_account() OWNER TO postgres;

--
-- Name: trigger_before_insert_audit_ProjectProposal_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_before_insert_audit_ProjectProposal_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX("sequence") + 1, 1) INTO NEW."sequence"
          FROM "audit_ProjectProposal"
         WHERE "GOSMActivity" = NEW."GOSMActivity";
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_audit_ProjectProposal_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_functionality(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_functionality() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%1000) + 1, 0) INTO NEW.id
          FROM Functionality;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_functionality() OWNER TO postgres;

--
-- Name: trigger_before_insert_functionalitycategory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_functionalitycategory() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%100) + 1, 0) INTO NEW.id
          FROM FunctionalityCategory;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_functionalitycategory() OWNER TO postgres;

--
-- Name: trigger_before_insert_gosm(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_gosm() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%100000) + 1, 1) INTO NEW.id
          FROM GOSM;

        NEW.id = (NEW.studentOrganization*100000) + NEW.id;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_gosm() OWNER TO postgres;

--
-- Name: trigger_before_insert_gosmactivity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_gosmactivity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id) + 1, 1) INTO STRICT NEW.sequence
          FROM GOSMActivity
         WHERE GOSM = NEW.GOSM;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_gosmactivity() OWNER TO postgres;

--
-- Name: trigger_before_insert_increment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_increment_sequence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	    EXECUTE format ('SELECT COALESCE(MAX(sequence) + 1, 1)
	                       FROM %I %I
	                      WHERE (%s);', TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT NEW."sequence"
	    USING NEW;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_increment_sequence() OWNER TO postgres;

--
-- Name: trigger_before_insert_organizationrole(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_organizationrole() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      SELECT COALESCE(MAX(id%10000) + 1, 0) INTO NEW.id
        FROM OrganizationRole;

      NEW.id = (NEW.organization%1000)*10000 + NEW.id;

      SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
        FROM OrganizationRole
      WHERE organization = NEW.organization;
      return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_organizationrole() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalattachment(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalattachment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalAttachment
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalattachment() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalexpenses(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalexpenses() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalExpenses
         WHERE projectProposal = NEW.projectProposal;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalexpenses() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalprogramdesign(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalprogramdesign() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal
           AND dayID = NEW.dayID;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalprogramdesign() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalprojectedincome(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalprojectedincome() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProjectedIncome
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalprojectedincome() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalsourcefunds(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalsourcefunds() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalsourcefunds() OWNER TO postgres;

--
-- Name: trigger_before_insert_schoolyear(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_schoolyear() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id := (NEW.startYear*10000) + NEW.endYear;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_schoolyear() OWNER TO postgres;

--
-- Name: trigger_before_insert_sequence_versioning(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_sequence_versioning() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW.sequence = 1;
            EXECUTE format('SELECT COALESCE(MAX("submissionID") + 1, 1)
                              FROM %I %I
                             WHERE (%s)', TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
            INTO STRICT NEW."submissionID"
            USING NEW;
        ELSE
            EXECUTE format ('SELECT COALESCE(MAX(sequence) + 1, 1)
                               FROM %I %I
                              WHERE "submissionID" = $1."submissionID"
                                AND (%s);', TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
            INTO STRICT NEW."sequence"
            USING NEW;
        END IF;

        RETURN NEW;
    END;
$_$;


ALTER FUNCTION public.trigger_before_insert_sequence_versioning() OWNER TO postgres;

--
-- Name: trigger_before_insert_term(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_term() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id := (NEW.schoolYearID*10) + NEW.number;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_term() OWNER TO postgres;

--
-- Name: trigger_before_update_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;
        NEW.dateModified = CURRENT_TIMESTAMP;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_account() OWNER TO postgres;

--
-- Name: trigger_before_update_account2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_account2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.dateModified = CURRENT_TIMESTAMP;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_account2() OWNER TO postgres;

--
-- Name: trigger_before_update_functionality(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_functionality() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id = OLD.id%1000;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_functionality() OWNER TO postgres;

--
-- Name: trigger_before_update_functionalitycategory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_functionalitycategory() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id = OLD.id%100;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_functionalitycategory() OWNER TO postgres;

--
-- Name: trigger_before_update_gosm_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_gosm_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
        END CASE;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_gosm_status() OWNER TO postgres;

--
-- Name: trigger_before_update_projectproposal(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_update_projectproposal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.trigger_before_update_projectproposal() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ARFOrganizationPosition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ARFOrganizationPosition" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ARFOrganizationPosition" OWNER TO postgres;

--
-- Name: AccountEvent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AccountEvent" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "AccountEvent" OWNER TO postgres;

--
-- Name: AccountNotification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AccountNotification" (
    id integer NOT NULL,
    account integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    message text
);


ALTER TABLE "AccountNotification" OWNER TO postgres;

--
-- Name: AccountNotification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "AccountNotification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AccountNotification_id_seq" OWNER TO postgres;

--
-- Name: AccountNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "AccountNotification_id_seq" OWNED BY "AccountNotification".id;


--
-- Name: ActivityPublicity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicity" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    material smallint,
    "modeOfDistribution" smallint,
    description text,
    "targetPostingDate" date,
    "submittedBy" integer,
    "dateSubmitted" date,
    status smallint,
    "checkedBy" integer,
    "dateChecked" date,
    comments text,
    filename text,
    "filenameToShow" text
);


ALTER TABLE "ActivityPublicity" OWNER TO postgres;

--
-- Name: ActivityPublicityMaterial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityMaterial" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityMaterial" OWNER TO postgres;

--
-- Name: ActivityPublicityModeOfDistribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityModeOfDistribution" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityModeOfDistribution" OWNER TO postgres;

--
-- Name: ActivityPublicityStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityStatus" OWNER TO postgres;

--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "ActivityPublicity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ActivityPublicity_id_seq" OWNER TO postgres;

--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "ActivityPublicity_id_seq" OWNED BY "ActivityPublicity".id;


--
-- Name: ActivityResearchForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityResearchForm" (
    "GOSMActivity" integer NOT NULL,
    sequence integer NOT NULL,
    "positionInOrganization" smallint,
    "IUTPOTA" smallint,
    "TASMI" smallint,
    "IFIDTA" smallint,
    "TAWWP" smallint,
    "TOUMTGTTA" smallint,
    "WWWITA" text,
    "FAC" text,
    "EFFA" text,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "ActivityResearchForm" OWNER TO postgres;

--
-- Name: ActivityVenue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityVenue" (
    id integer NOT NULL,
    name text,
    capacity integer,
    size smallint,
    rate numeric(12,2),
    "rateType" smallint,
    building smallint
);


ALTER TABLE "ActivityVenue" OWNER TO postgres;

--
-- Name: Building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Building" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "Building" OWNER TO postgres;

--
-- Name: ExpenseTypeAttachmentRequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ExpenseTypeAttachmentRequirement" (
    "expenseType" smallint NOT NULL,
    document smallint NOT NULL
);


ALTER TABLE "ExpenseTypeAttachmentRequirement" OWNER TO postgres;

--
-- Name: FinanceSignatoryType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "FinanceSignatoryType" (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE "FinanceSignatoryType" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransfer" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    purpose character varying(60),
    bsfilename text,
    "bsfilenameToShow" text,
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE "PostProjectBookTransfer" OWNER TO postgres;

--
-- Name: PostProjectBookTransferParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransferParticular" (
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectBookTransferParticular" OWNER TO postgres;

--
-- Name: PostProjectBookTransferStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransferStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectBookTransferStatus" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectBookTransfer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectBookTransfer_id_seq" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectBookTransfer_id_seq" OWNED BY "PostProjectBookTransfer".id;


--
-- Name: PostProjectDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPayment" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    "paymentBy" smallint,
    "delayedProcessing" text,
    fqfilename text,
    roffilename text,
    "fqfilenameToShow" text,
    "roffilenameToShow" text,
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE "PostProjectDirectPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentParticular" (
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentPayment" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectDirectPaymentPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectDirectPaymentStatus" OWNER TO postgres;

--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectDirectPayment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectDirectPayment_id_seq" OWNER TO postgres;

--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectDirectPayment_id_seq" OWNED BY "PostProjectDirectPayment".id;


--
-- Name: PostProjectProposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposal" (
    "GOSMActivity" integer NOT NULL,
    "preparedBy" integer,
    status smallint DEFAULT 0 NOT NULL,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "ANP" integer,
    "ANMP" integer,
    objectives text[],
    "WATTTWITA" text,
    "WWYGLIETA" text,
    "HDTATYLCTTDOTP" text,
    "WATTWWAWCYDTPTFHA" text,
    galsfilename text,
    "galsfilenameToShow" text,
    "isBriefContextCompleted" boolean DEFAULT false NOT NULL,
    "isOtherFinanceDocumentsCompleted" boolean DEFAULT false NOT NULL,
    "isFinanceDocumentCompleted" boolean DEFAULT false NOT NULL,
    "isCheckedDP" boolean DEFAULT false NOT NULL,
    "isCheckedR" boolean DEFAULT false NOT NULL,
    "isCheckedBT" boolean DEFAULT false NOT NULL,
    comments text,
    "sectionsToBeEdited" character varying(60)[],
    document jsonb,
    "checkedByStage1" integer,
    "signatureStage1" text,
    "checkedByStage2" integer,
    "signatureStage2" text
);


ALTER TABLE "PostProjectProposal" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalEventPicture" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    filename text,
    "filenameToShow" text,
    description text,
    "idNumber" integer
);


ALTER TABLE "PostProjectProposalEventPicture" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectProposalEventPicture_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectProposalEventPicture_id_seq" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectProposalEventPicture_id_seq" OWNED BY "PostProjectProposalEventPicture".id;


--
-- Name: PostProjectProposalExpense; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalExpense" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    particular character varying(45),
    establishment character varying(45),
    price numeric(12,2),
    filename text,
    "filenameToShow" text,
    "idNumber" integer
);


ALTER TABLE "PostProjectProposalExpense" OWNER TO postgres;

--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectProposalExpense_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectProposalExpense_id_seq" OWNER TO postgres;

--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectProposalExpense_id_seq" OWNED BY "PostProjectProposalExpense".id;


--
-- Name: PostProjectProposalStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "PostProjectProposalStatus" OWNER TO postgres;

--
-- Name: PostProjectReimbursement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursement" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    "paymentBy" smallint,
    "foodExpense" character varying(60),
    "NUCAODP" text,
    "delayedProcessing" text,
    filenames text[],
    "filenamesToShow" text[],
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE "PostProjectReimbursement" OWNER TO postgres;

--
-- Name: PostProjectReimbursementParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementParticular" (
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectReimbursementParticular" OWNER TO postgres;

--
-- Name: PostProjectReimbursementPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementPayment" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectReimbursementPayment" OWNER TO postgres;

--
-- Name: PostProjectReimbursementStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectReimbursementStatus" OWNER TO postgres;

--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectReimbursement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectReimbursement_id_seq" OWNER TO postgres;

--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectReimbursement_id_seq" OWNED BY "PostProjectReimbursement".id;


--
-- Name: PreActivityCashAdvance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvance" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    purpose text,
    justification text,
    "evaluatedBy" integer,
    status smallint
);


ALTER TABLE "PreActivityCashAdvance" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceParticular" (
    id integer NOT NULL,
    "cashAdvance" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PreActivityCashAdvanceParticular" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvanceParticular_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvanceParticular_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvanceParticular_id_seq" OWNED BY "PreActivityCashAdvanceParticular".id;


--
-- Name: PreActivityCashAdvanceSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceSignatory" (
    id integer NOT NULL,
    "cashAdvance" integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    "sectionsToEdit" character varying(60)[],
    document jsonb,
    "digitalSignature" text,
    "dateSigned" timestamp with time zone
);


ALTER TABLE "PreActivityCashAdvanceSignatory" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvanceSignatory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvanceSignatory_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvanceSignatory_id_seq" OWNED BY "PreActivityCashAdvanceSignatory".id;


--
-- Name: PreActivityCashAdvanceStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PreActivityCashAdvanceStatus" OWNER TO postgres;

--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvance_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvance_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvance_id_seq" OWNED BY "PreActivityCashAdvance".id;


--
-- Name: PreActivityDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPayment" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    "reasonForDelayedPRSProcessing" text,
    "galsFilename" text,
    "galsfilenameToShow" text,
    "fqFilename" text,
    "fqfilenameToShow" text,
    "rofFilename" text,
    "rofFilenameToShow" text,
    "evaluatedBy" integer,
    comments text,
    "dateEvaluated" timestamp with time zone,
    status smallint
);


ALTER TABLE "PreActivityDirectPayment" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentParticular" (
    id integer NOT NULL,
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PreActivityDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPaymentParticular_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPaymentParticular_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPaymentParticular_id_seq" OWNED BY "PreActivityDirectPaymentParticular".id;


--
-- Name: PreActivityDirectPaymentSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentSignatory" (
    id integer NOT NULL,
    "directPayment" integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    "sectionsToEdit" character varying(60)[],
    document jsonb,
    "digitalSignature" text,
    "dateSigned" timestamp with time zone
);


ALTER TABLE "PreActivityDirectPaymentSignatory" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPaymentSignatory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPaymentSignatory_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPaymentSignatory_id_seq" OWNED BY "PreActivityDirectPaymentSignatory".id;


--
-- Name: PreActivityDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PreActivityDirectPaymentStatus" OWNER TO postgres;

--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPayment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPayment_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPayment_id_seq" OWNED BY "PreActivityDirectPayment".id;


--
-- Name: ProjectProposalEvent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ProjectProposalEvent" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "ProjectProposalEvent" OWNER TO postgres;

--
-- Name: RateType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "RateType" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "RateType" OWNER TO postgres;

--
-- Name: VenueSize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "VenueSize" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "VenueSize" OWNER TO postgres;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account (
    idnumber integer NOT NULL,
    email character varying(255),
    type smallint DEFAULT 1,
    password character(60) NOT NULL,
    salt character(29),
    firstname character varying(45),
    middlename character varying(45),
    lastname character varying(45),
    contactnumber character varying(16),
    privatekey text,
    publickey text,
    path_profilepicture text,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    datemodified timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE account OWNER TO postgres;

--
-- Name: accounttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE accounttype (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE accounttype OWNER TO postgres;

--
-- Name: activityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activityattachmentrequirement (
    id integer NOT NULL,
    activitytype integer NOT NULL,
    attachment smallint NOT NULL,
    optional boolean DEFAULT false NOT NULL
);


ALTER TABLE activityattachmentrequirement OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE activityattachmentrequirement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityattachmentrequirement_id_seq OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE activityattachmentrequirement_id_seq OWNED BY activityattachmentrequirement.id;


--
-- Name: activitynature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activitynature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE activitynature OWNER TO postgres;

--
-- Name: activitytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activitytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE activitytype OWNER TO postgres;

--
-- Name: amtactivityevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE amtactivityevaluation (
    activity integer NOT NULL,
    venue smallint,
    equipment smallint,
    materials smallint,
    registration smallint,
    timeend smallint,
    activityexecution smallint,
    hosts smallint,
    facilitators smallint,
    presentation smallint,
    activities smallint,
    organizationstandingpresentation smallint,
    timestart smallint,
    actualstarttime time with time zone,
    actualendtime time with time zone,
    anp integer,
    person1ea smallint,
    person1loa smallint,
    person1iitskoa smallint,
    person1iomwm smallint,
    person2ea smallint,
    person2loa smallint,
    person2iitskoa smallint,
    person2iomwm smallint,
    comments1 text,
    comments2 text,
    comments3 text,
    suggestions1 text,
    suggestions2 text,
    suggestions3 text,
    evaluator integer,
    status integer,
    datereserved timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    dateevaluated timestamp with time zone
);


ALTER TABLE amtactivityevaluation OWNER TO postgres;

--
-- Name: amtactivityevaluationstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE amtactivityevaluationstatus (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE amtactivityevaluationstatus OWNER TO postgres;

--
-- Name: audit_Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "audit_Account" (
    id integer NOT NULL,
    responsible integer,
    affected integer,
    event smallint,
    date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    modifiedvalues jsonb
);


ALTER TABLE "audit_Account" OWNER TO postgres;

--
-- Name: audit_Account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "audit_Account_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "audit_Account_id_seq" OWNER TO postgres;

--
-- Name: audit_Account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "audit_Account_id_seq" OWNED BY "audit_Account".id;


--
-- Name: audit_ProjectProposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "audit_ProjectProposal" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    event smallint NOT NULL,
    "values" jsonb,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "audit_ProjectProposal" OWNER TO postgres;

--
-- Name: audit_ProjectProposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "audit_ProjectProposal_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "audit_ProjectProposal_id_seq" OWNER TO postgres;

--
-- Name: audit_ProjectProposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "audit_ProjectProposal_id_seq" OWNED BY "audit_ProjectProposal".id;


--
-- Name: college; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE college (
    shortacronym character(3) NOT NULL,
    fullacronym character varying(20),
    name character varying(60)
);


ALTER TABLE college OWNER TO postgres;

--
-- Name: documentattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE documentattachmentrequirement (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE documentattachmentrequirement OWNER TO postgres;

--
-- Name: expensetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE expensetype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE expensetype OWNER TO postgres;

--
-- Name: functionality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionality (
    id integer NOT NULL,
    name character varying(100),
    category integer
);


ALTER TABLE functionality OWNER TO postgres;

--
-- Name: functionalitycategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionalitycategory (
    id integer NOT NULL,
    name character varying(45),
    domain smallint
);


ALTER TABLE functionalitycategory OWNER TO postgres;

--
-- Name: functionalitydomain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionalitydomain (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE functionalitydomain OWNER TO postgres;

--
-- Name: gosm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosm (
    id integer,
    termid integer NOT NULL,
    studentorganization integer NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    datesubmitted timestamp with time zone,
    datestatusmodified timestamp with time zone,
    preparedby integer,
    statusmodifier integer,
    comments text
);


ALTER TABLE gosm OWNER TO postgres;

--
-- Name: gosmactivity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmactivity (
    id integer NOT NULL,
    gosm integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    goals character varying(255) NOT NULL,
    objectives character varying(255)[] NOT NULL,
    strategies character varying(255) NOT NULL,
    description text NOT NULL,
    measures character varying(255) NOT NULL,
    targetdatestart date,
    targetdateend date,
    activitynature smallint,
    activitytype smallint,
    activitytypeotherdescription character varying(45),
    isrelatedtoorganizationnature boolean NOT NULL,
    budget numeric(12,2) DEFAULT 0.0 NOT NULL,
    comments text,
    CONSTRAINT targetdate_start_end_value CHECK ((targetdatestart <= targetdateend))
);


ALTER TABLE gosmactivity OWNER TO postgres;

--
-- Name: gosmactivity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE gosmactivity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gosmactivity_id_seq OWNER TO postgres;

--
-- Name: gosmactivity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE gosmactivity_id_seq OWNED BY gosmactivity.id;


--
-- Name: gosmactivityprojecthead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmactivityprojecthead (
    idnumber integer NOT NULL,
    activityid integer NOT NULL
);


ALTER TABLE gosmactivityprojecthead OWNER TO postgres;

--
-- Name: gosmstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE gosmstatus OWNER TO postgres;

--
-- Name: organizationaccesscontrol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationaccesscontrol (
    role integer NOT NULL,
    functionality integer NOT NULL,
    isallowed boolean DEFAULT false NOT NULL
);


ALTER TABLE organizationaccesscontrol OWNER TO postgres;

--
-- Name: organizationcluster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationcluster (
    id smallint NOT NULL,
    name character varying(128) NOT NULL,
    acronym character varying(20)
);


ALTER TABLE organizationcluster OWNER TO postgres;

--
-- Name: organizationfacultyadviser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationfacultyadviser (
    id integer NOT NULL,
    organization integer NOT NULL,
    faculty integer NOT NULL,
    yearid integer DEFAULT system_get_current_year_id() NOT NULL
);


ALTER TABLE organizationfacultyadviser OWNER TO postgres;

--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organizationfacultyadviser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organizationfacultyadviser_id_seq OWNER TO postgres;

--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organizationfacultyadviser_id_seq OWNED BY organizationfacultyadviser.id;


--
-- Name: organizationnature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationnature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    acronym character varying(10)
);


ALTER TABLE organizationnature OWNER TO postgres;

--
-- Name: organizationofficer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationofficer (
    idnumber integer NOT NULL,
    role integer NOT NULL,
    yearid integer NOT NULL,
    dateassigned timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE organizationofficer OWNER TO postgres;

--
-- Name: organizationrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationrole (
    id integer DEFAULT '-1'::integer,
    organization integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    name character varying(100),
    rank integer,
    uniqueposition boolean DEFAULT false NOT NULL,
    masterrole integer,
    home_url text
);


ALTER TABLE organizationrole OWNER TO postgres;

--
-- Name: postactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE postactivityattachmentrequirement (
)
INHERITS (activityattachmentrequirement);


ALTER TABLE postactivityattachmentrequirement OWNER TO postgres;

--
-- Name: preactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE preactivityattachmentrequirement (
)
INHERITS (activityattachmentrequirement);


ALTER TABLE preactivityattachmentrequirement OWNER TO postgres;

--
-- Name: projectproposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposal (
    id integer NOT NULL,
    gosmactivity integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    enp integer,
    enmp integer,
    actualdatestart date,
    actualdateend date,
    venue integer,
    context1 text,
    context2 text,
    context3 text,
    isexpense boolean DEFAULT true NOT NULL,
    sourcefundother numeric(12,2),
    sourcefundparticipantfee numeric(12,2),
    sourcefundorganizational numeric(12,2),
    accumulatedoperationalfunds numeric(12,2),
    accumulateddepositoryfunds numeric(12,2),
    organizationfundothersource numeric(12,2),
    comments text,
    preparedby integer,
    facultyadviser integer,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    datesubmitted timestamp with time zone,
    datestatusmodified timestamp with time zone,
    isattachmentscomplete boolean DEFAULT false NOT NULL,
    isbriefcontextcomplete boolean DEFAULT false NOT NULL,
    isexpensecomplete boolean DEFAULT false NOT NULL,
    isprogramcomplete boolean DEFAULT false NOT NULL
);


ALTER TABLE projectproposal OWNER TO postgres;

--
-- Name: projectproposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposal_id_seq OWNER TO postgres;

--
-- Name: projectproposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposal_id_seq OWNED BY projectproposal.id;


--
-- Name: projectproposalattachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalattachment (
    id integer NOT NULL,
    projectproposal integer NOT NULL,
    requirement smallint NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    idnumber integer,
    filename text,
    filenametoshow text,
    directory text NOT NULL
);


ALTER TABLE projectproposalattachment OWNER TO postgres;

--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalattachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalattachment_id_seq OWNER TO postgres;

--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalattachment_id_seq OWNED BY projectproposalattachment.id;


--
-- Name: projectproposalexpenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalexpenses (
    id integer NOT NULL,
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    material character varying(45) NOT NULL,
    quantity integer NOT NULL,
    unitcost numeric(12,2) NOT NULL,
    type smallint DEFAULT 0 NOT NULL
);


ALTER TABLE projectproposalexpenses OWNER TO postgres;

--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalexpenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalexpenses_id_seq OWNER TO postgres;

--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalexpenses_id_seq OWNED BY projectproposalexpenses.id;


--
-- Name: projectproposalprogramdesign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprogramdesign (
    id integer NOT NULL,
    projectproposal integer NOT NULL,
    dayid integer NOT NULL,
    sequence integer NOT NULL,
    date date,
    starttime time with time zone,
    endtime time with time zone,
    activity text,
    activitydescription text,
    personincharge integer,
    CONSTRAINT projectproposalprogramdesign_check CHECK ((starttime <= endtime))
);


ALTER TABLE projectproposalprogramdesign OWNER TO postgres;

--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalprogramdesign_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalprogramdesign_id_seq OWNER TO postgres;

--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalprogramdesign_id_seq OWNED BY projectproposalprogramdesign.id;


--
-- Name: projectproposalprogramdesignpersonincharge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprogramdesignpersonincharge (
    id integer NOT NULL,
    programdesign integer NOT NULL,
    projecthead integer NOT NULL
);


ALTER TABLE projectproposalprogramdesignpersonincharge OWNER TO postgres;

--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalprogramdesignpersonincharge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalprogramdesignpersonincharge_id_seq OWNER TO postgres;

--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalprogramdesignpersonincharge_id_seq OWNED BY projectproposalprogramdesignpersonincharge.id;


--
-- Name: projectproposalprojectedincome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprojectedincome (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    item character varying(45) NOT NULL,
    quantity integer NOT NULL,
    sellingprice numeric(12,2) NOT NULL
);


ALTER TABLE projectproposalprojectedincome OWNER TO postgres;

--
-- Name: projectproposalsignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalsignatory (
    id integer NOT NULL,
    gosmactivity integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    sectionstoedit character varying(60)[],
    document jsonb,
    digitalsignature text,
    datesigned timestamp with time zone
);


ALTER TABLE projectproposalsignatory OWNER TO postgres;

--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalsignatory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalsignatory_id_seq OWNER TO postgres;

--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalsignatory_id_seq OWNED BY projectproposalsignatory.id;


--
-- Name: projectproposalsourcefunds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalsourcefunds (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    name character varying(45),
    amount numeric(12,2)
);


ALTER TABLE projectproposalsourcefunds OWNER TO postgres;

--
-- Name: projectproposalstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE projectproposalstatus OWNER TO postgres;

--
-- Name: schoolyear; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schoolyear (
    id integer,
    startyear integer NOT NULL,
    endyear integer NOT NULL,
    CONSTRAINT start_end_year_value CHECK ((startyear < endyear))
);


ALTER TABLE schoolyear OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE session OWNER TO postgres;

--
-- Name: signatorystatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatorystatus (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE signatorystatus OWNER TO postgres;

--
-- Name: signatorytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatorytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE signatorytype OWNER TO postgres;

--
-- Name: studentorganization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE studentorganization (
    id integer NOT NULL,
    name character varying(128),
    cluster smallint,
    nature smallint,
    college character(3),
    acronym character varying(20),
    description text,
    funds numeric(16,2) DEFAULT 0.0 NOT NULL,
    operationalfunds numeric(16,2) DEFAULT 0.0 NOT NULL,
    depositryfunds numeric(16,2) DEFAULT 0.0 NOT NULL,
    path_profilepicture text
);


ALTER TABLE studentorganization OWNER TO postgres;

--
-- Name: term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE term (
    id integer,
    schoolyearid integer NOT NULL,
    number integer NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    CONSTRAINT date_start_end_value CHECK ((datestart <= dateend)),
    CONSTRAINT number_max_value CHECK ((number <= 3)),
    CONSTRAINT number_min_value CHECK ((number >= 1))
);


ALTER TABLE term OWNER TO postgres;

--
-- Name: AccountNotification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification" ALTER COLUMN id SET DEFAULT nextval('"AccountNotification_id_seq"'::regclass);


--
-- Name: ActivityPublicity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity" ALTER COLUMN id SET DEFAULT nextval('"ActivityPublicity_id_seq"'::regclass);


--
-- Name: PostProjectBookTransfer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer" ALTER COLUMN id SET DEFAULT nextval('"PostProjectBookTransfer_id_seq"'::regclass);


--
-- Name: PostProjectDirectPayment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment" ALTER COLUMN id SET DEFAULT nextval('"PostProjectDirectPayment_id_seq"'::regclass);


--
-- Name: PostProjectProposalEventPicture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture" ALTER COLUMN id SET DEFAULT nextval('"PostProjectProposalEventPicture_id_seq"'::regclass);


--
-- Name: PostProjectProposalExpense id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense" ALTER COLUMN id SET DEFAULT nextval('"PostProjectProposalExpense_id_seq"'::regclass);


--
-- Name: PostProjectReimbursement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement" ALTER COLUMN id SET DEFAULT nextval('"PostProjectReimbursement_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvance_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvanceParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvanceParticular_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvanceSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvanceSignatory_id_seq"'::regclass);


--
-- Name: PreActivityDirectPayment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPayment_id_seq"'::regclass);


--
-- Name: PreActivityDirectPaymentParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPaymentParticular_id_seq"'::regclass);


--
-- Name: PreActivityDirectPaymentSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPaymentSignatory_id_seq"'::regclass);


--
-- Name: activityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: audit_Account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_Account" ALTER COLUMN id SET DEFAULT nextval('"audit_Account_id_seq"'::regclass);


--
-- Name: audit_ProjectProposal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_ProjectProposal" ALTER COLUMN id SET DEFAULT nextval('"audit_ProjectProposal_id_seq"'::regclass);


--
-- Name: gosmactivity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity ALTER COLUMN id SET DEFAULT nextval('gosmactivity_id_seq'::regclass);


--
-- Name: organizationfacultyadviser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser ALTER COLUMN id SET DEFAULT nextval('organizationfacultyadviser_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Name: preactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: preactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Name: projectproposal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal ALTER COLUMN id SET DEFAULT nextval('projectproposal_id_seq'::regclass);


--
-- Name: projectproposalattachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment ALTER COLUMN id SET DEFAULT nextval('projectproposalattachment_id_seq'::regclass);


--
-- Name: projectproposalexpenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses ALTER COLUMN id SET DEFAULT nextval('projectproposalexpenses_id_seq'::regclass);


--
-- Name: projectproposalprogramdesign id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign ALTER COLUMN id SET DEFAULT nextval('projectproposalprogramdesign_id_seq'::regclass);


--
-- Name: projectproposalprogramdesignpersonincharge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge ALTER COLUMN id SET DEFAULT nextval('projectproposalprogramdesignpersonincharge_id_seq'::regclass);


--
-- Name: projectproposalsignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory ALTER COLUMN id SET DEFAULT nextval('projectproposalsignatory_id_seq'::regclass);


--
-- Data for Name: ARFOrganizationPosition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ARFOrganizationPosition" (id, name) FROM stdin;
0	Officer
1	Member
2	Non-member
\.


--
-- Data for Name: AccountEvent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AccountEvent" (id, name) FROM stdin;
0	Edit
1	Create
2	Deactivate
3	Reactivate
\.


--
-- Data for Name: AccountNotification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AccountNotification" (id, account, sequence, date, message) FROM stdin;
\.


--
-- Data for Name: ActivityPublicity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicity" (id, "GOSMActivity", "submissionID", sequence, material, "modeOfDistribution", description, "targetPostingDate", "submittedBy", "dateSubmitted", status, "checkedBy", "dateChecked", comments, filename, "filenameToShow") FROM stdin;
\.


--
-- Data for Name: ActivityPublicityMaterial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityMaterial" (id, name) FROM stdin;
0	Not applicable
1	Tarpualine
2	Banderitas
3	Ticket
\.


--
-- Data for Name: ActivityPublicityModeOfDistribution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityModeOfDistribution" (id, name) FROM stdin;
0	Online
1	Printed
\.


--
-- Data for Name: ActivityPublicityStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityStatus" (id, name) FROM stdin;
0	For Evaluation
1	Approved
2	Pended
3	Denied
4	Old Version
\.


--
-- Data for Name: ActivityResearchForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityResearchForm" ("GOSMActivity", sequence, "positionInOrganization", "IUTPOTA", "TASMI", "IFIDTA", "TAWWP", "TOUMTGTTA", "WWWITA", "FAC", "EFFA", "dateSubmitted") FROM stdin;
\.


--
-- Data for Name: ActivityVenue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityVenue" (id, name, capacity, size, rate, "rateType", building) FROM stdin;
0	A 1502-A Conference Room	20	0	360.00	0	0
1	A 1502-B Conference Room	10	0	230.00	0	0
2	A 1505-A Conference Room	12	0	240.00	0	0
3	A 1505-B Conference Room	8	0	110.00	0	0
4	A 1506 Conference Room	30	0	850.00	0	0
5	A 1602 Conference Room	20	0	680.00	0	0
6	A 703 Lecture Room	120	1	1200.00	0	0
7	A 903 Lecture Room	120	1	1200.00	0	0
8	A 1103 Lecture Room	120	1	1200.00	0	0
9	A 1403 Lecture Room	120	1	1200.00	0	0
10	A 1703 Lecture Room	120	1	1200.00	0	0
11	A1402 Micro Teaching Laboratory	45	0	700.00	0	0
12	A1805 Micro Teaching Laboratory	45	0	700.00	0	0
13	20th Floor Board Room	20	0	900.00	0	0
14	20th Floor Conference Room	8	0	400.00	0	0
15	20th Floor Multipurpose Room	200	2	2500.00	0	0
16	Classroom (Full-size)	45	0	620.00	0	0
17	Classroom (Half-size	25	0	340.00	0	0
18	Natividad Fajardo-Rosario Gonzalez Auditorium, 18th Flr.	238	2	3000.00	0	0
19	Neil Room	12	3	700.43	4	0
\.


--
-- Data for Name: Building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Building" (id, name) FROM stdin;
0	Br. Andrew Gonzales Building
1	Br. Gabriel Conon (SPS) Building
2	Don Enrique Yuchengco Building
3	Enrique Razon Building
4	Velasco Building
5	Gokongwei Building
6	La Salle Building
7	St. Joseph Building
8	St. Miguel Building
9	St. Mutien Marie Building
10	University Library Building
11	William Shaw Building
12	Others
13	Henry Sy Building
\.


--
-- Data for Name: ExpenseTypeAttachmentRequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ExpenseTypeAttachmentRequirement" ("expenseType", document) FROM stdin;
0	9
1	9
1	10
2	9
2	10
6	11
\.


--
-- Data for Name: FinanceSignatoryType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "FinanceSignatoryType" (id, name, lineup) FROM stdin;
0	Organization Finance/Treasurer	0
1	Organization President	10
2	Director of S-Life	20
3	Dean of Student Affairs	30
4	Vice President for Lasallian Mission	40
5	President	50
\.


--
-- Data for Name: PostProjectBookTransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransfer" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, purpose, bsfilename, "bsfilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransferParticular" ("bookTransfer", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransferStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PostProjectDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, "paymentBy", "delayedProcessing", fqfilename, roffilename, "fqfilenameToShow", "roffilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentParticular" ("directPayment", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentPayment" (id, name) FROM stdin;
0	Cheque
1	Book Transfer
\.


--
-- Data for Name: PostProjectDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
\.


--
-- Data for Name: PostProjectProposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposal" ("GOSMActivity", "preparedBy", status, "dateCreated", "ANP", "ANMP", objectives, "WATTTWITA", "WWYGLIETA", "HDTATYLCTTDOTP", "WATTWWAWCYDTPTFHA", galsfilename, "galsfilenameToShow", "isBriefContextCompleted", "isOtherFinanceDocumentsCompleted", "isFinanceDocumentCompleted", "isCheckedDP", "isCheckedR", "isCheckedBT", comments, "sectionsToBeEdited", document, "checkedByStage1", "signatureStage1", "checkedByStage2", "signatureStage2") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalEventPicture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalEventPicture" (id, "GOSMActivity", "submissionID", sequence, filename, "filenameToShow", description, "idNumber") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalExpense; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalExpense" (id, "GOSMActivity", "submissionID", sequence, particular, establishment, price, filename, "filenameToShow", "idNumber") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalStatus" (id, name) FROM stdin;
0	Unopened
1	Opened
2	In-progress
3	For Approval
4	Approved
5	Pend
\.


--
-- Data for Name: PostProjectReimbursement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursement" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, "paymentBy", "foodExpense", "NUCAODP", "delayedProcessing", filenames, "filenamesToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementParticular" ("bookTransfer", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementPayment" (id, name) FROM stdin;
0	Payment By Check
1	Payment By Book Transfer
\.


--
-- Data for Name: PostProjectReimbursementStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PreActivityCashAdvance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvance" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", purpose, justification, "evaluatedBy", status) FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceParticular" (id, "cashAdvance", particular) FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceSignatory" (id, "cashAdvance", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PreActivityDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", "nameOfEstablishment", amount, "reasonForDelayedPRSProcessing", "galsFilename", "galsfilenameToShow", "fqFilename", "fqfilenameToShow", "rofFilename", "rofFilenameToShow", "evaluatedBy", comments, "dateEvaluated", status) FROM stdin;
\.


--
-- Data for Name: PreActivityDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentParticular" (id, "directPayment", particular) FROM stdin;
\.


--
-- Data for Name: PreActivityDirectPaymentSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentSignatory" (id, "directPayment", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Data for Name: PreActivityDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: ProjectProposalEvent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ProjectProposalEvent" (id, name) FROM stdin;
0	Updated Main Project Proposal
1	Updated Expense
2	Updated Program Design
3	Deleted Expense
4	Deleted Program Design
\.


--
-- Data for Name: RateType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "RateType" (id, name) FROM stdin;
0	Per hour
1	Per person
2	Per use
3	Per person, per use
4	Per Dominique
\.


--
-- Data for Name: VenueSize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "VenueSize" (id, name) FROM stdin;
0	Small
1	Mediume
2	Large
3	Lian Sized
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account (idnumber, email, type, password, salt, firstname, middlename, lastname, contactnumber, privatekey, publickey, path_profilepicture, datecreated, datemodified) FROM stdin;
11445955	juliano_laguio@dlsu.edu.ph	1	$2a$06$Niw1t/NhB9ZvjVZxxol8Mei.HuSzUGbsr2x/5gdMajyJXwRhpgfBW	$2a$06$Niw1t/NhB9ZvjVZxxol8Me	Lian	Blanco	Laguio	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\nwgXZLPlVyHxGuufO9QIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
11445954	markus_flores@dlsu.edu.ph	1	$2a$06$AZvg0tEXgmkLvnWxC2qpOOOYHANIRwriIeTehoPUolJtPsMta6oNO	$2a$06$AZvg0tEXgmkLvnWxC2qpOO	Markus	\N	Flores	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\npmy+d4D7v1WgUb79LwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
11445953	dominique_dagunton@dlsu.edu.ph	1	$2a$06$YqSuH8fkts4LK/K2zsbnKuqLtt2NFF25W6DbQIgMJYqqTPKCh.P3u	$2a$06$YqSuH8fkts4LK/K2zsbnKu	Dominique	\N	Dagunton	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCn04c01GwNuiVOY2ggQjOPTsxgXGC/FFbmXvoCGGAm+M3sJnVh\n2s/Qqb/QlvzAZueznA06AeaoAVXpHCstdN/O0wOU+9j2B/VQtVangWJyTsf2Nomq\nKjynJyeobwqWyuuJvxpoV58XUkw9ojcf2vQxt7MDxq8uGXNfMWFpYf0oIQIDAQAB\nAoGBAKeWj5mt1gkPLVnN4pj0AtDEe0pudR3ajbyWc0nMVZgVNGzxKp6BBqz0FduS\nKutm11GAL6URaOe0Dbouqt9FqocW2R50zDEL/mdkDRjXK1wyBQUjfIIahDtkR0Ej\nwx64R01yB5zGIrysmG9HgwhUXRsItUCC+as3LFnN2A3DrSjRAkEA81ls8OBCkiYd\nnjxaIY/gZNYjnWnfL4B613qSB3Vt0ShPRXKZ7So0BLCt3oNHfIVCobYXS7SL9kFJ\n+X0uOLo+gwJBALCNBEQynm4Q91cs1yURQRODi88tkldbH4aSK1AUdD1phILuFN4G\n6PhPzKmkKuSxv7MlHbRxGoWd4vukuLqoPYsCQC4+YitsEnp/b8VwJpiWJMhEwUPa\nqKT4P1/PVQzBzfqfNGE4I/QjvvrdME1GmUEaec0NM2QZjTdgtNQKa8wv6E0CQHdS\nR1DkOSlAdDpJxvp5Z9cNb/9M2HwLzQnBXl6YBFvBJdrrl9TbLLcuD6+TkZ3Q+DPW\nYPYj/v3RUKgskuEsdbMCQQCWW277qGp5CqmYzb6DCDkZEY08miojdHqiebK2bfrN\n5a4o1xkYuqzLS26OUJUSHyeWaERiq/J+CukFK78ML4Bz\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCn04c01GwNuiVOY2ggQjOPTsxg\nXGC/FFbmXvoCGGAm+M3sJnVh2s/Qqb/QlvzAZueznA06AeaoAVXpHCstdN/O0wOU\n+9j2B/VQtVangWJyTsf2NomqKjynJyeobwqWyuuJvxpoV58XUkw9ojcf2vQxt7MD\nxq8uGXNfMWFpYf0oIQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
11445952	neil_capistrano@dlsu.edu.ph	1	$2a$06$R70/ypbQ5phS95yZ6mPfrem1up8COY5OIhOa.Hp5t4Kmbyff5coam	$2a$06$R70/ypbQ5phS95yZ6mPfre	Neil	\N	Capistrano	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\nmTuU9jnyflD7mRlopQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
1111111	org_pres@dlsu.edu.ph	1	$2a$06$OtgbC24Rkat3NQDxecsmf.scXS.izIIsU/Ztk0jaGTS.K3.yxUe96	$2a$06$OtgbC24Rkat3NQDxecsmf.	Organization	\N	President	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\n+6oAoC4KMw6ZSBJfvwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
2222222	org_vp@dlsu.edu.ph	1	$2a$06$NCckuM8S2tR9zAriRK1.YuN/40i/ktHMAF2wanBO6Iz0zxU3BNq7.	$2a$06$NCckuM8S2tR9zAriRK1.Yu	Organization	\N	VP - Finance	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\nUgY0Yfen0N0vn+n4qwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
3333333	org_avp@dlsu.edu.ph	1	$2a$06$bruwBmNEVuByEsLkS0A5P.YsapDjo/9NMWFe1SO1toFSqUdrCfOqS	$2a$06$bruwBmNEVuByEsLkS0A5P.	Organization	\N	AVP - Finance	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\nfZibfHtWczJ3qtPsVwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
4444444	faculty_adviser1@dlsu.edu.ph	2	$2a$06$WhqKV7aaMLU6ACJubJNFIutOCx0MvrAmK4UWZWD67POvAkB/.N8Ui	$2a$06$WhqKV7aaMLU6ACJubJNFIu	Faculty	\N	Adviser	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCct6871QS2qtDxi5T12eSk/znmDFDIuLH1Q2V3owXqV7WldLso\nDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHEGe1n6litU/6CUnKUjlKEF9nw\nB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIlNxDPm6J/sYxt8ymirQIDAQAB\nAoGAZi/LfjsHCMjW1zlJlwlN8lxNd3h+UHNF7oPUrK7LE6O/WLSFuLfj8BHbqg6v\n5qjDsStEL6aPXuPYIPQF2uafQXwU9WSG7Iw4fybkOachHtEhxZB4KUSxVKqJynqA\nyzBSG8rAU7OOJr9dRUlVt8vIw6KXzol4A6ZQ8CH2BdAzuo0CQQDaRDWGOp4nLAV9\nMlVwM2QvHSJifS40F77VC7v6FMrqdp/GXXHtXxqltyp+5BZfkn2WldzcbOD7Gnj7\nG20l7rz7AkEAt8+DJlk3BpHDoi3Zpy4V+z6RNQgP+IyQ5eVksUethyV8mhs5kSzs\nIXpbKCIw+FpPiXfWf9noUqkwHvKw3FE+dwJAT0OmDHENLjyWYbj9vhlrsJBsBEhh\nlxlofAYe5drXNf6OV4Nn9EQtcTDrhdlfJqYUZbNW2dXQfmBGvypeoP/qMQJBAJg1\n0MbqzfQ0tKoSCdC1CyLYtuoRWRhbXonhobZkQsBNPJdowA0GBCvc5KuhVKf0MTUG\n9as9yXLaA609D1QCOxUCQD/rjvaV80gcG1AXJFc6y9w13hYUCpfBRATBHvoz3pAN\nwYsx9+22oRsrfmBQFuxo0o7Z1u+RJC7S5bRkKTL89Uc=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCct6871QS2qtDxi5T12eSk/znm\nDFDIuLH1Q2V3owXqV7WldLsoDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHE\nGe1n6litU/6CUnKUjlKEF9nwB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIl\nNxDPm6J/sYxt8ymirQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
5555555	docu_vp@dlsu.edu.ph	1	$2a$06$dLrTXFz7V0d6pOzh1ast5O0vqGOt68pwX6tmj9ZwPHSgU0qGu6Bke	$2a$06$dLrTXFz7V0d6pOzh1ast5O	Organization	\N	VP - Docu	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/K3G9u1nV2qd7k3lfCoRCKbcG\ntVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9dMMVuozDgfLn7dxe+O3TjI1g\nCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMtC5Baj3ihb9Y0RKKhgQIDAQAB\nAoGAc8jXJPmaJQlVhcgqM+nR192NbwcSUU+7MyX12yv+aKs//vvZHb7xAOPRrLbR\n0ThJ5RCrK4Jp0FiKI2Vzz5f7Zxdhvuwl6wYhcMZ8zk42fX8bzUF1uBjPsRk84gWK\n7I3faSvXqeuEiDNjXkjKfIMWyBL//vUowl7dc4rRiZHew1UCQQC473GHpVn9WRg7\nI36Ts6QGJVB6/AgZaBSwatj0eXSJLOToILxIjmtf/oe9j8Pfx9VoxGvuuxikrjJu\nX83xxk5TAkEAsxNzrImX4Z2xV+cg2xVDG/ojMhhsGRrJk9HF65UZoRX3KNyY/SlI\n3BZ99MayvTsTgxv6bvMaXnbjrCgNr6rOWwJBAJWjCNWc8WeRQ432dmDEph9i6e/Z\nJiSIltT4X3vRGn40GTPJ6Q88TZ1qsiKrxO25H/CZnkuYj6QQXzX3xweuUYkCQG4o\niiDaJ2cvtVdoo8qBgt3j+uCnK2AqHVRkV8c62iBAveESCr65NcvFvkfkLzG+9JrT\njDPSMidoJVfS79BfVz8CQBMKt18LgvWQsd76NUPgnFDWkS8O5h7kIJrU3nHuKDjT\nBZcLymoRZJvM/52CSshJ3iJ/80HDD/3DEN2KhMlnBpc=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/\nK3G9u1nV2qd7k3lfCoRCKbcGtVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9\ndMMVuozDgfLn7dxe+O3TjI1gCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMt\nC5Baj3ihb9Y0RKKhgQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
6666666	aps_vc@dlsu.edu.ph	1	$2a$06$GtzBH4vy1XzrcEfCNaOP8udTygSt8WGUhKD0XopCaRVH11rP.OSwO	$2a$06$GtzBH4vy1XzrcEfCNaOP8u	CSO	\N	VC - APS	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDS96X7dtaSFpn9k/7mo17P/Wwz+kK2pTbveE105mCkPA2OHVSc\n9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3KURL0ImjPDLg99TN+KncSz9Xp\n33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31KjxmbyR7gNI+iN7eSxNKbwIDAQAB\nAoGBAM079tFnjt6X9j7mlvewvzAADh+SuwwMNiFJG7E53ZJoiZdTmVkJByFSzLSp\n5SovSnGxQBuqrRC7KtBEYGoicmxSWrPa28YstZw3VyK5zay9wWuyogHyx535bUuI\ngIu2rkGqCnlVO93PEPHZisCN3DWnxSmrwSleJXLyXEebW9ThAkEA/EmCw3zyeQGs\n05i8RI92q7gumnvbVrBrf2i3SEPA+4H63Asg/NU9hDrWyNS0+MiU3/ov7N5h/7v4\nkNwAteKkVQJBANYSdzuL8rDS8vN78l8xT0qFnHqNg777yR28RFAwiBUCAwOYQG2f\ng8MD1g1l3Nzu7riewIDZXE5CCSlnEE4717MCQHjv5DdB1hobq3VjahyTiReYGv8D\nEInl2CIjWHjTwdbO4CpLS2zn661PZ1auYHJB9NvJWt/5WpD00preW5jVJGECQDio\n1ooaNnf6vXcYfUQYxwXQa2Q8hHxOJCMMq4AV+E6nI6kV6SeaqsM5BrSxG04Wp3SS\nAB2aakYEUGx27OfoCuUCQQDqnjl4xK+d7yMpfz58gGOQIuKgPQlSFx7BDlBBcX46\nPeRqcg6LDDmiTQeAW0N8ywoyAsTe8lLyomiujzoa0nNC\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDS96X7dtaSFpn9k/7mo17P/Wwz\n+kK2pTbveE105mCkPA2OHVSc9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3K\nURL0ImjPDLg99TN+KncSz9Xp33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31Kjxm\nbyR7gNI+iN7eSxNKbwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
7777777	aps_avc@dlsu.edu.ph	1	$2a$06$Vq7pkWgJlzrnrajoJ20MHOyEnJwdXYcqsUhVGK8KpN.RC9xZue7Ey	$2a$06$Vq7pkWgJlzrnrajoJ20MHO	CSO	\N	AVC - APS	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCOipOmH7ymZy3hQ41GlpFn6bgNPtEuQmvSDnZWbkfC0HWG7ho5\nuqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR9G+81YH6T8Qp8MyaN/5uggc6\nA7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzqtiKPUEpbCtFuQc+SUQIDAQAB\nAoGANbnp2Q3RT29IjcWmdFrAR8iCRQvOUH9coHovBHjgt39XLRqF7Ah9qmQl5XjB\nYyO68OkwCjylKx2M4AFFSnBPPeWC4N4e3hok/82rtyhzUkL6TmSNmY0utqjdhC7f\nQFgRutu6mcyi4kRIiVgr68ZSOioQcELoct1T8vTFJqfUj5kCQQDFEKgnnAJaVTrF\nz9yVH5SNiEk683nqI2zHI4paeq48MRyKPb9Wtv56zmKzY3lZ+X9eflYDd763kA6T\n7oG4MHSjAkEAuSuR7X7j53ELX02QqDyXVSScostkIDUJGUDA+WiVirEkA54Jh+gX\nDmGJZlA3wfEvZN1/6lp/8ywWW/tIw0rYewJAX0WCRkQCTzHNTD0F44J1C0fMP5fe\nZPfjaxMfnEabXbZQmfToQEAQH8cPqLJ6xKj+jux9IQgPSCd5JMO2KxoiCQJAKpRI\nRBJvmaK2+L0/TFBShDOdCRo39ef8JaBsP227JV9CZsqKaoQF+TqYe7xqdeBeA5Wj\nemJBFcvHgHMx8iZdzQJBAMAa4CCAqM8FIlF50LMi/Mh07RVL7bpGTTZNgNmyoj3S\nWo4x/9CFpNLrR3Za7Q4Vxmb8DGdfJIgb9fu7FGMf97I=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOipOmH7ymZy3hQ41GlpFn6bgN\nPtEuQmvSDnZWbkfC0HWG7ho5uqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR\n9G+81YH6T8Qp8MyaN/5uggc6A7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzq\ntiKPUEpbCtFuQc+SUQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
8888888	pnp_avc@dlsu.edu.ph	1	$2a$06$OmgFAcGtk92TWbGH7K80cuYBhd0pKKkn5.fKYLrmCE20B25L9kRti	$2a$06$OmgFAcGtk92TWbGH7K80cu	CSO	\N	AVP - PNP	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQChUp/jlMxfxNpHoOrGA5DaT+2yfWLbXwM+PApszBLX74I8oRne\nK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+N0HVnjGXoiFrQ3H4ATKr7hiO\nKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG1qclxQml4ztiHAcgEQIDAQAB\nAoGAQsoPckx/lMLOUEt6B8MgLJJc6cHptMMQd6qp8kNHJel+NRXJvObALPy1srx9\neKLLq4IwNLj8VuNLqAkAkLsqCbJ9Es0OVcD4Ubx+oWy6mF+5Os8o+zvA/VaL9yM3\nMquCHgepg+NnjKmP8//6/u/DCVNix+NENRW6VCxpwJlVTTECQQDNH8PnP5ppUQed\nAXeWOWR7dSCVAoYIhyAQt8Hgu9a1UsXs9TG/1zVZNqP1mLHR8GdShD0mVozI8MED\nFYYQfWeVAkEAyVW4Hh/jJZKrgYWa+Ypi314E8VJkqrEmZt9HrmwHaI3BRv02Jldk\nSoJJvjmJxfkZaoDZXogD+AlKGy70bKAHjQJAItkosRrPIuFPR889/9mURp0pgedB\n2iUKv4xYddOzsG51jcJCR3NKbvOne0wLubz78LrioKbHmEO+psV7V0XW2QJAa9Id\nFPzsr115vZZoZUUIKCj4qqf+Qy81qpfeknlGCmcH39WQ3z2j9wcJKPc1YjFBvDie\nsDJVNcr7xc0Clv2orQJAch33cTkbl1v+TvSKyXUJhCv5hj8OMSFQKy2YRHsS0Yis\nW4PuwQiPdp1Xt33nDD31qVfZhcpTWb5HO9yJXGP9Dw==\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChUp/jlMxfxNpHoOrGA5DaT+2y\nfWLbXwM+PApszBLX74I8oRneK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+\nN0HVnjGXoiFrQ3H4ATKr7hiOKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG\n1qclxQml4ztiHAcgEQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
9999999	amt_vc@dlsu.edu.ph	1	$2a$06$GXHA.PwgLX70gWq3/y6vaOlZJcqYDpVMyjfxWVNR27LQcZRAkIES6	$2a$06$GXHA.PwgLX70gWq3/y6vaO	CSO	\N	VC - AMT	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXgIBAAKBgQDC1X8I3fweNqM3ah6SQA6f0zx8l00xgpEOByevUeWqXd1Ftp7+\nqPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/4dm6pR4pnw09lJ0E0Gtl/2aV\nJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUmJES+qmH3K7QToeN4yQIDAQAB\nAoGBAJzOy8FNOD7w5ogRBq3alGqZzlLQSzaPyUMrCwuVtGxbw1z6UBjR1S6pcRg4\nuY5Sfs6UfJMeaScRdronJ5L0BRWQ+lb/iCo+NGO9zZ36QNJbjD9iMtKneSgKkLcW\n8NW0VBsODMH9kgihzTwpB3ZoLh8wlKPJcOzuGX/1p2p5LnIBAkEA4+ac+byWeP8a\nTu8oHVhc6SUbQGIzenMxXdQOjoyUwmxnbGy1nvou210vwb/ZaUKkDeDh4U/ZwEE0\n0sAW4oE9qQJBANrbK+VZ9z89p/3nOLZW+EZUzxj4TVExHWuBGwILLSVfPv+xCNfH\nmL63XjlRl66wDv1m5lFbsrmU6V+RBl0+FiECQGLaZh6hYbeMF9JDRGguKubqNH7h\n2ah0jOZBFCta6S/IK7hJEyKpLGf0bMGiwOA6isSGVhQQOch9wDbmIUcQfjkCQQDF\nK33RhArnM8H8Umrag2Hr4w4tPc5SXoBV0Rum7LDAoZ2dOD5yQEURVRwTYbnYzI7E\npwbKt2U+IrVZvstQB9ZhAkEAvAIe2B8spxnFDG0KIUxsd9H5HUidfiqHNQ5Vd7Uc\nNP4KPvDCOkN/W7llKwUwYjyqBtYasC9/Vbkm2VyLY67V7g==\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC1X8I3fweNqM3ah6SQA6f0zx8\nl00xgpEOByevUeWqXd1Ftp7+qPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/\n4dm6pR4pnw09lJ0E0Gtl/2aVJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUm\nJES+qmH3K7QToeN4yQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
20111111	john.lingatong@dlsu.edu.ph	3	$2a$06$1oxNkrd2r883ZvbI4z.FOeSFLcPS1ebR1lp0f1o9IBtMzHUv84pZm	$2a$06$1oxNkrd2r883ZvbI4z.FOe	John	\N	Lingatong	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCIqhYRfVFMwLhS/WPMcmxtKfRWgGJYmmuqCl6pO/CiaIp3ThmH\nts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3LZQunSjMuNGk8xkAGPFGu3im\n2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiGy2FUn6BFoW7mun7GGwIDAQAB\nAoGAN6gdKK5Cp+Fsr8+mDyMiaSrG6VuLsc3hvvROLNnOXDX6/i9+Ujju/KkYTERz\nzVKkMMKFblynROw+Z/fbGb6QXf0rTOnKbkQieK8YdNEd68J1BWhbD+UOrz9lhEBm\n0uMS41anqSGaAP2tFevVnl9/8U/pSmc80wXqDpH5cHBnnoECQQDOXZDonw6/GNn8\niWeDvWXG07zVGntKNCDe3RyrQZtYfbUKW2OwaAqITDMfV5Kr2i1X8xa8xDIEL2wm\nKsSKrfa7AkEAqYjZ9SlhBwLqOOeTnC6SR4TNn2KtBDQoNKgmMq+0d2nPeX/USiZw\nuAVpAdmVhzQS2zYyL6ebUfCHQw8qKyJoIQJBAKnTjEYzZ2JSJEpUFXDv84rtgw/o\nrB+DyK0/T7GL2zi2sr8kOGTbKhfChau8WMK+WORw83xDBVo2YI0EUxxBT7MCQFi/\nRfGblqo38WqWd2QD0RlVQNqVqiKQNxfRiiVwaxUzs6NTskqastjyJBUO1MKxFMni\nJgViROFw+y20i4uG+GECQBJ4/YRtaJrxMInKJa7bILbxMm0XMJXsiYvwtrhZwPVl\n2/F88VroQYVzIsUYOYK3vg6ldYHMQgEPhdplhc/vZpY=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCIqhYRfVFMwLhS/WPMcmxtKfRW\ngGJYmmuqCl6pO/CiaIp3ThmHts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3\nLZQunSjMuNGk8xkAGPFGu3im2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiG\ny2FUn6BFoW7mun7GGwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
20111112	nelca.balisado_villarin@dlsu.edu.ph	4	$2a$06$2lbynKLGqAo1n7oq9q9tOuuOgK6178/V771nJGti7hbWQ8AgtnbmG	$2a$06$2lbynKLGqAo1n7oq9q9tOu	Nelca	\N	Balisado-Villarin	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQCVHtq2eH91z0KzdE8k0Aai7F/QtKcl4cxhQJwUgu7lRJRXqRGQ\nPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVTZAZK3k8IPAYPsgy2vPaRwC/B\nTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCICdCtimFkHk1bDfKAhQIDAQAB\nAoGALU4FduCfIOTKSAkzLmUBTyhvZ9Iq4ih61qUxhk3NVNyEESntixxKcyTGT1lK\nBQS50F3/nSVc+8M3CsrTr4jVqZ80llON+lNr935mnzBJOqUXrTlbI7KJMm2qRch8\nhK1VxsaW8euABl/Jd+WDWwArYd1lfQbGHrwlcvzzz1hy9hUCQQDxeAzpdNsFufho\nGRf4KwHA4QW2mY5xmwyEGpc/6zFgyvsRqmVNooU5C3SZE7AZvcPriGWKAIrBPsXj\nWD0Sqz5rAkEAnhghYkbkbhugY762c4I+N+4slcbwjwWp9fRJvw9ljUIptY4eNPp9\nNzWnOB/8G6QBc9zjJf2a9WnBXSkH3SMYzwJBAKzgDh52EvielEGy9X4vDCpS8Awz\nE9Ax+Vv6zZ5tfASYTffvzmcum8KjeO6/May8N7BBDrEmgjCoCHUjj1X2U9ECQQCT\nY3XENMmEKbdnJobcu2EcLa1dWaIuBJ7GkaArQsRvZG6UN9HLnHgef6PNPGyCrG06\nQoV2hq/v+k9udfFB5hWbAkAdjPOT7CZ2i2kYNQLWADlX/b+o4bo4Jw51rPSty+r/\nssySvgGl9ggP11vrORaMIa/domqWw7ONL48qTM6TW//v\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVHtq2eH91z0KzdE8k0Aai7F/Q\ntKcl4cxhQJwUgu7lRJRXqRGQPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVT\nZAZK3k8IPAYPsgy2vPaRwC/BTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCI\nCdCtimFkHk1bDfKAhQIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
20111113	michael_broughton@dlsu.edu.ph	5	$2a$06$0yDccDpzanqaZZmBtGym.eLBSR4p.lAteGhvOoWjXbyejUgB3/2F6	$2a$06$0yDccDpzanqaZZmBtGym.e	Michael	\N	Broughton	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICWwIBAAKBgQCDMPPM2aRhI/BbEV1YTNKV1e0JfBoWVJj3Z24izrnSk0G3EItV\nYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oMiOeTzCjJQ/a9mel0exGk/1t2\nfz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm3/xyb6TWONUr0/rn1QIDAQAB\nAoGAQPfSFIVHkU+h7QdpaZwJwWgCjermZF6arhKLiTNE9NI1/fl0duGxh+IQOS+R\njA28M6LahVDCAeo9jwVD3Yxu/V7C4jRQCO2h89OEbBUUMw2Rz9+BBxqFeQLuMPLL\ncGOltN5FPh0VTJ8/7SRJrh7GByV9U/rrRICPMbpQ4PRZagECQQDXeeBbBYKn/Fay\n1AXeTVtoceUNdQE2RPUNxcTVuvvvEY46fTBrHqc1JuVzu/ms+nkOrSaJnlNyDW0u\nF2v6QGuBAkEAm90rqDa5rPUqd+R+YFpiHbMaYmvOJSnBhTMPzj59XpcsH10G+5c/\noSIS7PPMoI0efN7K/WwgZV/MeuC+4uo2VQJAZWW85hhZu6NLSSvs9weAFE5Ec2i0\nAU3B45FFZy5uj7m7LFrtBfuOw7xiDWxPuc7EWNuyXuBadDlNP3tWHJVkAQJADdHv\nlAu+LPLUICtXdU2uU3nVBhMPBUaNjTT42s25qhB3bhR+kQJZNv1hdjcr1rSMln/e\nudfDi5mR9PdGlbI0vQJAA3H1Jo2Y7rgFmUbH1DVSAY9bq/VcQGY38RAMH2ZhnhAb\nZfcWDwvDmQo1dVyyGo2SuOkhkGwvv6zjAy5jj0jWiA==\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDMPPM2aRhI/BbEV1YTNKV1e0J\nfBoWVJj3Z24izrnSk0G3EItVYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oM\niOeTzCjJQ/a9mel0exGk/1t2fz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm\n3/xyb6TWONUr0/rn1QIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
20111114	raymundo.suplido@dlsu.edu.ph	6	$2a$06$y2oVjnPjSf9rgt3pTaJqweObVTjBaKO1AWirkxQVPRXLpisQ.9wIG	$2a$06$y2oVjnPjSf9rgt3pTaJqwe	Raymundo	\N	Suplido	+63 9228474849	-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQC30FZyZj8mXFG3+PhdCjUuq3XZA/tgETJF2MWykVDA9PtGHBUp\nGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+8qfMvku8z5djxon9iFBdboy2\n0z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmVO19bxmutmUVCreXNlwIDAQAB\nAoGAeH0RXXXWaT/UtUJ3Ew3Q5KGx4yowCb3b9Vrt5GpKw+ESINfhqwonp704SBLH\nH/R0JTryyC5Sk2A6K7pfqonBoT2it9DmeRcbHAeuIR4j7ktee0PYySlC7tJkDCwT\nxIjHNR8ERKJkLE5rbVSSiOFJm0+6t9/0RY8nK2jaPBclKLkCQQD6m/LsAkWSYMy4\nyvcclKmJas1C4drQ0UMmNKyVYnio07tz53pomawgunnxCM7jkAa0HCV7l1cwF+ld\nEdtPdLf1AkEAu8SPoEc666cgrOi5zDw0Mh38nRUBDSltZx9MtoAK1vcjoKs0v73u\nRb29eVQUjjaz7+7uBqKONjOSXmJ8zshT2wJAKQIDyiLFB6LXXRW5QfABnf7f/6W9\njJXxivrrkrY+UEH1Vo32Nc+PnvtkoNB0KkCTGD3S1Fp7Zd9DzHrzjBjpUQJAdE02\nrQ8Rpr75FUB9PMyZg+Vg/6bv5MghNHuFl5DNpgKj9bO104IAIQB6aLk0ljW51EaI\n9mEfduEQqxeTuL0KewJBAL1hayWIehvj1zGvJYmyc77IwQ2BFgdSw+b44ONE3Ocv\nQPioERQTABNTUF3gFSCPhpnzv0RTU1aNTASBWMgT8L8=\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC30FZyZj8mXFG3+PhdCjUuq3XZ\nA/tgETJF2MWykVDA9PtGHBUpGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+\n8qfMvku8z5djxon9iFBdboy20z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmV\nO19bxmutmUVCreXNlwIDAQAB\n-----END PUBLIC KEY-----	\N	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08
\.


--
-- Data for Name: accounttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY accounttype (id, name) FROM stdin;
0	Admin
1	Student Account
2	Faculty Adviser Account
3	Director of S-Life
4	Dean of Student Affairs
5	Vice President for Lasallian Mission
6	President
\.


--
-- Data for Name: activityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY activityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Data for Name: activitynature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY activitynature (id, name) FROM stdin;
1	Academic
2	Special Interest
3	Departmental Initiative
4	Fundraising
5	Community Development
6	Organizational Development
7	Issue Advocacy
8	Lasallian Formation/Spiritual Growth
9	Outreach
\.


--
-- Data for Name: activitytype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY activitytype (id, name) FROM stdin;
0	Competition
1	Distribution
2	General Assembly
3	Seminar/Workshop
4	Publicity/Awareness Campaign
5	Meetings
6	Spiritual Activity
7	Recruitment/Audition
8	Recreation
9	Others
\.


--
-- Data for Name: amtactivityevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY amtactivityevaluation (activity, venue, equipment, materials, registration, timeend, activityexecution, hosts, facilitators, presentation, activities, organizationstandingpresentation, timestart, actualstarttime, actualendtime, anp, person1ea, person1loa, person1iitskoa, person1iomwm, person2ea, person2loa, person2iitskoa, person2iomwm, comments1, comments2, comments3, suggestions1, suggestions2, suggestions3, evaluator, status, datereserved, dateevaluated) FROM stdin;
\.


--
-- Data for Name: amtactivityevaluationstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY amtactivityevaluationstatus (id, name) FROM stdin;
0	Unassigned Evaluation
1	Pending Evaluation
3	Evaluated
\.


--
-- Data for Name: audit_Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "audit_Account" (id, responsible, affected, event, date, modifiedvalues) FROM stdin;
\.


--
-- Data for Name: audit_ProjectProposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "audit_ProjectProposal" (id, "GOSMActivity", sequence, event, "values", "dateCreated") FROM stdin;
\.


--
-- Data for Name: college; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY college (shortacronym, fullacronym, name) FROM stdin;
CED	BAGCED	Br. Andrew Gonzalez FSC College of Education
CCS	\N	College of Computer Studies
COL	\N	College of Law
CLA	\N	College of Liberal Arts
COS	\N	College of Science
COE	GCOE	Gokongwei College of Engineering
COB	RVRCOB	Ramon V. del Rosario College of Business
SOE	\N	School of Economics
\.


--
-- Data for Name: documentattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documentattachmentrequirement (id, name) FROM stdin;
0	Mechanics
1	Letter for use of Different Venues in Campus
2	Sample Design
3	Venue Reservation Ticket
4	Credentials of Speaker
5	Sample Publicity
6	Agenda
7	LSPO Form
8	Sample Application Form
9	Informal Quotation
10	Estimated List of Participants
11	Mechanics of Competition
\.


--
-- Data for Name: expensetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY expensetype (id, name) FROM stdin;
0	Others
1	Food Expense
2	Accomodation Expense
3	Venue Expense
4	Transport Expense
5	Honorarium
6	Cash Prize
7	Corruption Expense
\.


--
-- Data for Name: functionality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY functionality (id, name, category) FROM stdin;
211000	Submit GOSM	211
211001	Resubmit GOSM	211
104002	Evaluate GOSM	104
104003	Evaluate Project Proposal	104
108004	Evaluate Activity (AMT)	108
106005	View Publicity Material	106
109006	Submit Activity Research Form (ARF)	109
214007	Modify Organizational Structure	214
3008	Manage Organizations	3
211009	View Project Head Dashboard	211
211010	View APS Report	211
211011	Sign Project Proposal as Treasurer	211
211012	Sign Project Proposal as Documentations	211
104013	Sign Project Proposal Phase - 1	104
104014	Sign Project Proposal Phase - 2	104
211015	Force Sign Project Proposal	211
210016	Submit Publicity Material	210
106017	Evaluate Publicity Material	106
212018	Submit Financial Documents	212
\.


--
-- Data for Name: functionalitycategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY functionalitycategory (id, name, domain) FROM stdin;
0	Website Configuration	0
1	Organization Structure Management	0
2	Account Management	0
3	Manage Organizations List	0
104	Activity Processing	1
105	Finance	1
106	Publicity and Productions	1
107	Activity Monitoring	1
108	Activity Documentation	1
109	Organizational Research	1
210	Publicity/Creatives/Productions	2
211	Activity Processing & Documentations	2
212	Submit Financial Documents	2
213	Cancel Financial Documents	2
214	Organization Management	2
\.


--
-- Data for Name: functionalitydomain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY functionalitydomain (id, name) FROM stdin;
0	Administrative
1	CSO
2	Organization
3	Faculty Adviser
4	SLIFE
5	Accouning
\.


--
-- Data for Name: gosm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosm (id, termid, studentorganization, status, datecreated, datesubmitted, datestatusmodified, preparedby, statusmodifier, comments) FROM stdin;
100001	201720181	1	3	2017-11-23 16:14:07.618715+08	\N	2017-11-23 16:14:07.618715+08	\N	\N	\N
\.


--
-- Data for Name: gosmactivity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmactivity (id, gosm, sequence, goals, objectives, strategies, description, measures, targetdatestart, targetdateend, activitynature, activitytype, activitytypeotherdescription, isrelatedtoorganizationnature, budget, comments) FROM stdin;
1	100001	1	Goal Mo to	{Objectives,Mo,To}	Strategies Mo to	Descibe kita	Measure mo to :)	2017-09-06	2017-09-06	1	2	\N	f	999.99	\N
2	100001	2	Goal Mo to 2	{"Objectives 2","Mo 2","To 2"}	Strategies Mo to 2	Descibe kita 2	Measure mo to :) 2	2017-10-13	2017-10-14	1	2	\N	f	999.99	\N
3	100001	3	Approve this Activity	{"Approve this Activity"}	Approve this Activity	Approve this Activity	Approve this Activity	2017-11-06	2017-11-23	1	0	\N	t	1200.00	\N
4	100001	4	Pend this Activity	{"Pend this Activity"}	Pend this Activity	Pend this Activity	Pend this Activity	2017-12-12	2017-12-12	1	0	\N	t	1200.00	\N
5	100001	5	Deny this Activity	{"Deny this Activity"}	Deny this Activity	Deny this Activity	Deny this Activity	2017-12-13	2017-12-30	1	0	\N	t	1200.00	\N
\.


--
-- Data for Name: gosmactivityprojecthead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmactivityprojecthead (idnumber, activityid) FROM stdin;
3333333	1
3333333	3
3333333	4
3333333	5
\.


--
-- Data for Name: gosmstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmstatus (id, name) FROM stdin;
1	Created
2	For Approval
3	Approved
4	Pending
5	Denied
\.


--
-- Data for Name: organizationaccesscontrol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationaccesscontrol (role, functionality, isallowed) FROM stdin;
0	104002	t
1	104002	t
2	104002	t
3	104002	t
4	104002	t
11	104003	t
12	104003	t
13	104003	t
8	108004	t
9	108004	t
10	108004	t
20	109006	t
21	109006	t
22	109006	t
0	214007	t
1	3008	t
2	3008	t
3	3008	t
4	3008	t
5	3008	t
21	3008	t
13	104013	t
12	104014	t
17	106017	t
18	106017	t
19	106017	t
10023	211000	t
10023	214007	t
10023	211009	t
10023	211010	t
10023	211015	t
10024	211009	t
10024	211010	t
10025	211009	t
10025	211010	t
10026	211009	t
10026	211010	t
10027	211009	t
10027	211010	t
10027	211012	t
10028	211009	t
10028	211010	t
10029	211009	t
10029	211010	t
10029	211011	t
10029	212018	t
10030	211009	t
10030	211010	t
10030	212018	t
20031	211000	t
20031	214007	t
20031	211009	t
20031	211010	t
20031	211015	t
20032	211009	t
20032	211010	t
20033	211009	t
20033	211010	t
20034	211009	t
20034	211010	t
20035	211009	t
20035	211010	t
20035	211012	t
20036	211009	t
20036	211010	t
20037	211009	t
20037	211010	t
20037	211011	t
20037	212018	t
20038	211009	t
20038	211010	t
20038	212018	t
30039	211000	t
30039	214007	t
30039	211009	t
30039	211010	t
30039	211015	t
30040	211009	t
30040	211010	t
30041	211009	t
30041	211010	t
30042	211009	t
30042	211010	t
30043	211009	t
30043	211010	t
30043	211012	t
30044	211009	t
30044	211010	t
30045	211009	t
30045	211010	t
30045	211011	t
30045	212018	t
30046	211009	t
30046	211010	t
30046	212018	t
40047	211000	t
40047	214007	t
40047	211009	t
40047	211010	t
40047	211015	t
40048	211009	t
40048	211010	t
40049	211009	t
40049	211010	t
40050	211009	t
40050	211010	t
40051	211009	t
40051	211010	t
40051	211012	t
40052	211009	t
40052	211010	t
40053	211009	t
40053	211010	t
40053	211011	t
40053	212018	t
40054	211009	t
40054	211010	t
40054	212018	t
50055	211000	t
50055	214007	t
50055	211009	t
50055	211010	t
50055	211015	t
50056	211009	t
50056	211010	t
50057	211009	t
50057	211010	t
50058	211009	t
50058	211010	t
50059	211009	t
50059	211010	t
50059	211012	t
50060	211009	t
50060	211010	t
50061	211009	t
50061	211010	t
50061	211011	t
50061	212018	t
50062	211009	t
50062	211010	t
50062	212018	t
60063	211000	t
60063	214007	t
60063	211009	t
60063	211010	t
60063	211015	t
60064	211009	t
60064	211010	t
60065	211009	t
60065	211010	t
60066	211009	t
60066	211010	t
60067	211009	t
60067	211010	t
60067	211012	t
60068	211009	t
60068	211010	t
60069	211009	t
60069	211010	t
60069	211011	t
60069	212018	t
60070	211009	t
60070	211010	t
60070	212018	t
70071	211000	t
70071	214007	t
70071	211009	t
70071	211010	t
70071	211015	t
70072	211009	t
70072	211010	t
70073	211009	t
70073	211010	t
70074	211009	t
70074	211010	t
70075	211009	t
70075	211010	t
70075	211012	t
70076	211009	t
70076	211010	t
70077	211009	t
70077	211010	t
70077	211011	t
70077	212018	t
70078	211009	t
70078	211010	t
70078	212018	t
80079	211000	t
80079	214007	t
80079	211009	t
80079	211010	t
80079	211015	t
80080	211009	t
80080	211010	t
80081	211009	t
80081	211010	t
80082	211009	t
80082	211010	t
80083	211009	t
80083	211010	t
80083	211012	t
80084	211009	t
80084	211010	t
80085	211009	t
80085	211010	t
80085	211011	t
80085	212018	t
80086	211009	t
80086	211010	t
80086	212018	t
90087	211000	t
90087	214007	t
90087	211009	t
90087	211010	t
90087	211015	t
90088	211009	t
90088	211010	t
90089	211009	t
90089	211010	t
90090	211009	t
90090	211010	t
90091	211009	t
90091	211010	t
90091	211012	t
90092	211009	t
90092	211010	t
90093	211009	t
90093	211010	t
90093	211011	t
90093	212018	t
90094	211009	t
90094	211010	t
90094	212018	t
100095	211000	t
100095	214007	t
100095	211009	t
100095	211010	t
100095	211015	t
100096	211009	t
100096	211010	t
100097	211009	t
100097	211010	t
100098	211009	t
100098	211010	t
100099	211009	t
100099	211010	t
100099	211012	t
100100	211009	t
100100	211010	t
100101	211009	t
100101	211010	t
100101	211011	t
100101	212018	t
100102	211009	t
100102	211010	t
100102	212018	t
110103	211000	t
110103	214007	t
110103	211009	t
110103	211010	t
110103	211015	t
110104	211009	t
110104	211010	t
110105	211009	t
110105	211010	t
110106	211009	t
110106	211010	t
110107	211009	t
110107	211010	t
110107	211012	t
110108	211009	t
110108	211010	t
110109	211009	t
110109	211010	t
110109	211011	t
110109	212018	t
110110	211009	t
110110	211010	t
110110	212018	t
120111	211000	t
120111	214007	t
120111	211009	t
120111	211010	t
120111	211015	t
120112	211009	t
120112	211010	t
120113	211009	t
120113	211010	t
120114	211009	t
120114	211010	t
120115	211009	t
120115	211010	t
120115	211012	t
120116	211009	t
120116	211010	t
120117	211009	t
120117	211010	t
120117	211011	t
120117	212018	t
120118	211009	t
120118	211010	t
120118	212018	t
130119	211000	t
130119	214007	t
130119	211009	t
130119	211010	t
130119	211015	t
130120	211009	t
130120	211010	t
130121	211009	t
130121	211010	t
130122	211009	t
130122	211010	t
130123	211009	t
130123	211010	t
130123	211012	t
130124	211009	t
130124	211010	t
130125	211009	t
130125	211010	t
130125	211011	t
130125	212018	t
130126	211009	t
130126	211010	t
130126	212018	t
140127	211000	t
140127	214007	t
140127	211009	t
140127	211010	t
140127	211015	t
140128	211009	t
140128	211010	t
140129	211009	t
140129	211010	t
140130	211009	t
140130	211010	t
140131	211009	t
140131	211010	t
140131	211012	t
140132	211009	t
140132	211010	t
140133	211009	t
140133	211010	t
140133	211011	t
140133	212018	t
140134	211009	t
140134	211010	t
140134	212018	t
150135	211000	t
150135	214007	t
150135	211009	t
150135	211010	t
150135	211015	t
150136	211009	t
150136	211010	t
150137	211009	t
150137	211010	t
150138	211009	t
150138	211010	t
150139	211009	t
150139	211010	t
150139	211012	t
150140	211009	t
150140	211010	t
150141	211009	t
150141	211010	t
150141	211011	t
150141	212018	t
150142	211009	t
150142	211010	t
150142	212018	t
160143	211000	t
160143	214007	t
160143	211009	t
160143	211010	t
160143	211015	t
160144	211009	t
160144	211010	t
160145	211009	t
160145	211010	t
160146	211009	t
160146	211010	t
160147	211009	t
160147	211010	t
160147	211012	t
160148	211009	t
160148	211010	t
160149	211009	t
160149	211010	t
160149	211011	t
160149	212018	t
160150	211009	t
160150	211010	t
160150	212018	t
170151	211000	t
170151	214007	t
170151	211009	t
170151	211010	t
170151	211015	t
170152	211009	t
170152	211010	t
170153	211009	t
170153	211010	t
170154	211009	t
170154	211010	t
170155	211009	t
170155	211010	t
170155	211012	t
170156	211009	t
170156	211010	t
170157	211009	t
170157	211010	t
170157	211011	t
170157	212018	t
170158	211009	t
170158	211010	t
170158	212018	t
180159	211000	t
180159	214007	t
180159	211009	t
180159	211010	t
180159	211015	t
180160	211009	t
180160	211010	t
180161	211009	t
180161	211010	t
180162	211009	t
180162	211010	t
180163	211009	t
180163	211010	t
180163	211012	t
180164	211009	t
180164	211010	t
180165	211009	t
180165	211010	t
180165	211011	t
180165	212018	t
180166	211009	t
180166	211010	t
180166	212018	t
190167	211000	t
190167	214007	t
190167	211009	t
190167	211010	t
190167	211015	t
190168	211009	t
190168	211010	t
190169	211009	t
190169	211010	t
190170	211009	t
190170	211010	t
190171	211009	t
190171	211010	t
190171	211012	t
190172	211009	t
190172	211010	t
190173	211009	t
190173	211010	t
190173	211011	t
190173	212018	t
190174	211009	t
190174	211010	t
190174	212018	t
200175	211000	t
200175	214007	t
200175	211009	t
200175	211010	t
200175	211015	t
200176	211009	t
200176	211010	t
200177	211009	t
200177	211010	t
200178	211009	t
200178	211010	t
200179	211009	t
200179	211010	t
200179	211012	t
200180	211009	t
200180	211010	t
200181	211009	t
200181	211010	t
200181	211011	t
200181	212018	t
200182	211009	t
200182	211010	t
200182	212018	t
210183	211000	t
210183	214007	t
210183	211009	t
210183	211010	t
210183	211015	t
210184	211009	t
210184	211010	t
210185	211009	t
210185	211010	t
210186	211009	t
210186	211010	t
210187	211009	t
210187	211010	t
210187	211012	t
210188	211009	t
210188	211010	t
210189	211009	t
210189	211010	t
210189	211011	t
210189	212018	t
210190	211009	t
210190	211010	t
210190	212018	t
220191	211000	t
220191	214007	t
220191	211009	t
220191	211010	t
220191	211015	t
220192	211009	t
220192	211010	t
220193	211009	t
220193	211010	t
220194	211009	t
220194	211010	t
220195	211009	t
220195	211010	t
220195	211012	t
220196	211009	t
220196	211010	t
220197	211009	t
220197	211010	t
220197	211011	t
220197	212018	t
220198	211009	t
220198	211010	t
220198	212018	t
230199	211000	t
230199	214007	t
230199	211009	t
230199	211010	t
230199	211015	t
230200	211009	t
230200	211010	t
230201	211009	t
230201	211010	t
230202	211009	t
230202	211010	t
230203	211009	t
230203	211010	t
230203	211012	t
230204	211009	t
230204	211010	t
230205	211009	t
230205	211010	t
230205	211011	t
230205	212018	t
230206	211009	t
230206	211010	t
230206	212018	t
240207	211000	t
240207	214007	t
240207	211009	t
240207	211010	t
240207	211015	t
240208	211009	t
240208	211010	t
240209	211009	t
240209	211010	t
240210	211009	t
240210	211010	t
240211	211009	t
240211	211010	t
240211	211012	t
240212	211009	t
240212	211010	t
240213	211009	t
240213	211010	t
240213	211011	t
240213	212018	t
240214	211009	t
240214	211010	t
240214	212018	t
250215	211000	t
250215	214007	t
250215	211009	t
250215	211010	t
250215	211015	t
250216	211009	t
250216	211010	t
250217	211009	t
250217	211010	t
250218	211009	t
250218	211010	t
250219	211009	t
250219	211010	t
250219	211012	t
250220	211009	t
250220	211010	t
250221	211009	t
250221	211010	t
250221	211011	t
250221	212018	t
250222	211009	t
250222	211010	t
250222	212018	t
260223	211000	t
260223	214007	t
260223	211009	t
260223	211010	t
260223	211015	t
260224	211009	t
260224	211010	t
260225	211009	t
260225	211010	t
260226	211009	t
260226	211010	t
260227	211009	t
260227	211010	t
260227	211012	t
260228	211009	t
260228	211010	t
260229	211009	t
260229	211010	t
260229	211011	t
260229	212018	t
260230	211009	t
260230	211010	t
260230	212018	t
270231	211000	t
270231	214007	t
270231	211009	t
270231	211010	t
270231	211015	t
270232	211009	t
270232	211010	t
270233	211009	t
270233	211010	t
270234	211009	t
270234	211010	t
270235	211009	t
270235	211010	t
270235	211012	t
270236	211009	t
270236	211010	t
270237	211009	t
270237	211010	t
270237	211011	t
270237	212018	t
270238	211009	t
270238	211010	t
270238	212018	t
280239	211000	t
280239	214007	t
280239	211009	t
280239	211010	t
280239	211015	t
280240	211009	t
280240	211010	t
280241	211009	t
280241	211010	t
280242	211009	t
280242	211010	t
280243	211009	t
280243	211010	t
280243	211012	t
280244	211009	t
280244	211010	t
280245	211009	t
280245	211010	t
280245	211011	t
280245	212018	t
280246	211009	t
280246	211010	t
280246	212018	t
290247	211000	t
290247	214007	t
290247	211009	t
290247	211010	t
290247	211015	t
290248	211009	t
290248	211010	t
290249	211009	t
290249	211010	t
290250	211009	t
290250	211010	t
290251	211009	t
290251	211010	t
290251	211012	t
290252	211009	t
290252	211010	t
290253	211009	t
290253	211010	t
290253	211011	t
290253	212018	t
290254	211009	t
290254	211010	t
290254	212018	t
300255	211000	t
300255	214007	t
300255	211009	t
300255	211010	t
300255	211015	t
300256	211009	t
300256	211010	t
300257	211009	t
300257	211010	t
300258	211009	t
300258	211010	t
300259	211009	t
300259	211010	t
300259	211012	t
300260	211009	t
300260	211010	t
300261	211009	t
300261	211010	t
300261	211011	t
300261	212018	t
300262	211009	t
300262	211010	t
300262	212018	t
310263	211000	t
310263	214007	t
310263	211009	t
310263	211010	t
310263	211015	t
310264	211009	t
310264	211010	t
310265	211009	t
310265	211010	t
310266	211009	t
310266	211010	t
310267	211009	t
310267	211010	t
310267	211012	t
310268	211009	t
310268	211010	t
310269	211009	t
310269	211010	t
310269	211011	t
310269	212018	t
310270	211009	t
310270	211010	t
310270	212018	t
320271	211000	t
320271	214007	t
320271	211009	t
320271	211010	t
320271	211015	t
320272	211009	t
320272	211010	t
320273	211009	t
320273	211010	t
320274	211009	t
320274	211010	t
320275	211009	t
320275	211010	t
320275	211012	t
320276	211009	t
320276	211010	t
320277	211009	t
320277	211010	t
320277	211011	t
320277	212018	t
320278	211009	t
320278	211010	t
320278	212018	t
330279	211000	t
330279	214007	t
330279	211009	t
330279	211010	t
330279	211015	t
330280	211009	t
330280	211010	t
330281	211009	t
330281	211010	t
330282	211009	t
330282	211010	t
330283	211009	t
330283	211010	t
330283	211012	t
330284	211009	t
330284	211010	t
330285	211009	t
330285	211010	t
330285	211011	t
330285	212018	t
330286	211009	t
330286	211010	t
330286	212018	t
340287	211000	t
340287	214007	t
340287	211009	t
340287	211010	t
340287	211015	t
340288	211009	t
340288	211010	t
340289	211009	t
340289	211010	t
340290	211009	t
340290	211010	t
340291	211009	t
340291	211010	t
340291	211012	t
340292	211009	t
340292	211010	t
340293	211009	t
340293	211010	t
340293	211011	t
340293	212018	t
340294	211009	t
340294	211010	t
340294	212018	t
350295	211000	t
350295	214007	t
350295	211009	t
350295	211010	t
350295	211015	t
350296	211009	t
350296	211010	t
350297	211009	t
350297	211010	t
350298	211009	t
350298	211010	t
350299	211009	t
350299	211010	t
350299	211012	t
350300	211009	t
350300	211010	t
350301	211009	t
350301	211010	t
350301	211011	t
350301	212018	t
350302	211009	t
350302	211010	t
350302	212018	t
360303	211000	t
360303	214007	t
360303	211009	t
360303	211010	t
360303	211015	t
360304	211009	t
360304	211010	t
360305	211009	t
360305	211010	t
360306	211009	t
360306	211010	t
360307	211009	t
360307	211010	t
360307	211012	t
360308	211009	t
360308	211010	t
360309	211009	t
360309	211010	t
360309	211011	t
360309	212018	t
360310	211009	t
360310	211010	t
360310	212018	t
370311	211000	t
370311	214007	t
370311	211009	t
370311	211010	t
370311	211015	t
370312	211009	t
370312	211010	t
370313	211009	t
370313	211010	t
370314	211009	t
370314	211010	t
370315	211009	t
370315	211010	t
370315	211012	t
370316	211009	t
370316	211010	t
370317	211009	t
370317	211010	t
370317	211011	t
370317	212018	t
370318	211009	t
370318	211010	t
370318	212018	t
380319	211000	t
380319	214007	t
380319	211009	t
380319	211010	t
380319	211015	t
380320	211009	t
380320	211010	t
380321	211009	t
380321	211010	t
380322	211009	t
380322	211010	t
380323	211009	t
380323	211010	t
380323	211012	t
380324	211009	t
380324	211010	t
380325	211009	t
380325	211010	t
380325	211011	t
380325	212018	t
380326	211009	t
380326	211010	t
380326	212018	t
\.


--
-- Data for Name: organizationcluster; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationcluster (id, name, acronym) FROM stdin;
1	Alliance of Science Organizations	ASO
2	Alliance of Special Interest and Socio-Civic Organizations	ASPIRE
3	College of Liberal Arts Professional Organizations	CAP12
4	Engineering Alliance Geared Towards Excellence	ENGAGE
5	Alliance of Professional Organizations of Business and Economics	PROBE
\.


--
-- Data for Name: organizationfacultyadviser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationfacultyadviser (id, organization, faculty, yearid) FROM stdin;
1	1	4444444	20172018
\.


--
-- Data for Name: organizationnature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationnature (id, name, acronym) FROM stdin;
1	Special Interest	SPIN
2	Professional Organization	PROF
3	Socio-civic and Religious	SCORE
4	Professional Organization Group	PROG
\.


--
-- Data for Name: organizationofficer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationofficer (idnumber, role, yearid, dateassigned) FROM stdin;
11445955	10	20172018	2017-11-23 16:14:07.618715+08
11445954	30039	20172018	2017-11-23 16:14:07.618715+08
11445954	20031	20172018	2017-11-23 16:14:07.618715+08
11445953	1	20172018	2017-11-23 16:14:07.618715+08
1111111	10023	20172018	2017-11-23 16:14:07.618715+08
2222222	10029	20172018	2017-11-23 16:14:07.618715+08
3333333	10026	20172018	2017-11-23 16:14:07.618715+08
5555555	10027	20172018	2017-11-23 16:14:07.618715+08
6666666	12	20172018	2017-11-23 16:14:07.618715+08
7777777	13	20172018	2017-11-23 16:14:07.618715+08
8888888	18	20172018	2017-11-23 16:14:07.618715+08
9999999	8	20172018	2017-11-23 16:14:07.618715+08
\.


--
-- Data for Name: organizationrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationrole (id, organization, sequence, name, rank, uniqueposition, masterrole, home_url) FROM stdin;
0	0	1	Chairperson	0	t	\N	\N
1	0	2	Executive Vice Chairperson for Internals	10	t	0	\N
2	0	3	Executive Vice Chairperson for Externals	10	t	0	\N
3	0	4	Executive Vice Chairperson for Activities and Documentation	10	t	0	\N
4	0	5	Executive Vice Chairperson for Finance	10	t	0	\N
5	0	6	Vice Chairperson for Activity Documentations and Management	20	t	2	\N
6	0	7	Associate Vice Chairperson for Activity Documentations and Management	30	f	5	\N
7	0	8	Associate for Activity Documentations and Management	40	f	6	\N
8	0	9	Vice Chairperson for Activity Monitoring Team	20	t	2	\N
9	0	10	Associate Vice Chairperson for Activity Monitoring Team	30	f	9	\N
10	0	11	Associate for Activity Monitoring Team	40	f	10	\N
11	0	12	Vice Chairperson for Activity Processing and Screening	20	t	2	\N
12	0	13	Associate Vice Chairperson for Activity Processing and Screening	30	f	11	\N
13	0	14	Associate Activity Processing and Screening	40	f	12	\N
14	0	15	Vice Chairperson for Finance	20	t	2	\N
15	0	16	Associate Vice Chairperson for Finance	30	f	14	\N
16	0	17	Associate for Finance	40	f	15	\N
17	0	18	Vice Chairperson for Publicity and Productions	20	t	3	\N
18	0	19	Associate Vice Chairperson for Publicity and Productions	30	f	18	\N
19	0	20	Associate for Publicity and Productions	40	f	19	\N
20	0	21	Vice Chairperson for Organizational Research and Analysis	20	t	2	\N
21	0	22	Associate Vice Chairperson for Organizational Research and Analysis	30	f	21	\N
22	0	23	Associate for Organizational Research and Analysis	40	f	22	\N
10023	1	1	President	0	t	\N	\N
10024	1	2	Executive Secretariat	10	t	10023	\N
10025	1	3	External Executive Vice President	10	t	10023	\N
10026	1	4	Internal Executive Vice President	10	t	10023	\N
10027	1	5	Vice President of Documentations	20	t	10024	\N
10028	1	6	Associate Vice President of Documentations	30	f	10027	\N
10029	1	7	Vice President of Finance	20	t	10026	/Organization/treasurer/dashboard
10030	1	8	Associate Vice President of Finance	30	f	10029	/Organization/treasurer/dashboard
20031	2	1	President	0	t	\N	\N
20032	2	2	Executive Secretariat	10	t	20031	\N
20033	2	3	External Executive Vice President	10	t	20031	\N
20034	2	4	Internal Executive Vice President	10	t	20031	\N
20035	2	5	Vice President of Documentations	20	t	20032	\N
20036	2	6	Associate Vice President of Documentations	30	f	20035	\N
20037	2	7	Vice President of Finance	20	t	20034	/Organization/treasurer/dashboard
20038	2	8	Associate Vice President of Finance	30	f	20037	/Organization/treasurer/dashboard
30039	3	1	President	0	t	\N	\N
30040	3	2	Executive Secretariat	10	t	30039	\N
30041	3	3	External Executive Vice President	10	t	30039	\N
30042	3	4	Internal Executive Vice President	10	t	30039	\N
30043	3	5	Vice President of Documentations	20	t	30040	\N
30044	3	6	Associate Vice President of Documentations	30	f	30043	\N
30045	3	7	Vice President of Finance	20	t	30042	/Organization/treasurer/dashboard
30046	3	8	Associate Vice President of Finance	30	f	30045	/Organization/treasurer/dashboard
40047	4	1	President	0	t	\N	\N
40048	4	2	Executive Secretariat	10	t	40047	\N
40049	4	3	External Executive Vice President	10	t	40047	\N
40050	4	4	Internal Executive Vice President	10	t	40047	\N
40051	4	5	Vice President of Documentations	20	t	40048	\N
40052	4	6	Associate Vice President of Documentations	30	f	40051	\N
40053	4	7	Vice President of Finance	20	t	40050	/Organization/treasurer/dashboard
40054	4	8	Associate Vice President of Finance	30	f	40053	/Organization/treasurer/dashboard
50055	5	1	President	0	t	\N	\N
50056	5	2	Executive Secretariat	10	t	50055	\N
50057	5	3	External Executive Vice President	10	t	50055	\N
50058	5	4	Internal Executive Vice President	10	t	50055	\N
50059	5	5	Vice President of Documentations	20	t	50056	\N
50060	5	6	Associate Vice President of Documentations	30	f	50059	\N
50061	5	7	Vice President of Finance	20	t	50058	/Organization/treasurer/dashboard
50062	5	8	Associate Vice President of Finance	30	f	50061	/Organization/treasurer/dashboard
60063	6	1	President	0	t	\N	\N
60064	6	2	Executive Secretariat	10	t	60063	\N
60065	6	3	External Executive Vice President	10	t	60063	\N
60066	6	4	Internal Executive Vice President	10	t	60063	\N
60067	6	5	Vice President of Documentations	20	t	60064	\N
60068	6	6	Associate Vice President of Documentations	30	f	60067	\N
60069	6	7	Vice President of Finance	20	t	60066	/Organization/treasurer/dashboard
60070	6	8	Associate Vice President of Finance	30	f	60069	/Organization/treasurer/dashboard
70071	7	1	President	0	t	\N	\N
70072	7	2	Executive Secretariat	10	t	70071	\N
70073	7	3	External Executive Vice President	10	t	70071	\N
70074	7	4	Internal Executive Vice President	10	t	70071	\N
70075	7	5	Vice President of Documentations	20	t	70072	\N
70076	7	6	Associate Vice President of Documentations	30	f	70075	\N
70077	7	7	Vice President of Finance	20	t	70074	/Organization/treasurer/dashboard
70078	7	8	Associate Vice President of Finance	30	f	70077	/Organization/treasurer/dashboard
80079	8	1	President	0	t	\N	\N
80080	8	2	Executive Secretariat	10	t	80079	\N
80081	8	3	External Executive Vice President	10	t	80079	\N
80082	8	4	Internal Executive Vice President	10	t	80079	\N
80083	8	5	Vice President of Documentations	20	t	80080	\N
80084	8	6	Associate Vice President of Documentations	30	f	80083	\N
80085	8	7	Vice President of Finance	20	t	80082	/Organization/treasurer/dashboard
80086	8	8	Associate Vice President of Finance	30	f	80085	/Organization/treasurer/dashboard
90087	9	1	President	0	t	\N	\N
90088	9	2	Executive Secretariat	10	t	90087	\N
90089	9	3	External Executive Vice President	10	t	90087	\N
90090	9	4	Internal Executive Vice President	10	t	90087	\N
90091	9	5	Vice President of Documentations	20	t	90088	\N
90092	9	6	Associate Vice President of Documentations	30	f	90091	\N
90093	9	7	Vice President of Finance	20	t	90090	/Organization/treasurer/dashboard
90094	9	8	Associate Vice President of Finance	30	f	90093	/Organization/treasurer/dashboard
100095	10	1	President	0	t	\N	\N
100096	10	2	Executive Secretariat	10	t	100095	\N
100097	10	3	External Executive Vice President	10	t	100095	\N
100098	10	4	Internal Executive Vice President	10	t	100095	\N
100099	10	5	Vice President of Documentations	20	t	100096	\N
100100	10	6	Associate Vice President of Documentations	30	f	100099	\N
100101	10	7	Vice President of Finance	20	t	100098	/Organization/treasurer/dashboard
100102	10	8	Associate Vice President of Finance	30	f	100101	/Organization/treasurer/dashboard
110103	11	1	President	0	t	\N	\N
110104	11	2	Executive Secretariat	10	t	110103	\N
110105	11	3	External Executive Vice President	10	t	110103	\N
110106	11	4	Internal Executive Vice President	10	t	110103	\N
110107	11	5	Vice President of Documentations	20	t	110104	\N
110108	11	6	Associate Vice President of Documentations	30	f	110107	\N
110109	11	7	Vice President of Finance	20	t	110106	/Organization/treasurer/dashboard
110110	11	8	Associate Vice President of Finance	30	f	110109	/Organization/treasurer/dashboard
120111	12	1	President	0	t	\N	\N
120112	12	2	Executive Secretariat	10	t	120111	\N
120113	12	3	External Executive Vice President	10	t	120111	\N
120114	12	4	Internal Executive Vice President	10	t	120111	\N
120115	12	5	Vice President of Documentations	20	t	120112	\N
120116	12	6	Associate Vice President of Documentations	30	f	120115	\N
120117	12	7	Vice President of Finance	20	t	120114	/Organization/treasurer/dashboard
120118	12	8	Associate Vice President of Finance	30	f	120117	/Organization/treasurer/dashboard
130119	13	1	President	0	t	\N	\N
130120	13	2	Executive Secretariat	10	t	130119	\N
130121	13	3	External Executive Vice President	10	t	130119	\N
130122	13	4	Internal Executive Vice President	10	t	130119	\N
130123	13	5	Vice President of Documentations	20	t	130120	\N
130124	13	6	Associate Vice President of Documentations	30	f	130123	\N
130125	13	7	Vice President of Finance	20	t	130122	/Organization/treasurer/dashboard
130126	13	8	Associate Vice President of Finance	30	f	130125	/Organization/treasurer/dashboard
140127	14	1	President	0	t	\N	\N
140128	14	2	Executive Secretariat	10	t	140127	\N
140129	14	3	External Executive Vice President	10	t	140127	\N
140130	14	4	Internal Executive Vice President	10	t	140127	\N
140131	14	5	Vice President of Documentations	20	t	140128	\N
140132	14	6	Associate Vice President of Documentations	30	f	140131	\N
140133	14	7	Vice President of Finance	20	t	140130	/Organization/treasurer/dashboard
140134	14	8	Associate Vice President of Finance	30	f	140133	/Organization/treasurer/dashboard
150135	15	1	President	0	t	\N	\N
150136	15	2	Executive Secretariat	10	t	150135	\N
150137	15	3	External Executive Vice President	10	t	150135	\N
150138	15	4	Internal Executive Vice President	10	t	150135	\N
150139	15	5	Vice President of Documentations	20	t	150136	\N
150140	15	6	Associate Vice President of Documentations	30	f	150139	\N
150141	15	7	Vice President of Finance	20	t	150138	/Organization/treasurer/dashboard
150142	15	8	Associate Vice President of Finance	30	f	150141	/Organization/treasurer/dashboard
160143	16	1	President	0	t	\N	\N
160144	16	2	Executive Secretariat	10	t	160143	\N
160145	16	3	External Executive Vice President	10	t	160143	\N
160146	16	4	Internal Executive Vice President	10	t	160143	\N
160147	16	5	Vice President of Documentations	20	t	160144	\N
160148	16	6	Associate Vice President of Documentations	30	f	160147	\N
160149	16	7	Vice President of Finance	20	t	160146	/Organization/treasurer/dashboard
160150	16	8	Associate Vice President of Finance	30	f	160149	/Organization/treasurer/dashboard
170151	17	1	President	0	t	\N	\N
170152	17	2	Executive Secretariat	10	t	170151	\N
170153	17	3	External Executive Vice President	10	t	170151	\N
170154	17	4	Internal Executive Vice President	10	t	170151	\N
170155	17	5	Vice President of Documentations	20	t	170152	\N
170156	17	6	Associate Vice President of Documentations	30	f	170155	\N
170157	17	7	Vice President of Finance	20	t	170154	/Organization/treasurer/dashboard
170158	17	8	Associate Vice President of Finance	30	f	170157	/Organization/treasurer/dashboard
180159	18	1	President	0	t	\N	\N
180160	18	2	Executive Secretariat	10	t	180159	\N
180161	18	3	External Executive Vice President	10	t	180159	\N
180162	18	4	Internal Executive Vice President	10	t	180159	\N
180163	18	5	Vice President of Documentations	20	t	180160	\N
180164	18	6	Associate Vice President of Documentations	30	f	180163	\N
180165	18	7	Vice President of Finance	20	t	180162	/Organization/treasurer/dashboard
180166	18	8	Associate Vice President of Finance	30	f	180165	/Organization/treasurer/dashboard
190167	19	1	President	0	t	\N	\N
190168	19	2	Executive Secretariat	10	t	190167	\N
190169	19	3	External Executive Vice President	10	t	190167	\N
190170	19	4	Internal Executive Vice President	10	t	190167	\N
190171	19	5	Vice President of Documentations	20	t	190168	\N
190172	19	6	Associate Vice President of Documentations	30	f	190171	\N
190173	19	7	Vice President of Finance	20	t	190170	/Organization/treasurer/dashboard
190174	19	8	Associate Vice President of Finance	30	f	190173	/Organization/treasurer/dashboard
200175	20	1	President	0	t	\N	\N
200176	20	2	Executive Secretariat	10	t	200175	\N
200177	20	3	External Executive Vice President	10	t	200175	\N
200178	20	4	Internal Executive Vice President	10	t	200175	\N
200179	20	5	Vice President of Documentations	20	t	200176	\N
200180	20	6	Associate Vice President of Documentations	30	f	200179	\N
200181	20	7	Vice President of Finance	20	t	200178	/Organization/treasurer/dashboard
200182	20	8	Associate Vice President of Finance	30	f	200181	/Organization/treasurer/dashboard
210183	21	1	President	0	t	\N	\N
210184	21	2	Executive Secretariat	10	t	210183	\N
210185	21	3	External Executive Vice President	10	t	210183	\N
210186	21	4	Internal Executive Vice President	10	t	210183	\N
210187	21	5	Vice President of Documentations	20	t	210184	\N
210188	21	6	Associate Vice President of Documentations	30	f	210187	\N
210189	21	7	Vice President of Finance	20	t	210186	/Organization/treasurer/dashboard
210190	21	8	Associate Vice President of Finance	30	f	210189	/Organization/treasurer/dashboard
220191	22	1	President	0	t	\N	\N
220192	22	2	Executive Secretariat	10	t	220191	\N
220193	22	3	External Executive Vice President	10	t	220191	\N
220194	22	4	Internal Executive Vice President	10	t	220191	\N
220195	22	5	Vice President of Documentations	20	t	220192	\N
220196	22	6	Associate Vice President of Documentations	30	f	220195	\N
220197	22	7	Vice President of Finance	20	t	220194	/Organization/treasurer/dashboard
220198	22	8	Associate Vice President of Finance	30	f	220197	/Organization/treasurer/dashboard
230199	23	1	President	0	t	\N	\N
230200	23	2	Executive Secretariat	10	t	230199	\N
230201	23	3	External Executive Vice President	10	t	230199	\N
230202	23	4	Internal Executive Vice President	10	t	230199	\N
230203	23	5	Vice President of Documentations	20	t	230200	\N
230204	23	6	Associate Vice President of Documentations	30	f	230203	\N
230205	23	7	Vice President of Finance	20	t	230202	/Organization/treasurer/dashboard
230206	23	8	Associate Vice President of Finance	30	f	230205	/Organization/treasurer/dashboard
240207	24	1	President	0	t	\N	\N
240208	24	2	Executive Secretariat	10	t	240207	\N
240209	24	3	External Executive Vice President	10	t	240207	\N
240210	24	4	Internal Executive Vice President	10	t	240207	\N
240211	24	5	Vice President of Documentations	20	t	240208	\N
240212	24	6	Associate Vice President of Documentations	30	f	240211	\N
240213	24	7	Vice President of Finance	20	t	240210	/Organization/treasurer/dashboard
240214	24	8	Associate Vice President of Finance	30	f	240213	/Organization/treasurer/dashboard
250215	25	1	President	0	t	\N	\N
250216	25	2	Executive Secretariat	10	t	250215	\N
250217	25	3	External Executive Vice President	10	t	250215	\N
250218	25	4	Internal Executive Vice President	10	t	250215	\N
250219	25	5	Vice President of Documentations	20	t	250216	\N
250220	25	6	Associate Vice President of Documentations	30	f	250219	\N
250221	25	7	Vice President of Finance	20	t	250218	/Organization/treasurer/dashboard
250222	25	8	Associate Vice President of Finance	30	f	250221	/Organization/treasurer/dashboard
260223	26	1	President	0	t	\N	\N
260224	26	2	Executive Secretariat	10	t	260223	\N
260225	26	3	External Executive Vice President	10	t	260223	\N
260226	26	4	Internal Executive Vice President	10	t	260223	\N
260227	26	5	Vice President of Documentations	20	t	260224	\N
260228	26	6	Associate Vice President of Documentations	30	f	260227	\N
260229	26	7	Vice President of Finance	20	t	260226	/Organization/treasurer/dashboard
260230	26	8	Associate Vice President of Finance	30	f	260229	/Organization/treasurer/dashboard
270231	27	1	President	0	t	\N	\N
270232	27	2	Executive Secretariat	10	t	270231	\N
270233	27	3	External Executive Vice President	10	t	270231	\N
270234	27	4	Internal Executive Vice President	10	t	270231	\N
270235	27	5	Vice President of Documentations	20	t	270232	\N
270236	27	6	Associate Vice President of Documentations	30	f	270235	\N
270237	27	7	Vice President of Finance	20	t	270234	/Organization/treasurer/dashboard
270238	27	8	Associate Vice President of Finance	30	f	270237	/Organization/treasurer/dashboard
280239	28	1	President	0	t	\N	\N
280240	28	2	Executive Secretariat	10	t	280239	\N
280241	28	3	External Executive Vice President	10	t	280239	\N
280242	28	4	Internal Executive Vice President	10	t	280239	\N
280243	28	5	Vice President of Documentations	20	t	280240	\N
280244	28	6	Associate Vice President of Documentations	30	f	280243	\N
280245	28	7	Vice President of Finance	20	t	280242	/Organization/treasurer/dashboard
280246	28	8	Associate Vice President of Finance	30	f	280245	/Organization/treasurer/dashboard
290247	29	1	President	0	t	\N	\N
290248	29	2	Executive Secretariat	10	t	290247	\N
290249	29	3	External Executive Vice President	10	t	290247	\N
290250	29	4	Internal Executive Vice President	10	t	290247	\N
290251	29	5	Vice President of Documentations	20	t	290248	\N
290252	29	6	Associate Vice President of Documentations	30	f	290251	\N
290253	29	7	Vice President of Finance	20	t	290250	/Organization/treasurer/dashboard
290254	29	8	Associate Vice President of Finance	30	f	290253	/Organization/treasurer/dashboard
300255	30	1	President	0	t	\N	\N
300256	30	2	Executive Secretariat	10	t	300255	\N
300257	30	3	External Executive Vice President	10	t	300255	\N
300258	30	4	Internal Executive Vice President	10	t	300255	\N
300259	30	5	Vice President of Documentations	20	t	300256	\N
300260	30	6	Associate Vice President of Documentations	30	f	300259	\N
300261	30	7	Vice President of Finance	20	t	300258	/Organization/treasurer/dashboard
300262	30	8	Associate Vice President of Finance	30	f	300261	/Organization/treasurer/dashboard
310263	31	1	President	0	t	\N	\N
310264	31	2	Executive Secretariat	10	t	310263	\N
310265	31	3	External Executive Vice President	10	t	310263	\N
310266	31	4	Internal Executive Vice President	10	t	310263	\N
310267	31	5	Vice President of Documentations	20	t	310264	\N
310268	31	6	Associate Vice President of Documentations	30	f	310267	\N
310269	31	7	Vice President of Finance	20	t	310266	/Organization/treasurer/dashboard
310270	31	8	Associate Vice President of Finance	30	f	310269	/Organization/treasurer/dashboard
320271	32	1	President	0	t	\N	\N
320272	32	2	Executive Secretariat	10	t	320271	\N
320273	32	3	External Executive Vice President	10	t	320271	\N
320274	32	4	Internal Executive Vice President	10	t	320271	\N
320275	32	5	Vice President of Documentations	20	t	320272	\N
320276	32	6	Associate Vice President of Documentations	30	f	320275	\N
320277	32	7	Vice President of Finance	20	t	320274	/Organization/treasurer/dashboard
320278	32	8	Associate Vice President of Finance	30	f	320277	/Organization/treasurer/dashboard
330279	33	1	President	0	t	\N	\N
330280	33	2	Executive Secretariat	10	t	330279	\N
330281	33	3	External Executive Vice President	10	t	330279	\N
330282	33	4	Internal Executive Vice President	10	t	330279	\N
330283	33	5	Vice President of Documentations	20	t	330280	\N
330284	33	6	Associate Vice President of Documentations	30	f	330283	\N
330285	33	7	Vice President of Finance	20	t	330282	/Organization/treasurer/dashboard
330286	33	8	Associate Vice President of Finance	30	f	330285	/Organization/treasurer/dashboard
340287	34	1	President	0	t	\N	\N
340288	34	2	Executive Secretariat	10	t	340287	\N
340289	34	3	External Executive Vice President	10	t	340287	\N
340290	34	4	Internal Executive Vice President	10	t	340287	\N
340291	34	5	Vice President of Documentations	20	t	340288	\N
340292	34	6	Associate Vice President of Documentations	30	f	340291	\N
340293	34	7	Vice President of Finance	20	t	340290	/Organization/treasurer/dashboard
340294	34	8	Associate Vice President of Finance	30	f	340293	/Organization/treasurer/dashboard
350295	35	1	President	0	t	\N	\N
350296	35	2	Executive Secretariat	10	t	350295	\N
350297	35	3	External Executive Vice President	10	t	350295	\N
350298	35	4	Internal Executive Vice President	10	t	350295	\N
350299	35	5	Vice President of Documentations	20	t	350296	\N
350300	35	6	Associate Vice President of Documentations	30	f	350299	\N
350301	35	7	Vice President of Finance	20	t	350298	/Organization/treasurer/dashboard
350302	35	8	Associate Vice President of Finance	30	f	350301	/Organization/treasurer/dashboard
360303	36	1	President	0	t	\N	\N
360304	36	2	Executive Secretariat	10	t	360303	\N
360305	36	3	External Executive Vice President	10	t	360303	\N
360306	36	4	Internal Executive Vice President	10	t	360303	\N
360307	36	5	Vice President of Documentations	20	t	360304	\N
360308	36	6	Associate Vice President of Documentations	30	f	360307	\N
360309	36	7	Vice President of Finance	20	t	360306	/Organization/treasurer/dashboard
360310	36	8	Associate Vice President of Finance	30	f	360309	/Organization/treasurer/dashboard
370311	37	1	President	0	t	\N	\N
370312	37	2	Executive Secretariat	10	t	370311	\N
370313	37	3	External Executive Vice President	10	t	370311	\N
370314	37	4	Internal Executive Vice President	10	t	370311	\N
370315	37	5	Vice President of Documentations	20	t	370312	\N
370316	37	6	Associate Vice President of Documentations	30	f	370315	\N
370317	37	7	Vice President of Finance	20	t	370314	/Organization/treasurer/dashboard
370318	37	8	Associate Vice President of Finance	30	f	370317	/Organization/treasurer/dashboard
380319	38	1	President	0	t	\N	\N
380320	38	2	Executive Secretariat	10	t	380319	\N
380321	38	3	External Executive Vice President	10	t	380319	\N
380322	38	4	Internal Executive Vice President	10	t	380319	\N
380323	38	5	Vice President of Documentations	20	t	380320	\N
380324	38	6	Associate Vice President of Documentations	30	f	380323	\N
380325	38	7	Vice President of Finance	20	t	380322	/Organization/treasurer/dashboard
380326	38	8	Associate Vice President of Finance	30	f	380325	/Organization/treasurer/dashboard
\.


--
-- Data for Name: postactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY postactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Data for Name: preactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY preactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
1	0	0	f
2	0	1	f
3	1	2	f
4	2	3	f
5	3	4	f
6	4	3	f
7	4	5	f
8	5	3	f
9	5	6	f
10	6	3	f
11	6	7	t
12	7	3	f
13	7	8	f
14	7	0	f
15	8	3	f
16	9	3	f
\.


--
-- Data for Name: projectproposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposal (id, gosmactivity, status, enp, enmp, actualdatestart, actualdateend, venue, context1, context2, context3, isexpense, sourcefundother, sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, accumulateddepositoryfunds, organizationfundothersource, comments, preparedby, facultyadviser, datecreated, datesubmitted, datestatusmodified, isattachmentscomplete, isbriefcontextcomplete, isexpensecomplete, isprogramcomplete) FROM stdin;
1	1	2	1	1	2017-11-21	2017-11-22	0	Context kita	Context parin kita	Context ulit kita	t	69.69	69.69	69.69	69.69	69.69	\N	Comments ko toh	3333333	4444444	2017-11-23 16:14:07.618715+08	2017-11-23 16:14:07.618715+08	\N	f	f	f	f
\.


--
-- Data for Name: projectproposalattachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalattachment (id, projectproposal, requirement, sequence, idnumber, filename, filenametoshow, directory) FROM stdin;
\.


--
-- Data for Name: projectproposalexpenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalexpenses (id, projectproposal, sequence, material, quantity, unitcost, type) FROM stdin;
2	1	2	Boyfriend Material 2	80	60.00	0
3	1	3	Boyfriend Material 3	80	60.00	0
4	1	4	Boyfriend Material 4	7	15.00	0
5	1	5	Boyfriend Material 5	60	2.00	0
\.


--
-- Data for Name: projectproposalprogramdesign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprogramdesign (id, projectproposal, dayid, sequence, date, starttime, endtime, activity, activitydescription, personincharge) FROM stdin;
1	1	1	1	2017-10-14	21:34:03+08	23:00:00+08	Aguy	Gansa	3333333
\.


--
-- Data for Name: projectproposalprogramdesignpersonincharge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprogramdesignpersonincharge (id, programdesign, projecthead) FROM stdin;
\.


--
-- Data for Name: projectproposalprojectedincome; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprojectedincome (projectproposal, sequence, item, quantity, sellingprice) FROM stdin;
\.


--
-- Data for Name: projectproposalsignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalsignatory (id, gosmactivity, signatory, type, status, comments, sectionstoedit, document, digitalsignature, datesigned) FROM stdin;
1	1	3333333	0	0	\N	\N	\N	\N	\N
2	1	2222222	1	0	\N	\N	\N	\N	\N
3	1	1111111	2	0	\N	\N	\N	\N	\N
4	1	1111111	3	0	\N	\N	\N	\N	\N
5	1	5555555	5	0	\N	\N	\N	\N	\N
7	1	7777777	6	0	\N	\N	\N	\N	\N
8	1	6666666	7	0	\N	\N	\N	\N	\N
\.


--
-- Data for Name: projectproposalsourcefunds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalsourcefunds (projectproposal, sequence, name, amount) FROM stdin;
\.


--
-- Data for Name: projectproposalstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalstatus (id, name) FROM stdin;
1	Created
2	For approval
3	Approved
4	Pending
5	Denied
\.


--
-- Data for Name: schoolyear; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schoolyear (id, startyear, endyear) FROM stdin;
20152016	2015	2016
20162017	2016	2017
20172018	2017	2018
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY session (sid, sess, expire) FROM stdin;
NJuQBhKUqSiwK5OcxWgRYiT9Ch-2QDUu	{"cookie":{"originalMaxAge":3600000,"expires":"2017-11-23T09:15:46.672Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"4kaI_otipNTQiz4UYFaQqMK3","user":{"idNumber":1111111,"name":{"first":"Organization","middle":null,"last":"President"},"type":1,"organizationSelected":{"id":1,"path_profilePicture":""}},"valid":true}	2017-11-23 17:15:47
\.


--
-- Data for Name: signatorystatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY signatorystatus (id, name) FROM stdin;
0	Unsigned
1	Accepted
2	Pend
3	Denied
4	Force Signed
\.


--
-- Data for Name: signatorytype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY signatorytype (id, name, lineup) FROM stdin;
0	Project Head	0
1	Treasurer/Finance Officer	10
2	Immediate Superior	20
3	President	30
4	Faculty Adviser	40
5	Documentation Officer	50
6	APS - AVC	60
7	APS -  VC	70
\.


--
-- Data for Name: studentorganization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY studentorganization (id, name, cluster, nature, college, acronym, description, funds, operationalfunds, depositryfunds, path_profilepicture) FROM stdin;
0	Council of Student Organizations	\N	\N	\N	CSO	\N	0.00	0.00	0.00	\\plugins\\images\\cso.png
1	Chemistry Society	1	\N	\N	Chemsoc	\N	0.00	0.00	0.00	\N
2	Math Circle	1	\N	\N	MC	\N	0.00	0.00	0.00	\N
3	Physics Society	1	\N	\N	Physoc	\N	0.00	0.00	0.00	\N
4	Societas Vitae	1	\N	\N	SV	\N	0.00	0.00	0.00	\N
5	La Salle Computer Society	2	\N	\N	LSCS	\N	0.00	0.00	0.00	\N
6	Union of Students Inspired Towards Education	2	\N	\N	UNITED	\N	0.00	0.00	0.00	\N
7	DLSU Filipino & Chinese Organization	2	\N	\N	ENGLICOM	\N	0.00	0.00	0.00	\N
8	ROTARACT Club of DLSU	2	\N	\N	ROTARACT	\N	0.00	0.00	0.00	\N
9	United International Student Organization	2	\N	\N	UNISTO	\N	0.00	0.00	0.00	\N
10	AIESEC DLSU	2	\N	\N	AIESEC	\N	0.00	0.00	0.00	\N
11	Moo Media	2	\N	\N	\N	\N	0.00	0.00	0.00	\N
12	Outdoor Club	2	\N	\N	OC	\N	0.00	0.00	0.00	\N
13	Writer’s Guild	2	\N	\N	WG	\N	0.00	0.00	0.00	\N
14	De La Salle University - Environmental Conservation Organization	1	\N	\N	ECO	\N	0.00	0.00	0.00	\N
15	Gakuen Anime Shoshiki	2	\N	\N	GAS	\N	0.00	0.00	0.00	\N
16	The Organization for American Studies	3	\N	\N	AMSTUD	\N	0.00	0.00	0.00	\N
17	Behavioral Sciences Society	3	\N	\N	BSS	\N	0.00	0.00	0.00	\N
18	Cultura	3	\N	\N	\N	\N	0.00	0.00	0.00	\N
19	Dalubhasaan ng mga Umuusbong na Mag-aaral ng Araling Pilipino	1	\N	\N	DANUM	\N	0.00	0.00	0.00	\N
20	European Studies Association	3	\N	\N	ESA	\N	0.00	0.00	0.00	\N
21	Kapatiran ng Kabataan para sa Kaunlaran	3	\N	\N	Kaunlaran	\N	0.00	0.00	0.00	\N
22	Nihon Kenkyu Kai	3	\N	\N	NKK	\N	0.00	0.00	0.00	\N
23	Political Science Society	3	\N	\N	Poliscy	\N	0.00	0.00	0.00	\N
24	Samahan ng Lasalyanong Pilosopo	3	\N	\N	DLSU Pilosopo	\N	0.00	0.00	0.00	\N
25	Samahan ng mga Mag-aaral sa Sikolohiya	3	\N	\N	SMS	\N	0.00	0.00	0.00	\N
26	Sociedad De Historia	3	\N	\N	SDH	\N	0.00	0.00	0.00	\N
27	Team Communications	3	\N	\N	TeamComm	\N	0.00	0.00	0.00	\N
28	Association of Computer Engineering Students	4	\N	\N	ACCESS	\N	0.00	0.00	0.00	\N
29	Chemical Engineering Society	4	\N	\N	ChEn	\N	0.00	0.00	0.00	\N
30	Civil Engineering Society	4	\N	\N	CES	\N	0.00	0.00	0.00	\N
31	Electronic and Communications Engineering Society	4	\N	\N	ECES	\N	0.00	0.00	0.00	\N
32	Industrial Management Engineering Society	4	\N	\N	IMES	\N	0.00	0.00	0.00	\N
33	Society of Manufacturing Engineering	4	\N	\N	SME	\N	0.00	0.00	0.00	\N
34	AdCreate Society	5	\N	\N	AdCreate	\N	0.00	0.00	0.00	\N
35	Business Management Society	5	\N	\N	BMS	\N	0.00	0.00	0.00	\N
36	Economics Organization	5	\N	\N	EconOrg	\N	0.00	0.00	0.00	\N
37	Management of Financial Institutions Association	5	\N	\N	MaFia	\N	0.00	0.00	0.00	\N
38	Young Entrepreneurs Society	5	\N	\N	YES	\N	0.00	0.00	0.00	\N
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY term (id, schoolyearid, number, datestart, dateend) FROM stdin;
201520161	20152016	1	2015-08-24	2015-12-08
201520162	20152016	2	2016-01-06	2016-04-16
201520163	20152016	3	2016-05-23	2016-08-27
201620171	20162017	1	2016-09-12	2016-12-17
201620172	20162017	2	2016-01-04	2016-04-11
201620173	20162017	3	2017-05-15	2017-08-19
201720181	20172018	1	2017-09-11	2017-12-16
201720182	20172018	2	2018-01-08	2018-04-21
201720183	20172018	3	2018-05-24	2018-08-28
\.


--
-- Name: AccountNotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"AccountNotification_id_seq"', 1, false);


--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"ActivityPublicity_id_seq"', 1, false);


--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectBookTransfer_id_seq"', 1, false);


--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectDirectPayment_id_seq"', 1, false);


--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectProposalEventPicture_id_seq"', 1, false);


--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectProposalExpense_id_seq"', 1, false);


--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectReimbursement_id_seq"', 1, false);


--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvanceParticular_id_seq"', 1, false);


--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvanceSignatory_id_seq"', 1, false);


--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvance_id_seq"', 1, false);


--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPaymentParticular_id_seq"', 1, false);


--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPaymentSignatory_id_seq"', 1, false);


--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPayment_id_seq"', 1, false);


--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('activityattachmentrequirement_id_seq', 16, true);


--
-- Name: audit_Account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"audit_Account_id_seq"', 1, false);


--
-- Name: audit_ProjectProposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"audit_ProjectProposal_id_seq"', 1, false);


--
-- Name: gosmactivity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('gosmactivity_id_seq', 5, true);


--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organizationfacultyadviser_id_seq', 1, true);


--
-- Name: projectproposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposal_id_seq', 1, true);


--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalattachment_id_seq', 1, false);


--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalexpenses_id_seq', 5, true);


--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalprogramdesign_id_seq', 1, true);


--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalprogramdesignpersonincharge_id_seq', 1, false);


--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalsignatory_id_seq', 8, true);


--
-- Name: ARFOrganizationPosition ARFOrganizationPosition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ARFOrganizationPosition"
    ADD CONSTRAINT "ARFOrganizationPosition_pkey" PRIMARY KEY (id);


--
-- Name: AccountEvent AccountEvent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountEvent"
    ADD CONSTRAINT "AccountEvent_pkey" PRIMARY KEY (id);


--
-- Name: AccountNotification AccountNotification_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_id_key" UNIQUE (id);


--
-- Name: AccountNotification AccountNotification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_pkey" PRIMARY KEY (account, sequence);


--
-- Name: ActivityPublicityMaterial ActivityPublicityMaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityMaterial"
    ADD CONSTRAINT "ActivityPublicityMaterial_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityModeOfDistribution ActivityPublicityModeOfDistribution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityModeOfDistribution"
    ADD CONSTRAINT "ActivityPublicityModeOfDistribution_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityStatus ActivityPublicityStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityStatus"
    ADD CONSTRAINT "ActivityPublicityStatus_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicity ActivityPublicity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_id_key" UNIQUE (id);


--
-- Name: ActivityPublicity ActivityPublicity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: ActivityResearchForm ActivityResearchForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_pkey" PRIMARY KEY ("GOSMActivity", sequence);


--
-- Name: ActivityVenue ActivityVenue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_pkey" PRIMARY KEY (id);


--
-- Name: Building Building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Building"
    ADD CONSTRAINT "Building_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_pkey" PRIMARY KEY ("expenseType", document);


--
-- Name: FinanceSignatoryType FinanceSignatoryType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "FinanceSignatoryType"
    ADD CONSTRAINT "FinanceSignatoryType_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PostProjectBookTransferStatus PostProjectBookTransferStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferStatus"
    ADD CONSTRAINT "PostProjectBookTransferStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_id_key" UNIQUE (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PostProjectDirectPaymentPayment PostProjectDirectPaymentPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentPayment"
    ADD CONSTRAINT "PostProjectDirectPaymentPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPaymentStatus PostProjectDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentStatus"
    ADD CONSTRAINT "PostProjectDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_id_key" UNIQUE (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalStatus PostProjectProposalStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalStatus"
    ADD CONSTRAINT "PostProjectProposalStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectProposal PostProjectProposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_pkey" PRIMARY KEY ("GOSMActivity");


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PostProjectReimbursementPayment PostProjectReimbursementPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementPayment"
    ADD CONSTRAINT "PostProjectReimbursementPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursementStatus PostProjectReimbursementStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementStatus"
    ADD CONSTRAINT "PostProjectReimbursementStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_pkey" PRIMARY KEY ("cashAdvance", particular);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceStatus PreActivityCashAdvanceStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceStatus"
    ADD CONSTRAINT "PreActivityCashAdvanceStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentStatus PreActivityDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentStatus"
    ADD CONSTRAINT "PreActivityDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: ProjectProposalEvent ProjectProposalEvent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ProjectProposalEvent"
    ADD CONSTRAINT "ProjectProposalEvent_pkey" PRIMARY KEY (id);


--
-- Name: RateType RateType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RateType"
    ADD CONSTRAINT "RateType_pkey" PRIMARY KEY (id);


--
-- Name: VenueSize VenueSize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "VenueSize"
    ADD CONSTRAINT "VenueSize_pkey" PRIMARY KEY (id);


--
-- Name: account account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (idnumber);


--
-- Name: accounttype accounttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY accounttype
    ADD CONSTRAINT accounttype_pkey PRIMARY KEY (id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: activitynature activitynature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activitynature
    ADD CONSTRAINT activitynature_pkey PRIMARY KEY (id);


--
-- Name: activitytype activitytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activitytype
    ADD CONSTRAINT activitytype_pkey PRIMARY KEY (id);


--
-- Name: amtactivityevaluation amtactivityevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_pkey PRIMARY KEY (activity);


--
-- Name: amtactivityevaluationstatus amtactivityevaluationstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluationstatus
    ADD CONSTRAINT amtactivityevaluationstatus_pkey PRIMARY KEY (id);


--
-- Name: audit_Account audit_Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_Account"
    ADD CONSTRAINT "audit_Account_pkey" PRIMARY KEY (id);


--
-- Name: audit_ProjectProposal audit_ProjectProposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_ProjectProposal"
    ADD CONSTRAINT "audit_ProjectProposal_id_key" UNIQUE (id);


--
-- Name: audit_ProjectProposal audit_ProjectProposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_ProjectProposal"
    ADD CONSTRAINT "audit_ProjectProposal_pkey" PRIMARY KEY ("GOSMActivity", sequence);


--
-- Name: college college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY college
    ADD CONSTRAINT college_pkey PRIMARY KEY (shortacronym);


--
-- Name: documentattachmentrequirement documentattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documentattachmentrequirement
    ADD CONSTRAINT documentattachmentrequirement_pkey PRIMARY KEY (id);


--
-- Name: expensetype expensetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expensetype
    ADD CONSTRAINT expensetype_pkey PRIMARY KEY (id);


--
-- Name: functionality functionality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionality
    ADD CONSTRAINT functionality_pkey PRIMARY KEY (id);


--
-- Name: functionalitycategory functionalitycategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitycategory
    ADD CONSTRAINT functionalitycategory_pkey PRIMARY KEY (id);


--
-- Name: functionalitydomain functionalitydomain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitydomain
    ADD CONSTRAINT functionalitydomain_pkey PRIMARY KEY (id);


--
-- Name: gosm gosm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_id_key UNIQUE (id);


--
-- Name: gosm gosm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_pkey PRIMARY KEY (termid, studentorganization);


--
-- Name: gosmactivity gosmactivity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_id_key UNIQUE (id);


--
-- Name: gosmactivity gosmactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_pkey PRIMARY KEY (gosm, sequence);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_pkey PRIMARY KEY (idnumber, activityid);


--
-- Name: gosmstatus gosmstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmstatus
    ADD CONSTRAINT gosmstatus_pkey PRIMARY KEY (id);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_pkey PRIMARY KEY (role, functionality);


--
-- Name: organizationcluster organizationcluster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationcluster
    ADD CONSTRAINT organizationcluster_pkey PRIMARY KEY (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_id_key UNIQUE (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_pkey PRIMARY KEY (organization, faculty, yearid);


--
-- Name: organizationnature organizationnature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationnature
    ADD CONSTRAINT organizationnature_pkey PRIMARY KEY (id);


--
-- Name: organizationofficer organizationofficer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_pkey PRIMARY KEY (idnumber, role, yearid);


--
-- Name: organizationrole organizationrole_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_id_key UNIQUE (id);


--
-- Name: organizationrole organizationrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_pkey PRIMARY KEY (organization, sequence);


--
-- Name: PreActivityCashAdvanceSignatory pk_PreActivityCashAdvanceSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "pk_PreActivityCashAdvanceSignatory" PRIMARY KEY ("cashAdvance", signatory, type);


--
-- Name: PreActivityDirectPaymentSignatory pk_PreActivityDirectPaymentSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "pk_PreActivityDirectPaymentSignatory" PRIMARY KEY ("directPayment", signatory, type);


--
-- Name: projectproposalsignatory pk_ProjectProposalSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT "pk_ProjectProposalSignatory" PRIMARY KEY (gosmactivity, signatory, type);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: projectproposal projectproposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_id_key UNIQUE (id);


--
-- Name: projectproposal projectproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_pkey PRIMARY KEY (gosmactivity);


--
-- Name: projectproposalattachment projectproposalattachment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_id_key UNIQUE (id);


--
-- Name: projectproposalattachment projectproposalattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_pkey PRIMARY KEY (projectproposal, requirement, sequence);


--
-- Name: projectproposalexpenses projectproposalexpenses_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_id_key UNIQUE (id);


--
-- Name: projectproposalexpenses projectproposalexpenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_pkey PRIMARY KEY (projectproposal, dayid, sequence);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_pkey PRIMARY KEY (programdesign, projecthead);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalsignatory projectproposalsignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_id_key UNIQUE (id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalstatus projectproposalstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalstatus
    ADD CONSTRAINT projectproposalstatus_pkey PRIMARY KEY (id);


--
-- Name: schoolyear schoolyear_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schoolyear
    ADD CONSTRAINT schoolyear_id_key UNIQUE (id);


--
-- Name: schoolyear schoolyear_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schoolyear
    ADD CONSTRAINT schoolyear_pkey PRIMARY KEY (startyear, endyear);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: signatorystatus signatorystatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatorystatus
    ADD CONSTRAINT signatorystatus_pkey PRIMARY KEY (id);


--
-- Name: signatorytype signatorytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatorytype
    ADD CONSTRAINT signatorytype_pkey PRIMARY KEY (id);


--
-- Name: studentorganization studentorganization_acronym_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_acronym_key UNIQUE (acronym);


--
-- Name: studentorganization studentorganization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_pkey PRIMARY KEY (id);


--
-- Name: term term_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_id_key UNIQUE (id);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (schoolyearid, number);


--
-- Name: PreActivityCashAdvanceParticular after_delete_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_delete_PreActivityCashAdvanceParticular_signatories" AFTER DELETE ON "PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE "trigger_after_delete_PreActivityCashAdvanceParticular_signatori"();


--
-- Name: PreActivityCashAdvanceParticular after_insert_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvanceParticular_signatories" AFTER INSERT ON "PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_PreActivityCashAdvanceParticular_signatori"();


--
-- Name: PreActivityCashAdvance after_insert_PreActivityCashAdvance_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvance_signatories" AFTER INSERT ON "PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_PreActivityCashAdvance_signatories"();


--
-- Name: projectproposal after_insert_ProjectProposal_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_ProjectProposal_signatories" AFTER INSERT ON projectproposal FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_ProjectProposal_signatories"();


--
-- Name: studentorganization after_insert_studentorganization; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_insert_studentorganization AFTER INSERT ON studentorganization FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_studentorganization();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_facultyAdviser; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser" AFTER UPDATE ON projectproposal FOR EACH ROW WHEN ((((old.facultyadviser IS NULL) AND (new.facultyadviser IS NOT NULL)) OR ((old.facultyadviser IS NOT NULL) AND (new.facultyadviser IS NULL)) OR (old.facultyadviser <> new.facultyadviser))) EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_facultyAdviser"();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_immediateSuperior; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior" AFTER UPDATE ON projectproposal FOR EACH ROW WHEN (((old.preparedby IS NULL) OR (old.preparedby <> new.preparedby))) EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_immediateSuperio"();


--
-- Name: gosm after_update_gosm_studentorganization; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_update_gosm_studentorganization AFTER UPDATE ON gosm FOR EACH ROW WHEN ((old.studentorganization <> new.studentorganization)) EXECUTE PROCEDURE trigger_after_update_gosm_studentorganization();


--
-- Name: projectproposalsignatory after_update_projectproposalsignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_update_projectproposalsignatory_completion AFTER UPDATE ON projectproposalsignatory FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE "trigger_after_update_ProjectProposalSignatory_completion"();


--
-- Name: AccountNotification before_insert_AccountNotification; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_AccountNotification" BEFORE INSERT ON "AccountNotification" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_AccountNotification"();


--
-- Name: ActivityPublicity before_insert_ActivityPublicity_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityPublicity_sequence" BEFORE INSERT ON "ActivityPublicity" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_ActivityPublicity_sequence"();


--
-- Name: ActivityResearchForm before_insert_ActivityResearchForm_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityResearchForm_sequence" BEFORE INSERT ON "ActivityResearchForm" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_increment_sequence('ActivityResearchForm', 'arf', 'arf."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PostProjectBookTransfer before_insert_PostProjectBookTransfer_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectBookTransfer_sequence" BEFORE INSERT ON "PostProjectBookTransfer" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectBookTransfer_sequence"();


--
-- Name: PostProjectDirectPayment before_insert_PostProjectDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectDirectPayment_sequence" BEFORE INSERT ON "PostProjectDirectPayment" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectDirectPayment_sequence"();


--
-- Name: PostProjectProposalEventPicture before_insert_PostProjectProposalEventPicture_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalEventPicture_sequence" BEFORE INSERT ON "PostProjectProposalEventPicture" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalEventPicture_sequence"();


--
-- Name: PostProjectProposalExpense before_insert_PostProjectProposalExpense_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalExpense_sequence" BEFORE INSERT ON "PostProjectProposalExpense" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalExpense_sequence"();


--
-- Name: PostProjectReimbursement before_insert_PostProjectReimbursement_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursement_sequence" BEFORE INSERT ON "PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectReimbursement_sequence"();


--
-- Name: PreActivityCashAdvance before_insert_PreActivityCashAdvance_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvance_sequence" BEFORE INSERT ON "PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PreActivityCashAdvance_sequence"();


--
-- Name: PreActivityDirectPayment before_insert_PreActivityDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPayment_sequence" BEFORE INSERT ON "PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PreActivityDirectPayment_sequence"();


--
-- Name: account before_insert_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_account BEFORE INSERT ON account FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_account();


--
-- Name: audit_ProjectProposal before_insert_audit_ProjectProposal_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_audit_ProjectProposal_sequence" BEFORE INSERT ON "audit_ProjectProposal" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_audit_ProjectProposal_sequence"();


--
-- Name: functionality before_insert_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionality BEFORE INSERT ON functionality FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_functionality();


--
-- Name: functionalitycategory before_insert_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionalitycategory BEFORE INSERT ON functionalitycategory FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_functionalitycategory();


--
-- Name: gosm before_insert_ggosm; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_ggosm BEFORE INSERT ON gosm FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_gosm();


--
-- Name: gosmactivity before_insert_gosmactivity; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_gosmactivity BEFORE INSERT ON gosmactivity FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_gosmactivity();


--
-- Name: organizationrole before_insert_organizationrole; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_organizationrole BEFORE INSERT ON organizationrole FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_organizationrole();


--
-- Name: projectproposalattachment before_insert_projectproposalattachment; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalattachment BEFORE INSERT ON projectproposalattachment FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalattachment();


--
-- Name: projectproposalexpenses before_insert_projectproposalexpenses; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalexpenses BEFORE INSERT ON projectproposalexpenses FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalexpenses();


--
-- Name: projectproposalprogramdesign before_insert_projectproposalprogramdesign; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprogramdesign BEFORE INSERT ON projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalprogramdesign();


--
-- Name: projectproposalprojectedincome before_insert_projectproposalprojectedincome; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprojectedincome BEFORE INSERT ON projectproposalprojectedincome FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalprojectedincome();


--
-- Name: projectproposalsourcefunds before_insert_projectproposalsourcefunds; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalsourcefunds BEFORE INSERT ON projectproposalsourcefunds FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalsourcefunds();


--
-- Name: schoolyear before_insert_schoolyear; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_schoolyear BEFORE INSERT ON schoolyear FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_schoolyear();


--
-- Name: term before_insert_term; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_term BEFORE INSERT ON term FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_term();


--
-- Name: account before_update_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_account BEFORE UPDATE ON account FOR EACH ROW WHEN ((crypt((new.password)::text, (old.salt)::text) <> (old.password)::text)) EXECUTE PROCEDURE trigger_before_update_account();


--
-- Name: account before_update_account2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_account2 BEFORE UPDATE ON account FOR EACH ROW EXECUTE PROCEDURE trigger_before_update_account2();


--
-- Name: functionality before_update_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionality BEFORE UPDATE ON functionality FOR EACH ROW WHEN (((old.category <> new.category) OR (old.category IS NULL))) EXECUTE PROCEDURE trigger_before_update_functionality();


--
-- Name: functionalitycategory before_update_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionalitycategory BEFORE UPDATE ON functionalitycategory FOR EACH ROW WHEN (((old.domain <> new.domain) OR (old.domain IS NULL))) EXECUTE PROCEDURE trigger_before_update_functionalitycategory();


--
-- Name: gosm before_update_gosm_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_gosm_status BEFORE UPDATE ON gosm FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_before_update_gosm_status();


--
-- Name: projectproposal before_update_projectproposal; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_projectproposal BEFORE UPDATE ON projectproposal FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_before_update_projectproposal();


--
-- Name: AccountNotification AccountNotification_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_account_fkey" FOREIGN KEY (account) REFERENCES account(idnumber);


--
-- Name: ActivityPublicity ActivityPublicity_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: ActivityPublicity ActivityPublicity_checkedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_checkedBy_fkey" FOREIGN KEY ("checkedBy") REFERENCES account(idnumber);


--
-- Name: ActivityPublicity ActivityPublicity_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_material_fkey" FOREIGN KEY (material) REFERENCES "ActivityPublicityMaterial"(id);


--
-- Name: ActivityPublicity ActivityPublicity_modeOfDistribution_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_modeOfDistribution_fkey" FOREIGN KEY ("modeOfDistribution") REFERENCES "ActivityPublicityModeOfDistribution"(id);


--
-- Name: ActivityPublicity ActivityPublicity_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_status_fkey" FOREIGN KEY (status) REFERENCES "ActivityPublicityStatus"(id);


--
-- Name: ActivityPublicity ActivityPublicity_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: ActivityResearchForm ActivityResearchForm_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: ActivityResearchForm ActivityResearchForm_positionInOrganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_positionInOrganization_fkey" FOREIGN KEY ("positionInOrganization") REFERENCES "ARFOrganizationPosition"(id);


--
-- Name: ActivityVenue ActivityVenue_building_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_building_fkey" FOREIGN KEY (building) REFERENCES "Building"(id);


--
-- Name: ActivityVenue ActivityVenue_rateType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_rateType_fkey" FOREIGN KEY ("rateType") REFERENCES "RateType"(id);


--
-- Name: ActivityVenue ActivityVenue_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_size_fkey" FOREIGN KEY (size) REFERENCES "VenueSize"(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_document_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_document_fkey" FOREIGN KEY (document) REFERENCES documentattachmentrequirement(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_expenseType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_expenseType_fkey" FOREIGN KEY ("expenseType") REFERENCES expensetype(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES "PostProjectBookTransfer"(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectBookTransferStatus"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PostProjectDirectPayment"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_paymentBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_paymentBy_fkey" FOREIGN KEY ("paymentBy") REFERENCES "PostProjectDirectPaymentPayment"(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectDirectPaymentStatus"(id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PostProjectProposal PostProjectProposal_preparedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_preparedBy_fkey" FOREIGN KEY ("preparedBy") REFERENCES account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectProposalStatus"(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES "PostProjectReimbursement"(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectReimbursement PostProjectReimbursement_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_paymentBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_paymentBy_fkey" FOREIGN KEY ("paymentBy") REFERENCES "PostProjectReimbursementPayment"(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectReimbursementStatus"(id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES "PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES "PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_status_fkey" FOREIGN KEY (status) REFERENCES "PreActivityCashAdvanceStatus"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PreActivityDirectPaymentParticular"(id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PreActivityDirectPayment"(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES "PreActivityDirectPaymentStatus"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: account account_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_type_fkey FOREIGN KEY (type) REFERENCES accounttype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_attachment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_attachment_fkey FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: amtactivityevaluation amtactivityevaluation_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_activity_fkey FOREIGN KEY (activity) REFERENCES projectproposal(gosmactivity);


--
-- Name: amtactivityevaluation amtactivityevaluation_evaluator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_evaluator_fkey FOREIGN KEY (evaluator) REFERENCES account(idnumber);


--
-- Name: amtactivityevaluation amtactivityevaluation_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_status_fkey FOREIGN KEY (status) REFERENCES amtactivityevaluationstatus(id);


--
-- Name: audit_ProjectProposal audit_ProjectProposal_event_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "audit_ProjectProposal"
    ADD CONSTRAINT "audit_ProjectProposal_event_fkey" FOREIGN KEY (event) REFERENCES "ProjectProposalEvent"(id);


--
-- Name: functionality functionality_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionality
    ADD CONSTRAINT functionality_category_fkey FOREIGN KEY (category) REFERENCES functionalitycategory(id) ON UPDATE CASCADE;


--
-- Name: functionalitycategory functionalitycategory_domain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitycategory
    ADD CONSTRAINT functionalitycategory_domain_fkey FOREIGN KEY (domain) REFERENCES functionalitydomain(id) ON UPDATE CASCADE;


--
-- Name: gosm gosm_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES account(idnumber);


--
-- Name: gosm gosm_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_status_fkey FOREIGN KEY (status) REFERENCES gosmstatus(id);


--
-- Name: gosm gosm_statusmodifier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_statusmodifier_fkey FOREIGN KEY (statusmodifier) REFERENCES account(idnumber);


--
-- Name: gosm gosm_studentorganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_studentorganization_fkey FOREIGN KEY (studentorganization) REFERENCES studentorganization(id) ON UPDATE CASCADE;


--
-- Name: gosmactivity gosmactivity_activitynature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_activitynature_fkey FOREIGN KEY (activitynature) REFERENCES activitynature(id);


--
-- Name: gosmactivity gosmactivity_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: gosmactivity gosmactivity_gosm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_gosm_fkey FOREIGN KEY (gosm) REFERENCES gosm(id) ON UPDATE CASCADE;


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_activityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_activityid_fkey FOREIGN KEY (activityid) REFERENCES gosmactivity(id);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_functionality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_functionality_fkey FOREIGN KEY (functionality) REFERENCES functionality(id) ON UPDATE CASCADE;


--
-- Name: organizationaccesscontrol organizationaccesscontrol_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_role_fkey FOREIGN KEY (role) REFERENCES organizationrole(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_faculty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_faculty_fkey FOREIGN KEY (faculty) REFERENCES account(idnumber);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_organization_fkey FOREIGN KEY (organization) REFERENCES studentorganization(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_yearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_yearid_fkey FOREIGN KEY (yearid) REFERENCES schoolyear(id);


--
-- Name: organizationofficer organizationofficer_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: organizationofficer organizationofficer_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_role_fkey FOREIGN KEY (role) REFERENCES organizationrole(id);


--
-- Name: organizationrole organizationrole_masterrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_masterrole_fkey FOREIGN KEY (masterrole) REFERENCES organizationrole(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizationrole organizationrole_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_organization_fkey FOREIGN KEY (organization) REFERENCES studentorganization(id) ON UPDATE CASCADE;


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_documentattachmentrequirement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_documentattachmentrequirement FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_documentattachmentrequirement_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_documentattachmentrequirement_ FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: projectproposal projectproposal_facultyadviser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_facultyadviser_fkey FOREIGN KEY (facultyadviser) REFERENCES account(idnumber);


--
-- Name: projectproposal projectproposal_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES gosmactivity(id);


--
-- Name: projectproposal projectproposal_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES account(idnumber);


--
-- Name: projectproposal projectproposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_status_fkey FOREIGN KEY (status) REFERENCES projectproposalstatus(id);


--
-- Name: projectproposal projectproposal_venue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_venue_fkey FOREIGN KEY (venue) REFERENCES "ActivityVenue"(id);


--
-- Name: projectproposalattachment projectproposalattachment_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: projectproposalattachment projectproposalattachment_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalattachment projectproposalattachment_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_requirement_fkey FOREIGN KEY (requirement) REFERENCES documentattachmentrequirement(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_type_fkey FOREIGN KEY (type) REFERENCES expensetype(id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_personincharge_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_personincharge_fkey FOREIGN KEY (personincharge) REFERENCES account(idnumber);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_programdesign_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_programdesign_fkey FOREIGN KEY (programdesign) REFERENCES projectproposalprogramdesign(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_projecthead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_projecthead_fkey FOREIGN KEY (projecthead) REFERENCES account(idnumber);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES projectproposal(gosmactivity);


--
-- Name: projectproposalsignatory projectproposalsignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_signatory_fkey FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: projectproposalsignatory projectproposalsignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_status_fkey FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_type_fkey FOREIGN KEY (type) REFERENCES signatorytype(id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: studentorganization studentorganization_cluster_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_cluster_fkey FOREIGN KEY (cluster) REFERENCES organizationcluster(id);


--
-- Name: studentorganization studentorganization_college_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_college_fkey FOREIGN KEY (college) REFERENCES college(shortacronym);


--
-- Name: studentorganization studentorganization_nature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_nature_fkey FOREIGN KEY (nature) REFERENCES organizationnature(id);


--
-- Name: term term_schoolyearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_schoolyearid_fkey FOREIGN KEY (schoolyearid) REFERENCES schoolyear(id);


--
-- PostgreSQL database dump complete
--

