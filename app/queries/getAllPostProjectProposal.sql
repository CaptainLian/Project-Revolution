SELECT PPP."GOSMActivity", PPP."preparedBy", PPP.status, PPP."dateCreated", PPP."ANP", PPP."ANMP", 
       PPP.objectives, PPP."WATTTWITA", PPP."WWYGLIETA", PPP."HDTATYLCTTDOTP", PPP."WATTWWAWCYDTPTFHA", 
       PPP.galsfilename, PPP."galsfilenameToShow", PPP."isBriefContextCompleted", 
       PPP."isOtherFinanceDocumentsCompleted", PPP."isFinanceDocumentCompleted", 
       PPP."isCheckedDP", PPP."isCheckedR", PPP."isCheckedBT", PPP.comments, PPP."sectionsToBeEdited", 
       PPP.document, PPP."checkedByStage1", PPP."signatureStage1", PPP."checkedByStage2", 
       PPP."signatureStage2", G.studentorganization, PPR.actualdatestart
  FROM public."PostProjectProposal" PPP JOIN GOSMACTIVITY GA
                                          ON GA.id=PPP."GOSMActivity"
                                        JOIN GOSM G
                                          ON G.id=GA.GOSM
                                        JOIN PROJECTPROPOSAL PPR
                                          ON PPR.GOSMACTIVITY=GA.id
 WHERE G.TERMID=system_get_current_term_id();
