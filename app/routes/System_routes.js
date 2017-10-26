'use strict';
module.exports = function(configuration, modules, router, controllers){
	const systemController = controllers.System_controller;

	router.get('/', systemController.viewLogin);

	router.post('/system/AJAX/checkLogin', systemController.checkLogin);
	router.get('/logout', systemController.logout);
	router.post('/logout', systemController.logout);

	router.get('/System/Account');
	if(configuration.debug.enabled){
		router.get('/documentSign', systemController.documentSign);

		router.get('/test/view', (req, res) => {
			return res.render('APS/ActivityCheckingReworking', {
				csrfToken: req.csrfToken()
			});
		});
	}
};
