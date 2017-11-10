'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/Organization/treasurer/dashboard', controllers.Finance_controller.viewDashboard);
	router.get('/Finance/Settings', controllers.Finance_controller.viewFinanceSettings);
	router.get('/transaction', controllers.Finance_controller.createTransaction);
};
