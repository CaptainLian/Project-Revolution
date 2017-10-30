'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);

	const accountModel = models.Account_model;

	AdminController.viewAccountLogs = (req, res) => {

		accountModel.getAccountLogs()
		.then(data=>{

			return res.render('System/AccountLogs', {
				accountLogs: data,
				csrfToken: req.csrfToken()
			});
		}).catch(error=>{
			console.log(error);
		});
	};


	return AdminController;
};