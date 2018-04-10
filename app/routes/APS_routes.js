'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/APS/activityChecking',controllers.APS_controller.activityChecking);
	router.get('/APS/resched', controllers.APS_controller.resched);
	router.get('/APS/home', controllers.APS_controller.home);
	router.get('/APS/viewCalendar', controllers.APS_controller.viewCalendar);
	router.get('/APS/orgSummary', controllers.APS_controller.orgSummary);
	router.get('/APS/viewOrglist', controllers.APS_controller.viewOrglist);
	router.get('/APS/viewOrgGOSM', (req, res) => {
		return res.redirect('/APS/viewOrglist');
	});
	router.get('/APS/viewOrgGOSM/:orgID/:GOSMID', controllers.APS_controller.viewOrgGOSM);

	router.get('/APS/ActivityList', controllers.APS_controller.viewActivityList);
	router.get('/APS/Logs', controllers.APS_controller.viewAPSLogs);

	router.get('/CSO/home', controllers.CSO_controller.viewExecHome);//for cso exec home

	router.get('/APS/Signatory/ActivtiyList', controllers.APS_controller.viewPPRListToSign);
	router.get('/APS/Signatory/Activtiy/:activityID', controllers.APS_controller.viewPPRSign);
	router.get('/APS/Signatory/Activtiy/', (req, res) => {
		return res.redirect('/APS/Signatory/ActivtiyList');
	});
};
