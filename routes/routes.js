var express = require('express');
var router = express.Router();

var index = require('../app/controllers/index_controller');

router.get('/', index.neil);

router.get('/neil', index.home);


module.exports = router;