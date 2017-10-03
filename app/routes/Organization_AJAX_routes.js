'use strict';

module.exports = function(app , controllers){
	const express = require('express');
	const router = express.Router();
	const base = '/Organization/AJAX';

	//Pag add ng activity 
	router.post(`${base}/createGOSM`, controllers.Organization_controller.inputCreateGOSM);
	//Pass with status change
	router.post(`${base}/submitGOSM`, controllers.Organization_controller.submitGOSM);

	router.post(`${base}/getActivityDetails`, controllers.APS_controller.getActivityDetails);

	router.post(`${base}/deleteActivity`, controllers.Organization_controller.deleteActivity);
	router.post(`${base}/updateActivity`, controllers.Organization_controller.updateActivity);
	router.post(`${base}/activityRequirements` , controllers.Organization_controller.inputActivityRequirements);

	return router; 
};