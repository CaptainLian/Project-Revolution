'use strict';
module.exports = (configuration, mainApplication, modules) => {
    const middlewareMaker = require('../utility/middleware_maker.js');

    const logger = modules.logger;

	const loggerMiddleware = middlewareMaker(
        'HTTP Logger',
        'Logs HTTP/s based transactions',
        configuration.load_priority.HIGHEST,
        (req, res, next) => {
            const responseStart = Date.now();

            res.on('finish', () => {
              const response = Date.now() - responseStart;
              let statusColor = '';
              if(res.statusCode >= 500){
                statusColor = '\x1b[31m';
              }else if(res.statusCode >= 400){
                statusColor = '\x1b[33m';
              }else if(res.statusCode >= 300){
                statusColor = '\x1b[36m';
              }else if(res.statusCode >= 200){
                statusColor = '\x1b[32m';
              }else{
                statusColor = '\x1b[35m';
              }

              logger.debug(
                `\x1b[32m${req.method}\x1b[0m "${req.url}" ${statusColor}${res.statusCode}\x1b[0m (${res.statusMessage}) - ${response}ms`, {
                  from: 'HTTP'
                }
              );
            });
            next();
        }
    );

    return loggerMiddleware;
};
