var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	router.get('/createGOSM', controllers.APS_controller.viewCreateGOSM);
	router.post('/createGOSM', controllers.APS_controller.inputCreateGOSM);
	return router;
};

