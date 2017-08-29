var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	var index = controllers.index_controller;
	var gosm = controllers.gosmController;
	router.get('/viewOrglist', gosm.viewOrglist);
	router.get('/viewOrgGOSM', gosm.viewOrgGOSM);
	router.get('/viewActivityList', gosm.activityList);
	return router;
};

