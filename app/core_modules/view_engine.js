'use strict';
module.exports = (configuration, mainApplication) => {
    const path = require('path');
    const expressNunjucks = require('express-nunjucks');

    mainApplication.set('views', path.join(configuration.webserver.views.path));
    mainApplication.set('view engine', 'html');

    let njk = expressNunjucks(mainApplication, {
        watch: configuration.debug.enabled,
        autoescape: true,
        lstripBlocks: true,
        trimBlocks:true
    });
};
