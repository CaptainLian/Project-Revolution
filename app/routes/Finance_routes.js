'use strict';

var express = require('express');
var router = express.Router();

module.exports = function(app , controllers){
	router.get('/financeD', controllers.Finance_controller.viewDashboard);
	router.get('/transaction', controllers.Finance_controller.createTransaction);
	return router; 
};