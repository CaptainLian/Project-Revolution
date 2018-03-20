#!/usr/bin/env node
'use strict';

/**
* Setup of logger
*/
const dateFormat = require('dateformat');

const winston = require('winston');
const logger = new (winston.Logger)({
  emitErrs: false,
  level: 'debug',
  transports: [
     new (winston.transports.File)({
       filename: 'system.log',
       formatter: options => {
         let from = '';
         if(typeof options.meta === 'string'){
           from = `[${options.meta}]`;
         }else if(typeof options.meta === 'object' && typeof options.meta.from !== 'undefined'){
           from = `[${options.meta.from}]`;
         }

         return `[${dateFormat(Date.now(), 'yyyy-mmm-dd hh:mm:ss TT')}][${options.level.toUpperCase()}]${from}: ${options.message ? options.message : ''}`;
       }
     }),

     new(winston.transports.Console)({
       colorize: true,
       formatter: options => {
          // Return string will be passed to logger.
          var colour = '';
          switch (options.level) {
            case 'error':
              colour =  '\x1b[41m';
              break;

            case 'warning':
            case 'warn':
              colour =  '\x1b[43m';
              break;

            case 'info':
              colour =  '\x1b[44m';
              break;

            case 'debug':
              colour =  '\x1b[46m';
              break;
          }

          let from = typeof options.meta.from === 'string' ? `[${options.meta.from}]` : '';
          from = typeof options.meta.color === 'string' ? `${options.meta.color}${from}\x1b[0m` : `\x1b[42m${from}`;
          let pre = typeof options.meta.pre === 'string' ? `${options.meta.pre}` : '';
          return `${colour}[${dateFormat(Date.now(), 'yyyy-mmm-dd hh:mm:ss TT')}][${options.level.toUpperCase()}]${from}${pre}\x1b[0m: ${options.message ? options.message : ''}`;
       }
     })
  ],
  levels: {
    error:   0,
    warning: 1,
    warn:    1,
    info:    2,
    debug:   3
  }
});

/**
 * Loading of configuration is done here
 */
console.log('Loading Server Configuration');
const configuration = Object.create(null);
(() => {
    const pre_config = require('./config.js');
    for (const key in pre_config){
      console.log(`\tAdding global.config.key: ${key}`);
      var object = pre_config[key];
      configuration[key] = Object.create(null);
      for(const oKey in object){
        configuration[key][oKey] = object[oKey];
      }
    }
})();
console.log('Server Configuration Loaded\n');

/**
 * Module dependencies.
 */
const app = require('./application')(configuration, logger);
var http = require('http');

/**
 * Get port from environment and store in Express.
 */
var port = normalizePort(process.env.PORT || configuration.webserver.port);
app.set('port', port);

/**
 * Create HTTP server.
 */
var server = http.createServer(app);

/**
 * Listen on provided port, on all network interfaces.
 */
server.listen(port);
server.on('error', onError);
server.on('listening', onListening);


var cron = require('node-cron');
const AdminController = Object.create(null);
const path =  require('path')

var Class = require('ee-class')
, util = require('util')            
, exec = require('child_process').exec
, fs = require('fs')
, asyncMethod = require('async-method');
/* every 00:00:00 1st day of January,September, and May*/
cron.schedule('* 0 1 January,September,May *',function(){
  var filename = Date.parse(new Date())+'.sql';
  var dir = path.join(__dirname,'app','backup/'+filename );
  var command,ls;
  console.log("asdkajsdlkasdjlaskdjlskadj")
  console.log("asdkajsdlkasdjlaskdjlskadj")
  // if(configuration.database.password == ""){  
  if(true){
    console.log("1st")
    command = util.format('pg_dumpall -c -h %s -p %d --data-only -U %s --file=%s -l %s --no-password', configuration.database.host, configuration.database.port, configuration.database.username, dir, configuration.database.database);        
        console.log(command)
        ls = exec(command);
        
  }else{
    console.log("2st")
    command = util.format('pg_dumpall -c -h %s -p %d --data-only -U %s --file=%s -l %s --password %s', configuration.database.host, configuration.database.port, configuration.database.username, dir, configuration.database.database, configuration.database.password);        
        console.log(command)
        ls = exec((command), function(err, out, code) {
        
      });

        ls.stdin.write(configuration.database.password+" \n")  
  } 
},false).start();
// var schedule = require('node-schedule');
// var rule = new schedule.RecurrenceRule();
// rule.month = 3;
 
// schedule.scheduleJob(rule,function(){
//   console.log("asasdasdasdasdasdas")
//   console.log("asasdasdasdasdasdas")
// })


/**
 * Normalize a port into a number, string, or false.
 */
function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */
function onError(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }

  var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */
function onListening() {
  var addr = server.address();
  var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
}