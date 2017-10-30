'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let TreasurerAJAXController = Object.create(null);

    const projectProposalModel = models.ProjectProposal_model;

    TreasurerAJAXController.showNewTransaction = (req, res) =>{
    	database.task(t => {
			//TODO: replace with chosen activity id
			var activityId = 1;

			return t.batch([
				projectProposalModel.getProjectProposalExpenses(activityId)
			]);
		}).then(data=>{

		}).catch(error=>{
			console.log(error);
		});
    };
	
    
	return TreasurerAJAXController;
};
