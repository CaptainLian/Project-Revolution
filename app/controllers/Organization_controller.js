'use strict';
const Promise = require('bluebird');

module.exports = function(configuration, modules, models, database, queryFiles) {

    const systemModel = models.System_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const gosmModel = models.gosmModel;
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Organization-Controller';

    return {

        viewSubmitProjectProposalMain: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitProjectProposal_main',renderData);
        },
        viewSubmitPostProjectProposalMain: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitPostProjectProposal_main',renderData);
        },

        viewSubmitProjectProposalAttachments: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitProjectProposal_attachments',renderData);
        },

        viewSubmitProjectProposalBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitProjectProposal_briefcontext',renderData);
        },
        viewSubmitPostProjectProposalBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitPostProjectProposal_briefcontext',renderData);
        },
        viewSubmitPostProjectProposalOthers: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitPostProjectProposal_others',renderData);
        },
        viewSubmitPostProjectProposalFinanceDocument: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitPostProjectProposal_financedocuments',renderData);
        },
        // viewSubmitPostProjectProposalBriefContext: (req, res) => {
        //     const renderData = Object.create(null);
        //     renderData.extra_data = req.extra_data;
        //     renderData.csrfToken = req.csrfToken();

        //     return res.render('Org/SubmitPostProjectProposal_briefcontext',renderData);
        // },

        viewSubmitProjectProposalExpense: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitProjectProposal_expense', renderData);
        },

        viewSubmitProjectProposalProgramDesign: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/SubmitProjectProposal_programdesign',renderData);
        },

        viewHome: (req, res) => {
            database.task(t => {
                return t.batch([
                    //TODO: Replace hardcoded values
                    projectProposalModel.getProjectProposalsCountPerStatus(1, 5, t),
                    projectProposalModel.getProjectProposalsCountPerStatus(1, 4, t),
                    projectProposalModel.getProjectProposalsCountPerStatus(1, 3, t)
                ]);
            }).then(data => {
                logger.debug(`${JSON.stringify(data)}`, log_options);
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.allProjects = data[0];
                renderData.deniedProjects = data[1];
                renderData.pendingProjects = data[2];
                renderData.successProjects =  data[3];

                return res.render('Org/Home', renderData);
            }).catch(error => {
                throw error;
            });
        },

        view: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/Member', renderData);
        },

        viewProject: (req, res) => {
            database.task(t => {
                //TODO: Calculate hardcoded value
                let param = Object.create(null);
                param.gosm = 1;

                return t.batch([
                    organizationModel.getActivitiesWithPPR(param, t),
                    organizationModel.getActivitiesWithoutPPR(param, t),
                    projectProposalModel.getPPRProjectedCost(param, t),
                    gosmModel.getGOSMActivities(param.gosm, [
                            'budget AS budget',
                            'strategies AS strategies',
                            "to_char(targetdatestart, 'Mon DD, YYYY') AS startdate",
                            "to_char(targetdateend, 'Mon DD, YYYY') AS enddate"
                        ],
                        t)
                ]);
                //TODO: add signatories and score
            }).then(data => {
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;

                renderData.actWithPPR = data[0];
                renderData.actWithoutPPR = data[1];
                renderData.projectedCost = data[2];
                renderData.gosmActivity = data[3];
                return res.render('Org/viewProjectMain', renderData);
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

             logger.debug(`Deleting activity: ${req.body.dbid}`, log_options);
            gosmModel.deleteActivity(dbParam)
            .then(data => {
                return res.send("1");
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
                 logger.debug(`ID: ${data.id}`, log_options);

                return res.send(String(data.id));

            }).catch(error => {
                res.send("0");
                throw error;
            });
        },

        /**
         * Inserts Activities to GOSM
         * @method
         * @param   {[type]} req [description]
         * @param   {[type]} res [description]
         * @returns {[type]}     [description]
         */
        inputCreateGOSM: (req, res) => {
            logger.debug('inputCreateGOSM(): ',log_options);
            /* Validate input */
            logger.warning('inputCreateGOSM - Input not yet validated!', log_options);
            logger.debug(`${JSON.stringify(req.body)}`, log_options);

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

            let activityID = -1;
            systemModel.getCurrentTerm('id')
            .then(term => {
                logger.debug(`Current termID: ${term.id}`, log_options);

               /**
                * const param = {
                *      termID: term.id,
                *      studentOrganization
                * }
                * @type {Object}
                */
               let param = Object.create(null);
               param.termID = term.id;
               param.studentOrganization = req.session.user.organizationSelected.id;
               return gosmModel.getOrgGOSM(param);
           }).then(gosm => {
               logger.debug('starting transaction', log_options);
               return database.tx(transaction => {
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
                   logger.debug('Inserting GOSM Activity', log_options);
                   return gosmModel.insertProposedActivity(dbParam, transaction)
                   .then(activity => {
                       activityID = activity.activityid;
                       logger.debug(`ActivityID: ${activity.activityid}, person-in-charge_length: ${personInCharge.length}`, log_options);
                       const queries = [];

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
                           projectHeadParam.activityID = parseInt(activity.activityid);

                           queries[queries.length] = gosmModel.insertActivityProjectHead(projectHeadParam, transaction);
                       }
                       logger.debug('Inserting project heads', log_options);
                       return transaction.sequence(queries);
                   });
               });
           }).then(data => {
               return res.send(String(activityID));
           });
        },

        createActivityRequirements: (req, res) => {

            const dbParam = {};
            //TODO CHANGE ID
            dbParam. id = 1;

            database.task(task => {
                return task.batch([
                    gosmModel.getGOSMActivity(dbParam),
                    gosmModel.getGOSMActivityProjectHeads(dbParam)
                ]);
            }).then(data => {
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.gosmActivity = data[0];
                renderData.projectHeads = data[1];

                return res.render("Org/ActivityRequirements", renderData);
            }).catch(err => {
                throw err;
            });
        },
        viewSettingAcl: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            return res.render('Org/Settings_ACL',renderData);
        },

        //TODO Test
        viewCreateGOSM: (req, res) => {
             logger.debug('VIEW CREATE GOSM CONTROLLER', log_options);

            database.task(task1 => {
                logger.debug('Starting database task', log_options);
                return systemModel.getCurrentTerm('id', task1)
                .then(term => {
                    /**
                     * const param = {
                     *      termID: term.id,
                     *      studentOrganization
                     * }
                     * @type {Object}
                     */
                    let GOSMParam = Object.create(null);
                    GOSMParam.termID = term.id;
                    GOSMParam.studentOrganization = req.session.user.organizationSelected.id;

                    return gosmModel.getOrgGOSM(GOSMParam, task1)
                    .then(GOSM => {
                        /* GOSM Exists */
                        if (GOSM) {
                            return Promise.resolve(GOSM.id);
                        }
                        //else
                        return gosmModel.insertNewGOSM(GOSMParam.termID, GOSMParam.studentOrganization, true, task1)
                        .then(data => {
                            return Promise.resolve(data.id);
                        });
                    }).catch(err => {
                        throw err;
                    });
                }).then(GOSM => {
                    logger.debug('Starting batch queries', log_options);
                    return task1.batch([
                        gosmModel.getGOSMActivities(GOSM, undefined, task1),
                        gosmModel.getAllActivityTypes(['id', 'name'], task1),
                        gosmModel.getAllActivityNature(['id', 'name'], task1)
                    ]);
                });
             }).then(data => {
                logger.debug(`${JSON.stringify(data)}`, log_options);
                logger.debug(`${JSON.stringify(data[2])}`, log_options);
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.activityTypes = data[1];
                renderData.activityNature = data[2];
                renderData.gosmActivities = data[0];

                return res.render('Org/GOSM', renderData);
              }).catch(err => {
                  throw err;
              });
        },

        inputActivityRequirements: (req, res) => {
            let sched = JSON.parse(req.body.sched);
            let exp = JSON.parse(req.body.exp);
            let funds = JSON.parse(req.body.funds);

            // var sched = sched[0];
            console.log(funds.expense);
            // req.body.context

            //  logger.debug(`${JSON.stringify(req.body)}`, log_options);

            let projectProposalParam = {
                //TODO change gosmactivity value
                GOSMactivity: 2,
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

            database.tx(t /* transaction connection */ => {
                //  logger.debug(`${JSON.stringify(projectProposalParam)}`);
                return projectProposalModel.insertProjectProposal(projectProposalParam, t)
                .then(data => {
                    const projectProposalID = data.projectproposal;
                     logger.debug(`projectProposal: ${projectProposalID}`, log_options);
                    /*

                        PPR Program Design

                    */
                     logger.debug('Inserting Program Design',log_options);
                    for (let index0 = sched.length + 1; --index0;) {
                         logger.debug(sched, log_options);
                        const program = sched[sched.length - index0];
                        for (let index1 = program.time.length + 1; --index1;) {
                             logger.debug(index1, log_options);
                            const i = program.time.length - index1;
                            const item = program.time[i];
                            var dateSplit = program.date.split("/");

                            projectProposalModel.insertProjectProposalDesign({
                                projectProposal: projectProposalID,
                                dayID: i,
                                date:  "'" + dateSplit[2] + "-" + dateSplit[0] + "-" + dateSplit[1] + "'",
                                startTime: item.start,
                                endTime: item.end,
                                activity: item.actName,
                                activityDescription: item.actDesc,
                                personInCharge: item.pic
                            }, t).then(() => {

                            }).catch(err => {
                                throw err;
                            });
                        }
                    }

                    /*

                        Revenue

                    */
                     logger.debug('Inserting Revenue',log_options);
                    for (let index = funds.revenue.length + 1; --index;) {
                         logger.debug(`NAG LOOP`, log_options);
                        console.log("INDEX IS");
                        console.log(index);
                        console.log("LENGTH IS");
                        console.log(funds.revenue.length);
                        const item = funds.revenue[funds.revenue.length - index];
                        console.log(item);
                        projectProposalModel.insertProjectProposalProjectedIncome({
                            projectProposal: projectProposalID,
                            item: item.item,
                            quantity: item.quan,
                            sellingPrice: item.price
                        }, t).then(() => {

                        }).catch(err => {
                            throw err;
                        });
                    }

                    /*

                        Expense

                    */
                     logger.debug('Inserting Expenses',log_options);
                    for (let index = funds.expense.length + 1; --index;) {
                        console.log("INDEX IS");
                        console.log(index);
                        console.log("LENGTH IS");
                        console.log(funds.expense.length);
                        const item = funds.expense[funds.expense.length - index];
                        console.log(item);
                        projectProposalModel.insertProjectProposalExpenses({
                            projectProposal: projectProposalID,
                            material: item.item,
                            quantity: item.quan,
                            unitCost: item.price
                        }, t).then(() => {

                        }).catch(err => {
                            throw err;
                        });
                    }
                }).catch(err => {
                    throw err;
                });
            }).then(data => {
                 logger.debug(`${data}`, log_options);
            }).catch(err => {
                 logger.warning(`${JSON.stringify(err)}`, log_options);
                throw err;
            });
        }
    };
};
