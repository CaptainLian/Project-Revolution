module.exports = function(database, models, queryFiles){

	var gosmModel = models.GOSM_model;
	return {
		viewCreateGOSM: (req, res) => {
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {

				});
		},

		inputCreateGOSM: (req, res) => {
			console.log(JSON.stringify(req.body));
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {

				});
		}
	};
};