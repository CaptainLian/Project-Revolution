'use strict';
module.exports = (configuration, mainApplicationm, modules) => {
    const path = require('path');
    const fileSystem = require('fs');

    /* Dependency */
    const pgPromise = require('pg-promise')();
    const logger = modules.logger;

    /**
     * Specifies the connection paramaters
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
    connectionOptions.promiseLib = modules.Promise;
    
    /* Loading Query files */
    logger.info('\tLoading Query Files');
    var QueryFile = pgPromise.QueryFile;
    var queryFiles = Object.create(null);
    var queryFilesDir = fileSystem.readdirSync(configuration.database.query_files.path);

    for (let index = 0, length = queryFilesDir.length; index < length; ++index) {
        if (path.extname(queryFilesDir[index]) === '.sql') {
            logger.info(`\t\tFile: ${queryFilesDir[index]}`);
            let filename = queryFilesDir[index].substring(0, queryFilesDir[index].lastIndexOf('.'));
            queryFiles[filename] = QueryFile(
                `${configuration.database.query_files.path}/${queryFilesDir[index]}`, {
                    minify: configuration.database.query_files.minify,
                    compress: configuration.database.query_files.compress
                }
            );
        }
    }
    logger.info('\tLoading Query Files Complete');

    modules.pgPromise = pgPromise;
    const db = Object.create(null);
    db.database = pgPromise(connectionOptions);
    db.queryFiles = queryFiles;
    return db;
};
