var express = require('express');
var app = express();

module.exports = function (app, database, models, queryFiles){
	return [
		{
			name: 'Authenticate',
			description: 'Check if user is logged in',
			route:'*',
			action: function (req, res, next){
				console.log("MID VALID == "+ req.session.valid);
				if(!req.session.valid && req._parsedUrl.pathname != '/'){
					res.render("System/403");
				}else{
					next();
				}

			} 
		},

	];
};