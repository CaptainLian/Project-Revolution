'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;
    const organizationModel = models.organization_model;
    const accessControlModel = models.AccessControl_model;

    const logger = modules.logger;
    const log_options = {
        from: 'View-data-initialization'
    };

    const ViewInitializationMiddleware = Object.create(null);
    ViewInitializationMiddleware.name = 'Extra view-data initializer';
    ViewInitializationMiddleware.priority = configuration.load_priority.HIGHEST;
    ViewInitializationMiddleware.route = '/(.*)/AJAX/(.*)';
    ViewInitializationMiddleware.action = (req, res, next) => {
        req.extra_view_data = Object.create(null);
        req.extra_view_data.sidebars = [];
        logger.debug('View data Initialized', log_options);
        return next();
    };

    return [ViewInitializationMiddleware];
};
