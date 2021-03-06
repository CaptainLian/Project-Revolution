'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/ADM';

	router.get(`${base}/Activity/List`, controllers.ADM_controller.viewActivityToCheck);
	router.get(`${base}/main`, controllers.ADM_controller.viewHome);
	router.get(`${base}/viewGOSM`, controllers.ADM_controller.viewGOSM);
	router.get(`${base}/viewCalendar/:orgid`, controllers.ADM_controller.viewCalendar);
	router.get(`${base}/viewGrades`, controllers.ADM_controller.viewGrades);
	router.get(`${base}/viewOrgTerms`, controllers.ADM_controller.viewOrgTerms);
	router.get(`${base}/Activity/:id`, controllers.ADM_controller.viewActivity);
	router.post(`${base}/Activity/Save`, controllers.ADM_controller.updateStatus);
};

