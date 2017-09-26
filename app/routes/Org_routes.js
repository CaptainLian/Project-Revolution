var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	router.get('/member',controllers.Org_controller.view);
	router.get('/viewProject', controllers.Org_controller.viewProject);
	return router; 
};