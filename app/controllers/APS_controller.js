'use strict';

const log_options = {
    from: 'APS-Controller'
};

module.exports = function(configuration, modules, models, database, queryFiles) {
    const logger = modules.logger;

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;

    return {

        viewOrglist: (req, res) => {
            gosmModel.getAllCurrent()
            .then(GOSMList => {
                logger.debug(`Displaying GOSM list: ${JSON.stringify(GOSMList)}`, log_options);
                return res.render('APS/OrganizationGOSMList', {
                    GOSMList: GOSMList,
                    csrfToken: req.csrfToken()
                });
            }).catch(error => {
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
            }).then(data => {
                logger.debug(`${JSON.stringify(data)}`, log_options);

                /**
                 * let view = {
                 *     organizationName: data[0].name,
                 *     GOSMActivities: data[1],
                 *     GOSMID: GOSMID,
                 *     GOSMStatus: data[2].status,
                 *     csrfToken: req.csrfToken()
                 * };
                 * @type {Object}
                 */
                let view = Object.create(null);
                view.organizationName = data[0].name;
                view.GOSMActivities = data[1];
                view.GOSMID = GOSMID;
                view.GOSMStatus = data[2].status;
                view.csrfToken = req.csrfToken();
                view.showUpdateButtons = view.GOSMStatus != 1 && view.GOSMStatus != 3;
                return res.render('APS/OrganizationSpecificGOSM', view);
            }).catch(error => {
                throw error;
            });

        },

        getActivityDetails: (req, res) => {
            logger.debug(`GET ACTIVITY DETAILS: ${req.body.dbid}`, log_options);

            database.task(t => {
                return t.batch([
                    gosmModel.getActivityDetails(req.body.dbid, undefined, t),
                    gosmModel.getActivityProjectHeads(req.body.dbid, [
                        'firstname',
                        'lastname',
                        'a.idNumber'], t)
                ]);
            }).then(data => {
                return res.send(data);
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
            ]).then(data => {
                logger.debug(`Data: ${JSON.stringify(data)}`, log_options);
                return res.render('APS/ActivityList', {
                    csrfToken: req.csrfToken(),
                    proposals: data
                });
            }).catch(err => {
                throw err;
            });
        },


        activityChecking: (req, res) => {
            var activityId;
            database.task(task => {
                
                return projectProposalModel.getNextActivityForApproval(task)
                .then(data => {
                    activityId = data.id;
                    console.log(activityId);
                    
                    return task.batch([
                        Promise.resolve(data),
                        projectProposalModel.getProjectProposalExpenses(data.id),
                        projectProposalModel.getProjectProposalProjectedIncome(data.id),
                        projectProposalModel.getProjectProposalProgramDesign(data.id, [
                            'pppd.dayid AS dayid',
                            "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                            "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                            "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                            'pppd.activity AS activity',
                            'pppd.activitydescription AS activitydescription',
                            'pppd.personincharge AS personincharge'
                        ]),
                        projectProposalModel.getProjectProposalProjectHeads(data.id),
                        projectProposalModel.getProjectProposalAttachment(data.id)
                    ]);


                });
            }).then(data => {
                logger.debug(`${JSON.stringify(data[3])}`, log_options);
                return res.render('APS/ActivityChecking', {
                    projectProposal: data[0],
                    expenses: data[1],
                    //TODO: change value of activity
                    activity: activityId,
                    projectedIncome: data[2],
                    programDesign: data[3],
                    projectHeads: data[4],
                    attachment: data[5],
                    csrfToken: req.csrfToken()
                });
            }).catch(err => {
                throw err;
            });
        }
    };
};
