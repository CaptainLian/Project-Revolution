'use strict';

module.exports = function(database, models, queryFiles) {

    const systemModel = models.System_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const gosmModel = models.gosmModel;

    const log_options = Object.create(null);
    log_options.from = 'Organization-Controller';
    return {

        viewHome: (req, res) => {
            database.task(t => {
                    return t.batch([
                        //TODO: Replace hardcoded values
                        projectProposalModel.getProjectProposalsCountPerStatus(1, 5, t),
                        projectProposalModel.getProjectProposalsCountPerStatus(1, 4, t),
                        projectProposalModel.getProjectProposalsCountPerStatus(1, 3, t)
                    ]);
                })
                .then(data => {
                    global.logger.debug(`${JSON.stringify(data)}`, log_options);
                    res.render('APS/HomeMain', {
                        csrfToken: req.csrfToken(),
                        allProjects: data[0],
                        deniedProjects: data[1],
                        pendingProjects: data[2],
                        successProjects: data[3]
                    });
                })
                .catch(error => {
                    throw error;
                });
        },

        view: (req, res) => {
            res.render('Org/MemberMain');
        },

        viewProject: (req, res) => {
            database.task(t => {
                //TODO: Calculate hardcoded value
                let param = Object.create(null);
                param.gosm = 1;

                return t.batch([
                    organizationModel.getActivitiesWithPPR(param, t),
                    organizationModel.getActivitiesWithoutPPR(param, t)
                ]);
            }).then(data => {
                res.render('Org/viewProjectMain', {
                    actWithPPR: data[0],
                    actWithoutPPR: data[1]
                });
            }).catch(err => {
                throw err;
            });
        },

        submitGOSM: (req, res) => {
            //TODO: Session get student organization
            /**
             * let dbParam = {
             *      studentorganization: 
             *  };
             * @type {Object}
             */
            let dbParam = Object.create(null);
            dbParam.studentorganization = 1;

            gosmModel.submitGOSM(dbParam)
            .then(() => {})
            .catch(error => {
                throw error;
            });
        },

        deleteActivity: (req, res) => {
            let dbParam = Object.create(null);
            dbParam.id = req.body.dbid;

            global.logger.debug(`Deleting activity: ${req.body.dbid}`, log_options);
            gosmModel.deleteActivity(dbParam)
            .then(data => {
                res.send("1");
            }).catch(error => {
                res.send('0');
                throw error;
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
                global.logger.debug(`ID: ${data.id}`, log_options);
                res.send(data.id + "");
            }).catch(error => {
                res.send("0");
                throw error;
            });
        },

        //TODO: Test
        /**
         * Inserts Activities to GOSM
         * @method
         * @param   {[type]} req [description]
         * @param   {[type]} res [description]
         * @returns {[type]}     [description]
         */
        inputCreateGOSM: (req, res) => {
            /* Validate input */
            global.logger.warning('inputCreateGOSM - Input not yet validated!', log_options);
            global.logger.debug(`JSON.stringify(req.body)`, log_options);

            /* Parse input*/
            let strategy = req.body.strategy;
            let goals = req.body.goals;
            let objectives = [];
            objectives = req.body['objectives[]'];

            if (!Array.isArray(objectives)) {
                objectives = [objectives];
            }

            let description = req.body.description;
            let measures = req.body.measures;
            let startDate = req.body.targetDateStart;
            let startDateSplit = startDate.split("/");
            let endDate = req.body.targetDateEnd;
            let endDateSplit = endDate.split("/");
            let activityType = req.body['activity-type'];
            let others = req.body.otherDescription;
            let natureType = req.body['nature-type'];
            let personInCharge = [];
            personInCharge = req.body['personInCharge[]'];

            if (!Array.isArray(personInCharge)) {
                personInCharge = [personInCharge];
            }

            let isRelatedToOrganization = req.body.isRelatedToOrganization;
            let budget = req.body.budget;

            /* Process input */
            database.task(task => {
                return systemModel.getCurrentTerm('id', task)
                .then(term => {
                    global.logger.debug(`Current termID: ${term.id}`, log_options);

                    /**
                     * const param = {
                     *      termID: term.id,
                     *      studentOrganization
                     * }
                     * @type {Object}
                     */
                    let param = Object.create(null);
                    param.termID = term.id;
                    //TODO: replace with session data
                    param.studentOrganization = 1;

                    return task.tx(t => {
                        return gosmModel.getOrgGOSM(param, t)
                            .then(gosm => {
                                const dbParam = {
                                    GOSM: gosm.id,
                                    goals: goals,
                                    objectives: objectives,
                                    strategies: strategy,
                                    description: description,
                                    measures: measures,
                                    targetDateStart: `${startDateSplit[2]}-${startDateSplit[0]}-${startDateSplit[1]}`,
                                    targetDateEnd: `${endDateSplit[2]}-${endDateSplit[0]}-${endDateSplit[1]}`,
                                    activityNature: natureType,
                                    activityType: activityType,
                                    activityTypeOtherDescription: others,
                                    isRelatedToOrganizationNature: isRelatedToOrganization,
                                    budget: budget
                                };

                                if (activityType == 10 && others == null) {
                                    throw new Error('Error activity type others empty');
                                }

                                const insertPromise = gosmModel.insertProposedActivity(dbParam, t);
                                return insertPromise;
                            }).then(activity => {
                                global.logger.debug(`inserted: ${activity.activityid}, person-in-charge_length: ${personInCharge.length}`, log_options);
                                const queries = [Promise.resolve(activity.activityID)];

                                for (let index = personInCharge.length + 1; --index;) {
                                    const item = personInCharge[personInCharge.length - index];
                                    console.log("Inside the loop");
                                    console.log(item);

                                    /**
                                     * const projectHeadParam = {
                                     *      idNumber: parseInt(item),
                                     *      activityID: activity.activityid
                                     *  };
                                     * @variable projectHeadParam
                                     * @type {Object}
                                     */
                                    const projectHeadParam = Object.create(null);
                                    projectHeadParam.idNumber = parseInt(item);
                                    projectHeadParam.activityID = activity.activityid;

                                    queries[queries.length] = gosmModel.insertActivityProjectHead(projectHeadParam, t);
                                }

                                return t.sequence(queries);
                            });
                    }).then(data => { //task end
                        return Promise.resolve(data[0]);
                    });
                });
            }).then(activityID => {
                res.send(String(activityID));
            }).catch(err => {
                throw err;
            });
        },

        createActivityRequirements: (req, res) => {
            res.render("APS/ActivityRequirementsMain", {
                csrfToken: req.csrfToken()
            });
        },

        //TODO Test
        viewCreateGOSM: (req, res) => {
            global.logger.debug('VIEW CREATE GOSM CONTROLLER', log_options);

            database.task(task1 => {
                return systemModel.getCurrentTerm('id', task1)
                    .then(term => {
                        /**
                         * let param = {
                         *      termID: data.id,
                         *      studentOrganization
                         * };
                         * @variable param
                         * @type {Object}
                         */
                        let GOSMParam = Object.create(null);
                        GOSMParam.termID = term.id;
                        //TODO Replace with session variable
                        GOSMParam.studentOrganization = 1;

                        return gosmModel.getOrgGOSM(GOSMParam, task1)
                            .then(GOSM => {
                                /* GOSM Exists */
                                if (GOSM) {
                                    return Promise.resolve(GOSM.id);
                                }
                                //else
                                return task1.tx(transaction => {
                                    return gosmModel.insertNewGOSM(GOSMParam.termID, GOSMParam.studentOrganization, true, transaction)
                                    .then(data => {
                                        return Promise.resolve(data.id);
                                    });
                                });
                            });
                    }).then(GOSM => {
                        return task1.batch([
                            gosmModel.getGOSMActivities(GOSM, task1),
                            gosmModel.getAllActivityTypes(task1),
                            gosmModel.getAllActivityNature(task1)
                        ]);
                    });
            }).then(data => {
                res.render('APS/GOSMMain', {
                    activityTypes: data[0],
                    activityNature: data[1],
                    gosmActivities: data[2],
                    csrfToken: req.csrfToken()
                });
            }).catch(err => {
                throw err;
            });
        }
    };
};