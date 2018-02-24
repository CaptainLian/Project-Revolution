'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const CONSTANTS_FACULTYADMIN_SIDEBARS = require('../utility/CONSTANTS_FacultyAdmin_sidebars.json');

    const logger = modules.logger;
    const log_options = {
        from: 'FacultyAdmin-Sidebar-Middleware'
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
        if(!req.extra_data.system.sidebars.canAttach || (req.session.user.type < 3 || req.session.user.type > 6))
            return next();

        logger.debug(`Attaching admin sidebars` ,log_options);

        const sidebars = req.extra_data.view.sidebars;    
        for(const sidebar of CONSTANTS_FACULTYADMIN_SIDEBARS){
            sidebars[sidebars.length] = sidebar;
        }
        
        return next();
    };

    return [SidebarAttacher];
};
