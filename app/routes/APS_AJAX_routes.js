'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/APS/ajax';
	router.post(`${base}/GetGOSMActivityDetails`, controllers.APS_AJAX_controller.getGOSMActivityDetails);
	router.post(`${base}/UpdateGOSM`, controllers.APS_AJAX_controller.updateGOSM);
	router.post(`${base}/UpdateGOSMActivityComment`, controllers.APS_AJAX_controller.updateGOSMActivityComment);
	router.post(`${base}/getProjectProposaActivityDetails`, controllers.APS_AJAX_controller.getProjectProposalActivityDetails);
	router.post(`/APS/ajax/activityChecking`, controllers.APS_AJAX_controller.activityChecking);

	if(configuration.debug.enabled){
		router.get('/APS/ajax/GetGOSMActivityDetails', controllers.APS_AJAX_controller.getGOSMActivityDetails);
		router.get('/APS/ajax/UpdateGOSM', controllers.APS_AJAX_controller.updateGOSM);
		router.get('/APS/ajax/UpdateGOSMActivityComment', controllers.APS_AJAX_controller.updateGOSMActivityComment);
		router.get('/APS/ajax/getProjectProposaActivityDetails', controllers.APS_AJAX_controller.getProjectProposalActivityDetails);
	}
};
