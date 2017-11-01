'use strict';


module.exports = function(configuration, modules, models, database, queryFiles) {
    const logger = modules.logger;

    const log_options = Object.create(null);
    log_options.from = 'APS-Controller';

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;

    const APSController = Object.create(null);

    APSController.viewOrglist = (req, res) => {
        gosmModel.getAllCurrent()
        .then(GOSMList => {
            logger.debug(`Displaying GOSM list: ${JSON.stringify(GOSMList)}`, log_options);
            const renderData = Object.create(null);
            renderData.GOSMList = GOSMList,
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('APS/OrganizationGOSMList', renderData);
        });
    };

    APSController.viewOrgGOSM = (req, res) => {
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
            view.extra_data = req.extra_data;
            return res.render('APS/OrganizationSpecificGOSM', view);
        }).catch(error => {
            throw error;
        });
    };

    APSController.getActivityDetails = (req, res) => {
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
    };


    APSController.viewActivityList = (req, res) => {
        projectProposalModel.getAllActivityProjectProposal([
            'ga.id',
            'ga.strategies AS name',
            "to_char(ga.targetDateStart, 'Mon DD, YYYY') AS dateEvent",
            //AS can be placed in a 2nd array
            ["date_part('day', age(ga.targetDateStart, CURRENT_TIMESTAMP))", 'daysLate'],
            'so.name AS organizationName'
        ]).then(data => {
            logger.debug(`Data: ${JSON.stringify(data)}`, log_options);
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            renderData.proposals = data;
            return res.render('APS/ActivityList', renderData);
        });
    };

    APSController.activityChecking = (req, res) => {
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
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;

            renderData.projectProposal = data[0];
            renderData.expenses = data[1];
            renderData.activity = activityId;
            renderData.projectedIncome = data[2];
            renderData.programDesign = data[3];
            renderData.projectHeads = data[4];
            renderData.attachment = data[5];
            return res.render('APS/ActivityChecking', renderData);
        }).catch(err => {
            throw err;
        });
    };

    APSController.viewAPSLogs = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        return res.render('APS/Logs');
    };

    return APSController;
};
