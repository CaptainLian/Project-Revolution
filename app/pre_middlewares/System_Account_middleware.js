var express = require('express');
var app = express();

const logger = global.logger;
const log_options = {from: 'Authenticate'};
module.exports = function (app, database, models, queryFiles){
	if((global.config.debug.enabled && global.config.debug.enable_login_check) || !global.config.debug.enabled ){
		return [{
			name: 'Authenticate',
			description: 'Check if user is logged in',
			route:'*',
			action: function (req, res, next){
					const session = req.session;
					if(session.user === undefined && req._parsedUrl.pathname !== '/'){
						logger.debug('User Not Logged-in!', log_options);
						res.render("System/403");
					}else{
						logger.debug('Passed!', log_options);
						logger.debug(`Logged-in user: ${session.user}`, log_options);
					logger.debug(`Session: ${JSON.stringify(session)}`,log_options);
						next();
					}
				}
			},
		];
	}
	return [];
	
};
