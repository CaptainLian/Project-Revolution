'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const logger = modules.logger;
    const log_options = {
        from: 'ExtraData_Initialization-Middleware'
    };

    const ExtraDataInitialization = Object.create(null);
    ExtraDataInitialization.name = 'ExtraData Initialization';
    ExtraDataInitialization.priority = configuration.load_priority.CORE;
    ExtraDataInitialization.action = (req, res, next) => {
        req.extra_data = Object.create(null);
        logger.debug('Extra data initialized', log_options);

        if(req.method === 'GET'){
            req.extra_data.view = Object.create(null);
            req.extra_data.view.sidebars = [];
            logger.debug('View data initialized', log_options);
        }
        req.extra_data.user = Object.create(null);
        logger.debug('User data initialized', log_options);

        req.extra_data.system = Object.create(null);
        logger.debug('System data initialized', log_options);
        
        return next();
    };

    return [ExtraDataInitialization];
};