var express = require('express');
var app = express();

const logger = global.logger;
const log_options = {
    from: 'Authenticate'
};
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    if ((configuration.debug.enabled && configuration.debug.enable_login_check) || !configuration.debug.enabled) {
        return [{
            name: 'Authenticate',
            description: 'Check if user is logged in',
            route: '*',
            priority: configuration.load_priority.NORMAL,
            action: function(req, res, next) {
                const session = req.session;
                if (typeof session.user === 'undefined' && req._parsedUrl.pathname !== '/') {
                    logger.debug('User Not Logged-in!', log_options);
                    res.status(405);
                    res.render("System/403");
                } else {
                    logger.debug('Passed!', log_options);
                    logger.debug(`Logged-in user: ${session.user}`, log_options);
                    logger.debug(`Session: ${JSON.stringify(session)}`, log_options);
                    return next();
                }
            }
        }];
    }
    return [];
};
