'use strict';
console.log('Initializing Server\n');

var express = require('express');
var path = require('path');

var favicon = require('serve-favicon');
var nunjucks = require('nunjucks');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/routes');
var middlewares = require('./app/middlewares/middleware');	

//function to help me
var requireDir = require('require-dir');
var app = express();

/* Loading of configuration is done here */
console.log('Loading Server Configuration');
var config = require('./config.json');
global.config = {};

for (var key in config){
  console.log(`Adding global.config.key: ${key}`);
  var object = config[key];
  global.config[key] = {};
  for(var oKey in object){
    global.config[key][oKey] = object[oKey];
  }
}

console.log('Server Configuration Loaded\n');

console.log('Connecting to database');
var pgPromise = require('pg-promise')();
var database = pgPromise({
  host: global.config.database.host,
  port: global.config.database.port, 
  database: global.config.database.database,
  user: global.config.database.username,
  password: global.config.database.password
});
console.log('Database Connected\n');

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

app.use(middlewares);
app.use(routes);

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


/*
let qrm = pgp.queryResult;
//query from database
db.query('SELECT * FROM organization', undefined, qrm.any)
  .then((data) => {
  	console.log(data);
  })
  .catch((error) => {
  	console.log(error);
  });


let queryFile = pgp.QueryFile('../app/query/testQuery.sql', {minify: true});
//same as the above
 db.any(queryFile)
   .then((data) => {
		console.log(data);
 }).catch((error) => {
 		console.log(error);
 });
 */
console.log('Server Initialization Complete');
module.exports = app;
