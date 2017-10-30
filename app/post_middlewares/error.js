const log_options = {
    from: 'Error_postware'
};

module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const logger = modules.logger;
    return [{
        name: 'Bad CSRF Token',
        priority: configuration.load_priority.NORMAL,
        action: function(err, req, res, next) {
            if (err.code === 'EBADCSRFTOKEN') {
                logger.warning(`Bad CSRF token: ${req.session.csrfSecret}`, log_options);
                res.status(403);
                res.render('System/403');
                return;
            }
            return next(err);
        }
    }, {
        name: 'Error 404',
        description: 'For unset/unknown URLs',
        priority: configuration.load_priority.NORMAL,
        action: function(req, res, next) {
            logger.warning(`Error 404 original URL: ${req.originalUrl}, url: ${req.url}`, log_options);
            var err = new Error('Not Found');
            err.status = 404;
            return res.render('System/404');
        }
    }, {
        name: 'Error 500',
        description: 'Generalized error logging',
        priority: configuration.load_priority.NORMAL,
        action: function(err, req, res, next) {
            let {message, stack} = err;

            // render the error page
            logger.error(`${message}\n${stack}`);
            res.status(err.status || 500);
            return res.render('error', {
                message: message,
                stack: stack
            });
        }
    }];
};
