'use strict';
module.exports = (configuration, mainApplication) => {

    const path = require('path');
    const nunjucks = require('nunjucks');

    mainApplication.set('views', path.join(configuration.webserver.views.path));
    mainApplication.set('view engine', 'html');
    nunjucks.configure(configuration.webserver.views.path, {
        autoescape: true,
        express: mainApplication
    });
};
