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
            //  var orgGOSMParam = {
            //          termID: data.id,
            //          studentOrganization: 1 //to be replaced by session variable

            //      };
            //  return gosmModel.getOrgGOSM(orgGOSMParam);
            // })
            // .then(data => {
            //  if (data)
            // });
            gosmModel.getSchoolYear()
                .then(data => {
                    console.log(data.endyear);


                    var orgGOSMParam = {
                        termID: data.id,
                        studentOrganization: 1 //to be replaced by session variable

                    };

                    gosmModel.getOrgGOSM(orgGOSMParam)
                        .then(data => {
                            console.log(data);


                            if (data == null) {
                                // insert GOSM

                                console.log("DUMAAN SIYA DITO");

                                gosmModel.insertNewGOSM(orgGOSMParam)
                                    .then(data => {

                                        gosmModel.getOrgGOSM(orgGOSMParam)
                                            .then(data => {
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
                                            .catch(error => {

                                            });
                                    })
                                    .catch(error => {
                                        console.log(error);
                                    });
                            } else {
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
                        .catch(error => {
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
                    //TODO Flatten
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

        updateActivity: (req, res) => {

            console.log(req.body);

            var id = req.body.id;

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
            var others = req.body.othersDescription;
            var natureType = req.body['nature-type'];
            var personInCharge = [];
            personInCharge = req.body['personInCharge[]'];


            if (!Array.isArray(personInCharge)) {
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
                targetDateStart: "'" + startDateSplit[2] + "-" + startDateSplit[0] + "-" + startDateSplit[1] + "'",
                targetDateEnd: "'" + endDateSplit[2] + "-" + endDateSplit[0] + "-" + endDateSplit[1] + "'",
                activityNature: natureType,
                activityType: activityType,
                activityTypeOtherDescription: others,
                isRelatedToOrganizationNature: isRelatedToOrganization,
                budget: budget
            };

            gosmModel.updateActivity(dbParam)
                .then(data => {
                    console.log(data);
                    res.send(data.id + "");
                })
                .catch(error => {
                    console.log(error);
                    res.send("0");
                });
        },

        inputActivityRequirements: (req, res) => {
            let sched = JSON.parse(req.body.sched);

            let exp = JSON.parse(req.body.exp);
            let funds = JSON.parse(req.body.funds);
            // var sched = sched[0];

            // console.log(sched.time[1].start);
            // req.body.context

            console.log(req.body);
            var projectProposalParam = {};

            database.tx(t => {
                    return projectProposalModel.insertProjectProposal({}, t)
                        .then(data => {
                            const projectProposalID = data.projectProposal;
                            t.task(t => {
                                const queries = [];

                                /* 

                                    PPR Program Design

                                */
                                for (let index0 = sched.length + 1; --index0;) {
                                    const program = sched[sched.length - index0];
                                    for (let index1 = program.length + 1; --index1;) {
                                        const i = program.length - index1;
                                        const item = data[i];
                                        queries[queries.length] = projectProposalModel.insertProjectProposalDesign({
                                            projectProposal: projectProposalID,
                                            dayID: i,
                                            date: item.date,
                                            startTime: item.start,
                                            endTime: item.end,
                                            activity: item.actName,
                                            activityDescription: item.actDesc,
                                            personInCharge: item.pic
                                        }, t);
                                    }
                                }

                                // insert finances


                                /* 

                                    Revenue

                                */
                                for (let index = funds.revenue.length + 1; --index;) {
                                    const item = funds.revenue[funds.revenue.length - index];
                                    queries[queries.length] = projectProposalModel.insertProjectProposalProjectedIncome({
                                        projectProposal: projectProposalID,
                                        material: item.item,
                                        quantity: item.quan,
                                        sellingPrice: item.price
                                    }, t);
                                }

                                /*

                                    Expense

                                */
                                for (let index = funds.expense.length + 1; --index;) {
                                    const item = funds.expense[funds.expense.length - index];
                                    queries[queries.length] = projectProposalModel.insertProjectProposalExpenses({
                                        projectProposal: projectProposalID,
                                        material: item.item,
                                        quantity: item.quan,
                                        unitCost: item.price
                                    }, t);
                                }

                                return t.batch(queries);
                            });
                        });
                })
                .then(data => {
                    logger.debug('', log_options);
                })
                .catch(err => {
                    throw err;
                });
        },

        deleteActivity: (req, res) => {

            let dbParam = {
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

            let dbParam = {
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
                            'strategies', ["to_char(targetDateStart, 'Mon DD, YYYY')", 'targetDateStart']
                        ], t),
                        gosmModel.getGOSM(GOSMID, 'status', t)
                    ]);
                })
                .then(data => {
                    logger.debug(JSON.stringify(data), log_options);

                    let view = {
                        organizationName: data[0].name,
                        GOSActivities: data[1],
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
            projectProposalModel.getAllActivityProjectProposal([
                    'ga.id',
                    'ga.strategies AS name',
                    "to_char(ga.targetDateStart, 'Mon DD, YYYY') AS dateEvent",
                    //AS can be placed in a 2nd array
                    ["date_part('day', age(ga.targetDateStart, CURRENT_TIMESTAMP))", 'daysLate'],
                    'so.name AS organizationName'
                ])
                .then(data => {
                    logger.debug(`Data: ${JSON.stringify(data)}`, log_options);
                    res.render('APS/ActivityList', {
                        csrfToken: req.csrfToken(),
                        proposals: data
                    });
                })
                .catch(err => {
                    throw err;
                });
        }
    };
};