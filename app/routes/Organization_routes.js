'use strict';

module.exports = function(configuration, modules, router, controllers){
	const base = '/Organization';

	router.get(`${base}/home`, controllers.Organization_controller.viewHome);
	router.get('/member',controllers.Organization_controller.view);
	router.get('/viewProject', controllers.Organization_controller.viewProject);
	router.get(`${base}/createGOSM`, controllers.Organization_controller.viewCreateGOSM);
	router.get(`${base}/activityRequirements`, controllers.Organization_controller.createActivityRequirements);
	router.get(`${base}/Treasurer/NewTransaction`, controllers.Treasurer_controller.newTransaction);
    router.get(`${base}/Treasurer/NewTransactionOthers`, controllers.Treasurer_controller.newTransactionOthers);

    router.get(`${base}/ProjectProposal/GOSMList`, controllers.Organization_controller.viewGOSMActivityListProjectProposal);
    router.get(`${base}/ProjectProposal/Main`, controllers.Organization_controller.viewSubmitProjectProposalMain);
    router.get(`${base}/ProjectProposal/Attachments`, controllers.Organization_controller.viewSubmitProjectProposalAttachments);
    router.get(`${base}/ProjectProposal/BriefContext`, controllers.Organization_controller.viewSubmitProjectProposalBriefContext);
    router.get(`${base}/ProjectProposal/Expense`, controllers.Organization_controller.viewSubmitProjectProposalExpense);
    router.get(`${base}/ProjectProposal/ProgramDesign`, controllers.Organization_controller.viewSubmitProjectProposalProgramDesign);


    router.post(`${base}/projectproposal/SaveContext`, controllers.Organization_controller.saveContext);
    router.post(`${base}/projectproposal/SaveDesign`, controllers.Organization_controller.saveDesign);
    router.post(`${base}/projectproposal/SaveExpenses`, controllers.Organization_controller.saveExpenses);
    router.post(`${base}/projectproposal/SaveAttachments`, controllers.Organization_controller.saveAttachments);

    router.get(`${base}/Setting/ACL`, controllers.Organization_controller.viewSettingAcl);
    router.get(`${base}/PostProjectProposal/Main`, controllers.Organization_controller.viewSubmitPostProjectProposalMain);
    router.get(`${base}/PostProjectProposal/BriefContext`, controllers.Organization_controller.viewSubmitPostProjectProposalBriefContext);
    router.get(`${base}/PostProjectProposal/Others`, controllers.Organization_controller.viewSubmitPostProjectProposalOthers);
    router.get(`${base}/PostProjectProposal/FinanceDocument`, controllers.Organization_controller.viewSubmitPostProjectProposalFinanceDocument);

};