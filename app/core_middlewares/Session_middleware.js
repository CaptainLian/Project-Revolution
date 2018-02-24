module.exports = (configuration, mainApplication, modules) => {

    const middlewareMaker = require('../utility/middleware_maker.js');

    /* Required modules */
    const pg = require('pg');
    const session = require('express-session');
    const pgSession = require('connect-pg-simple')(session);
    const pool = require('pg-pool');

    const session_config = configuration.webserver.session;

    /**
     * const connectionOptions = {
     *  host: configuration.database.host;
     *  port: configuration.database.port;
     *  database: configuration.database.database;
     *  user: configuration.database.username;
     *  password: configuration.database.password;
     * }
     * @type {Object}
     */
    const connectionOptions = Object.create(null);
    connectionOptions.host = configuration.database.host;
    connectionOptions.port = configuration.database.port;
    connectionOptions.database = configuration.database.database;
    connectionOptions.user = configuration.database.username;
    connectionOptions.password = configuration.database.password;

    return middlewareMaker(
        'Sessions',
        undefined,
        configuration.load_priority.NORMAL,
        session({
          store: new pgSession({
            pool: new pool(connectionOptions),
            tableName: session_config.table_name
          }),
          // proxy: session_config.proxy,
          name: session_config.name,
          rolling: session_config.rolling,
          resave: session_config.resave,
          saveUninitialized: session_config.saveUninitialized,
          unset: session_config.unset,
          //TODO: replace with auto generated secret
          secret: 'this is a place holder secret, would be replaced by an auto generated secret',
          cookie: {
            httpOnly: session_config.cookie.httpOnly,
            path: session_config.cookie.path,
            sameSite: session_config.cookie.sameSite,
            secure: session_config.cookie.secure,
            maxAge: session_config.cookie.maxAge
          }
        })
    );
};
