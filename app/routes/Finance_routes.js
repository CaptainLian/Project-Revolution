'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/financeD', controllers.Finance_controller.viewDashboard);
	router.get('/transaction', controllers.Finance_controller.createTransaction);
};
