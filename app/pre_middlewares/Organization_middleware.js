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
                logger.debug('Organization selected detected', log_options);
                req.extra_view_data.organizationSelected = Object.create(null);
                organizationModel.getOrganizationInformation(req.session.organizationSelected.id, [
                    'acronym',
                    'path_profilePicture'
                ])
                .then(data => {
                    req.extra_view_data.organizationSelected.acronym = data.acronym;
                    req.extra_view_data.organizationSelected.path_profilePicture = data.path_profilepicture;

                    return accessControlModel.isAllowedAccessFunctionality(
                        req.session.user.idNumber,
                        0,
                        req.session.user.organizationSelected/10000
                    );
                }).then(data => {
                    const sidebar = Object.create(null);
                    sidebar.name = 'Submit Organization GOSM';
                    sidebar.link = '/Organization/CreateGOSM';
                    req.extra_view_data.sidebars[req.extra_view_data.sidebars.length] = sidebar;
                    return next();
                }).catch(err => {
                    return next(err);
                });
            }
        }
        return next();
    };

    return [OrganizationMiddleware];
};
