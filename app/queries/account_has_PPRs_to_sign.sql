WITH "CurrentTermActivityIDs" AS (
    SELECT id AS GOSMActivity
      FROM GOSMActivity
     WHERE GOSM IN (SELECT id
		      FROM GOSM
		     WHERE termID = system_get_current_term_id())
)
 SELECT EXISTS(SELECT *
                 FROM ProjectProposalSignatory
                WHERE GOSMActivity IN (SELECT GOSMActivity
                                         FROM "CurrentTermActivityIDs")
                  AND signatory = ${idNumber}
                  AND status = 0) as exists;
