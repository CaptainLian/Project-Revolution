'use strict';
module.exports = (configuration, mainApplication, modules) => {
	const middlewareMaker = require('../utility/middleware_maker.js');

    return middlewareMaker(
        'CSRF protection',
        undefined,
        configuration.load_priority.LOWEST,
        require('csurf')({
        	cookie: false,
        	ignoreMethods: ['GET', 'HEAD', 'OPTIONS'],
        	sessionKey: 'session'
        })
    );
};
