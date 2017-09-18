'use strict';

const logger = global.logger;
const log_options = {
    from: 'APS-Controller'
};

module.exports = function(database, models, queryFiles) {

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;

    return {
        home: (req, res) => {
            res.render('APS/HomeMain', {
                csrfToken: req.csrfToken()
            });
        },
        viewCreateGOSM: (req, res) => {

			console.log('VIEW CREATE GOSM CONTROLLER');

			// gosmModel.getSchoolYear()
			// .then(data => {
			// 	var orgGOSMParam = {
			// 			termID: data.id,
			// 			studentOrganization: 1 //to be replaced by session variable

			// 		};
			// 	return gosmModel.getOrgGOSM(orgGOSMParam);
			// })
			// .then(data => {
			// 	if (data)
			// });
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
											};
											Promise.all([gosmModel.getAllActivityTypes(), gosmModel.getAllActivityNature(), gosmModel.getGOSMActivities(dbParam)])
												.then(data => {
													res.render('APS/GOSMMain', {
														activityTypes: data[0],
														activityNature: data[1],
														gosmActivities: data[2],
														csrfToken: req.csrfToken()
													});
												})
												.catch(error => {
													console.log(error);
													res.send('ERROR');
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


								var dbParam = {
									GOSM: gosmID
								};

								console.log(dbParam);

								Promise.all([gosmModel.getAllActivityTypes(), gosmModel.getAllActivityNature(), gosmModel.getGOSMActivities(dbParam)])
									.then(data => {
										res.render('APS/GOSMMain', {
											activityTypes: data[0],
											activityNature: data[1],
											gosmActivities: data[2],
											csrfToken: req.csrfToken()
										});
									})
									.catch(error => {
										console.log(error);
										res.send('ERROR');
									});
							}
						})
						.catch(error =>{
							console.log(error);
						});



				});
		},


        createActivityRequirements: (req, res) => {
            res.render("APS/ActivityRequirementsMain", {
                csrfToken: req.csrfToken()
            });
        },
        inputCreateGOSM: (req, res) => {

            gosmModel.getSchoolYear()
                .then(data => {
                    console.log(data.endyear);
                    var endYear = data.endyear;
                    var startYear = endYear - 1;

                    console.log(startYear);

                    // var data = JSON.stringify(req.body);
                    console.log(req.body);

                    var strategy = req.body.strategy;
                    var goals = req.body.goals;
                    var objectives = [];
                    objectives = req.body['objectives[]'];


                    if (!Array.isArray(objectives)) {
                        objectives = [objectives];

                    }

                    var description = req.body.description;
                    var measures = req.body.measures;
                    var startDate = req.body.targetDateStart;
                    var startDateSplit = startDate.split("/");
                    var endDate = req.body.targetDateEnd;
                    var endDateSplit = endDate.split("/");
                    var activityType = req.body['activity-type'];
                    var others = req.body.otherDescription;
                    var natureType = req.body['nature-type'];
                    var personInCharge = [];
                    personInCharge = req.body['personInCharge[]'];

                    if (!Array.isArray(personInCharge)) {
                        personInCharge = [personInCharge];
                    }

                    var isRelatedToOrganization = req.body.isRelatedToOrganization;
                    var budget = req.body.budget;

                    var orgGOSMParam = {
                        termID: data.id,
                        studentOrganization: 1 //to be replaced by session variable
                    };

                    gosmModel.getOrgGOSM(orgGOSMParam)
                        .then(data => {

                            var dbParam = {
                                GOSM: data.id, //to be replaced by session variable
                                goals: goals,
                                objectives: objectives,
                                strategies: strategy,
                                description: description,
                                measures: measures,
                                targetDateStart: "'" + startDateSplit[2] + "-" + startDateSplit[0] + "-" + startDateSplit[1] + "'",
                                targetDateEnd: "'" + endDateSplit[2] + "-" + endDateSplit[0] + "-" + endDateSplit[1] + "'",
                                activityNature: natureType,
                                activityType: activityType,
                                activityTypeOtherDescription: others,
                                isRelatedToOrganizationNature: isRelatedToOrganization,
                                budget: budget

                            };

                            console.log(dbParam);

                            if (activityType == 10 && others == null) {
                                //error blank others

                            } else {
                                //insert to db
                                gosmModel.insertProposedActivity(dbParam)
                                    .then(data => {

                                        console.log(data.activityid);

                                        console.log(personInCharge.length);

                                        for (var i = 0; i < personInCharge.length; i++) {

                                            console.log("Inside the loop");
                                            console.log(personInCharge[i]);

                                            var projectHeadParam = {
                                                idNumber: parseInt(personInCharge[i]),
                                                activityID: data.activityid

                                            };

                                            gosmModel.insertActivityProjectHead(projectHeadParam)
                                                .then(data => {

                                                })
                                                .catch(error => {
                                                    console.log(error);
                                                });
                                        }
                                        res.send(data.activityid + '');
                                    })
                                    .catch(error => {
                                        res.send("0");
                                        console.log(error);
                                    });
                            }
                        })
                        .catch(error => {
                            console.log(error);
                        });
                });
        },


        inputActivityRequirements: (req, res) => {
            var sched = JSON.parse(req.body.sched);
            // console.log(sched);
            var exp = JSON.parse(req.body.exp);
            sched = sched[0];
            var funds = JSON.parse(req.body.funds);

            console.log(sched.time[1].start);

            // console.log(exp);


            // dummy values
            var projectProposalParam = {
                GOSMactivity: 1,
                status: 1,
                enp: 10,
                enmp: 20,
                venue: 'gokongwei',
                contactNumber: 123455678,
                accumulatedOperationalFunds: 100,
                accumulatedDepositoryFunds: 100

            };

        },
		updateActivity: (req, res) => {

			console.log(req.body);

				var id = req.body.id;

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
				var others = req.body.othersDescription;
				var natureType =  req.body['nature-type'];
				var personInCharge = [];
				personInCharge = req.body['personInCharge[]'];


				if(!Array.isArray(personInCharge)){
					personInCharge = [personInCharge];
				}

				var isRelatedToOrganization = req.body.isRelatedToOrganization;
				var budget = req.body.budget;

				var dbParam = {

					id: id,
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

				gosmModel.updateActivity(dbParam)
					.then(data =>{
						console.log(data);
						res.send(data.id+"");
					})
					.catch(error =>{
						console.log(error);
						res.send("0");
					});

				

		},

        inputActivityRequirements: (req, res) => {
			var sched = JSON.parse(req.body.sched);

			var exp = JSON.parse(req.body.exp);
			var funds = JSON.parse(req.body.funds);
			// var sched = sched[0];

			// console.log(sched.time[1].start);
			// req.body.context

			console.log(req.body);
			

			var projectProposalParam = {
				GOSMactivity: 1, // value should come from previous page
				status: 1,
				enp: req.body.enp, 
				enmp: req.body.enmp,
				venue: req.body.venue,
				sourceFundOther: exp.others,
				sourceFundParticipantFee: exp.participant,
				sourceFundOrganizational: exp.orgFunds,
				accumulatedOperationalFunds: funds.ope,
				accumulatedDepositoryFunds: funds.dep,
				organizationalFundOtherSource: funds.other,
				preparedBy: req.session.user 
			};

			db.tx(t => {
				return gosmModel.insertProjectProposal(projectProposalParam, t)
				.then(data => {

					var projectProposal = data.projectProposal
					
					let queries = [];
					for (var i = 0; i < sched.length; i++){
							for (var j = 0; j < sched[i].length; j++){
								var dbParam = {

									projectProposal: projectProposal,
									dayID: i,
									date: sched[i].date,
									startTime: sched[i].time[j].start,
									endTime: sched[i].time[j].end,
									activity: sched[i].time[j].actName,
									activityDescription: sched[i].time[j].actDesc,
									personInCharge: sched[i].time[j].pic
								};

								queries.push(t.none(gosmModel.insertProjectProposalProgramDesign(dbParam)));


							}
						}


					// insert finances

					for (var i = 0; i < funds.revenue.length; i++){

						var dbParam = {

							projectProposal: projectProposal,
							material: funds.revenue.item,
							quantity: funds.revenue.quan,
							sellingPrice: funds.revenue.price

						};

						queries.push(t.none(gosmModel.insertProjectProposalProjectedIncome(dbParam)));

					}

					for (var i = 0; i < funds.expense.length; i++){

						var dbParam = {

							projectProposal: projectProposal,
							material: funds.expense.item,
							quantity: funds.expense.quan,
							unitCost: funds.expense.price

						};

						queries.push(t.none(gosmModel.insertProjectProposalExpenses(dbParam)));
						
					}

					


					return t.batch(queries);
				});
			}).then(data => {

			}).catch(error=>{
				console.log(error);
			});

			
		},

        deleteActivity: (req, res) => {

            var dbParam = {
                id: req.body.dbid
            };
            console.log("TO DELETE");
            console.log(dbParam);

            gosmModel.deleteActivity(dbParam)
                .then(data => {
                    res.send("1");
                })
                .catch(error => {
                    res.send('0');
                    logger.error(error, log_options);
                });
        },

        submitGOSM: (req, res) => {

            var dbParam = {
                //TODO: Session get student organization
                studentorganization: 1 // session variable of organization
            };

            gosmModel.submitGOSM(dbParam)
                .then(() => {

                })
                .catch(error => {
                    throw error;
                });
        },

        viewOrglist: (req, res) => {
            gosmModel.getAllCurrent()
                .then(GOSMList => {
                    logger.debug(`Displaying GOSM list: ${JSON.stringify(GOSMList)}`, log_options);
                    res.render('APS/OrglistMain', {
                        GOSMList: GOSMList,
                        csrfToken: req.csrfToken()
                    });
                })
                .catch(error => {
                    throw error;
                });
        },

        viewOrgGOSM: (req, res) => {
            const organizationID = req.params.orgID;
            const GOSMID = req.params.GOSMID;

            logger.debug(`Viewing GOSM of ID: ${GOSMID} of Organization: ${organizationID}`, log_options);
            database.task(t => {
                    return t.batch([
                        organizationModel.getOrganizationInformation(organizationID, 'name', t),
                        gosmModel.getActivitiesFromID(GOSMID, [
                            'id',
                            'strategies', ["to_char(targetDateStart, 'Mon DD, YYYY')",
                                'targetDateStart'
                            ]
                        ], t),
                        gosmModel.getGOSM(GOSMID, 'status', t)
                    ]);
                })
                .then(data => {
                    logger.debug(JSON.stringify(data), log_options);

                    let view = {
                        organizationName: data[0].name,
                        GOSMActivities: data[1],
                        GOSMID: GOSMID,
                        GOSMStatus: data[2].status,
                        csrfToken: req.csrfToken()
                    };
                    view.showUpdateButtons = view.GOSMStatus != 1 && view.GOSMStatus != 3;
                    res.render('APS/OrgGOSMMain', view);
                })
                .catch(error => {
                    throw error;
                });
        },

        getActivityDetails: (req, res) => {
            logger.debug(`GET ACTIVITY DETAILS: ${req.body.dbid}`, log_options);

            database.task(t => {
                return t.batch([
                    gosmModel.getActivityDetails(req.body.dbid, undefined, t),
                    gosmModel.getActivityProjectHeads(req.body.dbid, ['firstname', 'lastname', 'a.idNumber'], t)
                ]);
            }).then(data => {
                res.send(data);
            }).catch(error => {
                throw error;
            });
        },

        viewActivityList: (req, res) => {
            let activityDetails;
            res.render('APS/ActivityList', {
                csrfToken: req.csrfToken()
            });
        }
    };
};