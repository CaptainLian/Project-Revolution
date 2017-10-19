'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let AMTController = Object.create(null);

	AMTController.viewActivityEvaluation = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();

		return res.render('AMT/ActivityEvaluation', renderData);
	};

	return AMTController;
};
