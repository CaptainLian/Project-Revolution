const dateFormat = require('dateformat');


module.exports = function(database, models, queryFiles){

	var gosmModel = models.gosmModel;
	return {
		viewCreateGOSM: (req, res) => {
			console.log('VIEW CREATE GOSM CONTROLLER');

			gosmModel.getSchoolYear()
				.then(data => {
					console.log(data.endyear);
					var endYear = data.endyear;
					var startYear = endYear-1;


					var dbParam = {
						startYear: startYear,
						endYear: endYear,
						studentOrganization: 1, //to be replaced by session variable

					};

					Promise.all([gosmModel.getAllActivityTypes(), gosmModel.getAllActivityNature(), gosmModel.getGOSMActivities(dbParam)])
						.then(data => {
							res.render('GOSMMain', {
								activityTypes: data[0],
								activityNature: data[1],
								gosmActivities: data[2]
							});
						})
						.catch(error => {
							console.log(error);
							res('ERROR');
						});


				});


		},
		createActivityRequirements:(req, res)=>{
			res.render("APS/ActivityRequirementsMain");
		},

		inputCreateGOSM: (req, res) => {

			gosmModel.getSchoolYear()
				.then(data => {
					console.log(data.endyear);
					var endYear = data.endyear;
					var startYear = endYear-1;

					console.log(startYear);

					// var data = JSON.stringify(req.body);
					console.log(req.body);

					var strategy = req.body.strategy;
					var goals = req.body.goals;
					var objectives = [];
					objectives = req.body['objectives[]'];

					if(typeof objectives !== 'array'){
						objectives = [objectives];
					}

					var description = req.body.description;
					var measures =  req.body.measures;
					var startDate = req.body.targetDateStart;
					var startDateSplit = startDate.split("/");
					var endDate = req.body.targetDateEnd;
					var endDateSplit = endDate.split("/");
					var activityType = req.body['activity-type'];
					var others = req.body.otherDescription;
					var natureType =  req.body['nature-type'];
					var personInCharge = [];
					personInCharge = req.body['personInCharge[]'];

					if(typeof personInCharge !== 'array'){
						personInCharge = [personInCharge];
					}

					var isRelatedToOrganization = req.body.isRelatedToOrganization;
					var budget = req.body.budget;

					var dbParam = {
						startYear: startYear,
						endYear: endYear,
						studentOrganization: 1, //to be replaced by session variable
						goals: goals,
						objectives: objectives,
						strategies: strategy,
						description: description,
						measures: measures,
						targetDateStart: "'"+startDateSplit[2]+"-"+startDateSplit[0]+"-"+startDateSplit[1]+"'",
						targetDateEnd: "'"+endDateSplit[2]+"-"+endDateSplit[0]+"-"+endDateSplit[1]+"'",
						peopleInCharge: personInCharge,
						activityNature: natureType,
						activityType: activityType,
						activityTypeOtherDescription: others,
						isRelatedToOrganizationNature: isRelatedToOrganization,
						budget: budget

					};

					if (activityType == 10 && others == null){
						//error blank others

					}

					else{
					//insert to db
						gosmModel.insertProposedActivity(dbParam)
							.then(data =>{
								res.send("1");
							})
							.catch(error =>{
								res.send("0");
								console.log(error);
							});



					}




				});




		},
		submitGOSM:(req ,res)=>{

		},

		viewOrglist:( req, res) =>{
			let yearsPromise = gosmModel.getSubmissionYears();
			let allGOSMPromise = gosmModel.getAll();
			Promise.all([yearsPromise, allGOSMPromise])
				.then(function(data) {
					let GOSMList = data[1];
					for(const gosm of GOSMList){
						console.log(gosm);
					}
					console.log(GOSMList);
					res.render('APS/OrglistMain', {
						GOSMList: data[1]
					});
				})
				.catch(function(error) {
					console.log(error);

					res.send(500);
					throw error;
				});
		},
		viewOrgGOSM :( req, res)=>{
			console.log("CHECK THIS OUT" +req.params.orgid);

			let organizationID = req.params.orgid;
			gosmModel.getSpecificOrg(organizationID)
			.then(data => {
				console.log(data);
				res.render('APS/OrgGOSMMain', {activities: data});
			})
			.catch(error => {
				console.log(data);
				throw error;
			});
		},
		activityList :( req, res)=>{
			res.render('APS/ActivityListMain');
		},
		inputCreateGOSM: (req, res) => {
			console.log(JSON.stringify(req.body));
			res.render('GOSM');
		}
	};
};