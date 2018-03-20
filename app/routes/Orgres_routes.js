'use strict';
module.exports = function (configuration, modules, router, controllers, models, database, queryFiles){
	router.get('/ORGRES/Manage/Account',controllers.ORGRES_controller.viewManageAccount);
	router.get('/ORGRES/Manage/Time',controllers.ORGRES_controller.viewManageTime);
	router.get('/ORGRES/Manage/Organization',controllers.ORGRES_controller.viewManageOrg);
	router.get('/ORGRES/viewHome',controllers.ORGRES_controller.viewHome);

	router.get('/ORGRES/officerSurveyForm', controllers.ORGRES_controller.officerSurveyForm);
	router.get('/ORGRES/memberSurveyForm', controllers.ORGRES_controller.memberSurveyForm);

	router.post('/ORGRES/submitOfficerSurveyForm', controllers.ORGRES_controller.submitOfficerSurveyForm);
	router.post('/ORGRES/submitMemberSurveyForm', controllers.ORGRES_controller.submitMemberSurveyForm);

	router.get('/ORGRES/SubmitActivityResearchForm', controllers.ORGRES_controller.viewSubmitResearchActivityForm);
	router.post('/ORGRES/SubmitResearchForm', controllers.ORGRES_controller.submitResearchActivityForm);
	router.post('/orgres/time/submit',controllers.ORGRES_controller.submitTime);

};
