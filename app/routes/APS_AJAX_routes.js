var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	router.get('/APS/ajax/GetGOSMActivityDetails', controllers.APS_AJAX_controller.getGOSMActivityDetails);
	router.post('/APS/ajax/GetGOSMActivityDetails', controllers.APS_AJAX_controller.getGOSMActivityDetails);
	return router; 
}