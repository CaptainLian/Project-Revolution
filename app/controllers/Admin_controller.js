'use strict';
const  PgTools = require('pg-tools');
const  configuration = require('../../config.js');

module.exports = function(configuration, modules, models, database, queryFiles){
	const AdminController = Object.create(null);
	const path =  require('path')
	const accountModel = models.Account_model;
	    var Class = require('ee-class')
            , util = require('util')            
            , exec = require('child_process').exec
            , fs = require('fs')
            , asyncMethod = require('async-method');
	


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

	AdminController.import = (req, res) => {
		var tool = new PgTools();
		//  tool.restoreDatabase({
		//     host: 'localhost'
		//     , port: 5432
		//     , user: 'postgres'	
		//     , password: 'postgres'	    
		//     ,dumpPath: '/home/shinichi/dir2/test.sql'
		//     , database: 'CSODB'
		// }, function (error, output, message) {
		//     console.log(error)
		// });
	
	};

	AdminController.export = (req, res) => {
		var filename = Date.parse(new Date())+'.sql';
		var dir = path.join(__dirname,'..','backup/'+filename );
		var command,ls;
		
		if(configuration.database.password == ""){
			console.log("1st")
			command = util.format('pg_dumpall -c -h %s -p %d --data-only -U %s --file=%s -l %s --no-password', configuration.database.host, configuration.database.port, configuration.database.username, dir, configuration.database.database);        
	        console.log(command)
	        ls = exec(command);
	        
		}else{
			console.log("2st")
			command = util.format('pg_dumpall -c -h %s -p %d --data-only -U %s --file=%s -l %s --password %s', configuration.database.host, configuration.database.port, configuration.database.username, dir, configuration.database.database, configuration.database.password);        
	        console.log(command)
	        ls = exec((command), function(err, out, code) {
				
				});

	        ls.stdin.write(configuration.database.password+" \n")  
		}
		
  
	};
	
	return AdminController;
};