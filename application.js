module.exports = (configuration, logger) => {
	const express = require('express');

	const application = express();


	/**
	 * const priority = {
	 * 		CORE: 25,
	 * 		HIGHEST: 20,
	 * 		HIGH: 15,
	 * 		NORMAL = 10,
	 * 		LOW = 5,
	 * 		LOWEST = 0
	 * };
	 * @type {Object}
	 */
	const load_priority = Object.create(null);
	load_priority.CORE = 25;
	load_priority.HIGHEST = 20;
	load_priority.HIGH = 15;
	load_priority.NORMAL = 10;
	load_priority.LOW = 5;
	load_priority.LOWEST = 0;

	/**
	 * Contains all middlewares of the application
	 * ideally the object is structured as
	 * const middlewares = {
	 * 		core_middlewares = [
	 * 	 		{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res)
	 * 				priority: NUMBER
	 * 			}
	 * 		],
	 *
	 *		pre_middlewares = [
	 *  		{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res)
	 * 				priority: NUMBER
	 * 			}
	 *  	],
	 * 
	 * 		post_middlewares = [
	 * 			{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res, next)
	 * 				priority: NUMBER
	 * 			}
	 * 		]
	 * };
	 * @type {Object}
	 */
	const middlewares = Object.create(null);
	middlewares.core_middlewares = Object.create(null);
	middlewares.pre_middlewares = Object.create(null);
	middlewares.post_middlewares = Object.create(null);



	return application;
};