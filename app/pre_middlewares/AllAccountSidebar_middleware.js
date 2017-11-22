'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const logger = modules.logger;
    const log_options = {
        from: 'AllAcountSidebar-Middleware'
    };
    const AccountModel = models.Account_model;

    const AllAcountSidebar = Object.create(null);
    AllAcountSidebar.name = 'All Account Sidebar';
    AllAcountSidebar.priority = configuration.load_priority.LOWEST;
    AllAcountSidebar.action = (req, res, next) => {
        if(!req.extra_data.system.sidebars.canAttach)
            return next();

        if(req.session.user.type === 1){
            logger.debug('User type 1', log_options);
            logger.debug(`Org selected: ${req.session.user.organizationSelected}`, log_options);
            if(req.session.user.organizationSelected == 0){
                logger.debug('CSO organization', log_options);
                return next();
            }
        }

        const sidebars = req.extra_data.view.sidebars;

        return AccountModel.hasPPRToSign(req.session.user.idNumber)
        .then(PPR => {
            logger.debug(`has PPR To Sign ${PPR.exists}`, log_options);
            if(PPR.exists){
                sidebars[sidebars.length] = {
                    name: 'Sign Project Proposal',
                    link: '/APS/Signatory/ActivtiyList'
                };
            }
            return next();
        });
    };

    return [AllAcountSidebar];
};
