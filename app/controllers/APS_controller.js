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
			var startDateSplit = startDate.split("/");
			var endDate = req.body.targetDateEnd
			var endDateSplit = endDate.split("/");
			var activityType = req.body['activity-type'];
			var others = req.body.otherDescription;
			var natureType =  req.body['nature-type'];
			var personInCharge = req.body.personInCharge;
			var isRelatedToOrganization = req.body.isRelatedToOrganization;
			var budget = req.body.budget;

			var dbParam = {
				startYear: startDateSplit[2],
				endYear: endDateSplit[2],
				studentOrganization: 1,
				goals: goals,
				objectives: objectives,
				strategy: strategy,

				description: description,
				measures: measures,
				targetDateStart: startDateSplit[2]+"-"+startDateSplit[0]+"-"+startDateSplit[1],
				targetDateEnd: endDateSplit[2]+"-"+endDateSplit[0]+"-"+endDateSplit[1],
				peopleInCharge: personInCharge,
				activityNature: natureType,
				activityType: activityType,
				activityTypeOthersDescription: other,
				isRelatedToOrganization: isRelatedToOrganization,
				budget: budget

			};

			if (activityType == 10 && others == null){
				//error blank others

				console.log("Gumana");
			}
			
			else{
				//insert to db
				gosmModel.insertProposedActivity(dbParam){

				}
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