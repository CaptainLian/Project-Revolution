'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
    const logger = modules.logger;
    const log_options = Object.create(null);
    
    log_options.from = 'PNP-AJAX-Controller';

	const pnpModel = models.PNP_model;
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.ProjectProposal_model;
    const accountModel = models.Account_model;

    const PNPAJAXController = Object.create(null);

	PNPAJAXController.pubsChecked = (req, res) => {
		logger.info('call pubsChecked()', log_options);

		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;

		var pubParam = {
			idNumber: req.session.user.idNumber,
			  status: req.body.stat,
			 comment: req.body.comment,
			      id: req.body.id,
			revision: req.body.revision
		};

		console.log("pubParam");
		console.log(pubParam);

		return pnpModel.updatePublicityStatus(pubParam).then(data=>{
			res.jsonp([1]);

			logger.debug('Adding notifications for project heads', log_options);
			return pnpModel.getPublicityDetails(req.body.id);
		}).then(pubDetails => {
			return database.task(t => {
				return t.batch([
					gosmModel.getActivityDetails(pubDetails.GOSMActivity, [
						'ga.strateges AS strategies'
					], t),

					gosmModel.getActivityProjectHeads(pubDetails.GOSMActivity, [
						'ph.idnumber AS "idNumber"'
					], t)
				]);
			});
		}).then(([activityDetail, projectHeads]) => {
			return database.task(t => {
				let queries = [];

				let title = `Evaluation of Publicity`;
				let description = null;
				switch(req.body.stat){
					case 1: {
						description = `Your publicity for activity: ${activityDetail.strategies} have been approved`;
					}break;

					case 2: {
						description = `Your publicity for activity: ${activityDetail.strategies} have been pended`;
					}break;

					case 3: {
						description = `Your publicity for activity: ${activityDetail.strategies} has been denied`;
					}break;
				}

				for(const projectHead of projectHeads){
					queries[queries.length] = accountModel.addNotification(
						projectHead.idNumber,
						title,
						description,
						null,
						null,
						t
					);
				}

				return t.batch(queries);
			});
		}).then(() => {
			return logger.debug('Notifications added to project heads', log_options);
		}).catch(err=>{
			return logger.error(`${err.message}: ${err.stack}`, log_options);
		});
	};


	return PNPAJAXController;
};
