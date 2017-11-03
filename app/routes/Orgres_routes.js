'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/ORGRES/ManageAccount',controllers.ORGRES_controller.viewManageAccount);
	// router.get('/ORGRES/ManageOrganization',controllers.ORGRES_controller.viewManageOrg);
	

};
