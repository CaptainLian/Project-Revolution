UPDATE projectproposalsignatory
   SET status=${status},
       sectionstoedit = NULL,
       document = NULL,
       digitalSignature = NULL,
       dateSigned = NULL
 WHERE gosmactivity=${gosmactivity};
