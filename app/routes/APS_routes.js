'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/APS/activityChecking',controllers.APS_controller.activityChecking);
	router.get('/APS/viewOrglist', controllers.APS_controller.viewOrglist);
	router.get('/APS/viewOrgGOSM', (req, res) => {
		res.redirect('/APS/viewOrglist');
	});
	router.get('/APS/viewOrgGOSM/:orgID/:GOSMID', controllers.APS_controller.viewOrgGOSM);

	router.get('/APS/ActivityList', controllers.APS_controller.viewActivityList);
	router.get('/APS/Logs', controllers.APS_controller.viewAPSLogs);
};
