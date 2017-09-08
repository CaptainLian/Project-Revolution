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
            logger.debug('Error 404', log_options);
            var err = new Error('Not Found');
            err.status = 404;
            res.render('System/404');
        }
    }, {
        name: 'Error 500',
        description: 'Generalized error logging',
        action: function(err, req, res, next) {
            // render the error page
            console.log(err);
            logger.error(err.toString());
            res.status(err.status || 500);
            res.render('error', {
                message: err.message,
                error: err
            });
        }
    }];
};