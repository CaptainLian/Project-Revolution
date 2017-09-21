var express = require('express');
var app = express();

const logger = global.logger;
const log_options = {
    from: 'Error_postware'
};

module.exports = function(app, database, models, queryFiles) {
    return [{
        name: 'Bad CSRF Token',
        action: function(err, req, res, next) {
            if (err.code === 'EBADCSRFTOKEN') {
                logger.warning(`Bad CSRF token: ${req.session.csrfSecret}`, log_options);
                res.status(403);
                res.render('System/403');
                return;
            }
            next(err);
        }
    }, {
        name: 'Error 404',
        description: 'For unset/unknown URLs',
        action: function(req, res, next) {
            logger.warning(`Error 404 original URL: ${req.originalUrl}, url: ${req.url}`, log_options);
            var err = new Error('Not Found');
            err.status = 404;
            res.render('System/404');
        }
    }, {
        name: 'Error 500',
        description: 'Generalized error logging',
        action: function(err, req, res, next) {
            let {message, stack} = err;

            // render the error page
            logger.error(`${message}\n${stack}`);
            res.status(err.status || 500);
            res.render('error', {
                message: message,
                stack: stack
            });
        }
    }];
};