'use strict';



module.exports = function(app , controllers){
	const express = require('express');
	const router = express.Router();

	router.get('/Organization/home', controllers.Organization_controller.viewHome);
	router.get('/member',controllers.Organization_controller.view);
	router.get('/viewProject', controllers.Organization_controller.viewProject);

	return router; 
};