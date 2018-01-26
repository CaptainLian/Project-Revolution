'use strict';
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const accountModel = models.Account_model;

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
        const user = req.session.user;
        if(req.method !== 'GET' || !user)
            return next();
        logger.debug('Attaching notifications', log_options);

        return accountModel.getNotifications(user.idNumber).then(notifications => {
            req.extra_data.view.navbar.notifications = notifications;
            return next();
        });
    };

    return [NotificationAttacher];
};
