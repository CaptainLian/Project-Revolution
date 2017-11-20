'use strict';

module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/APS/ajax';
	router.post(`${base}/GetGOSMActivityDetails`, controllers.APS_AJAX_controller.getGOSMActivityDetails);
	router.post(`${base}/UpdateGOSM`, controllers.APS_AJAX_controller.updateGOSM);
	router.post(`${base}/UpdateGOSMActivityComment`, controllers.APS_AJAX_controller.updateGOSMActivityComment);
	router.post(`${base}/getProjectProposaActivityDetails`, controllers.APS_AJAX_controller.getProjectProposalActivityDetails);
	router.post(`${base}/activityChecking`, controllers.APS_AJAX_controller.activityChecking);

    router.post(`${base}/SignProjectProposal`, controllers.APS_AJAX_controller.SignProjectProposal);

	if(configuration.debug.enabled){
		router.get(`${base}/GetGOSMActivityDetails`, controllers.APS_AJAX_controller.getGOSMActivityDetails);
		router.get(`${base}/ajax/UpdateGOSM`, controllers.APS_AJAX_controller.updateGOSM);
		router.get(`${base}/UpdateGOSMActivityComment`, controllers.APS_AJAX_controller.updateGOSMActivityComment);
		router.get(`${base}/getProjectProposaActivityDetails`, controllers.APS_AJAX_controller.getProjectProposalActivityDetails);

        router.get(`${base}/SignProjectProposal`, controllers.APS_AJAX_controller.SignProjectProposal);
	}
};
