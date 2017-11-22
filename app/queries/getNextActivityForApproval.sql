WITH "CurrentTermPPR" AS (
    SELECT ppr.GOSMActivity
      FROM ProjectProposal ppr
      WHERE ppr.status = 2
        AND GOSMActivity IN (SELECT id 
                               FROM GOSMActivity ga
                              WHERE ga.GOSM IN (SELECT id 
                                                  FROM GOSM g
                                                 WHERE g.termID = system_get_current_term_id()
                                                   AND g.status = 3))
  ORDER BY id ASC
),"AccountToSign" AS ( /* The minimum type of the user to sign PPRs */
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st 
                                               ON pps.type = st.id
     WHERE pps.signatory = ${idNumber}
       AND pps.GOSMActivity IN (SELECT GOSMActivity FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
), "ProjectProposalCurrentLineup" AS ( /* The actual minimum type of each PPR*/
    SELECT pps.GOSMActivity, MIN(st.lineup) AS lineup
      FROM ProjectProposalSignatory pps LEFT JOIN SignatoryType st
                                               ON pps.type = st.id
     WHERE GOSMActivity IN (SELECT GOSMActivity FROM "CurrentTermPPR")
       AND status = 0
  GROUP BY pps.GOSMActivity
), "PPRCanSign" AS (
    SELECT * 
      FROM ProjectProposal ppr
     WHERE ppr.GOSMActivity IN (SELECT ppcl.GOSMActivity
                                  FROM "ProjectProposalCurrentLineup" ppcl INNER JOIN "AccountToSign" ats
                                                                                   ON ppcl.GOSMActivity = ats.GOSMActivity
                                                                                  AND ppcl.lineup = ats.lineup)
)
SELECT AN.NAME AS nature, AT.NAME AS type, GA.STRATEGIES AS strategies, SO.NAME AS orgname, PP.VENUE AS venue,
	   PP.ENMP AS enmp, PP.ENP AS enp, GA.OBJECTIVES AS objectives, PP.CONTEXT1 AS context1, PP.CONTEXT2 AS context2,
	   PP.CONTEXT3 AS context3, PP.ID as id, PP.SOURCEFUNDOTHER as sourcefundother, PP.SOURCEFUNDPARTICIPANTFEE AS sourcefundparticipantfee, 
	   PP.SOURCEFUNDORGANIZATIONAL, PP.ACCUMULATEDOPERATIONALFUNDS as accumulatedoperationalfunds,
	   PP.ACCUMULATEDDEPOSITORYFUNDS AS accumulateddepositoryfunds, PP.ORGANIZATIONFUNDOTHERSOURCE AS organizationfundothersource
FROM ((SELECT * FROM "PPRCanSign"
        WHERE STATUS =2
          AND dateStatusModified IS NULL
     ORDER BY dateSubmitted) 
    UNION
    (SELECT *
       FROM "PPRCanSign"
      WHERE STATUS =2
        AND dateStatusModified IS NOT NULL 
   ORDER BY dateStatusModified)
     LIMIT 1) PP LEFT JOIN GOSMACTIVITY GA
					              ON PP.GOSMACTIVITY = GA.ID
				         LEFT JOIN ACTIVITYNATURE AN
				                ON GA.ACTIVITYNATURE=AN.ID
				         LEFT JOIN ACTIVITYTYPE AT
				                ON GA.ACTIVITYTYPE=AT.ID
				         LEFT JOIN GOSM G
				                ON G.ID=GA.GOSM
				         LEFT JOIN STUDENTORGANIZATION SO
				                ON SO.ID=G.STUDENTORGANIZATION;