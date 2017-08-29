var express = require('express');
var router = express.Router();

module.exports = function (app, controllers){
	var index = controllers.index_controller;
	var test = controllers.test_controller;

	router.get('/', index.home);

	return router;
};

