'use strict';

module.exports = function(configuration, modules, router, controllers){
	if(configuration.debug.enabled){
		const attachExtraRenderData = require('../utility/attachExtraRenderData.js');
		const log_options = Object.create(null);
		log_options.from = 'TEST ROUTES';

		const logger = modules.logger;
		router.get('/test', controllers.test_controller.test);
		router.get('/blank', (req, res) => {
			const renderData = attachExtraRenderData(undefined, req);
			logger.debug(JSON.stringify(renderData), log_options);
			return res.render('System/blank', renderData);
		});
	}
};
