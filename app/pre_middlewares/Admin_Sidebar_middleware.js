'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;
    const accessControlModel = models.AccessControl_model;

    const logger = modules.logger;
    const log_options = {
        from: 'Admin-Sidebar-Middleware'
    };

    /**
     * const StudentAccountAccessControlMiddleware = {
     *     name: 'Admin sidebar attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const AdminSidebarAttacher = Object.create(null);
    AdminSidebarAttacher.name = 'Admin sidebar attacher';
    AdminSidebarAttacher.priority = configuration.load_priority.LOW;
    AdminSidebarAttacher.action = (req, res, next) => {
        logger.debug(`Attaching admin sidebars` ,log_options);
       if(req.extra_data.system.sidebars.canAttach && req.session.user.type === 0){

       }

       return next();
    };

    return [AdminSidebarAttacher];
};