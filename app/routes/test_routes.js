'use strict';

module.exports = function(app , controllers){
	const express = require('express');
	const router = express.Router();

	if(global.config.debug.enabled){
		router.get('/test', controllers.test_controller.test);
	}

	return router; 
};