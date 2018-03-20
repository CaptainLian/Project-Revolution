'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.post('/ORGRES/AJAX/SaveAccount',controllers.ORGRES_controller.saveAccount);
	router.post('/ORGRES/AJAX/DeleteAccount',controllers.ORGRES_controller.deleteAccount);
	router.post('/ORGRES/AJAX/UpdateAccount',controllers.ORGRES_controller.updateAccount);
	router.post('/ORGRES/AJAX/getSpecificAccount',controllers.ORGRES_controller.getSpecificAccount);
	router.post('/ORGRES/AJAX/idNumber',controllers.ORGRES_controller.idNumberCheck);
	// router.post('/ORGRES/AJAX/getRolesTaken',controllers.ORGRES_controller.getRolesTaken);
	

};
