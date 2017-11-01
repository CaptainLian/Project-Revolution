'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);
	
	const accountModel = models.Account_model;

	AdminController.viewAccountLogs = (req, res) => {
		accountModel.getAccountLogs()
		.then(data=>{
			const renderData = Object.create(null);
			renderData.extra_data = req.extra_data;
			renderData.accountLogs = data;
			renderData.csrfToken = req.csrfToken();

			return res.render('System/AccountLogs', renderData);
		});
	};
	
	return AdminController;
};