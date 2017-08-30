var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	router.get('/', controllers.SYSTEM_controller.viewLogin);
	
	router.post('/', controllers.SYSTEM_controller.checkLogin);
	return router; 
}