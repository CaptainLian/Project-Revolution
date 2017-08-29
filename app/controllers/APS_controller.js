module.exports = function(database, models, queryFiles){

	var gosmModel = models.GOSM_model;
	return {
		viewCreateGOSM: (req, res) => {
			console.log('VIEW CREATE GOSM CONTROLLER');
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {
					console.log(error);
					res('ERROR');
				});
		},

		inputCreateGOSM: (req, res) => {
			
			var data = JSON.stringify(req.body);
			console.log(req.body);

			var strategy = req.body.strategy;
			var goals = req.body.goals;
			var objectives = req.body.objectives;
			var description = req.body.description;
			var measures =  req.body.measures;
			var startDate = req.body.targetDateStart;
			var endDate = req.body.targetDateEnd
			var activityType = req.body['activity-type'];
			var others = req.body.otherDescription;
			var natureType =  req.body['nature-type'];
			var personInCharge = req.body.personInCharge;
			var isRelatedToOrganization = req.body.isRelatedToOrganization;
			var budget = req.body.budget;

			if (activityType == 10 && others == null){
				//error blank others

				console.log("Gumana");
			}
			
			else{
				//insert
				gosmModel
			}


			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {
					console.log(error);
				});


		}
	};
};