'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);

	const accountModel = models.Account_model;

	AdminController.viewAccountLogs = (req, res) => {

		const renderData = Object.create(null);
		renderData.extra_data = req.extra_data;

		accountModel.getAccountLogs()
		.then(data=>{

			return res.render('System/AccountLogs', renderData, {
				accountLogs: data,
				csrfToken: req.csrfToken()
			});
		}).catch(error=>{
			console.log(error);
		});
		

	};
	
	return AdminController;
};