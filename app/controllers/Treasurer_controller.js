'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let TreasurerController = Object.create(null);

    const projectProposalModel = models.ProjectProposal_model;


	TreasurerController.newTransaction = (req, res) => {
		database.task(t => {
			return t.batch([
				projectProposalModel.getApprovedPPRs(t)
			]);
		}).then(data=>{
			return res.render('Org/Treasurer/NewTransaction', {
				csrfToken: req.csrfToken(),
				pprs: data[0]
			});

		}).catch(error=>{
			console.log(error);
		});
	};

    TreasurerController.newTransactionOthers = (req, res) => {
		return res.render('Org/Treasurer/NewTransactionOthers');
	};
    
	return TreasurerController;
};
