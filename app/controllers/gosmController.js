const dateFormat = require('dateformat');

module.exports = function(database, models, queryFiles){
	const model_gosm = models.gosmModel;
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('APS/GOSMMain');
			//next();
		}
	};
};