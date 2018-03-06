'use strict';
module.exports = function(configuration, modules, router, controllers){
	router.get('/Admin/Account/Logs', controllers.Admin_controller.viewAccountLogs);
	router.get('/Admin/Backup/import', controllers.Admin_controller.import);
	router.get('/Admin/Backup/export', controllers.Admin_controller.export);
};
