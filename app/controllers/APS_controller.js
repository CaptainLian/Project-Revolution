const dateFormat = require('dateformat');
const logger = global.logger;

module.exports = function(database, models, queryFiles){

	const gosmModel = models.gosmModel;
	const organizationModel = models.organization_model;

	return {
		home: (req, res)=>{
			res.render('APS/HomeMain');
		},
		viewCreateGOSM: (req, res) => {
			console.log('VIEW CREATE GOSM CONTROLLER');

			gosmModel.getSchoolYear()
				.then(data => {
					console.log(data.endyear);
					

					var orgGOSMParam = {
						termID: data.id,
						studentOrganization: 1 //to be replaced by session variable

					};

					gosmModel.getOrgGOSM(orgGOSMParam)
						.then(data =>{
							console.log(data);


							if(data == null){
								// insert GOSM

								console.log("DUMAAN SIYA DITO");

								gosmModel.insertNewGOSM(orgGOSMParam)
									.then(data =>{

										gosmModel.getOrgGOSM(orgGOSMParam)
											.then(data =>{
												var gosmID = data.id;
												
											dbParam = {
												GOSM: gosmID
											}
											Promise.all([gosmModel.getAllActivityTypes(), gosmModel.getAllActivityNature(), gosmModel.getGOSMActivities(dbParam)])
												.then(data => {
													res.render('APS/GOSMMain', {
														activityTypes: data[0],
														activityNature: data[1],
														gosmActivities: data[2]
													});
												})
												.catch(error => {
													console.log(error);
													res('ERROR');
												});
											})
											.catch(error =>{

											});
									})
									.catch(error =>{
										console.log(error);
									});
							}
							else{
								console.log("ELSE");

								var gosmID = data.id;


								dbParam = {
									gosm: gosmID
								};

								console.log(dbParam);

								Promise.all([gosmModel.getAllActivityTypes(), gosmModel.getAllActivityNature(), gosmModel.getGOSMActivities(dbParam)])
									.then(data => {
										res.render('APS/GOSMMain', {
											activityTypes: data[0],
											activityNature: data[1],
											gosmActivities: data[2]
										});
									})
									.catch(error => {
										console.log(error);
										res('ERROR');
									});
							}
						})
						.catch(error =>{
							console.log(error);
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


					if(!Array.isArray(objectives)){
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


					if(!Array.isArray(personInCharge)){
						personInCharge = [personInCharge];
					}

					var isRelatedToOrganization = req.body.isRelatedToOrganization;
					var budget = req.body.budget;

					var orgGOSMParam = {
						termID: data.id,
						studentOrganization: 1 //to be replaced by session variable

					};

					gosmModel.getOrgGOSM(orgGOSMParam)
						.then(data =>{

							var dbParam = {
								GOSM: data.id, //to be replaced by session variable
								goals: goals,
								objectives: objectives,
								strategies: strategy,
								description: description,
								measures: measures,
								targetDateStart: "'"+startDateSplit[2]+"-"+startDateSplit[0]+"-"+startDateSplit[1]+"'",
								targetDateEnd: "'"+endDateSplit[2]+"-"+endDateSplit[0]+"-"+endDateSplit[1]+"'",
								activityNature: natureType,
								activityType: activityType,
								activityTypeOtherDescription: others,
								isRelatedToOrganizationNature: isRelatedToOrganization,
								budget: budget

							};

							console.log(dbParam);

							if (activityType == 10 && others == null){
								//error blank others

							}

							else{
							//insert to db
								gosmModel.insertProposedActivity(dbParam)
									.then(data =>{

										console.log(data.activityid);

										console.log(personInCharge.length);

										for (var i = 0; i < personInCharge.length; i++){

											console.log("Inside the loop");
											console.log(personInCharge[i]);

											var projectHeadParam = {
												idNumber: parseInt(personInCharge[i]),
												activityID: data.activityid

											};

											gosmModel.insertActivityProjectHead(projectHeadParam)
												.then(data=>{

												})
												.catch(error =>{
													console.log(error);
												});
										}


										res.send("1");
									})
									.catch(error =>{
										res.send("0");
										console.log(error);
									});
							}

						})
						.catch(error =>{
							console.log(error);
						});

					
				});
		},
		deleteActivity: (req,res)=>{

			var dbParam = {
				id: req.body.dbid
			};

			gosmModel.deleteActivity(dbParam)
				.then(data =>{

				})
				.catch(error =>{
					console.log(error);
				});


		},

		viewOrglist:( req, res) =>{
			gosmModel.getAllCurrent()
				.then(GOSMList => {
					console.log(GOSMList);
					res.render('APS/OrglistMain', {GOSMList: GOSMList});
				})
				.catch(error => {
					console.log(error);
				});
		},
		
		inputActivityRequirements: (req, res) => {

			console.log(req.body.sched);

			//step 1
			var context = req.body.context;
			
			//step 2
			var date = [];
			date = req.body['date[]'];
			var timeStart = [];
			timeStart = req.body['timeStart[]'];
			var timeEnd = [];
			timeEnd = req.body['timeEnd[]'];
			var activity = [];
			activity = req.body['activity[]'];
			var description = [];
			description = req.body['description[]'];
			var personInCharge = [];
			personInCharge = req.body['personInCharge'];

			//step 3
			var expenses = req.body.expenses;
			var organizationalFunds = req.body.organizationalFunds;
			var participantsFee = req.body.participantsFee;
			var others = req.body.others;

			var material = [];
			material = req.body['material[]'];
			var materialQuantity = [];
			materialQuantity = req.body['materialQuantity[]'];
			var unitCost = [];
			unitCost = req.body['unitCost[]'];

			//step 4
			var operationalFund = req.body.operationalFund;
			var depositoryFund = req.body.depositoryFund;
			var otherSourceOfFunds = req.body.otherSourceOfFunds;

			var revenueItem = [];
			revenueItem = req.body['revenueItem[]'];
			var revenueQuantity = [];
			revenueQuantity = req.body['revenueQuantity[]'];
			var revenueSellingPrice = [];
			revenueSellingPrice = req.body['revenueSellingPrice[]'];


			var expenseItem = [];
			expenseItem = req.body['expenseItem[]'];
			var expenseQuantity = [];
			expenseQuantity = req.body['expenseQuantity[]'];
			var expenseSellingPrice = [];
			expenseSellingPrice = req.body['expenseSellingPrice[]'];

			//step 5
			var attachment = req.body.attachment;

			var enp = req.body.enp;
			var venue = req.body.venue;
		},

		viewOrgGOSM :( req, res)=>{
			let organizationID = req.params.orgID;
			let GOSMID = req.params.GOSMID;

			logger.debug(`Viewing GOSM of ID: ${GOSMID} of Organization: ${organizationID}`);

			database.task( t => {
				return t.batch([
					organizationModel.getOrganizationInformation(organizationID, 'name', t),
					gosmModel.getActivitiesFromID(GOSMID, ['id', 'strategies', 'targetDateStart'], t)
				]);
			})
			.then(data => {
				logger.debug(JSON.stringify(data));
				res.render('APS/OrgGOSMMain', {
					organizationName: data[0].name,
					GOSMActivities: data[1]
				});
			})
			.catch( error => {
				throw error;
			});
		},

		activityList :(req, res)=>{
			res.render('APS/ActivityListMain');
		},

	};
};
