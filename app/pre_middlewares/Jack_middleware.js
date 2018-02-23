'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const CONSTANTS_admin_sidebars = require('../utility/CONSTANTS_admin_sidebars.json');

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Jack-Middleware'

    const JackMiddleware = Object.create(null);
    JackMiddleware.name = 'Admin sidebar attacher';
    JackMiddleware.priority = configuration.load_priority.LOW;
    JackMiddleware.action = (req, res, next) => {
        return jack(next);
    };

    function jack(next){
        logger.debug('call Jack()', log_options);

        return next();
    }

    return [JackMiddleware];
};
