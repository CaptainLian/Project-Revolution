'use strict';

module.exports = function(configuration, modules, router, controllers){
	const base = '/Organization';

	router.get(`${base}/home`, controllers.Organization_controller.viewHome);
	router.get('/member',controllers.Organization_controller.view);
	router.get('/viewProject', controllers.Organization_controller.viewProject);
	router.get(`${base}/createGOSM`, controllers.Organization_controller.viewCreateGOSM);
	router.get(`${base}/activityRequirements`, controllers.Organization_controller.createActivityRequirements);
	router.get(`${base}/Treasurer/NewTransaction`, controllers.Treasurer_controller.newTransaction);
};
