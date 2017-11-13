'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let PNPController = Object.create(null);
	const pnpModel = models.PNP_model;

	PNPController.viewPubs = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;

		return res.render('PNP/ViewPubs', renderData);
	};	

	PNPController.viewPubsList = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;
		pnpModel.getPubsToCheck()
			.then(pubs=>{
				renderData.pubs = pubs;
				return res.render('PNP/PubsToCheck', renderData);
			}).catch(err=>{
				console.log("ERROR VIEW PUB");
				console.log(err);
			})

		
	};	
	
	return PNPController;
};