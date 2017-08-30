var express = require('express');
var app = express();

module.exports = function (app, database, models, queryFiles){
	return [
		{
			name: 'First',
			description: '',
			action: function (req, res, next){
				console.log("TITS ni harambe");
				next();
			} 
		},


		{
			name: 'Second',
			description: '',
			route: '/',
			action: function (req, rest, next){
				next();
			}
		}
	];
};