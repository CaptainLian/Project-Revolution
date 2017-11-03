'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {

    const logger = modules.logger;
    const log_options = {
        from: 'Functionality_Sidebars-Middleware'
    };

    const accountModel = models.Account_model;
    const accessibleSidebars = require('../utility/FunctionalityAccessibleSidebars.js').functionalitySidebars;

    logger.debug(`Accessible Sidebars definition: ${JSON.stringify(accessibleSidebars)}`, log_options);

    const Sidebar_data_attacher_middleware = Object.create(null);
    Sidebar_data_attacher_middleware.name = 'Sidebar extra_data system attacher';
    Sidebar_data_attacher_middleware.priority = configuration.load_priority.HIGH;
    Sidebar_data_attacher_middleware.action = (req, res, next) => {

        if(!req.extra_data.view){
            req.extra_data.system.sidebars = Object.create(null);
            req.extra_data.system.sidebars.canAttach = false;
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to extra_data uninitialized`, log_options);
            return next();
        }

        if (!req.session.user) {
            req.extra_data.system.sidebars = Object.create(null);
            req.extra_data.system.sidebars.canAttach = false;
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to session not existent`, log_options);
            return next();
        }

        if (!req.session.user.organizationSelected) {
            req.extra_data.system.sidebars = Object.create(null);
            req.extra_data.system.sidebars.canAttach = false;
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to organization not selected`, log_options);
            return next();
        }

        if (req.method !== 'GET') {
            req.extra_data.system.sidebars = Object.create(null);
            req.extra_data.system.sidebars.canAttach = false;
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to method not GET`, log_options);
            return next();
        }
        

        req.extra_data.system.sidebars = Object.create(null);
        req.extra_data.system.sidebars.canAttach = true;
        logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}`, log_options);
        return next();
    };

    const Sidebar_view_attacher_Middleware = Object.create(null);
    Sidebar_view_attacher_Middleware.name = 'Sidebar extra_data.view attacher';
    Sidebar_view_attacher_Middleware.priority = configuration.load_priority.LOW;
    Sidebar_view_attacher_Middleware.action = (req, res, next) => {
        if(!req.extra_data.system.sidebars.canAttach){
            return next();
        }
        
        const user = req.session.user;
        const organizationSelected = user.organizationSelected;
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
                if(accessibleSidebars[functionality]){
                    for(const sidebar of accessibleSidebars[functionality]){
                        sidebars[sidebars.length] = sidebar;
                    }
                }
            }
        }

        return next();
    };

    const Sidebar_SubmitProjectProposal_Middleware = Object.create(null);
    Sidebar_SubmitProjectProposal_Middleware.name = 'Submit Project Proposal Attacher';
    Sidebar_SubmitProjectProposal_Middleware.priority = configuration.load_priority.LOW;
    Sidebar_SubmitProjectProposal_Middleware.action = (req, res, next) => {
        if(!req.extra_data.system.sidebars.canAttach){
            return next();
        }

        const user = req.session.user;
        const organizationSelected = user.organizationSelected;
        accountModel.hasGOSMActivityWithoutPPR(user.idNumber, organizationSelected.id)
        .then(activity => {
            logger.debug(`Has GOSM activity without PPR: ${activity.exists}`, log_options);
            if(activity.exists){
                const sidebars = req.extra_data.view.sidebars;
                const newSidebar = Object.create(null);
                newSidebar.name = 'Submit Project Proposal';
                newSidebar.link = '/blank';
             }
        });               

        return next();
    };
    return [
        Sidebar_data_attacher_middleware,
        Sidebar_view_attacher_Middleware,
        Sidebar_SubmitProjectProposal_Middleware
    ];
};
