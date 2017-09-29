'use strict';

var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	

	router.get('/activityChecking',controllers.APS_controller.activityChecking);


	router.get('/APS/viewOrglist', controllers.APS_controller.viewOrglist);
	router.get('/APS/viewOrgGOSM', (req, res) => {
		res.redirect('/APS/viewOrglist');
	});
	router.get('/APS/viewOrgGOSM/:orgID/:GOSMID', controllers.APS_controller.viewOrgGOSM);

	router.get('/APS/ActivityList', controllers.APS_controller.viewActivityList);

	return router;
};
