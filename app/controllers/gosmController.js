module.exports = function(database, models, queryFiles){
	var getAllActivityTypeSQL = queryFiles.getAllActivityTypes;
	
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('GOSM');
			//next();
		},

		inputCreateGOSM: (req, res) => {

			console.log(JSON.stringify(req.body));
			res.render('GOSM');
		}
	};
};