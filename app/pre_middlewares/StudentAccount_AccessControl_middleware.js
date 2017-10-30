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
        logger.debug(`Extra-data contents: ${JSON.stringify(req.extra_data)}`, log_options);
        const user = req.session.user;

        if (user && (user.type === 1) && req.method === 'GET') {
            try {
                logger.debug(`Logged-in user: ${user.idNumber}, type: student`, log_options);
                return accessControlModel.getAccountAccessControl(user.idNumber)
                .then(data => {
                    const accessControl = Object.create(null);
                    const accessibleFunctionalitiesList = Object.create(null);

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

                        if(accessibleFunctionalitiesList[functionalitySequence]){
                            accessibleFunctionalitiesList[functionalitySequence] = accessibleFunctionalitiesList[functionalitySequence] || isAllowed;
                        }else{
                            accessibleFunctionalitiesList[functionalitySequence] = isAllowed;
                        }
                    }
                    logger.debug(`User access control: ${JSON.stringify(accessControl)}`, log_options);
                    logger.debug(`Accessible functions list: ${JSON.stringify(accessibleFunctionalitiesList)}`, log_options);
                    req.extra_data.user.accessControl = accessControl;
                    req.extra_data.user.accessibleFunctionalitiesList = accessibleFunctionalitiesList;
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