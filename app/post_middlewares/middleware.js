var express = require('express');
var app = express();


module.exports = function (app, database, models, queryFiles){
	return [
		{
			name: '',
			description: '',
			action: function (req, res, next){
				next();
			} 
		},

		
		{
			name: '',
			description: '',
			route: '/',
			action: function (req, rest, next){
				next();
			}
		}
	];
};