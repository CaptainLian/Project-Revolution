'use strict';

module.exports = function(configuration, modules, router, controllers){

	if(configuration.debug.enabled){
		
		const attachExtraRenderData = require('../utility/attachExtraRenderData.js');
		const log_options = Object.create(null);
		log_options.from = 'TEST ROUTES';

		const logger = modules.logger;
		logger.error('Attaching test routes! Disable debug mode for production environments', log_options);
		configuration.security.routes_ignore_login_required.push('/test');
		router.get('/test', controllers.test_controller.test);
		configuration.security.routes_ignore_login_required.push('/account');
		router.get('/account', controllers.test_controller.account);
		configuration.security.routes_ignore_login_required.push('/notification');
		router.get('/notification', controllers.test_controller.notification);
		configuration.security.routes_ignore_login_required.push('/account');
		router.get('/account', controllers.test_controller.account);
		
		configuration.security.routes_ignore_login_required.sort();
	}
};
