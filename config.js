'use strict';

/**
 * Contains configurations for the webserver
 * how to connect, what directories, etc.
 *
 * The current working directory is the file of the config.js
 * The paths are manually transformed to absoulute paths at the bottom of this script. 
 *
 * @type  {Object}
 */
const configuration = {
    "security": {
        "routes_ignore_login_required": [
            "",
            "/",
            "/system/AJAX/checkLogin",
            "/logout",
            "/ORGRES/officerSurveyForm",
            "/ORGRES/memberSurveyForm"
        ],
        "encryption": {
            "bits": 1024,
            "web_workers_amount": -1
        },
        "enable_login_check": true
    },

    "debug": {
        "enabled": true
    },

    "webserver": {
        "port": 3000,
        "url": "",
        "controllers": {
            "path": "./app/controllers"
        },
        "core_middlewares": {
            "path": "./app/core_middlewares"
        },
        "core_modules": {
            "path": "./app/core_modules"
        },
        "pre_middlewares": {
            "path": "./app/pre_middlewares"
        },
        "routes": {
            "path": "./app/routes"
        },
        "post_middlewares": {
            "path": "./app/post_middlewares"
        },
        "assets": {
            "path": "./app/assets"
        },
        "views": {
            "path": "./app/views"
        },
        "session": {
            "proxy": false,
            "name": "CSO",
            "resave": true,
            "saveUninitialized": true,
            "unset": "destroy",
            "table_name": "session",
            "rolling": true,
            "key": "replace with an autogenerated session key later or soon, siguro sa thesis-it2 na gagagawin?",
            "cookie": {
                "httpOnly": false,
                "path": "/",
                "sameSite": "strict",
                "secure": false,
                "maxAge": 3600000,
                //TODO: Replace secret with auto generated one
                "secret": "this is a place holder secret, would be replaced by an auto generated secret, kapag inimplement nalang siguro ako mag iisip :/"
            }
        },
        "easter_eggs":{
            "enable_footer_quotes": true
        },
        "email": {
        	"host": "smtp.gmail.com",
        	"port": 465,
        	"secure": true,
        	"connectionTimeout": "10000",
        	"username": "dlsum.facultyattendance@gmail.com",
        	"password": "01234567891011"
        }
    },
    "database": {
        "host": "localhost",
        "port": 5432,
        "database": "CSODB",
        "username": "postgres",
        "password": "1234",
        "query_files": {
            "path": "./app/queries",
            "compress": true,
            "minify": true
        },
        "models": {
            "path": "./app/models"
        }
    }
};

/**
 * Module to be use to resolve to absolute paths
 * @type  {function}
 */
const resolve = require('path').resolve;

/* Preprocessing of configuration data */
configuration.security.routes_ignore_login_required.sort();
/* Webserver path */
configuration.webserver.controllers.path = resolve(configuration.webserver.controllers.path);
configuration.webserver.pre_middlewares.path = resolve(configuration.webserver.pre_middlewares.path);
configuration.webserver.post_middlewares.path = resolve(configuration.webserver.post_middlewares.path);
configuration.webserver.core_modules.path = resolve(configuration.webserver.core_modules.path);
configuration.webserver.core_middlewares.path = resolve(configuration.webserver.core_middlewares.path);
configuration.webserver.assets.path = resolve(configuration.webserver.assets.path);
configuration.webserver.views.path = resolve(configuration.webserver.views.path);
/* Database paths */
configuration.database.query_files.path = resolve(configuration.database.query_files.path);
configuration.database.models.path = resolve(configuration.database.models.path);

module.exports = configuration;
