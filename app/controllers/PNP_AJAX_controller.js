'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let PNPAJAXController = Object.create(null);
	const pnpModel = models.PNP_model;
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.ProjectProposal_model;

	PNPAJAXController.pubsChecked = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;
		console.log("ASDASDASDASDASDASDASDASDASDASDASD")

		var pubParam = {
			idNumber: req.session.user.idNumber,
			status: req.body.stat,
			comment:req.body.comment,
			id:req.body.id,
			revision:(req.body.revision)
		}
		console.log("pubParam");
		console.log(pubParam);
		return pnpModel.updatePublicityStatus(pubParam).then(data=>{
			return res.jsonp([1]); 
		}).catch(err=>{
			console.log(err);
		});
	};	

	
	return PNPAJAXController;
};