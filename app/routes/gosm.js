var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	var index = controllers.index_controller;
	var gosm = controllers.gosmController;

	router.get('/createGOSM', gosm.viewCreateGOSM);
	router.post('/createGOSM', gosm.inputCreateGOSM);
	return router;
};

