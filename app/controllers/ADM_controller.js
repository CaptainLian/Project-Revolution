'use strict';
var timediff = require('timediff');
module.exports = function(configuration, modules, models, database, queryFiles){
	let ADM_controller = Object.create(null);

	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'ADM-Controlller';

	const amtModel = models.ActivityMonitoring_model;
	const projectProposalModel = models.ProjectProposal_model;

	ADM_controller.viewActivityToCheck = (req, res) => {
		

		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();
		
		
		
		
	};
	ADM_controller.viewActivity = (req, res) => {
		

		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();
		res.render('ADM/ActivityToCheck',renderData)
		
		
		
	};
	
	
	return ADM_controller;
};