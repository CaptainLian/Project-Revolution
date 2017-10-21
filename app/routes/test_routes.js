'use strict';

module.exports = function(configuration, modules, router, controllers){
	if(configuration.debug.enabled){
		router.get('/test', controllers.test_controller.test);
	}
};
