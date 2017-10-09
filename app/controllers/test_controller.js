'use strict';
module.exports = function(database, models, queryFiles){
	let testController = Object.create(null);

	testController.test = (req, res) => {
		models.organization_model.getOrganizationStructure(0)
		.then(data => {
			return res.send(data);
		}).catch(err => {
			console.log(err);
		});
	};
	
	return testController;
};