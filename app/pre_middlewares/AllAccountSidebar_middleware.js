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

        const sidebars = req.extra_data.view.sidebars;
        return AccountModel.hasPPRToSign(req.session.user.idNumber)
        .then(PPR => {
            logger.debug(`Has PPR To Sign ${PPR.exists}`, log_options);
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
