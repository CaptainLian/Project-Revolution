module.exports = function(database, models, queryFiles){
	var getAllActivityTypeSQL = queryFiles.getAllActivityTypes;
	
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('GOSMMain');
			//next();
		},

		inputCreateGOSM: (req, res) => {

			console.log(JSON.stringify(req.body));
			res.render('GOSM');
		}
	};
};