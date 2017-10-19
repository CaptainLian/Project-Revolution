const path = require('path');

const configuration = {
    "debug": {
        "enabled": true,
        "enable_login_check": false
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
            "key": "replace with an autogenerated session key",
            "cookie": {
                "httpOnly": false,
                "path": "/",
                "sameSite": "strict",
                "secure": false,
                "maxAge": 3600000,
                //TODO: Replace secret with auto generated one
                "secret": "this is a place holder secret, would be replaced by an auto generated secret"
            }
        },
        "encryption": {
            "bits": 1024,
            "web_workers_amount": -1
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

configuration.webserver.controllers.path = path.resolve(configuration.webserver.controllers.path);
configuration.webserver.pre_middlewares.path = path.resolve(configuration.webserver.pre_middlewares.path);
configuration.webserver.post_middlewares.path = path.resolve(configuration.webserver.post_middlewares.path);
configuration.webserver.core_modules.path = path.resolve(configuration.webserver.core_modules.path);
configuration.webserver.core_middlewares.path = path.resolve(configuration.webserver.core_middlewares.path);
configuration.webserver.assets.path = path.resolve(configuration.webserver.assets.path);
configuration.webserver.views.path = path.resolve(configuration.webserver.views.path);

configuration.database.query_files.path = path.resolve(configuration.database.query_files.path);
configuration.database.models.path = path.resolve(configuration.database.models.path);

module.exports = configuration;
