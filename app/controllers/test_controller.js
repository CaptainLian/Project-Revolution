'use strict';

module.exports = function(database, models, queryFiles){
	return {
		test: function(req, res){
			req.session.views = req.session.views ? 1 : req.session.views++;
			res.send(new String(req.session.views));
		}
	};
};