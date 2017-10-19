'use strict';
var logger = global.logger;
logger.info('Initializing Server\n');

var express = require('express');
var path = require('path');

var nunjucks = require('nunjucks');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var pg = require('pg'),
    session = require('express-session'),
    pgSession = require('connect-pg-simple')(session);

var Pool = require('pg-pool');
//function to help me
var requireDir = require('require-dir');
var fileSystem = require('fs');
var app = express();

var pgPromise = require('pg-promise')();

var database_connection_options = {
  host: global.config.database.host,
  port: global.config.database.port,
  database: global.config.database.database,
  user: global.config.database.username,
  password: global.config.database.password
};
var database = pgPromise(database_connection_options);

// view engine setup
app.set('views', path.join(__dirname, 'app/views'));
app.set('view engine', 'html');
nunjucks.configure('./app/views/', {
    autoescape: true,
    express: app
});


// Middle
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser('this is a place holder secret, would be replaced by an auto generated secret'));
app.use(function(req, res, next) {
  const responseStart = Date.now();

  res.on('finish', () => {
    const response = Date.now() - responseStart;
    //      //msg: "HTTP {{req.method}} {{req.url}}", // optional: customize the default logging message. E.g. "{{res.statusCode}} {{req.method}} {{res.responseTime}}ms {{req.url}}"
    // Color the text and status code, using the Express/morgan color palette (text: gray, status: default green, 3XX cyan, 4XX yellow, 5XX red).
    let statusColor = '';
    if(res.statusCode >= 500){
      statusColor = '\x1b[31m';
    }else if(res.statusCode >= 400){
      statusColor = '\x1b[33m';
    }else if(res.statusCode >= 300){
      statusColor = '\x1b[36m';
    }else if(res.statusCode >= 200){
      statusColor = '\x1b[32m';
    }else{
      statusColor = '\x1b[35m';
    }

    logger.debug(
      `\x1b[32m${req.method}\x1b[0m "${req.url}" ${statusColor}${res.statusCode}\x1b[0m (${res.statusMessage}) - ${response}ms`, {
        from: 'HTTP'
      }
    );
  });
  next();
});
app.use(express.static(global.config.webserver.assets.path));

let session_config = global.config.webserver.session;
app.use(
  session({
    store: new pgSession({
      pool: new Pool(database_connection_options),
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

app.use(require('csurf')({
	cookie: false,
	ignoreMethods: ['GET', 'HEAD', 'OPTIONS'],
	sessionKey: 'session'
}));
/*
Load QueryFiles
*/
logger.info('Loading Query Files');
var QueryFile = pgPromise.QueryFile;
var queryFiles = {};
var queryFilesDir = fileSystem.readdirSync(global.config.database.query_files.path);

for(let index = 0, length = queryFilesDir.length; index < length; ++index){
  if(queryFilesDir[index].substring(queryFilesDir[index].lastIndexOf('.'), queryFilesDir[index].length) === '.sql'){
      logger.info(`\tFile: ${queryFilesDir[index]}`);
      let filename = queryFilesDir[index].substring(0, queryFilesDir[index].lastIndexOf('.'));
      queryFiles[filename] = QueryFile(
      path.resolve(global.config.database.query_files.path) + '/' + queryFilesDir[index],
      {
        minify: global.config.database.query_files.minify,
        compress: global.config.database.query_files.compress
      }
    );
  }
}
logger.info('Loading Query Files Complete\n');

/*
 Load Models
 */
logger.info('Loading Models');
var models = {};
var requireModels= requireDir(global.config.database.models.path);
for(let key in requireModels){
  logger.info(`\tFile: ${key}.js`);
  models[key] = requireModels[key](database, queryFiles);
}
logger.info('Loading Models Complete\n');

/*
Load Pre-middlewares
 */
logger.info('Loading Pre-middlewares');
var requirePre_Middlewares = requireDir(global.config.webserver.pre_middlewares.path);
for(let key in requirePre_Middlewares){
  logger.info(`\tFile: ${key}.js`);
  let middlewares = requirePre_Middlewares[key](app, database, models, queryFiles);

  for(let index = 0, length = middlewares.length; index < length; ++index){
    let middleware = middlewares[index];
    logger.info(`\t\tMiddleware Action Named: ${middleware.name}`);
    if(!!middleware.description){
      logger.info(`\t\t\tDescription: ${middleware.description}`);
    }
    if(!!middleware.route && typeof middleware.route === 'string'){
      logger.info(`\t\t\tRoute: '${middleware.route}'`);
      app.use(middleware.route, middleware.action);
    }else{
      app.use(middleware.action);
    }
  }
}
logger.info('Loading Pre-middlewares Complete\n');
/*
Load controllers
 */
logger.info('Loading Controllers');
var controllers = {};
var requireControllers = requireDir(global.config.webserver.controllers.path);
for(let key in requireControllers){
  logger.info(`\tFile: ${key}.js`);
  controllers[key] = requireControllers[key](database, models, queryFiles);
}
logger.info('Loading Controllers Complete\n');


/*
Load routes
 */
logger.info('Loading Routes');
var routes = {};
var requireRoutes = requireDir(global.config.webserver.routes.path);
for(let key in requireRoutes){
  logger.info(`\tFile: ${key}.js`);
  routes[key] = requireRoutes[key](app,controllers);
  app.use(routes[key]);
}
logger.info('Loading Routes Complete\n');

/*
Load post-middlewares
Wet code :(
 */
logger.info('Loading Post-middlewares');
var requirePost_Middlewares = requireDir(global.config.webserver.post_middlewares.path);
for(let key in requirePost_Middlewares){
  logger.info(`\tFile: ${key}.js`);
  var middlewares = requirePost_Middlewares[key](app, database, models, queryFiles);

  for(let index = 0, length = middlewares.length; index < length; ++index){
    let middleware = middlewares[index];
    logger.info(`\t\tMiddleware Action Named: ${middleware.name}`);
    if(!!middleware.description){
      logger.info(`\t\t\tDescription: ${middleware.description}`);
    }
    if(!!middleware.route && typeof middleware.route === 'string'){
      logger.info(`\t\t\tRoute: '${middleware.route}'`);
      app.use(middleware.route, middleware.action);
    }else{
      app.use(middleware.action);
    }
  }
}

logger.info('Loading Post-middlewares Complete\n');

logger.info('Server Initialization Complete');

module.exports = app;