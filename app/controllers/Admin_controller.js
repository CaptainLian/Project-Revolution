'use strict';
const  PgTools= require('pg-tools');

module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);
	
	const accountModel = models.Account_model;
	


	AdminController.viewAccountLogs = (req, res) => {
		accountModel.getAccountLogs().then(data=>{
			const renderData = Object.create(null);
			renderData.extra_data = req.extra_data;
			renderData.accountLogs = data;
			renderData.csrfToken = req.csrfToken();

			return res.render('System/AccountLogs', renderData);
		});
	};

	AdminController.import = (req, res) => {
		var tool = new PgTools();
		 tool.restoreDatabase({
		    host: 'localhost'
		    , port: 5432
		    , user: 'postgres'	
		    , password: 'postgres'	    
		    ,dumpPath: '/home/shinichi/dir2/test.sql'
		    , database: 'CSODB'
		}, function (error, output, message) {
		    console.log(error)
		});
	
	};

	AdminController.export = (req, res) => {
		console.log("ASd")
		var tool = new PgTools();
		 tool.dumpDatabase({
		    host: 'localhost',
		    port: 5432,
		    user: 'postgres',
		    password: 'postgres',
		    dumpPath: '/home/shinichi/dir2/test.sql',
		    database: 'CSODB'
		}).catch(err=>{
			console.log(err)
		});	
	};
	
	return AdminController;
};