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
                let view = {};
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
            database.task(task => {
                //TODO replace 1, hard coded vaue
                return projectProposalModel.getActivityProjectProposalDetails(1, [
                    ['at.name', 'type'],
                    'an.name AS nature',
                    'ga.strategies AS strategies',
                    'so.name AS orgname',
                    'pp.venue AS venue',
                    'pp.enmp AS enmp',
                    'pp.enp AS enp',
                    'ga.objectives AS objectives',
                    'pp.context AS context',
                    'pp.id AS id'
                ], task).then(data => {
                    return task.batch([
                        Promise.resolve(data),
                        projectProposalModel.getProjectProposalExpenses(data.id),
                        projectProposalModel.getProjectProposalProjectedIncome(data.id),
                        projectProposalModel.getProjectProposalProgramDesign(data.id),
                        projectProposalModel.getProjectProposalProjectHeads(data.id)
                    ]);
                });
            }).then(data => {
                return res.render('APS/activityChecking', {
                    projectProposal: data[0],
                    expenses: data[1],
                    projectedIncome: data[2],
                    programDesign: data[3],
                    projectHeads: data[4]
                });
            }).catch(err => {
                throw err;
            });
        }
    };
};