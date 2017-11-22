'use strict';
var timediff = require('timediff');
module.exports = function(configuration, modules, models, database, queryFiles){
	let ADM_controller = Object.create(null);

	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'ADM-Controlller';

	const amtModel = models.ActivityMonitoring_model;
	const systemModel = models.System_model;
    const pnpModel = models.PNP_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const gosmModel = models.gosmModel;
    
    const path = require('path');

	ADM_controller.viewActivityToCheck = (req, res) => {
		

		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();

		postProjectProposalModel.getPostActsToCheck()
				.then(data=>{
					console.log(data);
					console.log("data");
					renderData.postacts = data
					res.render('ADM/ActivityList', renderData);
				})
		
		
		
	};
	ADM_controller.viewActivity = (req, res) => {
		

		database.task(t=>{
                var dbParam = {
                    gosmid:req.params.id
                }
                
                return t.batch([
                        postProjectProposalModel.getPostActsDetails(dbParam,t),
                        postProjectProposalModel.getLatestEventPicture(dbParam,t),
                        postProjectProposalModel.getLatestPostExpense(dbParam,t)
                        // projectProposalModel.getProjectProposalProjectHeads(3)
                        ]);
            }).then(data=>{
                console.log(data);
                console.log("data[1]");
                
                const renderData = Object.create(null);
                renderData.activity = data[0]
                renderData.pictures=data[1]
                renderData.expense = data[2];
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                res.render('ADM/ActivityToCheck',renderData)
            }).catch(err=>{
                console.log(err);
            })
		
		
		
		
	};
	
	
	return ADM_controller;
};