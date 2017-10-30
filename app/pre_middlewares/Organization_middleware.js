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
    OrganizationMiddleware.priority = configuration.load_priority.LOW;
    OrganizationMiddleware.action = (req, res, next) => {
        const user = req.session.user.organizationSelected || {organizationSelected: false};
        if(req.method === 'GET'){
            if(user.organizationSelected){
                const organization = req.session.organizationSelected;
                logger.debug('Organization selected detected', log_options);

                req.extra_data.view.organizationSelected = Object.create(null);
                req.extra_data.view.organizationSelected.acronym = organization.acronym;
                req.extra_data.view.organizationSelected.path_profilePicture = organization.path_profilepicture;
            }


            const accessibleFunctionalitiesList = req.extra_data.user.accessibleFunctionalitiesList;

            //Can create GOSM?
            if(accessibleFunctionalitiesList[0]){
                logger.debug('User can submit GOSM', log_options);
                let sidebars= req.extra_data.view.sidebars;

                sidebars[sidebars.length] = {
                    name: 'Submit GOSM',
                    link: '/Organization/createGOSM'
                };
            }    
        }
        return next();
    };

    return [OrganizationMiddleware];
};
