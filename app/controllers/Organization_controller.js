'use strict';
const Promise = require('bluebird');
const fs = require('fs');
var cuid = require('cuid');


module.exports = function(configuration, modules, models, database, queryFiles) {

    const systemModel = models.System_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const gosmModel = models.gosmModel;
    const logger = modules.logger;
    const path = require('path');

    const log_options = Object.create(null);
    log_options.from = 'Organization-Controller';

    return {

        //Create ProjectProposal
        viewGOSMActivityListProjectProposal: (req, res) => {


            systemModel.getCurrentTerm()
            .then(data=>{
                var param = {
                    termID: data.id,
                    studentOrganization: req.session.user.organizationSelected.id
                };
                
                gosmModel.getOrgGOSM(param)
                .then(data1=>{


                    var dbParam = {
                        gosm: data1.id
                    };

                    projectProposalModel.getGOSMActivitiesToImplement(dbParam)
                    .then(data2=>{

                        const renderData = Object.create(null);
                        renderData.extra_data = req.extra_data;
                        renderData.csrfToken = req.csrfToken();
                        renderData.activities = data2;
                        console.log(renderData);
                        return res.render('Org/ActivityToImplement', renderData);
                    }).catch(error=>{
                        console.log(error);
                    });


                }).catch(error=>{

                });
                 
            }).catch(error=>{

            });
            

            

            
        },
        viewGOSMActivityListPostProjectProposal: (req, res) => {

            //TODO: session of gosm id??
            var dbParam = {
                idNumber: req.session.user.idNumber
            };
            console.log(dbParam);
            postProjectProposalModel.getPostActsToImplement(dbParam)
            .then(data=>{
                console.log(data);
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.activities = data;
                console.log(renderData);
                if(req.session.postSubmitted){
                    renderData.success = 1;
                    req.session.postSubmitted = false;
                }
                return res.render('Org/PostActivityToImplement', renderData);
            }).catch(error=>{
                console.log(error);
            });

            
        },

        viewSubmitProjectProposalMain: (req, res) => {

            console.log("ITPO");
            //still no ppr or rejected ppr
            if (req.params.status == 0){

                console.log("ENTER 0");

                var dbParam = {
                    gosmactivity: req.params.id,
                    preparedby: req.session.user.idNumber
                };

                projectProposalModel.insertProjectProposal(dbParam)
                .then(data=>{

                    database.task(task => {
                        return task.batch([
                            gosmModel.getGOSMActivity(dbParam),
                            gosmModel.getGOSMActivityProjectHeads(dbParam),
                            projectProposalModel.getProjectProposal(dbParam)
                        ]);
                    }).then(data => {
                        const renderData = Object.create(null);
                        renderData.extra_data = req.extra_data;
                        renderData.csrfToken = req.csrfToken();

                        renderData.gosmActivity = data[0];
                        renderData.projectHeads = data[1];
                        renderData.projectProposal = data[2];
                        renderData.gosmid = req.params.id;

                        return res.render('Org/SubmitProjectProposal_main',renderData);
                    }).catch(err => {
                        console.log(err);
                    });


                }).catch(error=>{
                    console.log(error);
                });

            } // already started ppr
            else if (req.params.status == 1){

                console.log("ENTER 1");

                var dbParam = {
                    gosmactivity: req.params.id
                };

                database.task(task => {
                        return task.batch([
                            gosmModel.getGOSMActivity(dbParam),
                            gosmModel.getGOSMActivityProjectHeads(dbParam),
                            projectProposalModel.getProjectProposal(dbParam)
                        ]);
                    }).then(data => {
                        const renderData = Object.create(null);
                        renderData.extra_data = req.extra_data;
                        renderData.csrfToken = req.csrfToken();

                        renderData.gosmActivity = data[0];
                        renderData.projectHeads = data[1];
                        renderData.projectProposal = data[2];
                        renderData.gosmid = req.params.id;
                        console.log(data[2]);
                        console.log("KAHITANONGMESSAGE");

                        return res.render('Org/SubmitProjectProposal_main',renderData);
                    }).catch(err => {
                        console.log(err);
                        console.log(err.stack);
                    });

            }
            

        },
        viewSubmitPostProjectProposalMain: (req, res) => {
            var dbParam = {
                idNumber: req.session.user.idNumber,
                gosmid:req.params.gosmid
            };
             var dbParam2 = {                
                gosmactivity:req.params.gosmid
            };
            
            console.log(dbParam);
            database.task(task=>{
                return task.batch([
                    postProjectProposalModel.getPostProjectProposalMain(dbParam),
                    gosmModel.getGOSMActivityProjectHeads(dbParam2)
                    ]);
            }).then(data =>{
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();                
                renderData.activities = data[0];
                renderData.projectHeads = data[1];
                renderData.gosmid = req.params.gosmid;
                console.log(renderData.activities);
                console.log(renderData.projectHeads);
                return res.render('Org/SubmitPostProjectProposal_main', renderData);
            }).catch(err=>{
                console.log(err);
            });
            // postProjectProposalModel.getPostProjectProposalMain(dbParam)
            // .then(data=>{
            //     console.log(data);
            //     const renderData = Object.create(null);
            //     renderData.extra_data = req.extra_data;
            //     renderData.csrfToken = req.csrfToken();
                
            //     renderData.activities = data;
            //     console.log(renderData);
            //     // return res.render('Org/SubmitPostProjectProposal_main', renderData);
            // }).catch(error=>{
            //     console.log(error);
            // });


            
        },

        viewSubmitProjectProposalAttachments: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.actID = req.params.id;
            console.log("req.body");
            console.log(req.params.id);
            var gl = {
                projectId: req.params.id
            }
            

             database.task(task => {
                       
                        return task.batch([
                                gosmModel.getGOSMActivityType(req.params.id, undefined, task).
                                   then(data =>{
                                        console.log("DATA");
                                        console.log(data[0].activitytype);
                                        return gosmModel.getGOSMActivityAttachmentRequirement(data[0].activitytype,task);
                                        
                                   }),
                               projectProposalModel.getLatestProjectProposalAttachment(gl)

                            ]) 
                       
                    }).then(data => {
                        console.log("DATA");
                        console.log(data[0]);
                        renderData.attachments = data[0];
                        renderData.documents = data[1]
                        console.log("DATA1");
                        console.log(data[1]);
                        return res.render('Org/SubmitProjectProposal_attachments',renderData);
                    }).catch(error => {
                        console.log(error);
                    });


          
        },

        viewSubmitProjectProposalBriefContext: (req, res) => {

            const orgID = req.session.user.organizationSelected.id;

            console.log("OrgID is");
            console.log(orgID);

            var dbParam = {
                    gosmactivity: req.params.id,
                    orgId: orgID
            };


             database.task(task => {
                        return task.batch([
                            projectProposalModel.getProjectProposal(dbParam),
                            projectProposalModel.getAllVenues(),
                            projectProposalModel.getOrgFacultyAdvisers(dbParam)
                        ]);
                    }).then(data => {
                       
                        const renderData = Object.create(null);
                        renderData.extra_data = req.extra_data;
                        renderData.csrfToken = req.csrfToken();
                        renderData.projectProposal = data[0];
                        renderData.venues = data[1];
                        renderData.advisers = data[2];
                        renderData.gosmactivity = dbParam;

                        return res.render('Org/SubmitProjectProposal_briefcontext',renderData);

                    }).catch(error => {
                        console.log(error);
                    });


        },
        viewSubmitPostProjectProposalBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.id = req.params.gosmid
            var dbParam = {
                gosmid:req.params.gosmid
            }
            console.log("DATA")
            console.log(req.params);
            database.task(t=>{
                return  t.batch([
                    gosmModel.getObjectives(dbParam),
                    postProjectProposalModel.getPostBriefContext(dbParam)
                    ]);
            }).then(data => {
                renderData.objectives = data[0].objectives;
                renderData.save =  data[1];
                console.log(renderData.save);
                return res.render('Org/SubmitPostProjectProposal_briefcontext',renderData);
            }).catch(err => {
                console.log(err);
            })
            
        },
        viewSubmitPostProjectProposalOthers: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.id = req.params.gosmid;
            return res.render('Org/SubmitPostProjectProposal_others',renderData);
        },
        viewSubmitPostProjectProposalFinanceDocument: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                gosmid : req.params.gosmid
            }
            postProjectProposalModel.getPostProjectProposal(dbParam).then(data => {
                renderData.status = data;
                renderData.id = req.params.gosmid;
                console.log(data);
                return res.render('Org/SubmitPostProjectProposal_financedocuments',renderData);    
            }).catch(err =>{
                console.log(err);
            })
            
        },
        // viewSubmitPostProjectProposalBriefContext: (req, res) => {
        //     const renderData = Object.create(null);
        //     renderData.extra_data = req.extra_data;
        //     renderData.csrfToken = req.csrfToken();

        //     return res.render('Org/SubmitPostProjectProposal_briefcontext',renderData);
        // },

        viewSubmitProjectProposalExpense: (req, res) => {

            const orgID = req.session.user.organizationSelected.id;

            console.log("OrgID is");
            console.log(orgID);

            var dbParam = {
                    gosmactivity: req.params.id,
                    orgId: orgID
            };

            database.task(task=>{
                return task.batch([
                    projectProposalModel.getProjectProposal(dbParam),
                    projectProposalModel.getProjectProposalExpenses(req.params.id)                    
                ]);
            })
            .then(data=>{

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.gosmactivity = dbParam;
                renderData.projectProposal = data[0];
                renderData.expenses = data[1];

                console.log(renderData.gosmactivity);
                console.log(renderData.projectProposal);
            
                return res.render('Org/SubmitProjectProposal_expense', renderData);
            }).catch(error=>{
                console.log(error);
            });


        },

        viewSubmitProjectProposalProgramDesign: (req, res) => {

            const orgID = req.session.user.organizationSelected.id;

            console.log("OrgID is");
            console.log(orgID);

            var dbParam = {
                    gosmactivity: req.params.id,
                    orgId: orgID
            };


            database.task(task =>{
                return task.batch([
                    projectProposalModel.getProjectProposal(dbParam),
                    gosmModel.getGOSMActivityProjectHeads(dbParam),
                    projectProposalModel.getProjectProposalProgramDesign(req.params.id, [
                        'pppd.dayid AS dayid',
                        "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                        "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI') AS starttime",
                        "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI') AS endtime",
                        'pppd.activity AS activity',
                        'pppd.activitydescription AS activitydescription',
                        'pppd.personincharge AS personincharge'
                    ])
                ]);
            })
            .then(data=>{

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.gosmactivity = dbParam;
                renderData.projectProposal = data[0];
                renderData.projectHeads = data[1];
                renderData.programDesign = data[2];

                console.log(renderData.gosmactivity);
                console.log(renderData.projectProposal);

                return res.render('Org/SubmitProjectProposal_programdesign',renderData);
            }).catch(error=>{
                console.log(error);
            });

        },

        viewProjectHeadHome: (req, res) => {
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

                return res.render('Org/ProjectHeadHome', renderData);
            }).catch(error => {
                throw error;
            });
        },


        viewOfficers: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrf = req.csrfToken();

            return res.render('Org/Officers', renderData);
        },

        viewAPSReport: (req, res) => {
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
            logger.debug('submitGOSM()', log_options);
            logger.debug('Submitting GOSM', log_options);
            /**
             * let dbParam = {
             *      studentorganization:
             *  };
             * @type {Object}
             */
            let dbParam = Object.create(null);
            dbParam.studentorganization = req.session.user.organizationSelected.id;

            gosmModel.submitGOSM(dbParam)
            .then(() => {
                res.send("1");
                logger.debug('GOSM Submitted', log_options);
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
                       logger.debug(`ActivityID: ${activity.activityid}, person-in-charge_length: ${personInCharge.length}`, log_options);

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

                           gosmModel.insertActivityProjectHead(projectHeadParam, transaction)
                           .then(data => {

                           });
                       }
                       logger.debug('Inserting project heads', log_options);
                       return Promise.resolve(activity.activityid);
                   });
               });
           }).then(data => {
               return res.send(String(data));
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


        saveContext: (req, res) =>{
            console.log(req.body);

            let startDateSplit = req.body.actualDateStart.split("/");
            let endDateSplit = req.body.actualDateEnd.split("/");


            var dbParam = {
                actualDateStart:  "'" + startDateSplit[2] + "-" + startDateSplit[0] + "-" + startDateSplit[1] + "'",
                actualDateEnd:  "'" + endDateSplit[2] + "-" + endDateSplit[0] + "-" + endDateSplit[1] + "'",
                id: req.params.ppr,
                enp: req.body.enp,
                enmp: req.body.enmp,
                venue: req.body.venue,
                adviser: req.body.adviser,
                isexpense: req.body.expense,
                context1: req.body.context1,
                context2: req.body.context2,
                context3: req.body.context3,
                isBriefContextComplete: true
            };

            if(!(req.body.actualDateStart).trim() ||
                !(req.body.actualDateEnd).trim() ||
                !(req.body.enp).trim() || 
                !(req.body.enmp).trim() || 
                !(req.body.venue).trim() ||
                !(req.body.adviser).trim() ||
                !(req.body.expense).trim() ||
                !(req.body.context1).trim() ||
                !(req.body.context2).trim() ||
                !(req.body.context3).trim()){

                dbParam.isBriefContextComplete = false;
                
            }

            if (!(req.body.actualDateStart).trim()){
                dbParam.actualDateStart=null;
            }

            if (!(req.body.actualDateEnd).trim()){
                dbParam.actualDateEnd=null;
            }

            if (!(req.body.enp).trim()){
                dbParam.enp=null;
            }

            if (!(req.body.enmp).trim()){
                dbParam.enmp=null;
            }

            console.log(req.params.id);

            console.log(dbParam);

            projectProposalModel.updatePPRBriefContext(dbParam)
            .then(data=>{

            }).catch(error=>{
                console.log(error);
            });

            res.redirect(`/Organization/ProjectProposal/Main/${req.params.id}/1`);



        },
        postSaveContext: (req, res) =>{
            console.log(req.params);

            // TODO: change id, to come from selected activity
            var obj = req.body['obj[]'].filter(function(e){return e}); 
            var dbParam = {
                id: req.body.gosmid,
                           
                well: req.body.wentWell,
                learning: req.body.learning,
                develop: req.body.develop,                
                mistakes: req.body.mistakes,
                objectives:req.body['obj[]'],
                isBriefContextComplete: true
            };

            console.log(dbParam)
            console.log(obj.length != (req.body['obj[]']).length
                )
            if(  !(req.body.wentWell).trim() ||
                !(req.body.learning).trim() ||
                !(req.body.develop).trim() ||
                !(req.body.learning).trim() ||
                !(req.body.mistakes).trim() ||
                obj.length != (req.body['obj[]']).length
                )
            {

                dbParam.isBriefContextComplete = false;
                
            }
            console.log("dbParam")
            console.log(dbParam);
            postProjectProposalModel.updatePostProjectProposal(dbParam)
                               .then(data=>{
                                    return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`)
                               }).catch(err=>{
                                    console.log(err);
                               });
            
            // return res.redirect(`Organization/postprojectproposal/main/${req.bod}`)
        },
        postSaveExpenses: (req, res) =>{
             const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            
            // var date = new Date().toJSON();

             
             var dir3 = path.join (__dirname,'..','assets','upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)){
                fs.mkdirSync(dir3);
            }            
            var dir = path.join (__dirname,'..','assets','upload','postacts');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)){
                fs.mkdirSync(dir);
            }
            
            var dir2 = path.join (__dirname,'..','assets','upload','postacts',req.session.user.idNumber+"");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)){
                fs.mkdirSync(dir2);
            }
            var dir4 = path.join (__dirname,'..','assets','upload','images');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir4)){
                fs.mkdirSync(dir4);
            }
            var dir5 = path.join (__dirname,'..','assets','upload','images',req.session.user.idNumber+"");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir5)){
                fs.mkdirSync(dir5);
            }

            //SETTING VALUE OF FINANCE DOCMENT
            var dp = true;
            var bt = true;
            var reim = true;
            if(typeof req.body.bt == "undefined"){
                bt = false;
            }

            if(typeof req.body.dp == "undefined"){
                dp = false
            }
            if(typeof req.body.reim == "undefined"){
                reim = false
            }


            // console.log(req.files);
            database.tx(t=>{
                //NORMAL THINGS TO INSERT
                var statParam ={
                    dp:dp,
                    bt:bt,
                    reim:reim
                }; 
                var finParam = {
                    gosmid : req.body.gosmid,
                    status:true
                }
                
                if(typeof req.files['gals'] == 'object'){
                    var galsFilename = cuid() + path.extname(req.files['gals'].name);
                    var galsFilenameToShow = (req.files['gals'].name);
                    var pg = path.join(dir5,galsFilename);
                    var galsParam ={
                         gosmid: req.body.gosmid,
                         filename : galsFilename,
                         filenameToShow: galsFilenameToShow
                    };

                    Promise.all([
                        postProjectProposalModel.insertPostProjectProposalGals(galsParam,t),
                        req.files['gals'].mv(pg)
                        ]).then(data=>{
                            console.log("")
                        }).catch(err=>{
                            console.log("========PROMISE PICTURE============");
                            console.log(err)


                        });
                }else{
                    finParam.status = false;
                }
               console.log("========TAs33333333333  Sd=========");
                console.log(finParam);
                //EXPENSES MAY VARY 
                console.log(typeof req.files['file[]'])
                if(typeof req.files['file[]'] == 'object'){
                    if(typeof req.files['file[]'][Symbol.iterator] == 'function'){
                        for(var ctr = 0; ctr < req.body['est[]'].length; ctr++){    
                            
                            var orignalFileName = req.files['file[]'][ctr].name;
                            var ftype = path.extname(orignalFileName);
                            console.log(ftype);
                            var fname = cuid()+ftype;

                            var dbParam ={
                                gosmid: req.body.gosmid,
                                particular:req.body['par[]'][ctr],
                                establishment:req.body['est[]'][ctr],
                                price:req.body['price[]'][ctr],
                                file: fname,
                                filenameToShow:req.files['file[]'][ctr].name,
                                idNumber:req.session.user.idNumber,
                               
                            };
                            var p = path.join(dir2,fname);
                            Promise.all([
                                    req.files['file[]'][ctr].mv(p),
                                    postProjectProposalModel.insertPostProjectExpense(dbParam,t)
                                ]).then(result =>{

                                }).catch(err =>{
                                    console.log("========PROMISE=========");
                                    console.log(err);
                                })
                        }
                    }else{

                            var orignalFileName = req.files['file[]'].name;
                            var ftype = path.extname(orignalFileName);
                            console.log(ftype);
                            var fname = cuid()+ftype;

                            var dbParam ={
                                gosmid: req.body.gosmid,
                                particular:req.body['par[]'],
                                establishment:req.body['est[]'],
                                price:req.body['price[]'],
                                file: fname,
                                filenameToShow:req.files['file[]'].name,
                                idNumber:req.session.user.idNumber,
                               
                            };
                            var p = path.join(dir2,fname);
                            Promise.all([
                                    req.files['file[]'].mv(p),
                                    postProjectProposalModel.insertPostProjectExpense(dbParam,t)
                                ]).then(result =>{

                                }).catch(err =>{
                                    console.log("========PROMISE=========");
                                    console.log(err);
                                })
                    }
                }else{
                    finParam.status = false;
                }
                console.log("========TA22222222222=========");
                console.log(finParam);
                if(typeof req.files['pictures[]'] == 'object'){
                console.log(typeof req.files['pictures[]'][Symbol.iterator] );
                    if(typeof req.files['pictures[]'][Symbol.iterator] == 'function'){
                        for(var ctr = 0; ctr < req.body['pictureCaption[]'].length; ctr++){    
                            var orignalFileName = req.files['pictures[]'][ctr].name;
                            var ftype = path.extname(orignalFileName);
                            console.log(ftype);
                            var fname = cuid()+ftype;
                            var pictureParam = {
                                gosmid: req.body.gosmid,
                                filename : ftype,
                                filenameToShow:req.files['pictures[]'].name,
                                idNumber:req.session.user.idNumber,
                                description: req.body["pictureCaption[]"][ctr]
                            }
                            var p = path.join(dir5,fname);
                            Promise.all([
                                    req.files['pictures[]'][ctr].mv(p),
                                    postProjectProposalModel.insertPostProjectProposalEventPictures(pictureParam,t)
                                ]).then(result =>{

                                }).catch(err =>{
                                    console.log("========PROMISE=========");
                                    console.log(err);
                                })

                        }
                    }else{
                         var orignalFileName = req.files['pictures[]'].name;
                            var ftype = path.extname(orignalFileName);
                            console.log(ftype);
                            var fname = cuid()+ftype;
                            var pictureParam = {
                                gosmid: req.body.gosmid,
                                filename : ftype,
                                filenameToShow:req.files['pictures[]'].name,
                                idNumber:req.session.user.idNumber,
                                description: req.body["pictureCaption[]"]
                            }
                            var p = path.join(dir5,fname);
                            Promise.all([
                                    req.files['pictures[]'].mv(p),
                                    postProjectProposalModel.insertPostProjectProposalEventPictures(pictureParam,t)
                                ]).then(result =>{

                                }).catch(err =>{
                                    console.log("========PROMISE=========");
                                    console.log(err);
                                })

                    }
                }else{
                    finParam.status = false;
                }
                 console.log("+++++++++++++++++++++++++++++++");
                console.log(statParam)
                postProjectProposalModel.updatePostProjectProposalFinanceDocumentStatus(statParam,t);
                console.log("========TAsdASDASd=========");
                console.log(finParam);
                postProjectProposalModel.updatePostProjectRequiredCompleteness(finParam,t);
                //PICTURES MAY VARY 

            }).then(data=>{
                 return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`)

            }).catch(err=>{
                console.log("========TAST=========");
                                console.log(err);
            })
            
            // TODO: change id, to come from selected activity
         
            // return res.redirect(`Organization/postprojectproposal/main/${req.bod}`)
        },

        saveDesign: (req, res) =>{


            console.log(req.body);
            console.log("asda++++++++++++++++++++++++++++++++++L");
            var sched = JSON.parse(req.body.sched);
            var keys =  Object.keys(sched);
            console.log(keys);

            var dbParam = {
                projectproposal: req.body.pid
            };

            projectProposalModel.deleteProgramDesign(dbParam)
            .then(data=>{

            }).catch(error=>{
                console.log("delete error");
                console.log(error);
            });


            var index = 0;

            database.tx(transaction=>{

                

                for (var item in sched){
                    console.log(sched[item].length);

                    for (var i = 0; i < sched[item].length; i++){

                        console.log(sched[item][i]);

                        let dateSplit = item.split("/");

                        var dbParam = {
                            projectProposal: req.body.pid,
                            dayID: index,
                            date: "'" + dateSplit[2] + "-" + dateSplit[0] + "-" + dateSplit[1] + "'",
                            startTime: sched[item][i].start,
                            endTime: sched[item][i].end,
                            activity: sched[item][i].act,
                            activityDescription: sched[item][i].desc,
                            personInCharge: sched[item][i].person
                        };

                        console.log("DBPARAM");
                        console.log(dbParam);


                        projectProposalModel.insertProjectProposalDesign(dbParam, transaction)
                        .then(data=>{

                        }).catch(error=>{
                            console.log("insertsched error");
                            console.log(error);
                        });

                        
                    }
                    index++;
                }

                console.log("INDEX IS");
                console.log(index);

                if (index == 0){

                    console.log("ENTERS EMPTY");

                    var param = {
                        id: req.body.pid,
                        status: false
                    };

                    console.log(param);

                    projectProposalModel.updateIsProgramDesignComplete(param, transaction)
                    .then(data=>{

                    }).catch(error=>{
                        console.log("updateIsProgramDesignComplete")
                        console.log(error);
                    });
                } 
                else {

                    console.log("ENTERS");

                    var param = {
                        id: req.body.pid,
                        status: true
                    };

                    projectProposalModel.updateIsProgramDesignComplete(param, transaction)
                    .then(data=>{

                    }).catch(error=>{
                        console.log(error);
                    });

                 }



            }).then(data=>{
                return res.send("1");

            }).catch(error=>{
                console.log(error);
            });


         },

        savePPR:(req, res)=>{
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            console.log("req.body");
            console.log(req.body);
            console.log("req.params");
            console.log(req.params.id);
            var dbParam = {
                id: req.body.pprid,
                preparedby: req.session.user.idNumber
            };
            console.log(req.body.context);
            if(req.body.context && req.body.program && req.body.expense && req.body.attachment){
                console.log("IZ HERE");

                projectProposalModel.submitProjectProposal(dbParam)
                .then(data=>{
                return res.redirect(`/Organization/ProjectProposal/gosmlist/`);
                }).catch(error=>{

                });

                // postProjectProposalModel.insertPostProjectProposal(dbParam)
                // .then(data=>{
                //     return res.render(`/Organization/ProjectProposal/gosmlist`,renderData);
                // }).catch(err=>{

                // });
            }else{

                console.log("IZ HERE INSTEAD");

                return res.redirect(`/Organization/ProjectProposal/gosmlist/`);
            }

        },

        postSaveAttachments: (req, res) =>{
            // var date = new Date().toJSON();

             var dir3 =__dirname+'/../assets/upload/';
             var dir3 = path.join (__dirname,'..','assets','upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)){
                fs.mkdirSync(dir3);
            }
            var dir =__dirname+'/../assets/upload/preacts/';
            var dir = path.join (__dirname,'..','assets','upload','preacts');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)){
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname+'/../assets/upload/preacts/'+req.session.user.idNumber+'/';
            var dir2 = path.join (__dirname,'..','assets','upload','preacts',req.session.user.idNumber+"");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)){
                fs.mkdirSync(dir2);
            }
            var bt, reim, dp;
            if(typeof req.body.bt == 'undefined'){
                bt =false;
            }
            if(typeof req.body.reim == 'undefined'){
                reim = false;
            }
            if(typeof req.body.dp == 'undefined'){
                dp = false;
            }
            console.log(req.body);
            console.log("=========================== FILES");
            console.log(typeof req.files['rof-dp']);
           
          
        
           
           

            

            database.tx(t=>{
                 var statFin = {             
                    stat:true,
                    gosmid: (req.body.gosmid)
                }
                var fqName='';
                var fqcuid='';
                var rofName = '';
                var rofcuid ='';
                if(dp){
                    if(typeof req.files['fq-dp'] == 'object' || typeof req.files['rof-dp'] == 'object'){
                        //DP
                       
                        if(typeof req.files['fq-dp'] == 'object'){
                            fqName = req.files['fq-dp'].name;
                            fqcuid = cuid()+path.extname(fqName);    
                        }
                       
                        if(typeof req.files['rof-dp'] == 'object'){
                            rofName = req.files['rof-dp'].name;
                            rofcuid = cuid()+path.extname(rofName);
                        }
                        var dpParam = {
                            gosmid: req.body.gosmid,
                            est: req.body['est-dp'],
                            amount: 0.0,
                            paymentBy: req.body['pb-dp'],
                            delayedProcessing: req.body['delayed-dp'],
                            fq: fqcuid,
                            fqts: fqName,
                            rof: rofcuid,
                            rofts: rofName,
                            idNumber: req.session.user.idNumber

                        };
                        if(req.body['amount-dp'] != ''){
                            dpParam.amount = req.body['amount-dp'];
                        }
                        if( !(req.body['est-dp']).trim() || 
                            !(req.body['amount-dp']).trim()|| 
                            !(req.body['pb-dp']).trim() || 
                            !(req.body['delayed-dp']).trim() 

                            ){
                          
                            statFin.stat = false;
                        }

                        if(typeof req.files['fq-dp'] == 'object' && typeof req.files['rof-dp'] == 'object'){
                            console.log(dpParam);
                             Promise.all([
                                    req.files['fq-dp'].mv(path.join(dir2,fqcuid)),
                                    req.files['rof-dp'].mv(path.join(dir2,rofcuid)),
                                    postProjectProposalModel.insertPostDP(dpParam,t)
                                ])
                                .then(data =>{

                                }).catch(err =>{
                                     console.log("==================DP1");
                                    console.log(err);
                                });
                        }
                        else if( typeof req.files['rof-dp'] == 'object'){
                             Promise.all([
                            
                                    req.files['rof-dp'].mv(path.join(dir2,rofcuid)),
                                    postProjectProposalModel.insertPostDP(dpParam,t)
                                ])
                                .then(data =>{

                                }).catch(err =>{
                                     console.log("==================DP2");
                                    console.log(err);
                                });
                        }
                        else if(typeof req.files['fq-dp'] == 'object' ){
                             Promise.all([
                                    req.files['fq-dp'].mv(path.join(dir2,fqcuid)),
                            
                                    postProjectProposalModel.insertPostDP(dpParam,t)
                                ])
                                .then(data =>{

                                }).catch(err =>{
                                     console.log("==================DP3");
                                    console.log(err);
                                });
                        }

                    }else{
                        statFin.stat = false;
                         var dpParam = {
                            gosmid: req.body.gosmid,
                            est: req.body['est-dp'],
                            amount: 0.0,
                            paymentBy: req.body['pb-dp'],
                            delayedProcessing: req.body['delayed-dp'],
                            fq: fqcuid,
                            fqts: fqName,
                            rof: rofcuid,
                            rofts: rofName,
                            idNumber: req.session.user.idNumber

                        };
                        if(req.body['amount-dp'] != ''){
                            dpParam.amount = req.body['amount-dp'];
                        }
                         postProjectProposalModel.insertPostDP(dpParam,t)
                    }
                }
                if(bt){
                    if(typeof req.files['bs-bt'] == 'object'){
                        //BT
                        var bsName = req.files['bs-bt'].name;
                        var bscuid = cuid()+path.extname(bsName);
                        var btParam = {
                            gosmid : req.body.gosmid,
                            est : req.body["est-bt"],
                            amount: req.body["amount-bt"],
                            purpose: req.body['pur-bt'],
                            bs: bscuid,
                            bsts: bsName,
                            idNumber: req.session.user.idNumber
                        };
                         if( !(req.body['est-bt']).trim() || 
                            !(req.body['amount-bt']).trim() || 
                            !(req.body['pur-bt']).trim()
                            ){
                           
                            statFin.isFinanceDocumentCompleted = false;
                        }
                        if(req.body['amount-bt'] != ''){
                            btParam.amount = req.body['amount-bt'];
                        }
                        Promise.all([
                                    req.files['bs-bt'].mv(path.join(dir2,bscuid)),
                                    postProjectProposalModel.insertPostBT(btParam,t)
                                ])
                                .then(data =>{

                                }).catch(err =>{
                                    console.log("==================bt");
                                    console.log(err);
                                });

                    }else{
                        var bscuid = '';
                        var bsts = '';
                        statFin.stat = false;
                         var btParam = {
                            gosmid : req.body.gosmid,
                            est : req.body["est-bt"],
                            amount: 0.0,
                            purpose: req.body['pur-bt'],
                            bs: bscuid,
                            bsts: bsName,
                            idNumber: req.session.user.idNumber
                        };
                        if(req.body['amount-bt'] != ''){
                            btParam.amount = req.body['amount-bt'];
                        }
                        postProjectProposalModel.insertPostBT(btParam,t)
                    }
                }


                if(reim){
                    if(typeof req.files['rec-pr'] == 'object'){
                        //REIM
                        var names =[];
                        var nameToShow = [];
                        if(typeof req.files['rec-pr'][Symbol.iterator] == 'function'){
                            for(var ctr = 0; ctr < req.files['rec-pr'].length; ctr++){
                                var recName = req.files['rec-pr'][ctr].name;
                                var reccuid = cuid()+path.extname(recName); 
                                names.push(recName)  ;
                                nameToShow.push(reccuid);
                                req.files['rec-pr'][ctr].mv(path.join(dir2,reccuid))
                                    .then(data=>{

                                    }).catch(err=>{
                                        console.log("==================REIM");
                                        console.log(err);
                                    })
                            }
                        }else{
                            var recName = req.files['rec-pr'].name;
                            var reccuid = cuid()+path.extname(recName); 
                            names.push(recName)  ;
                            nameToShow.push(reccuid);
                            req.files['rec-pr'].mv(path.join(dir2,reccuid))
                                .then(data=>{

                                }).catch(err=>{
                                    console.log("==================REIM1");
                                    console.log(err);
                                })
                        }
                        var rParam = {
                            gosmid : req.body.gosmid,
                            est : req.body["est-pr"],
                            amount: 0.0,
                            paymentBy : req.body['pb-pr'],
                            delayedProcessing: req.body['delayed-pr'],
                            n:req.body['n-pr'],
                            filenames: names,
                            filenamesToShow: nameToShow,
                            idNumber: req.session.user.idNumber

                        }
                        
                        if( !(req.body['est-pr']).trim() || 
                            !(req.body['amount-pr']).trim() || 
                            !(req.body['delayed-pr']).trim() || 
                            !(req.body['n-pr']).trim()

                            ){
                            
                            statFin.stat = false;
                        }
                        if(req.body['amount-pr'] != '')
                            rParam.amount = req.body['amount-pr'];
                        console.log(rParam);
                        postProjectProposalModel.insertPostReim(rParam,t)
                        .then(data =>{

                        })
                        .catch(err=>{
                            console.log("=======================REIM2");
                            console.log(err);
                        });
                    }else{
                        statFin.stat = false;
                         var rParam = {
                            gosmid : req.body.gosmid,
                            est : req.body["est-pr"],
                            amount: 0.0,
                            paymentBy : req.body['pb-pr'],
                            delayedProcessing: req.body['delayed-pr'],
                            n:req.body['n-pr'],
                            filenames: names,
                            filenamesToShow: nameToShow,
                            idNumber: req.session.user.idNumber

                        }
                        if(req.body['amount-pr'] != '')
                            rParam.amount = req.body['amount-pr'];
                        postProjectProposalModel.insertPostReim(rParam,t)
                    }
                }
                console.log(statFin);
                    
                 postProjectProposalModel.updatePostProjectFinanceCompleteness(statFin,t)
                    .then(data =>{

                    })
                    .catch(err=>{
                        console.log("=======================FINAUPDATE");
                        console.log(err);
                    });


            }).then(data =>{
                return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`);
            }).catch(err =>{
                console.log("==================TRAC");
                console.log(err);
            })
        },


        saveExpenses: (req, res) =>{
            console.log("HERE");
            console.log(req.body);

            var dbParam = {
                id: req.params.ppr,
                accumulatedOperationalFunds: req.body.ope,
                accumulatedDepositoryFunds: req.body.dep,
                organizationFundOtherSource: req.body.otherfunds,
                sourceFundOrganizational: req.body.org,
                sourceFundParticipantFee: req.body.par,
                sourceFundOther: req.body.others,
                isExpenseComplete: true
            };

            console.log(req.body['item[]'].length);

            projectProposalModel.updatePPRExpenses(dbParam);

            var dbParam2 = {
                projectproposal: req.params.ppr
            };

            projectProposalModel.deleteExpenses(dbParam2);

            database.tx(transaction=>{

                for (var i = 0; i < req.body['item[]'].length-1; i++){

                    var dbParam3 = {
                        projectProposal: req.params.ppr,
                        material: req.body['item[]'][i],
                        quantity: req.body['quantity[]'][i],
                        unitCost: req.body['price[]'][i],
                        type: req.body['typeOfItem[]'][i]
                    };

                    console.log("ENTERS LOOP");
                    console.log(dbParam3);

                    projectProposalModel.insertProjectProposalExpenses(dbParam3, transaction)
                    .then(data=>{

                    }).catch(error=>{
                        console.log(error);
                    });
                }

            });

            

            res.redirect(`/Organization/ProjectProposal/Main/${req.params.id}/1`);

        },

        saveAttachments: (req, res) =>{
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            
            // var date = new Date().toJSON();

             var dir3 =__dirname+'/../assets/upload/';
             var dir3 = path.join (__dirname,'..','assets','upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)){
                fs.mkdirSync(dir3);
            }
            var dir =__dirname+'/../assets/upload/preacts/';
            var dir = path.join (__dirname,'..','assets','upload','preacts');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)){
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname+'/../assets/upload/preacts/'+req.session.user.idNumber+'/';
            var dir2 = path.join (__dirname,'..','assets','upload','preacts',req.session.user.idNumber+"");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)){
                fs.mkdirSync(dir2);
            }
 

            dir2 = path.normalize(dir2);
            console.log("req.files");
            console.log(req.body);
            console.log(req.session.user.idNumber);

            var dt = ['application/vnd.oasis.opendocument.text',
                      'application/vnd.oasis.opendocument.spreadsheet',
                       'application/vnd.oasis.opendocument.presentation',
                       'application/pdf'];

        
            database.task(task => {
                       
                        return gosmModel.getGOSMActivityType(req.body.activityId, undefined, task).
                               then(data =>{
                                    console.log("DATA");
                                    console.log(data[0].activitytype);
                                    return gosmModel.getGOSMActivityAttachmentRequirement(data[0].activitytype,task);
                                    
                               });
                       
                    }).then(data => {


                        var ctr = 0;
                        console.log(req.files['uploadfile[]']);
                        console.log("TYPE OF ONE UPLOAD");
                        console.log(typeof req.files['uploadfile[]'][Symbol.iterator]);
                        if(typeof req.files['uploadfile[]'][Symbol.iterator] == 'function'){
                            for(var file of req.files['uploadfile[]']){
                                // console.log(file);
                                // console.log("file");
                                // console.log(data[ctr].id);
                                
                                var date = cuid();           
                                var nFilename = file.name.split('.').pop();
                                console.log("new File name");
                                console.log(nFilename);
                                 var db ={
                                        projectId : req.body.activityId,
                                        requirement: data[ctr].id,
                                        dir: dir2 + file.name +' - '+ date,
                                        idNumber: req.session.user.idNumber,
                                        filename: date +'.'+ nFilename,
                                        filenametoShow: file.name

                                    };
                                console.log("FILE");
                                console.log(path.normalize(path.join(dir2 , date +'.'+ nFilename)));
                                var p = path.normalize(path.join(dir2 , date +'.'+ nFilename));
                                Promise.all([
                                            file.mv(p),
                                            projectProposalModel.insertProjectProposalAttachment(db)

                                            ]).then(result=>{
                                                console.log(result);
                                            }).catch(err=>{
                                                console.log(err);
                                            });                                                
                                ctr++
                            }
                        }else if(typeof req.files['uploadfile[]'][Symbol.iterator] == 'undefined'){
                              var file = req.files['uploadfile[]'];
                              var nFilename = file.name.split('.').pop();
                                console.log("new File name");
                                var date = cuid();     
                              var db ={
                                        projectId : req.body.activityId,
                                        requirement: data[ctr].id,
                                        dir: dir2 + file.name +' - '+ date,
                                        idNumber: req.session.user.idNumber,
                                        filename: date +'.'+ nFilename,
                                        filenametoShow: file.name

                                    };
                                
                                console.log("FILE");
                                var p = path.normalize(path.join(dir2 , date +'.'+ nFilename));
                                console.log(path.normalize(path.join(dir2 , date +'.'+ nFilename)));
                                Promise.all([
                                            file.mv(p),
                                            projectProposalModel.insertProjectProposalAttachment(db)

                                            ]).then(result=>{
                                                console.log(result);
                                            }).catch(err=>{
                                                console.log(err);
                                            });          
                        }


                        // console.log("DATA1");
                        // console.log(data);
                        // console.log(data[0].id);
                        // renderData.attachments = data;
                        console.log("ACT ID ");
                        console.log(req.body.activityId);

                        return res.redirect(`/Organization/ProjectProposal/main/${req.body.activityId}/1`);
                    }).catch(error => {
                        console.log(error);
                    });

                    var dbParam = {
                            id: req.body.activityId
                    };

                    projectProposalModel.updateIsAttachmentsComplete(dbParam)
                    .then(data=>{

                    }).catch(error=>{
                        console.log(error);
                    });


        },
        postSaveMain: (req, res)=>{
            var dbParam3 = {
                gosmid: req.body.gosmid,
                status:3
            }
             var dbParam = {
                idNumber: req.session.user.idNumber
            };
            console.log(dbParam3);
            
            database.tx(t=>{
                postProjectProposalModel.updatePostProjectProposalCompleteness(dbParam3,t);    
                return postProjectProposalModel.getPostActsToImplement(dbParam,t);
            }).then(data=>{
               
                req.session.postSubmitted = true;
                return res.redirect('/Organization/PostProjectProposal/GOSMList');
            }).catch(err=>{
                 console.log("POST SAVE MAIN");
                console.log(error);
            });
          

           

        }
    };
};
