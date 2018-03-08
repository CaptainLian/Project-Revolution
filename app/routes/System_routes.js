'use strict';
module.exports = function(configuration, modules, router, controllers){
	const systemController = controllers.System_controller;

	router.get('/', systemController.viewLogin);

	router.get('/logout', systemController.logout);
	router.post('/logout', systemController.logout);

	router.get('/home', systemController.viewHome);

	if(configuration.debug.enabled){
		router.get('/documentSign', systemController.documentSign);

		router.get('/test/view', (req, res) => {
			return res.render('APS/ActivityCheckingReworking', {
				csrfToken: req.csrfToken()
			});
		});
	}

    router.get('/blank', (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        
        return res.render('System/blank', renderData);
    });

    router.get('/System/ChangeOrganization/:organization', controllers.System_controller.studentChangeOrganization);

    router.get('/System/ChangeExpiredPassword', controllers.System_controller.viewChangeExpiredPassword);
    router.get('/System/ChangePassword', controllers.System_controller.viewChangePassword);
};
