var express = require('express');
var app = express();

const logger = global.logger;

module.exports = function (app, database, models, queryFiles){
	return [
		{
			name: 'Error 404',
			description: 'For unset/unknown URLs',
			action: function(req, res, next) {
			  var err = new Error('Not Found');
			  err.status = 404;
			  res.render('System/404');
			}
		},
		
		{
			name: 'Error 500',
			description: 'Generalized error logging',
			action: function(err, req, res, next) {
			  // render the error page
			  res.status(err.status || 500);
			  res.render('error',{message:err.message, error:err});
			  logger.error(err);
			}
		}
	
	];
};