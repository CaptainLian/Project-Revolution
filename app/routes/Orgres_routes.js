'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/ORGRES/Manage/Account',controllers.ORGRES_controller.viewManageAccount);
	router.get('/ORGRES/Manage/Time',controllers.ORGRES_controller.viewManageTime);
	router.get('/ORGRES/Manage/Organization',controllers.ORGRES_controller.viewManageOrg);
	
	router.post('/orgres/time/submit',controllers.ORGRES_controller.submitTime);

};
