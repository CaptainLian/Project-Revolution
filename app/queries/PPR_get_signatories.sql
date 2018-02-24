SELECT
    a.idNumber as signatory,
    a.firstname || ' ' || a.lastname AS signatoryName,
    st.name AS type, ss.name AS status,
    pps.digitalSignature,
    TO_CHAR(pps.dateSigned, 'Mon DD, YYYY') AS dateSigned
  FROM (SELECT *
          FROM ProjectProposalSignatory pps
         WHERE pps.GOSMActivity = ${activityID}) pps LEFT JOIN SignatoryType st
                                                            ON pps.type = st.id
                                                     LEFT JOIN SignatoryStatus ss
                                                            ON pps.status = ss.id
                                                     LEFT JOIN Account a
                                                            ON pps.signatory = a.idNumber
ORDER BY st.lineup ASC, a.idNumber DESC;
