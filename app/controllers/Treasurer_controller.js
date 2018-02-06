'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let TreasurerController = Object.create(null);

    const projectProposalModel = models.ProjectProposal_model;

    TreasurerController.viewDashboard = (req, res) => {
    	const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;

		return res.render('Org/Treasurer/Dashboard', renderData);
	};


	TreasurerController.newTransaction = (req, res) => {
		database.task(t => {
			return t.batch([

			//TODO: replace activity ID
			projectProposalModel.getApprovedPPRs(0)

			]);
		}).then(data => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            renderData.pprs = data[0];
			return res.render('Org/Treasurer/NewTransaction', renderData);
		});
	};

    TreasurerController.newTransactionOthers = (req, res) => {
    	const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
		return res.render('Org/Treasurer/NewTransactionOthers', renderData);
	};

	return TreasurerController;
};
