'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const CONSTANTS_FACULTY_SIDEBARS = require('../utility/CONSTANTS_Faculty_sidebars.json');

    const logger = modules.logger;
    const log_options = {
        from: 'Faculty-Sidebar-Middleware'
    };

    /**
     * const StudentAccountAccessControlMiddleware = {
     *     name: 'Admin sidebar attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const SidebarAttacher = Object.create(null);
    SidebarAttacher.name = 'Faculty Admin sidebar attacher';
    SidebarAttacher.priority = configuration.load_priority.LOW;
    SidebarAttacher.action = (req, res, next) => {
        if(!req.extra_data.system.sidebars.canAttach || (req.session.user.type !== 2))
            return next();

        logger.debug(`Attaching faculty sidebars` ,log_options);

        const sidebars = req.extra_data.view.sidebars;
        for(const sidebar of CONSTANTS_FACULTY_SIDEBARS){
            sidebars[sidebars.length] = sidebar;
        }

        return next();
    };

    return [SidebarAttacher];
};
