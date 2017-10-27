'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;
    const accessControlModel = models.AccessControl_model;

    const logger = modules.logger;
    const log_options = {
        from: 'StudentAccount-AccessControl-Middleware'
    };

    const StudentAccountAccessControlMiddleware = Object.create(null);
    StudentAccountAccessControlMiddleware.name = 'StudentAccount-AccessControl-Middleware';
    StudentAccountAccessControlMiddleware.priority = configuration.load_priority.HIGHEST;
    StudentAccountAccessControlMiddleware.action = (req, res, next) => {
        const user = req.session.user;

        if (user && (user.type === 1)) {
            try {
                logger.debug(`Logged-in user: ${user.idNumber}, type: student`, log_options);
                return accessControlModel.getAccountAccessControl(user.idNumber)
                .then(data => {
                    const accessControl = Object.create(null);

                    for (let index = data.length; index--;) {
                        const row = data[index];
                        /* ES6 object destructuring */
                        const {
                            organization,
                            functionalitySequence,
                            isAllowed
                        } = row;

                        if (accessControl[organization]) {
                            accessControl[organization][functionalitySequence] = isAllowed;
                        } else {
                            const orgData = Object.create(null);
                            orgData[functionalitySequence] = isAllowed;

                            accessControl[organization] = orgData;
                        }
                    }
                    console.log(`User access control: ${JSON.stringify(accessControl)}`);
                    req.extra_data.user.accessControl = accessControl;
                    return next();
                }).catch(error => {
                    return next(error);
                });
            } catch (err) {
                return next(err);
            }
        }

        return next();
    };

    return [StudentAccountAccessControlMiddleware];
};