'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let PNPController = Object.create(null);


	PNPController.viewPubs = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();

		return res.render('PNP/ViewPubs', renderData);
	};

	
	
	return PNPController;
};