'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const logger = modules.logger;
    const log_options = {
        from: 'ExtraData_Initialization-Middleware'
    };

    const SessionData_middleware = Object.create(null);
    SessionData_middleware.name = 'SessionData extra_data attacher';
    SessionData_middleware.priority = configuration.load_priority.HIGH;
    SessionData_middleware.action = (req, res, next) => {
        if(req.session.user){
            req.extra_data.user.name = req.session.user.name.last;
        }
        
        return next();
    };

    return [SessionData_middleware];
};