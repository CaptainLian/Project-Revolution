'use strict';

module.exports = function(configuration, modules, router, controllers){
	const base = '/Organization';
	router.get(`${base}/ProjectHead/home`, controllers.Organization_controller.viewProjectHeadHome);

	router.get(`${base}/Officers`,controllers.Organization_controller.viewOfficers);
	router.get(`${base}/APSReport`, controllers.Organization_controller.viewAPSReport);
	router.get(`${base}/createGOSM`, controllers.Organization_controller.viewCreateGOSM);
	router.get(`${base}/activityRequirements`, controllers.Organization_controller.createActivityRequirements);
	router.get(`${base}/Treasurer/NewTransaction`, controllers.Treasurer_controller.newTransaction);
    router.get(`${base}/Treasurer/NewTransactionOthers`, controllers.Treasurer_controller.newTransactionOthers);

    router.get(`${base}/ProjectProposal/GOSMList`, controllers.Organization_controller.viewGOSMActivityListProjectProposal);
    
    router.get(`${base}/ProjectProposal/Main/:id/:status`, controllers.Organization_controller.viewSubmitProjectProposalMain);
    router.get(`${base}/ProjectProposal/Attachments/:id`, controllers.Organization_controller.viewSubmitProjectProposalAttachments);
    router.get(`${base}/ProjectProposal/BriefContext/:id`, controllers.Organization_controller.viewSubmitProjectProposalBriefContext);
    router.get(`${base}/ProjectProposal/Expense/:id`, controllers.Organization_controller.viewSubmitProjectProposalExpense);
    router.get(`${base}/ProjectProposal/ProgramDesign/:id`, controllers.Organization_controller.viewSubmitProjectProposalProgramDesign);



    router.post(`${base}/projectproposal/SaveContext/:id/:ppr`, controllers.Organization_controller.saveContext);
    router.post(`${base}/projectproposal/SaveDesign/`, controllers.Organization_controller.saveDesign);


    router.post(`${base}/projectproposal/SavePPR`, controllers.Organization_controller.savePPR);

    router.post(`${base}/projectproposal/SaveExpenses`, controllers.Organization_controller.saveExpenses);
    router.post(`${base}/projectproposal/SaveAttachments`, controllers.Organization_controller.saveAttachments);
    router.get(`${base}/PostProjectProposal/GOSMList`, controllers.Organization_controller.viewGOSMActivityListPostProjectProposal);
    router.post(`${base}/PostProjectProposal/SaveContext`, controllers.Organization_controller.postSaveContext);    
    router.post(`${base}/PostProjectProposal/SaveExpenses`, controllers.Organization_controller.postSaveExpenses);
    // router.post(`${base}/postprojectproposal/SaveAttachments`, controllers.Organization_controller.postSaveAttachments);

    router.get(`${base}/Setting/ACL`, controllers.Organization_controller.viewSettingAcl);
    router.get(`${base}/PostProjectProposal/Main/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalMain);
    router.get(`${base}/PostProjectProposal/BriefContext/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalBriefContext);
    router.get(`${base}/PostProjectProposal/RequiredDocument/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalOthers);
    router.get(`${base}/PostProjectProposal/FinanceDocument/:gosmid`, controllers.Organization_controller.viewSubmitPostProjectProposalFinanceDocument);

};