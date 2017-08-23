var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	var index = controllers.index_controller;
	router.get('/', index.home);
	router.get('/neil', index.neil);

	return router;
};

