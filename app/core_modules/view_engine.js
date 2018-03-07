'use strict';
module.exports = (configuration, mainApplication) => {

    const path = require('path');
    const nunjucks = require('nunjucks');

    mainApplication.set('views', path.join(configuration.webserver.views.path));
    mainApplication.set('view engine', 'html');
    nunjucks.configure(configuration.webserver.views.path, {
        autoescape: true,
        lstripBlocks: true,
        trimBlocks: true,
        watch: configuration.debug.enabled,
        express: mainApplication
    });
};
