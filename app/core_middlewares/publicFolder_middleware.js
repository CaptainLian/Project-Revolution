'use strict';
module.exports = (configuration, mainApplication, modules) => {
    const middlewareMaker = require('../utility/middleware_maker.js');

	const assetMiddleWare = middlewareMaker(
        'Assets folder routes',
        'Contains routes for public assets',
        configuration.load_priority.HIGH,
        modules.express.static(configuration.webserver.assets.path)
    );

    return assetMiddleWare;
};
