var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	router.get('/createGOSM', controllers.APS_controller.viewCreateGOSM);
	router.get('/activityRequirements', controllers.APS_controller.createActivityRequirements);
	router.post('/createGOSM', controllers.APS_controller.inputCreateGOSM);
	router.post('/activityRequirements', controllers.APS_controller.inputActivityRequirements);
	return router;
};

