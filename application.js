module.exports = (configuration, logger) => {
    const express = require('express');
    /**
     * The main application
     * @type {Express-Application}
     */
	const application = express();

    /**
     * Modules used for within the application
     * @type {Object}
     */
    const modules = Object.create(null);
    modules.express = express;
    modules.logger = logger;
    modules.Promise = require('bluebird');
    modules.collections = require('./app/utility/collections.js');
    modules.attachExtraRenderData = require('./app/utility/attachExtraRenderData.js');
    /**
     * Application components helper modules
     */
     const requireDir = require('require-dir');

	/**
	 * const priority = {
	 * 		CORE: 25,
	 * 		HIGHEST: 20,
	 * 		HIGH: 15,
	 * 		NORMAL = 10,
	 * 		LOW = 5,
	 * 		LOWEST = 0
	 * };
	 * @type {Object}
	 */
	const load_priority = Object.create(null);
	load_priority.CORE = 25;
	load_priority.HIGHEST = 20;
	load_priority.HIGH = 15;
	load_priority.NORMAL = 10;
	load_priority.LOW = 5;
	load_priority.LOWEST = 0;
    configuration.load_priority = load_priority;

	/**
	 * Contains all middlewares of the application
	 * ideally the object is structured as
	 * const middlewares = {
	 * 		core_middlewares = [
	 * 	 		{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res)
	 * 				priority: NUMBER
	 * 			}
	 * 		],
	 *
	 *		pre_middlewares = [
	 *  		{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res)
	 * 				priority: NUMBER
	 * 			}
	 *  	],
	 *
	 * 		post_middlewares = [
	 * 			{
	 * 				name: String,
	 * 				description: String,
	 * 				action: function(err, req, res, next)
	 * 				priority: NUMBER
	 * 			}
	 * 		]
	 * };
	 * @type {Object}
	 */
	const middlewares = Object.create(null);
	middlewares.core_middlewares = [];
	middlewares.pre_middlewares = [];
	middlewares.post_middlewares = [];

    /*
        Setting-up database
     */
    logger.info('Setting-up database');
    const db = require(`${configuration.webserver.core_modules.path}/database.js`)(configuration, application, modules);
    const database = db.database;
    const queryFiles = db.queryFiles;
    logger.info('Set-up complete\n');

    /*
        Setting-up view engine
     */
    logger.info('Setting-up nunjucks view engine');
    require(`${configuration.webserver.core_modules.path}/view_engine.js`)(configuration, application);
    logger.info('Set-up complete\n');

    /*
        Setting-up core middlewares
     */
    logger.info('Loading core middlewares');
    (() => {
        logger.info('\tLoading Files: ');
        // Load each file
        const require_middlewares = requireDir(configuration.webserver.core_middlewares.path);

        // Iterate through each of the file
        for(const file in require_middlewares){
            logger.info(`\t\t: ${file}`);

            //construct the contents of the file
            const content = require_middlewares[file](configuration, application, modules);

            loadMiddlewares(content, middlewares.core_middlewares);
        }

        middlewares.core_middlewares.sort((a, b) => {
            return b.priority - a.priority;
        });

        logger.info('\tMounting core middlewares');
        mountMiddlewares(application, middlewares.core_middlewares, logger);
        logger.info('\tMounting Complete');

    })();
    logger.info('Loading complete\n');

    /*
        Load Models
    */
    logger.info('Loading Models');
    let models = Object.create(null);
    (() => {
        const requireModels = requireDir(configuration.database.models.path);
        for(let key in requireModels){
          logger.info(`\tFile: ${key}.js`);
          models[key] = requireModels[key](configuration, modules, database, queryFiles);
        }
    })();
    logger.info('Loading complete\n');

    /*
        Load Pre-middlewares
     */
    logger.info('Loading Pre-middlewares');
    (() => {
        const requirePre_Middlewares = requireDir(configuration.webserver.pre_middlewares.path);

        constructMiddlewares(requirePre_Middlewares, middlewares.pre_middlewares, configuration, application, modules, database, queryFiles, models);

        middlewares.pre_middlewares.sort((a, b) => {
            return b.priority - a.priority;
        });

        logger.info('\tMounting pre-middlewares');
        mountMiddlewares(application, middlewares.pre_middlewares, logger);
        logger.info('\tMounting Complete');
    })();
    logger.info('Loading complete\n');

    /*
        Load controllers
    */
    logger.info('Loading Controllers');
    let controllers = Object.create(null);
    (() => {
        const requireControllers = requireDir(configuration.webserver.controllers.path);
        for(const file in requireControllers){
          logger.info(`\tFile: ${file}.js`);
          controllers[file] = requireControllers[file](configuration, modules, models, database, queryFiles);
        }
    })();
    logger.info('Loading complete\n');

    logger.info('Loading Routes');
    let routes = Object.create(null);
    (() => {
        var requireRoutes = requireDir(configuration.webserver.routes.path);
        for(const file in requireRoutes){
          logger.info(`\tFile: ${file}.js`);
          const router = express.Router();
          routes[file] = requireRoutes[file](configuration, modules, router, controllers, models, database, queryFiles);
          application.use(router);
        }
    })();
    logger.info('Loading complete\n');

    logger.info('Loading Post-middlewares');
    (() => {
        const requirePost_Middlewares = requireDir(configuration.webserver.post_middlewares.path);
        constructMiddlewares(requirePost_Middlewares, middlewares.post_middlewares, configuration, application, modules, database, queryFiles, models);

        middlewares.post_middlewares.sort((a, b) => {
            return b.priority - a.priority;
        });

        logger.info('\tMounting post-middlewares');
        mountMiddlewares(application, middlewares.post_middlewares, logger);
        logger.info('\tMounting Complete');
    })();
    logger.info('Loading complete\n');

    logger.info('Server Set-up Complete');
	return application;
};

function constructMiddlewares(directory, loadPoint, configuration, mainApplication, modules, database, queryFiles, models){
    const logger = modules.logger;
    for(let file in directory){
      logger.info(`\tFile: ${file}.js`);
      const middlewares = directory[file](configuration, mainApplication, modules, database, queryFiles, models);

      for(const middleware of middlewares){
          loadMiddlewares(middleware, loadPoint);
      }
    }
}

function isObject(object){
    if(object === null)
        return false;
    return (typeof object !== 'function') && (typeof object === 'object');
}

function loadMiddlewares(content, loadPoint){
    if(content){
        if(Array.isArray(content)){
            for(const middleware of content){
                loadPoint[loadPoint.length] = middleware;
            }
        }else if(isObject(content)){
            loadPoint[loadPoint.length] = content;
        }
    }
}

function mountMiddlewares(application, middlewares, logger){
    for(const middleware of middlewares){
        if(middleware.name){
            logger.info(`\t\tName: ${middleware.name}`);
        }else{
            logger.info(`Unnamed Middleware`);
        }
        if(middleware.description){
            logger.info(`\t\t\tDescription: ${middleware.name}`);
        }
        logger.info(`\t\t\tPriority: ${middleware.priority}`);

        if(middleware.route){
            logger.info(`\t\t\tRoute: ${middleware.route}`);
            application.use(middleware.route, middleware.action);
        }else{
            application.use(middleware.action);
        }
    }
}
