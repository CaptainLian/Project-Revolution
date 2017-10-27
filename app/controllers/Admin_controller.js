'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);

	AdminController.viewAccountLogs = (req, res) => {
		return res.render('System/AccountLogs');
	};


	return AdminController;
};