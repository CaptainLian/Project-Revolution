'use strict';

var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	const systemController = controllers.System_controller;

	router.get('/', systemController.viewLogin);
	router.post('/', systemController.checkLogin);

	router.get('/logout', systemController.logout);
	router.post('/logout', systemController.logout);

	router.get('/documentSign', systemController.documentSign);

	return router;
};
