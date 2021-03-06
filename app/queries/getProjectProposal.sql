SELECT id, gosmactivity, status, enp, enmp, to_char(actualdatestart, 'MM/DD/YYYY') AS actualdatestart,
	   to_char(actualdateend, 'MM/DD/YYYY') AS actualdateend, to_char(actualdatestart, 'MonthDD, YYYY') AS startdate,
       venue, context1, context2, context3, isexpense, sourcefundother, 
       sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, 
       accumulateddepositoryfunds, organizationfundothersource, comments, 
       preparedby, facultyadviser, datecreated, datesubmitted, datestatusmodified, 
       isattachmentscomplete, isbriefcontextcomplete, isexpensecomplete, 
       isprogramcomplete, to_char(NOW(), 'Month DD, YYYY') AS currentdate,
       to_char(NOW(), 'YYYY-MM-DD') AS currdate, to_char(actualdateend, 'YYYY-MM-DD') AS actualedate
  FROM PROJECTPROPOSAL
 WHERE GOSMACTIVITY=${gosmactivity};