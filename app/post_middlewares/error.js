var express = require('express');
var app = express();


module.exports = function (app, database, models, queryFiles){
	return [
		{
			name: 'Error 404',
			description: '',
			action: function(req, res, next) {
			  var err = new Error('Not Found');
			  err.status = 404;
			  res.render('System/404');
			}
		},
		
		{
			name: 'Error 500',
			description: '',
			action: function(err, req, res, next) {
			  // set locals, only providing error in development
			  res.locals.message = err.message;
			  res.locals.error = req.app.get('env') === 'development' ? err : {};

			  // render the error page
			  res.status(err.status || 500);
			  res.render('error',{message:err.message, error:err});
			  console.log(err);
			}
		}
	
	];
};