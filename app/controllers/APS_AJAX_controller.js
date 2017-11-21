module.exports = function(configuration, modules, models, database, queryFiles) {
    const SIGN = require('../utility/digitalSignature.js').signString;
    const STRINGIFY = require('json-stable-stringify');

    const PATH_ASSETS = configuration.webserver.assets.path;

    const log_options = Object.create(null);
    log_options.from = 'AJAX-APS';
    log_options.color = '\x1b[35m';

    const logger = modules.logger;

    const gosmModel = models.gosmModel;
    const accountModel = models.Account_model;
    const projectProposalModel = models.ProjectProposal_model;

    const APS_AJAXController = Object.create(null);

    APS_AJAXController.getGOSMActivityDetails = (req, res) => {
        const activityID = parseInt(req.query.activityID ? req.query.activityID : req.body.activityID);

        if (isNaN(activityID)) {
            logger.debug(`Invalid input`);
            return res.send({
                valid: false
            });
        }
        logger.debug(`Getting Activity Details of id: ${activityID}`, log_options);

        database.task(t => {
            return t.batch([
                gosmModel.getActivityDetails(
                    activityID, [
                        ['ga.comments'],
                        ['at.name', 'type'],
                        ['an.name', 'nature'],
                        ["to_char(ga.targetDateStart, 'Mon DD, YYYY')", 'startDate'],
                        ["to_char(ga.targetDateEnd, 'Mon DD, YYYY')", 'endDate']
                    ],
                    t),
                gosmModel.getActivityProjectHeads(activityID, ['a.idNumber',
                    "firstname || ' ' || lastname AS name",
                    'contactNumber'
                ], t)
            ]);
        }).then(data => {
            logger.debug(`activity: ${JSON.stringify(data)}`, log_options);
            return res.send({
                valid: true,
                activityDetails: data[0],
                projectHeads: data[1]
            });
        }).catch(error => {
            res.send({
                valid: false
            });
            throw error;
        });
    };

    APS_AJAXController.updateGOSM = (req, res) => {
        const GOSMID = parseInt(req.body.GOSMID ? req.body.GOSMID : req.query.GOSMID);
        const statusID = parseInt(req.body.statusID ? req.body.statusID : req.query.statusID);
        const comments = req.body.comments ? req.body.comments : req.query.comments;

        if (isNaN(GOSMID) || isNaN(statusID)) {
            logger.debug(`Invalid input: GOSMID = ${GOSMID}, statusID = ${statusID}`, log_options);
            return res.send({
                valid: false
            });
        }

        gosmModel.updateGOSMStatus(GOSMID, statusID, comments)
        .then(status => {
            logger.debug(`query result: $(status)`, log_options);
            return res.send({
                valid: true,
                success: true
            });
        }).catch(error => {
            res.send({
                valid: true,
                success: false
            });
            throw error;
        });
    };

    APS_AJAXController.updateGOSMActivityComment = (req, res) => {
        const activityID = parseInt(req.body.activityID ? req.body.activityID : req.query.activityID);
        const comments = req.body.comments ? req.body.comments : req.query.comments;

        if (isNaN(activityID) || typeof comments !== 'string') {
            logger.warning(`Invalid input: activityID: ${activityID}, comments: ${comments}`, log_options);
            return res.send({
                valid: false
            });
        }

        logger.debug(`Valid input received: activityID: ${activityID}, comments: ${comments}`, log_options);
        gosmModel.updateActivityComment(activityID, comments)
        .then(data => {
            logger.debug('Success!', log_options);
            res.send({
                valid: true,
                success: true
            });
        }).catch(error => {
            res.send({
                valid: true,
                success: false
            });
            throw error;
        });
    };

    APS_AJAXController.getProjectProposalActivityDetails = (req, res) => {
        const PPRID = req.body.PPRID ? req.body.PPRID : req.query.PPRID;
        logger.debug(`PPR ID: ${PPRID}`, log_options);

        database.task(t => {
            return t.batch([
                projectProposalModel.getActivityProjectProposalDetails(PPRID, [
                    'at.name AS activityType',
                    'an.name AS activityNature',
                    "to_char(ga.targetDateStart, 'Mon DD, YYYY') || ' - ' || to_char(ga.targetDateEnd, 'Mon DD, YYYY') AS activityDate",
                    'pp.venue',
                    'pp.ENP',
                    'pp.context',
                    'ga.objectives'
                ], t),
                projectProposalModel.getProjectProposalProgramDesign(PPRID, undefined, t),
                projectProposalModel.getProjectProposalExpenses(PPRID, undefined, t)
            ]);
        }).then(data => {
            logger.debug(`Data: ${data}`, log_options);
            return res.send({
                valid: true,
                success: true,
                data: data
            });
        }).catch(err => {
            res.send({
                valid: true,
                success: false
            });
            throw err;
        });
    };

    APS_AJAXController.activityChecking = (req, res) => {
        var activityId;
        database.task(task => {

            let promises = [];

            console.log(req.body);

            const dbParam = {
                status: req.body.method,
                comments: req.body.comment,
                // TODO: add section to database
                //section: req.body.section,
                id: req.body.id
            };

            projectProposalModel.updatePPRStatus(dbParam, task)
            .then(() => {});

            return projectProposalModel.getNextActivityForApproval(req.session.user.idNumber, task)
            .then(data => {
                activityId = data.id;
                console.log(activityId);
                 var pa = {
                    projectId:data.id
                }
                return task.batch([
                    Promise.resolve(data),
                    projectProposalModel.getProjectProposalExpenses(data.id, task),
                    projectProposalModel.getProjectProposalProjectedIncome(data.id, task),
                    projectProposalModel.getProjectProposalProgramDesign(data.id, [
                        'pppd.dayid AS dayid',
                        "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                        "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                        "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                        'pppd.activity AS activity',
                        'pppd.activitydescription AS activitydescription',
                        'pppd.personincharge AS personincharge'
                    ], task),
                    projectProposalModel.getProjectProposalProjectHeads(data.id, task),
                    projectProposalModel.getLatestProjectProposalAttachment(pa)
                ]);
            });
        }).then(data => {
            console.log('actvityID');
            console.log(data);
            console.log(activityId);

            logger.debug(`${JSON.stringify(data[3])}`, log_options);
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.projectProposal = data[0];
            renderData.expenses = data[1];
            renderData.activity = activityId;
            renderData.projectedIncome = data[2];
            renderData.programDesign = data[3];
            renderData.projectHeads = data[4];
            renderData.attachment = data[5];
            renderData.csrfToken = req.csrfToken();

            return res.render('APS/ActivityChecking', renderData);
        }).catch(err => {
             const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            res.render('template/APS/NoActivityToCheck', renderData);
            logger.debug(`${err.message}/n${err.stack}`);
            // throw err;
        });
    };

    APS_AJAXController.SignProjectProposal = (req, res) => {
        logger.debug('SignProjectProposal()', log_options);

        const activityID = parseInt(req.body.activityID);
        const status = parseInt(req.body.status);

        /**
         * const reply = {
         *  success: boolean,
         *  valid: boolean,
         *  reroute: string (optional)
         * };
         * @type {[type]}
         */
        const reply = Object.create(null);

        if(!Number.isInteger(activityID) || ! Number.isInteger(status)){
            reply.success = false;
            reply.valid = false;
            return res.send(reply);
        }

        let afterProcessing = null;
        switch (status){
            case 1: { //Accpet
                logger.debug('Accept', log_options);
                afterProcessing = database.task(task => {
                    return task.batch([
                        //0
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
                            'PP.GOSMActivity AS activityID',
                            'PP.id AS PPRID',
                            'PP.SOURCEFUNDOTHER as sourcefundother',
                            'PP.SOURCEFUNDPARTICIPANTFEE AS sourcefundparticipantfee',
                            'PP.SOURCEFUNDORGANIZATIONAL',
                            'PP.ACCUMULATEDOPERATIONALFUNDS as accumulatedoperationalfunds',
                            'PP.ACCUMULATEDDEPOSITORYFUNDS AS accumulateddepositoryfunds',
                            'PP.ORGANIZATIONFUNDOTHERSOURCE AS organizationfundothersource'
                        ], task),
                        //1
                        projectProposalModel.getProjectProposalExpenses(activityID, [
                            'ppe.sequence',
                            'ppe.material',
                            'ppe.quantity',
                            'ppe.unitCost',
                            'et.name AS type'
                        ], task),
                        //2
                        projectProposalModel.getProjectProposalProjectedIncome(activityID, task),
                        //3
                        projectProposalModel.getProjectProposalProgramDesign(activityID, [
                            'pppd.dayid AS dayid',
                            'pppd.sequence',
                            "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                            "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                            "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                            'pppd.activity AS activity',
                            'pppd.activitydescription AS activitydescription',
                            'pppd.personincharge'
                        ], task),
                        //4
                        projectProposalModel.getProjectProposalProjectHeads(activityID, undefined, task),
                        //5
                        projectProposalModel.getProjectProposalAttachment(activityID, [
                            'ppa.requirement AS DocumentType',
                            'ppa.sequence',
                            'ppa.idNumber',
                            'ppa.filename AS path',
                            'ppa.filenameToShow AS filename'
                        ], task),
                        //6
                        accountModel.getAccountDetails(req.session.user.idNumber, [
                            'a.privateKey'
                        ], task)
                    ]);
                }).then(data => {
                    const documentObj = Object.create(null);

                    documentObj.ProjectProposalID = data[0].pprid;
                    documentObj.ActivityID = data[0].activityid;
                    documentObj.Nature = data[0].nature;
                    documentObj.Type = data[0].type;
                    documentObj.Strategies = data[0].strategies
                    documentObj.Organization = data[0].orgname;
                    documentObj.Venue = data[0].venue;
                    documentObj.ENMP = data[0].ENMP;
                    documentObj.ENP = data[0].ENP;
                    documentObj.Objectives = data[0].objectives;
                    documentObj.Context = data[0].context1;
                    documentObj.SourceFundOther = data[0].sourcefundother;
                    documentObj.SourceFundParticipantFee = data[0].sourcefundparticipantfee;
                    documentObj.SourceFundOrganization = data[0].sourcefundorganization;
                    documentObj.AccumulatedOperationalFunds = data[0].accumulatedoperationalfunds;
                    documentObj.AccumulatedDepositoryFunds = data[0].accumulateddepositoryfunds;
                    documentObj.OrganizationFundOtherSource = data[0].organizationfundothersource;

                    documentObj.Expenses = [];
                    for(const expense of data[1]){
                        const expenseObj = Object.create(null);
                        expenseObj.Sequence = expense.sequence;
                        expenseObj.Material = expense.material;
                        expenseObj.Quantity = expense.quantity;
                        expenseObj.UnitCost = expense.unitcost;
                        expenseObj.Type = expense.type;

                        documentObj.Expenses[documentObj.Expenses.length] = expenseObj;
                    }

                    documentObj.ProjectedIncome = [];
                    for(const income of data[2]){
                        const incomeObj = Object.create(null);
                        incomeObj.Sequence = income.sequence;
                        incomeObj.Item = income.item;
                        incomeObj.Quantity = income.quantity;
                        incomeObj.SellingPrice = income.sellingprice;

                        documentObj.ProjectedIncome[documentObj.ProjectedIncome.length] = incomeObj;
                    }

                    documentObj.ProgramDesign = [];
                    for(const program of data[3]){
                        const programObj = Object.create(null);
                        programObj.DayID = program.dayid;
                        programObj.Sequence = program.sequence;
                        programObj.Date = program.date;
                        programObj.StartTime = program.starttime;
                        programObj.EndTime = program.endtime;
                        programObj.Activity = program.activity;
                        programObj.Description = program.activitydescription;
                        programObj.PersonInCharge = Object.create(null);
                        programObj.PersonInCharge.IDNumber = program.personincharge;

                        documentObj.ProgramDesign[documentObj.ProgramDesign.length] = programObj;
                    }

                    documentObj.ProjectHeads = [];
                    for(const projectHead of data[4]){
                        const projectHeadObj = Object.create(null);
                        projectHeadObj.IDNumber = projectHead.idnumber;

                        documentObj.ProjectHeads[documentObj.ProjectHeads.length] = projectHeadObj;
                    }

                    //TODO: Add attachments to documentObj

                    const DOCUMENT_STRING = STRINGIFY(documentObj);
                    logger.debug(`Private Key: ${data[6].privatekey}`);
                    const {signature: DIGITAL_SIGNATURE} = SIGN(DOCUMENT_STRING, data[6].privatekey);

                    logger.debug(`Document: ${DOCUMENT_STRING}\nDigital Signature: ${DIGITAL_SIGNATURE}`, log_options);

                    afterProcessing = accountModel.approvePPR(activityID, req.session.user.idNumber, DOCUMENT_STRING, DIGITAL_SIGNATURE);
                }).then(data => {
                    return Promise.resolve(true);
                }).catch(err => {
                    logger.debug(`${err.message}\n${err.stack}`);
                });
            }break;

            case 2: { //Pend
                const sections = req.body.sectionsToBeEdited;
                const comments = req.body.comments;

                afterProcessing = accountModel.pendPPR(activityID, req.session.user.idNumber, comments, sections)
                .then(data => {
                    return Promise.resolve(true);
                });
            }break;

            case 3: { //Deny
                const comments = req.body.comments;

                afterProcessing = accountModel.denyPPR(activityID, req.session.user.idNumber, comments)
                .then(data => {
                    return Promise.resolve(true);
                });
            }break;

            default: {
                const err = new Error('Invalid status');
                afterProcessing = Promise.reject(err);
            }
        }

        return afterProcessing.then(data => {
            reply.success = true;
            reply.valid = true;
            reply.reroute = '/APS/Signatory/ActivtiyList';
            return res.send(reply);
        }).catch(err => {
            logger.warn(`${err.message}\n${err.stack}`, log_options);

            reply.success = false;
            reply.valid = false;
            return res.send(reply);
        });
    };

    return APS_AJAXController;
};
