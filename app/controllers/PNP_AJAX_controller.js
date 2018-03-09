'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'PNP-AJAX-Controller';

	const pnpModel = models.PNP_model;
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.ProjectProposal_model;
    
    let PNPAJAXController = Object.create(null);

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
			return res.jsonp([1]); 
		}).catch(err=>{
			return logger.error(`${err.message}: ${err.stack}`, log_options);
		});
	};	

	
	return PNPAJAXController;
};