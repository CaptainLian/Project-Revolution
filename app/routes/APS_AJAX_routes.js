'use strict';

var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	const base = '/APS/ajax';
	router.post(`${base}/GetGOSMActivityDetails`, controllers.APS_AJAX_controller.getGOSMActivityDetails);
	router.post(`${base}/UpdateGOSM`, controllers.APS_AJAX_controller.updateGOSM);
	router.post(`/APS/ajax/UpdateGOSMActivityComment`, controllers.APS_AJAX_controller.updateGOSMActivityComment);
	router.post(`/APS/ajax/getProjectProposaActivityDetails`, controllers.APS_AJAX_controller.getProjectProposalActivityDetails);
	router.post(`/APS/ajax/activityChecking`, controllers.APS_AJAX_controller.activityChecking);
	if(global.config.debug.enabled){
		router.get('/APS/ajax/GetGOSMActivityDetails', controllers.APS_AJAX_controller.getGOSMActivityDetails);
		router.get('/APS/ajax/UpdateGOSM', controllers.APS_AJAX_controller.updateGOSM);
		router.get('/APS/ajax/UpdateGOSMActivityComment', controllers.APS_AJAX_controller.updateGOSMActivityComment);
		router.get('/APS/ajax/getProjectProposaActivityDetails', controllers.APS_AJAX_controller.getProjectProposalActivityDetails);
	}

	return router; 
};