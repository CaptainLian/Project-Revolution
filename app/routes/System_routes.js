'use strict';

var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	const systemController = controllers.System_controller;

	router.get('/', systemController.viewLogin);

	router.post('/system/AJAX/checkLogin', systemController.checkLogin);
	router.get('/logout', systemController.logout);
	router.post('/logout', systemController.logout);

	if(global.config.debug.enabled){
		router.get('/documentSign', systemController.documentSign);

		router.get('/test/view', (req, res) => {
			return res.render('APS/ActivityCheckingReworking', {
				csrfToken: req.csrfToken()
			});
		});
	}
	
	return router;
};
