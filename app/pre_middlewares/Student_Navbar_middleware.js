'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;

    const logger = modules.logger;
    const log_options = {
        from: 'Student-Navbar-middleware'
    };

    /**
     * const StudentAccountAccessControlMiddleware = {
     *     name: 'Admin sidebar attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const StudentSidebarAttacher = Object.create(null);
    StudentSidebarAttacher.name = 'Admin sidebar attacher';
    StudentSidebarAttacher.priority = configuration.load_priority.LOW;
    StudentSidebarAttacher.action = (req, res, next) => {
    logger.debug(`Attaching student navbar data` ,log_options);

       return next();
    };

    return [StudentSidebarAttacher];
};