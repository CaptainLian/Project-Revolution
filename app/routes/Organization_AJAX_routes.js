'use strict';

module.exports = function(configuration, modules, router, controllers){
	const base = '/Organization/AJAX';

	//Pag add ng activity
	router.post(`${base}/createGOSM`, controllers.Organization_controller.inputCreateGOSM);

	router.post(`${base}/checkRatio`, controllers.Organization_controller.checkRatio);
	//Pass with status change
	router.post(`${base}/submitGOSM`, controllers.Organization_controller.submitGOSM);

	router.post(`${base}/getActivityDetails`, controllers.APS_controller.getActivityDetails);

	router.post(`${base}/deleteActivity`, controllers.Organization_controller.deleteActivity);
	router.post(`${base}/updateActivity`, controllers.Organization_controller.updateActivity);


	router.post(`${base}/addMember`, controllers.Organization_controller.addMember);
	router.post(`${base}/deleteMember`, controllers.Organization_controller.deleteMember);

	router.post(`${base}/treasurer/ShowNewTransaction`, controllers.Treasurer_AJAX_controller.showNewTransaction);

	//PNP

};
