var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	router.get('/', controllers.SYSTEM_controller.viewLogin);
	
	router.post('/', controllers.SYSTEM_controller.checkLogin);
	router.get('/logout', controllers.SYSTEM_controller.logout);
	router.get('/documentSign',controllers.SYSTEM_controller.documentSign);
	return router; 
}