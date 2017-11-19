SELECT id, gosmactivity, status, enp, enmp, to_char(actualdatestart, 'MM/DD/YYYY') AS actualdatestart,
	   to_char(actualdateend, 'MM/DD/YYYY') AS actualdateend,
       venue, context1, context2, context3, isexpense, sourcefundother, 
       sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, 
       accumulateddepositoryfunds, organizationfundothersource, comments, 
       preparedby, facultyadviser, datecreated, datesubmitted, datestatusmodified, 
       isattachmentscomplete, isbriefcontextcomplete, isexpensecomplete, 
       isprogramcomplete
  FROM PROJECTPROPOSAL
 WHERE GOSMACTIVITY=${gosmactivity};