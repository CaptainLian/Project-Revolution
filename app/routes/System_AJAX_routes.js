'use strict';
module.exports = function(configuration, modules, router, controllers){
	const systemController = controllers.System_controller;

	router.post('/System/AJAX/CheckLogin', controllers.System_AJAX_controller.checkLogin);
    router.post('/System/AJAX/UpdatePassword', controllers.System_AJAX_controller.updatePassword);
};
