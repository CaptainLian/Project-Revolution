'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const logger = modules.logger;
    const ignoreRoutes = configuration.security.routes_ignore_login_required;
    const contains = modules.collections.utilities.linearSearchContains;
    const log_options = Object.create(null);
    log_options.from = 'System-Account_middleware';

    if ((configuration.debug.enabled && configuration.security.enable_login_check) || !configuration.debug.enabled) {
        return [{
            name: 'Authenticate',
            description: 'Check if user is logged in',
            priority: configuration.load_priority.HIGH,
            action: function(req, res, next) {
                const session = req.session;

                logger.debug('Checking if user is logged-in', log_options);
                /* Must be logged in to enter */
                if(((typeof session.user) !== 'undefined') || contains(ignoreRoutes, req._parsedUrl.pathname)){
                    logger.debug('User is logged-in or accessing an ignored route', log_options);
                    return next();
                }else{
                    logger.debug('User is not logged-in', log_options);
                    res.status(405);
                    return res.render('System/403');
                }
            }
        }];
    }
    return [];
};
