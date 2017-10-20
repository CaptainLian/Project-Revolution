'use strict';
module.exports = (configuration, mainApplication, modules) => {
    const middlewareMaker = require('../utility/middleware_maker.js');

	const assetMiddleWare = middlewareMaker(
        'Assets folder routes',
        'Logs HTTP/s based transactions',
        configuration.load_priority.HIGH,
        modules.express.static(configuration.webserver.assets.path)
    );

    return assetMiddleWare;
};
