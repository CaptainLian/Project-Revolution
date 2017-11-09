'use strict';
module.exports = (configuration, mainApplication, modules) => {
	const middlewareMaker = require('../utility/middleware_maker.js');

    return middlewareMaker(
        'File protection',
        undefined,
        configuration.load_priority.HIGHEST,
        require('express-fileupload')()
    );
};
