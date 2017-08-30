var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	router.get('/login', controllers.SYSTEM_controller.login);	
	router.post('/login', controllers.SYSTEM_controller.inputLogin);	
	return router;
};

