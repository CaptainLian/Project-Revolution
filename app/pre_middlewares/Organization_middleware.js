'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;
    const organizationModel = models.organization_model;
    const accessControlModel = models.AccessControl_model;

    const logger = modules.logger;
    const log_options = {
        from: 'Organization-Middleware'
    };

    const OrganizationMiddleware = Object.create(null);
    OrganizationMiddleware.name = 'Organization_path_attacher';
    OrganizationMiddleware.priority = configuration.load_priority.LOWEST;
    OrganizationMiddleware.action = (req, res, next) => {
        if(req.session.user){
            if(req.session.organizationSelected){
                const organization = req.session.organizationSelected;
                logger.debug('Organization selected detected', log_options);

                req.locals.extra_view_data.organizationSelected = Object.create(null);
                req.locals.extra_view_data.organizationSelected.acronym = organization.acronym;
                req.locals.extra_view_data.organizationSelected.path_profilePicture = organization.path_profilepicture;

                return next();
            }
        }
        return next();
    };

    return [OrganizationMiddleware];
};
