'use strict';

module.exports = function(app , controllers){
	const express = require('express');
	const router = express.Router();
	const base = '/Organization';

	router.get(`${base}/home`, controllers.Organization_controller.viewHome);
	router.get('/member',controllers.Organization_controller.view);
	router.get('/viewProject', controllers.Organization_controller.viewProject);
	router.get(`${base}/createGOSM`, controllers.Organization_controller.viewCreateGOSM);
	router.get(`${base}/activityRequirements`, controllers.Organization_controller.createActivityRequirements);
	

	return router; 
};