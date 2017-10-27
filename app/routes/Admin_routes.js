'use strict';
module.exports = function(configuration, modules, router, controllers){
	router.get('/Admin/Account/Logs', controllers.Admin_controller.viewAccountLogs);
};
