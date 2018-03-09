'use strict';

module.exports = function(configuration, modules, models, database, queryFiles) {
    const logger = modules.logger;

    const log_options = Object.create(null);
    log_options.from = 'APS-Controller';

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const accountModel = models.Account_model;

    const APSController = Object.create(null);

    APSController.viewOrglist = (req, res) => {
        gosmModel.getAllCurrent().then(GOSMList => {
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
        console.log(req);
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
            // view.showUpdateButtons = view.GOSMStatus != 1 && view.GOSMStatus != 3;
            view.showUpdateButtons = view.GOSMStatus ==2;
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
            console.log(data)
            return res.render('APS/ActivityList', renderData);
        });
    };

    APSController.activityChecking = (req, res) => {c
        logger.debug('activityChecking()', log_options);
        var activityId;
        database.task(task => {

            return projectProposalModel.getNextActivityForApproval(req.session.user.idNumber, task)
            .then(data => {
                activityId = data.id;
                logger.debug(`Activity ID: ${activityId}`);

                var pa = {
                    projectId:data.id
                };

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
                    projectProposalModel.getLatestProjectProposalAttachment(pa),
                    projectProposalModel.getSignatories(data.id)
                ]);
            }).catch(err=>{
                return logger.warn(`Unhandled error: ${err.message}\n${err.stack} `, log_options);
            });
        }).then(data => {
            logger.debug(`${JSON.stringify(data[3])}`, log_options);
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            console.log("data[4]")
            console.log(data[4])
            renderData.projectProposal = data[0];
            renderData.expenses = data[1];
            renderData.activity = activityId;
            renderData.projectedIncome = data[2];
            renderData.programDesign = data[3];
            renderData.projectHeads = data[4];
            renderData.attachment = data[5];
            renderData.signatories = data[6];

            renderData.withExpense = data[1].length >0;
            renderData.withRevenue = data[2].length >0;

            console.log(data[2])
            console.log("REVENUE")
            console.log(data[1])
            console.log("EXPENSE")

            
            console.log(renderData.attachment);
            console.log("renderData.attachment");
            return res.render('APS/ActivityChecking', renderData);
        }).catch(err => {
            logger.debug(`${err.message}\n${err.stack}`, log_options);
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('template/APS/NoActivityToCheck', renderData);
        });
    };

    APSController.viewAPSLogs = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        return res.render('APS/Logs');
    };
    APSController.resched = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        projectProposalModel.getReschedActivities()
        .then(data=>{
            console.log(data)
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.activities = data;
            renderData.csrfToken = req.csrfToken();


            return res.render('APS/RescheduleChecking', renderData);
        }).catch(err=>{
            console.log(err)
        })
        // return res.render('APS/RescheduleChecking');
    };
    APSController.home = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        return res.render('APS/APSHome');
    };
    APSController.orgSummary = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        return res.render('APS/OrgApsSummary');
    };

    APSController.viewPPRListToSign = (req, res) => {
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;

        return accountModel.getPPRToSignList(req.session.user.idNumber)
        .then(list => {
            console.log(list)
            console.log("asdasdas")

            renderData.activities = list;
            return res.render('APS/ProjectProposal_sign_list', renderData);
        }).catch(err => {
            return logger.warn(`${err.message}\n${err.stack}`, log_options);
        });
    };

    APSController.viewPPRSign = (req, res) => {
        logger.debug('viewPPRSign()', log_options);

        let activityID = parseInt(req.params.activityID);

        if(!Number.isInteger(activityID)){
            return res.redirect('/APS/Signatory/ActivtiyList');
        }
        //TODO: check if PPR has already been signed by user

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        var dbParam = {
            gosmactivity: req.params.activityID
        }

        return database.task(task => {
            logger.debug('Executing batch queries', log_options);
            return task.batch([
                // 0
                projectProposalModel.getActivityProjectProposalDetailsGAID(activityID, [
                    'an.name AS nature',
                    'at.name AS type',
                    'GA.STRATEGIES AS strategies',
                    'SO.NAME AS orgname',
                    'av.name AS venue',
                    'PP.ENMP AS enmp',
                    'PP.ENP AS enp',
                    'GA.OBJECTIVES AS objectives',
                    'PP.CONTEXT1 AS context1',
                    'PP.CONTEXT2 AS context2',
                    'PP.CONTEXT3 AS context3',
                    'PP.ID as id',
                    'PP.SOURCEFUNDOTHER as sourcefundother',
                    'PP.SOURCEFUNDPARTICIPANTFEE AS sourcefundparticipantfee',
                    'PP.SOURCEFUNDORGANIZATIONAL',
                    'PP.ACCUMULATEDOPERATIONALFUNDS as accumulatedoperationalfunds',
                    'PP.ACCUMULATEDDEPOSITORYFUNDS AS accumulateddepositoryfunds',
                    'PP.ORGANIZATIONFUNDOTHERSOURCE AS organizationfundothersource',
                    'PP.isExpense as expense',
                    'PP.status as status'
                ]),
                // 1
                projectProposalModel.getProjectProposalExpenses(activityID),
                // 2
                projectProposalModel.getProjectProposalProjectedIncome(activityID),
                // 3
                projectProposalModel.getProjectProposalProgramDesign(activityID, [
                    'pppd.dayid AS dayid',
                    "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                    "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                    "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                    'pppd.activity AS activity',
                    'pppd.activitydescription AS activitydescription',
                    'pppd.personincharge AS personincharge'
                ]),
                // 4
                projectProposalModel.getProjectProposalProjectHeads(activityID),
                // 5
                projectProposalModel.getLatestProjectProposalAttachment({projectId: activityID}),
                // 6
                projectProposalModel.getSignatories(activityID),
                //7
                projectProposalModel.getSignatoryStatus(req.session.user.idNumber,activityID),
                //8
                projectProposalModel.getNextPPRSignatory(dbParam)
            ]);
        }).then(data => {
            renderData.projectProposal = data[0];
            renderData.expenses = data[1];
            renderData.activity = activityID;
            renderData.projectedIncome = data[2];
            renderData.programDesign = data[3];
            console.log("data[4]")
            console.log(data[4])
            renderData.projectHeads = data[4];
            renderData.attachment = data[5];
            renderData.signatories = data[6];
            renderData.withExpense = data[0].expense;
            renderData.withRevenue = data[2].length >0;
            renderData.status = data[7];
            console.log(data[2].length > 0);
            console.log("REVENUE");
            console.log(data[0].expense);
            console.log("EXPENSE");

            console.log(data[0].status);
            console.log(data[8])

            if(data[8]==null){
                renderData.showActions = false;
            }
            else{

                if(data[8].signatory == req.session.user.idNumber && data[0].status==2){
                    renderData.showActions = true;
                }
                else{
                    renderData.showActions = false;
                }

            }

            

            logger.debug(`Signatories: ${JSON.stringify(renderData.signatories)}`, log_options);
            logger.debug('rendering page', log_options);
            return res.render('APS/ProjectProposal_sign', renderData);
        }).catch(err => {
            return logger.debug(`${err.message}/n${err.stack}`, log_options);
        });
    };

    return APSController;
};
