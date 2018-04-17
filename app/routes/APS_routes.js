'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
    const logger = modules.logger;

    logger.debug('/APS/activityChecking');
	router.get('/APS/activityChecking',controllers.APS_controller.activityChecking);
    logger.debug('/APS/resched');
	router.get('/APS/resched', controllers.APS_controller.resched);
    logger.debug('/APS/home');
	router.get('/APS/home', controllers.APS_controller.home);
    logger.debug('/APS/viewCalendar');
	router.get('/APS/viewCalendar', controllers.APS_controller.viewCalendar);
    logger.debug('/APS/orgSummary');
	router.get('/APS/orgSummary', controllers.APS_controller.orgSummary);
    logger.debug('/APS/viewOrglist');
	router.get('/APS/viewOrglist', controllers.APS_controller.viewOrglist);

	router.get('/APS/viewOrgGOSM', (req, res) => {
		return res.redirect('/APS/viewOrglist');
	});
    logger.debug('/APS/viewOrgGOSM/:orgID/:GOSMID');
	router.get('/APS/viewOrgGOSM/:orgID/:GOSMID', controllers.APS_controller.viewOrgGOSM);
    logger.debug('/APS/ActivityList');
	router.get('/APS/ActivityList', controllers.APS_controller.viewActivityList);
    logger.debug('/APS/Logs');
	router.get('/APS/Logs', controllers.APS_controller.viewAPSLogs);
    logger.debug('/APS/home');
	router.get('/CSO/home', controllers.CSO_controller.viewExecHome);//for cso exec home

	router.get('/APS/Signatory/ActivtiyList', controllers.APS_controller.viewPPRListToSign);
	router.get('/APS/Signatory/Activtiy/:activityID', controllers.APS_controller.viewPPRSign);
	router.get('/APS/Signatory/Activtiy/', (req, res) => {
		return res.redirect('/APS/Signatory/ActivtiyList');
	});
};
