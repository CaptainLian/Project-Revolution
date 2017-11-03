'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {

    const logger = modules.logger;
    const log_options = {
        from: 'Functionality_Sidebars-Middleware'
    };

    const accessibleSidebars = require('../utility/FunctionalityAccessibleSidebars.js').functionalitySidebars;

    logger.debug(`Accessible Sidebars definition: ${JSON.stringify(accessibleSidebars)}`, log_options);


    const SidebarMiddleware = Object.create(null);
    SidebarMiddleware.name = 'Organization_path_attacher';
    SidebarMiddleware.priority = configuration.load_priority.LOW;
    SidebarMiddleware.action = (req, res, next) => {

        const user = req.session.user;
        if (!user) {
            return next();
        }

        const organizationSelected = user.organizationSelected;
        if (!organizationSelected) {
            return next();
        }

        if (req.method !== 'GET') {
            return next();
        }
        
        logger.debug('Organization selected detected', log_options);

        req.extra_data.view.organizationSelected = Object.create(null);
        req.extra_data.view.organizationSelected.acronym = organizationSelected.acronym;
        req.extra_data.view.organizationSelected.path_profilePicture = organizationSelected.path_profilepicture;

        const accessibleFunctionalitiesList = req.extra_data.user.accessibleFunctionalitiesList;
        const sidebars = req.extra_data.view.sidebars;

        for(const functionality in accessibleFunctionalitiesList){
            logger.debug(`functionality: ${functionality}`, log_options);
            if(accessibleFunctionalitiesList[functionality]){
                logger.debug(`\tsidebars: ${JSON.stringify(accessibleSidebars[functionality])}`, log_options);
                for(const sidebar of accessibleSidebars[functionality]){
                    sidebars[sidebars.length] = sidebar;
                }
            }
        }

        return next();
    };
    return [SidebarMiddleware];

};
