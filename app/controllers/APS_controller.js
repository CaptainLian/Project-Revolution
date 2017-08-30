module.exports = function(database, models, queryFiles){

	var gosmModel = models.GOSM_model;
	return {
		viewCreateGOSM: (req, res) => {
			console.log('VIEW CREATE GOSM CONTROLLER');
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('APS/GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {
					console.log(error);
					res('ERROR');
				});
		},
		createActivityRequirements:(req, res)=>{
			res.render("ActivityRequirementsMain");
		},

		inputCreateGOSM: (req, res) => {
			console.log(JSON.stringify(req.body));
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('APS/GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {

				});
		}
	};
};