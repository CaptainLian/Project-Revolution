var express = require('express');
var app = express();

app.use('/',function(req, res, next){
	console.log("Middleware");
	next();
});
module.exports = app;