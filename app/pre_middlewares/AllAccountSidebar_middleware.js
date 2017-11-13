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
        const sidebars = req.extra_data.view.sidebars;

        return AccountModel.hasPPRToSign(req.session.user.idNumber)
        .then(PPR => {
            if(PPR.exists){
                sidebars[sidebars.length] = {
                    name: 'Sign Project Proposal',
                    //TODO: list of PPR to sign
                    link: '/blank'
                };
            }
            return next();
        });
    };

    return [AllAcountSidebar];
};
