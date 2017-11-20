'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/Finance/Settings', controllers.Finance_controller.viewFinanceSettings);
	router.get('/transaction', controllers.Finance_controller.createTransaction);
	router.get('/transaction/evaluate', controllers.Finance_controller.evaluateTransaction);
	router.get('/transaction/preacts/cashadvance', controllers.Finance_controller.createPreactsCashAdvance);
	router.get('/transaction/preacts/directpayment', controllers.Finance_controller.createPreacts);
};
