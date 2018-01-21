'use strict';
module.exports = function(configuration, application, modules, database, queryFiles, models) {


    const logger = modules.logger;
    const log_options = {
        from: 'Notification-middleware'
    };

    /**
     * const StudentAccountAccessControlMiddleware = {
     *     name: 'Admin sidebar attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const NotificationAttacher = Object.create(null);
    NotificationAttacher.name = 'Account Notification Attacher';
    NotificationAttacher.priority = configuration.load_priority.LOW;
    NotificationAttacher.action = (req, res, next) => {
        return next();
    };

    return [NotificationAttacher];
};
