var express = require('express');
var router = express.Router();





module.exports = function (app, controllers){
	let index = controllers.index_controller;

	router.get('/', index.home);
	router.get('/gosm', index.gosm);
	router.get('/neil', index.neil);
};

