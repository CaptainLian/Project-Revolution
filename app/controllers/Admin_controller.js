'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);

	AdminController.viewAccountLogs = (req, res) => {
		const renderData = Object.create(null);
		renderData.extra_view_data = req.extra_view_data;
		return res.render('System/AccountLogs', renderData);
	};
	
	return AdminController;
};