'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/Finance/Settings', controllers.Finance_controller.viewFinanceSettings);
	router.get('/transaction', controllers.Finance_controller.createTransaction);

	router.get('/transaction/evaluate/:transaction/:id', controllers.Finance_controller.evaluateTransaction);

	router.get('/transaction/preacts/cashadvance/:gosmactivity/:projectproposal', controllers.Finance_controller.createPreactsCashAdvance);
	router.get('/transaction/preacts/directpayment/:gosmactivity', controllers.Finance_controller.createPreacts);
	router.get('/transaction/preacts/booktransfer/:gosmactivity', controllers.Finance_controller.createPreactsBookTransfer);

	router.post('/transaction/submitPreacts', controllers.Finance_controller.submitPreacts);
	router.post('/transaction/approveCashAdvance', controllers.Finance_controller.approveCashAdvance);
	router.post('/transaction/pendCashAdvance', controllers.Finance_controller.pendCashAdvance);

	router.get('/finance/list', controllers.Finance_controller.viewFinanceList);
	router.get('/finance/list/transaction/:gosmactivity', controllers.Finance_controller.viewTransaction)

};
