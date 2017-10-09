'use strict';

module.exports = function(app , controllers){
	const express = require('express');
	const router = express.Router();
	const base = '/AMT';

	router.get(`${base}/EvaluateActivity`, controllers.AMT_controller.viewActivityEvaluation);

	return router; 
};