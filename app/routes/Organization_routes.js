'use strict';

module.exports = function(configuration, modules, router, controllers){
	const base = '/Organization';
	router.get(`${base}/ProjectHead/home`, controllers.Organization_controller.viewProjectHeadHome);

	router.get(`${base}/Officers`,controllers.Organization_controller.viewOfficers);
    router.get(`${base}/report`,controllers.Organization_controller.viewReport);
    router.get(`${base}/viewAddMember`,controllers.Organization_controller.viewAddMember);
	router.get(`${base}/createGOSM`, controllers.Organization_controller.viewCreateGOSM); 
    router.get(`${base}/viewGOSMList`, controllers.Organization_controller.viewGOSMList);//shows the list of approved gosm for the school year
	router.get(`${base}/activityRequirements`, controllers.Organization_controller.createActivityRequirements);
    router.get(`${base}/viewGOSMDetails/:orgid`, controllers.Organization_controller.viewGOSMDetails);//shows the list of approved gosm for the school year

    router.get(`${base}/additional`, controllers.Organization_controller.additional);
    
    router.get(`${base}/ProjectProposal/GOSMList`, controllers.Organization_controller.viewGOSMActivityListProjectProposal);
    router.get(`${base}/ProjectProposal/Main/:id/:status`, controllers.Organization_controller.viewSubmitProjectProposalMain);
    router.get(`${base}/ProjectProposal/Attachments/:id/:gid/:status`, controllers.Organization_controller.viewSubmitProjectProposalAttachments);
    router.get(`${base}/ProjectProposal/BriefContext/:id/:status`, controllers.Organization_controller.viewSubmitProjectProposalBriefContext);
    router.get(`${base}/ProjectProposal/Expense/:id/:revenue/:status`, controllers.Organization_controller.viewSubmitProjectProposalExpense);
    router.get(`${base}/ProjectProposal/ProgramDesign/:id/:status`, controllers.Organization_controller.viewSubmitProjectProposalProgramDesign);

    router.get(`${base}/Setting/ACL`, controllers.Organization_controller.viewSettingAcl);
    router.post(`${base}/Setting/ACL/Save`, controllers.Organization_controller.saveAcl);

    router.post(`${base}/projectproposal/SaveContext`, controllers.Organization_controller.saveContext);
    router.post(`${base}/projectproposal/SaveExpenses`, controllers.Organization_controller.saveExpenses);
    router.post(`${base}/projectproposal/SaveDesign/`, controllers.Organization_controller.saveDesign);
    router.post(`${base}/projectproposal/SavePPR`, controllers.Organization_controller.savePPR);
    router.post(`${base}/projectproposal/SaveAttachments`, controllers.Organization_controller.saveAttachments);

    router.get(`${base}/projectproposal/projectproposaldetails/:gosmactivity`, controllers.Organization_controller.viewActivityDetails);


    //POST PROJECT POST
    router.post(`${base}/PostProjectProposal/SaveContext`, controllers.Organization_controller.postSaveContext);
    router.post(`${base}/PostProjectProposal/SaveExpenses`, controllers.Organization_controller.postSaveExpenses);
    router.post(`${base}/PostProjectProposal/SaveAttachments`, controllers.Organization_controller.postSaveAttachments);
    router.post(`${base}/PostProjectProposal/Main`, controllers.Organization_controller.postSaveMain);

    //POST PROJECT
    router.get(`${base}/PostProjectProposal/Completed/:gosmid`, controllers.Organization_controller.viewCompletedPostActs);
    router.get(`${base}/PostProjectProposal/GOSMList`, controllers.Organization_controller.viewGOSMActivityListPostProjectProposal);
    router.get(`${base}/PostProjectProposal/Main/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalMain);
    router.get(`${base}/PostProjectProposal/BriefContext/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalBriefContext);
    router.get(`${base}/PostProjectProposal/RequiredDocument/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalOthers);
    router.get(`${base}/PostProjectProposal/viewSubmitPostProjectProposalFinanceDocument/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalFinanceDocument);

    //PNP
    router.get(`${base}/Publicity/list`, controllers.Organization_controller.viewPubs);
    router.get(`${base}/Publicity/Create/:gosmid`, controllers.Organization_controller.viewPubsSpecific);
    router.post(`${base}/Publicity/Insert`, controllers.Organization_controller.insertPubs);
    router.post(`${base}/Publicity/modal`, controllers.Organization_controller.viewPubDetails);
    router.post(`${base}/Publicity/Reupload`, controllers.Organization_controller.reuploadPubs);

    //Treasurer
    router.get(`${base}/treasurer/dashboard`, controllers.Treasurer_controller.viewDashboard);

    router.get(`${base}/Orgres/list`, controllers.Organization_controller.orgresLists);
    router.get(`${base}/Orgres/Specific/:id`, controllers.Organization_controller.orgresSpecficActivity);

    router.get(`${base}/APSReport`, controllers.Organization_controller.apsReport);

};
