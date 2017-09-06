var express = require('express');
var app = express();

module.exports = function (app, database, models, queryFiles){
	if((global.config.debug.enabled && global.config.debug.enable_login_check) || !global.config.debug.enabled ){
		return [{
			name: 'Authenticate',
			description: 'Check if user is logged in',
			route:'*',
			action: function (req, res, next){
					console.log("MID VALID == "+ req.session.user);
					if(req.session.user === undefined && req._parsedUrl.pathname !== '/'){
						res.render("System/403");
					}else{
						next();
					}
				}
			},
		];
	}
	return [];
	
};
