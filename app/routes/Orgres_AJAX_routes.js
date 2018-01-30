'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.post('/ORGRES/AJAX/SaveAccount',controllers.ORGRES_controller.saveAccount);
	router.post('/ORGRES/AJAX/DeleteAccount',controllers.ORGRES_controller.deleteAccount);
	router.post('/ORGRES/AJAX/Info',controllers.ORGRES_controller.getInfo);
	router.post('/ORGRES/AJAX/getSpecificAccount',controllers.ORGRES_controller.getSpecificAccount);
	

};
