'use strict';
var fileSystem = require('fs');

module.exports = {
	webserver:{
		port: 3000,
		url: '',
		controllers:{
			path: './app/controllers'
		},
		pre_middlewares:{
			path: './app/pre_middlewares'
		},
		routes: {
			path: './app/routes'
		},
		post_middlewares:{
			path: './app/post_middlewares'
		},
		assets:{
			path: './app/assets'
		},
		views:{
			path: './app/views'
		}
	},
	/* 
		connection details to the database
	*/
	database: {
		host: 'localhost',
		port: 5432,
		database: 'CSODB',
		username: 'postgres',
		password: '',
		query_files:{
			path: './app/queries'
		},
		models: {
			path: './app/models'
		}
	}
};