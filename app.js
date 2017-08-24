'use strict';
console.log('Initializing Server\n');

var express = require('express');
var path = require('path');

var favicon = require('serve-favicon');
var nunjucks = require('nunjucks');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

//function to help me
var requireDir = require('require-dir');
var fileSystem = require('fs');
var app = express();


console.log('Testing Connection to database');
var pgPromise = require('pg-promise')();
var database = pgPromise({
  host: global.config.database.host,
  port: global.config.database.port, 
  database: global.config.database.database,
  user: global.config.database.username,
  password: global.config.database.password
});

/* testing the connection */
var qrm = pgPromise.queryResult;
//query from database
database.query('SELECT * FROM account WHERE studentid = 11445955', undefined, qrm.any)
  .then((data) => {
    //console.log(data);
    console.log('Database Connection successful');
  })
  .catch((error) => {
    console.log(error);
  });

// view engine setup
app.set('views', path.join(__dirname, 'app/views'));
app.set('view engine', 'html');
nunjucks.configure('./app/views/', {
    autoescape: true,
    express: app
});

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(global.config.webserver.assets.path));

/* 
Load QueryFiles
*/
/*


let queryFile = pgp.QueryFile('../app/query/testQuery.sql', {minify: true});
//same as the above
 db.any(queryFile)
   .then((data) => {
    console.log(data);
 }).catch((error) => {
    console.log(error);
 });
 */
console.log('Loading Query Files');
var QueryFile = pgPromise.QueryFile;
var queryFiles = {};
var queryFilesDir = fileSystem.readdirSync(global.config.database.query_files.path);

for(var index = 0, length = queryFilesDir.length; index < length; ++index){
  if(queryFilesDir[index].substring(queryFilesDir[index].lastIndexOf('.')), queryFilesDir[index].length === '.sql'){
      console.log(`\tFile: ${queryFilesDir[index]}`);
      var filename = queryFilesDir[index].substring(0, queryFilesDir[index].lastIndexOf('.'));
      queryFiles[filename] = QueryFile(
      path.resolve(global.config.database.query_files.path) + '/' + queryFilesDir[index], 
      {
        minify: global.config.database.query_files.minify, 
        compress: global.config.database.query_files.compress
      }
    );
  } 
}
console.log('Loading Query Files Complete\n');

/*
 Load Models
 */
console.log('Loading Models');
var models = {};
var requireModels= requireDir(global.config.database.models.path);
for(var key in requireModels){
  console.log(`\tFile: ${key}.js`);
  models[key] = requireModels[key](database, queryFiles);
}
console.log('Loading Models Complete\n');

/*
Load Pre-middlewares
 */
console.log('Loading Pre-middlewares');
var requirePre_Middlewares = requireDir(global.config.webserver.pre_middlewares.path);
for(var key in requirePre_Middlewares){
  console.log(`\tFile: ${key}.js`);
  var middlewares = requirePre_Middlewares[key](app, database, models, queryFiles);

  for(var index = 0, length = middlewares.length; index < length; ++index){
    var middleware = middlewares[index];
    console.log(`\t\tMiddleware Action Named: ${middleware.name}`);
    if(!!middleware.description){
      console.log(`\t\t\tDescription: ${middleware.description}`);
    }
    if(!!middleware.route && typeof middleware.route === 'string'){
      console.log(`\t\t\tRoute: '${middleware.route}'`);
      app.use(middleware.route, middleware.action);
    }else{
      app.use(middleware.action);
    }
  }
}
console.log('Loading Pre-middlewares Complete\n');
/*
Load controllers
 */
console.log('Loading Controllers');
var controllers = {};
var requireControllers = requireDir(global.config.webserver.controllers.path);
for(var key in requireControllers){
  console.log(`\tFile: ${key}.js`);
  controllers[key] = requireControllers[key](database, models, queryFiles);
}
console.log('Loading Controllers Complete\n');


/*
Load routes
 */
console.log('Loading Routes');
var routes = {};
var requireRoutes = requireDir(global.config.webserver.routes.path);
for(var key in requireRoutes){
  console.log(`\tFile: ${key}.js`);
  routes[key] = requireRoutes[key](app,controllers);
  app.use(routes[key]);
}
console.log('Loading Routes Complete\n');

/*
Load post-middlewares
 */
console.log('Loading Post-middlewares');
var requirePost_Middlewares = requireDir(global.config.webserver.post_middlewares.path);
for(var key in requirePost_Middlewares){
  console.log(`\tFile: ${key}.js`);
  var middlewares = requirePost_Middlewares[key](app, database, models, queryFiles);

  for(var index = 0, length = middlewares.length; index < length; ++index){
    var middleware = middlewares[index];
    console.log(`\t\tMiddleware Action Named: ${middleware.name}`);
    if(!!middleware.description){
      console.log(`\t\t\tDescription: ${middleware.description}`);
    }
    if(!!middleware.route && typeof middleware.route === 'string'){
      console.log(`\t\t\tRoute: '${middleware.route}'`);
      app.use(middleware.route, middleware.action);
    }else{
      app.use(middleware.action);
    }
  }
}

console.log('Loading Post-middlewares Complete\n');


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});


console.log('Server Initialization Complete');
module.exports = app;
