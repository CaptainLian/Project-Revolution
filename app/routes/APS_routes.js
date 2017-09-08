var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	router.get('/createGOSM', controllers.APS_controller.viewCreateGOSM);
	router.get('/home', controllers.APS_controller.home);

	router.post('/getActivityDetails', controllers.APS_controller.getActivityDetails);

	router.get('/activityRequirements', controllers.APS_controller.createActivityRequirements);
	router.post('/activityRequirements', controllers.APS_controller.inputActivityRequirements);

	router.post('/createGOSM', controllers.APS_controller.inputCreateGOSM);
	router.post('/deleteActivity', controllers.APS_controller.deleteActivity);
	router.post('/submitGOSM', controllers.APS_controller.submitGOSM);

	router.get('/viewOrglist', controllers.APS_controller.viewOrglist);
	router.get('/viewOrgGOSM/', function(req, res){
		res.redirect('/viewOrglist');
	});
	router.get('/viewOrgGOSM/:orgID/:GOSMID', controllers.APS_controller.viewOrgGOSM);

	router.get('/viewActivityList', controllers.APS_controller.activityList);

	return router;
};
