'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);

	AdminController.viewAccountLogs = (req, res) => {
		const renderData = Object.create(null);
		renderData.extra_data = req.extra_data;
		return res.render('System/AccountLogs', renderData);
	};
	
	return AdminController;
};