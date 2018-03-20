'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/Finance/Settings', controllers.Finance_controller.viewFinanceSettings);
	router.get('/Finance/viewHome', controllers.Finance_controller.viewHome);
	router.get('/transaction', controllers.Finance_controller.createTransaction);
	router.get('/transaction/preacts/', controllers.Finance_controller.viewFinanceList);
	router.get('/transaction/evaluate/:transaction/:id', controllers.Finance_controller.evaluateTransaction);

	router.get('/transaction/preacts/edit/', controllers.Treasurer_controller.editPreactsCashAdvance);

	router.get('/transaction/preacts/cashadvance/:gosmactivity', controllers.Finance_controller.createPreactsCashAdvance);
	router.get('/transaction/preacts/directpayment/:gosmactivity', controllers.Finance_controller.createPreactsDirectPayment);
	router.get('/transaction/preacts/booktransfer/:gosmactivity', controllers.Finance_controller.createPreactsBookTransfer);
	router.get('/transaction/reimbursement/:gosmactivity', controllers.Finance_controller.createReimbursement);

	router.get('/transaction/preacts/editCashAdvance/:id', controllers.Finance_controller.editPreactsCashAdvance);
	router.get('/transaction/preacts/editDirectPayment/:id', controllers.Finance_controller.editPreactsDirectPayment);
	router.get('/transaction/preacts/editBookTransfer/:id', controllers.Finance_controller.editPreactsBookTransfer);
	router.get('/transaction/editReimbursement/:id', controllers.Finance_controller.editReimbursement);

	router.post('/transaction/submitEditCashAdvance', controllers.Finance_controller.submitEditCashAdvance);
	router.post('/transaction/submitEditDirectPayment', controllers.Finance_controller.submitEditDirectPayment);
	router.post('/transaction/submitEditBookTransfer', controllers.Finance_controller.submitEditBookTransfer);
	router.post('/transaction/submitEditReimbursement', controllers.Finance_controller.submitEditReimbursement);

	router.post('/transaction/submitPreacts', controllers.Finance_controller.submitPreacts);
	router.post('/transaction/submitPreactsDirectPayment', controllers.Finance_controller.submitPreactsDirectPayment);
	router.post('/transaction/submitPreactsBookTransfer', controllers.Finance_controller.submitPreactsBookTransfer);
	router.post('/transaction/submitReimbursement', controllers.Finance_controller.submitReimbursement);
	router.post('/transaction/approveCashAdvance', controllers.Finance_controller.approveCashAdvance);
	router.post('/transaction/pendCashAdvance', controllers.Finance_controller.pendCashAdvance);
	router.post('/transaction/approveDirectPayment', controllers.Finance_controller.approveDirectPayment);
	router.post('/transaction/pendDirectPayment', controllers.Finance_controller.pendDirectPayment);
	router.post('/transaction/approveBookTransfer', controllers.Finance_controller.approveBookTransfer);
	router.post('/transaction/pendBookTransfer', controllers.Finance_controller.pendBookTransfer);
	router.post('/transaction/approveReimbursement', controllers.Finance_controller.approveReimbursement);
	router.post('/transaction/pendReimbursement', controllers.Finance_controller.pendReimbursement);

	router.get('/finance/list', controllers.Finance_controller.viewFinanceList);
	router.get('/finance/list/transaction/:gosmactivity', controllers.Finance_controller.viewTransaction);

};
