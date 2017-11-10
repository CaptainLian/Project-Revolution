-- GOAL get minimum amount of org's treasurer to sign the PPR
WITH "NumberOfToSignPerAccount" AS (
    SELECT signatory AS "account", COUNT(pprs.id) AS "numSign"
      FROM ProjectProposalSignatory pprs
     WHERE status = 0
       AND GOSMActivity IN (SELECT id
                             FROM "GOSMActivity_get_current_term_activity_ids"() )
  GROUP BY signatory
), "OrganizationTreasurerNumSign" AS (
SELECT *
  FROM "NumberOfToSignPerAccount"
 WHERE account IN (SELECT idNumber
                     FROM organization_get_treasurer_signatories("GOSMActivity_get_organization"(1)))
)
SELECT *
  FROM "OrganizationTreasurerNumSign";