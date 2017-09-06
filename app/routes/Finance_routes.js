var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	console.log(controllers);
	router.get('/financeD', controllers.Finance_controller.viewDashboard);
	return router; 
}