'use strict';

module.exports = function(configuration, modules, models, database, queryFiles) {
    const Promise = module.Promise;

    const SIGN = require('../utility/digitalSignature.js').signString;
    const STRINGIFY = require('json-stable-stringify');
    const fs = require('fs');
    var cuid = require('cuid');
    const path = require('path');

    const PATH_ASSETS = configuration.webserver.assets.path;

    const log_options = Object.create(null);
    log_options.from = 'AJAX-APS';
    log_options.color = '\x1b[35m';

    const logger = modules.logger;

    const gosmModel = models.gosmModel;
    const accountModel = models.Account_model;
    const projectProposalModel = models.ProjectProposal_model;
    const organizationModel = models.Organization_model;

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
        logger.debug('updateGOSM()', log_options);

        const GOSMID = parseInt(req.body.GOSMID ? req.body.GOSMID : req.query.GOSMID);
        const statusID = parseInt(req.body.statusID ? req.body.statusID : req.query.statusID);
        const comments = req.body.comments ? req.body.comments : req.query.comments;

        if (isNaN(GOSMID) || isNaN(statusID)) {
            logger.debug(`Invalid input: GOSMID = ${GOSMID}, statusID = ${statusID}`, log_options);

            return res.send({
                valid: false
            });
        }

        let isStatusSent = false;
        return gosmModel.updateGOSMStatus(GOSMID, statusID, req.session.user.idNumber, comments).then(GOSMStatus => {
            logger.debug('gosm status updated', log_options);

            res.send({
                valid: true,
                success: true
            });
            isStatusSent = true;

            //Next set of promises, these set gets details needed for notifications
            return database.task(t => {
                return t.batch([
                    gosmModel.getGOSM(GOSMID, [
                        'preparedBy AS pb'
                    ], t),

                    accountModel.getAccountDetails(
                        req.session.user.idNumber, [
                        'a.firstname || \' \' || a.lastname AS "name"'
                    ], t)
                ]);
            });
        }).then(data => {
            //Notifications processed here
            const GOSM = data[0];
            const evaluator = data[1];

            let title = null;
            let description = null;

            title = 'GOSM Evaluation';
            switch(statusID){
                //Approved
                case 3: {
                    description = `The organization's GOSM have been approved by ${evaluator.name}`;
                }break;

                //Pending
                case 4: {
                    description = `The organization's GOSM have been peended by ${evaluator.name}`;
                }break;

                //Denied
                case 5: {
                    description = `The organization's GOSM have been denied by ${evaluator.name}`;
                }break;
            }

            let details = Object.create(null);
            details.GOSMID = GOSMID;
            details.statusID = statusID;
            details.comments = comments;
            details.evaluator = req.session.user.idNumber;

            return accountModel.addNotification(
                GOSM.pb,
                title,
                description,
                details,
                null
            );
        }).then(() => {
            return logger.debug('Notifications added to president', log_options);
        }).catch(error => {
            if(!isStatusSent){
                res.send({
                    valid: true,
                    success: false
                });   
            }else{
                logger.error('Error in adding notifications', log_options);
            }

            return logger.error(`${error.message}\n${error.stack}`, log_options);
        });
    };

   APS_AJAXController.resched = (req, res) => {
        var comment = ' ' + req.body.comment;
        console.log("asdasdasdasdasdklajsdlkajsdlakjsdlkasjdlaskjdalksjd")
        console.log(req.body)
        if(comment != ' '){
        // if(comment == ' '){
            return projectProposalModel.approvePPResched(req.body.activityID, comment,req.body.status).then(data=>{
                res.json({status:1});
            }).catch(err=>{
                res.json({status:0});
                console.log(err)
                // return logger.error(`${err.message}\n${err.stack}`, log_options);
            })    
        }else{
            database.tx(t=>{
                return projectProposalModel.getActivityProjectProposalDetailsGAID(req.body.activityID,['PP.ID AS PRID','PP.rescheduledates as rescheduledates'],t)
                .then(data=>{
                    console.log("data")
                    console.log(data)
                    return t.batch([
                            projectProposalModel.updateProjectProposalActualDate(req.body.activityID,data.rescheduledates),
                            projectProposalModel.updateProjectProposalPD(data.prid,data.rescheduledates),
                            projectProposalModel.approvePPResched(req.body.activityID, comment,req.body.status)
                        ]).catch(err => {
                   console.log(err)
                });
                    
                })
            }).then(data=>{
                res.json({status:1});
            }).catch(err=>{
                res.json({status:0});
                console.log(err)
                // return logger.error(`${err.message}\n${err.stack}`, log_options);
            })    
        }
        
    };

    APS_AJAXController.approvalResched = (req, res) => {
        logger.debug('approvalResched()', log_options);

        console.log(req.files)
        database.tx(t=>{
            var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/preacts/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'preacts');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/preacts/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'preacts', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }
            var vrtFilename = cuid() + path.extname(req.files['file'].name);
            var vrtFilenameToShow = (req.files['file'].name);
            var pg = path.join(dir2, vrtFilename);

            req.files['file'].mv(pg)
            return t.batch([
                projectProposalModel.updatePPResched(req.body.activityID, req.body.reason, req.body.date, req.body.others, 6,t),
                projectProposalModel.updateVenueAttachment(req.body.activityID, vrtFilename, vrtFilenameToShow, req.session.user.idNumber)
            ])    
        }).then(data=>{

            res.json({status:1});
        }).catch(err=>{
            console.log(err)
            res.json({status:0});
            return logger.error(`${err.message}\n${err.stack}`);
        })
        
    };

    APS_AJAXController.updateGOSMActivityComment = (req, res) => {
        logger.debug('updateGOSMActivityComment()', log_options);
        const activityID = parseInt(req.body.activityID ? req.body.activityID : req.query.activityID);
        const comments = req.body.comments ? req.body.comments : req.query.comments;

        if (isNaN(activityID) || typeof comments !== 'string') {
            logger.warning(`Invalid input: activityID: ${activityID}, comments: ${comments}`, log_options);
            return res.send({
                valid: false
            });
        }

        logger.debug(`Valid input received: activityID: ${activityID}, comments: ${comments}`, log_options);
        return gosmModel.updateActivityComment(activityID, comments).then(() => {
            logger.debug('Success!', log_options);

            return res.send({
                valid: true,
                success: true
            });
        }).catch(error => {
            res.send({
                valid: true,
                success: false
            });

            return logger.error(`${error.message}\n${error.stack}`, log_options);
        });
    };

    APS_AJAXController.getProjectProposalActivityDetails = (req, res) => {
        logger.debug('getProjectProposalActivityDetails()', log_options);
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
        logger.debug('activityChecking', log_options);
        const activityID = parseInt(req.body.activityID);
        const status = parseInt(req.body.status);

        if(!Number.isInteger(activityID) || ! Number.isInteger(status)){
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('template/APS/NoActivityToCheck', renderData);
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
                    documentObj.Strategies = data[0].strategies;
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
                    const renderData = Object.create(null);
                    renderData.csrfToken = req.csrfToken();
                    renderData.extra_data = req.extra_data;
                    return res.render('template/APS/NoActivityToCheck', renderData);
                });
            }break;

            case 2: { //Pend
                const sections = req.body.sectionsToBeEdited;
                const comments = req.body.comments;

                afterProcessing = accountModel.pendPPR(activityID, req.session.user.idNumber, comments, sections).then(data => {
                    return Promise.resolve(true);
                });
            }break;

            case 3: { //Deny
                const comments = req.body.comments;

                afterProcessing = accountModel.denyPPR(activityID, req.session.user.idNumber, comments).then(data => {
                    return Promise.resolve(true);
                });
            }break;

            default: {
                const err = new Error('Invalid status');
                afterProcessing = Promise.reject(err);
            }
        }

        return afterProcessing
        .then(data => {
            return projectProposalModel.getNextActivityForApproval(req.session.user.idNumber);
        }).then(data => {
            return database.task(task => {
                var activityId = data.id;
                console.log(activityId);
                 var pa = {
                    projectId:data.id
                };
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
                    projectProposalModel.getLatestProjectProposalAttachment(pa),
                    Promise.resolve(activityId),
                    projectProposalModel.getSignatories(data.id)
                ]);
            });
        }).then(data => {
            logger.debug(`activityID: ${data[6]}`, log_options);
            logger.debug(`${JSON.stringify(data[3])}`, log_options);
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.projectProposal = data[0];
            renderData.expenses = data[1];
            renderData.activity = data[6];
            renderData.projectedIncome = data[2];
            renderData.programDesign = data[3];
            renderData.projectHeads = data[4];
            renderData.attachment = data[5];
            renderData.signatories = data[6];
            renderData.csrfToken = req.csrfToken();

            return res.render('APS/ActivityChecking', renderData);
        }).catch(err => {
            logger.debug('RENDEIRNG NO ACTIVITY TO CHECK');
            logger.warn(`${err.message}/n${err.stack}`);

            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('template/APS/NoActivityToCheck', renderData);
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
         * @type {object}
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
                    documentObj.Strategies = data[0].strategies;
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

                    return accountModel.approvePPR(activityID, req.session.user.idNumber, DOCUMENT_STRING, DIGITAL_SIGNATURE);
                });
            }break;

            case 2: { //Pend
                const sections = req.body.sectionsToBeEdited;
                const comments = req.body.comments;

                    var context = true;
                    var sched = true;
                    var expense = true;
                    var attachments = true;

                    for(var i = 0; i < req.body.sectionsToBeEdited.length; i++){

                        console.log('AT LEAST LOOPS BRUH');

                        if (req.body.sectionsToBeEdited[i] === 'Brief Context') {
                            context = false;
                            console.log('SHOULD ENTER THIS');
                        }

                        if (req.body.sectionsToBeEdited[i] === 'Program Design') {
                            sched = false;
                        }

                        if (req.body.sectionsToBeEdited[i] === 'Source of Funds') {
                            expense = false;
                        } else if (req.body.sectionsToBeEdited[i] === 'Organizational Funds') {
                            expense = false;
                        } else if (req.body.sectionsToBeEdited[i] === 'Revenue and Expense Table') {
                            expense = false;
                            console.log('ALSO THIS');
                        }

                        if (req.body.sectionsToBeEdited[i] === 'Attachments') {
                            attachments = false;
                        }
                    }

                    var updateParam = {
                        context: context,
                        sched: sched,
                        expense: expense,
                        attachments: attachments,
                        gosmactivity: activityID,
                        status: 4
                    };

                    console.log('UPDATE PARAM IS');
                    console.log(updateParam);

                    afterProcessing = projectProposalModel.updatePPRCompletion(updateParam).then(() => {
                        return accountModel.pendPPR(activityID, req.session.user.idNumber, comments, sections);
                    });
            }break;

            case 3: { //Deny
                const comments = req.body.comments;

                afterProcessing = accountModel.denyPPR(activityID, req.session.user.idNumber, comments);
            }break;

            default: {
                const err = new Error('Invalid status');
                afterProcessing = Promise.reject(err);
            }
        }

        return afterProcessing.then(() => {
            reply.success = true;
            reply.valid = true;
            reply.reroute = '/APS/Signatory/ActivtiyList';

            /**
             * Add notification to the project heads informing them of the evaluation
             */
            database.task(t => {
                return t.batch([
                    projectProposalModel.getActivityProjectProposalDetailsGAID(activityID, ['ga.strategies'], t),
                    projectProposalModel.getProjectHeadsGOSM({gosmid: activityID}, t),
                    accountModel.getAccountDetails(req.session.user.idNumber, ["(firstname || '' || lastname) AS name"], t),
                    projectProposalModel.getNextSignatory(activityID, t)
                ]);
            }).then(data => {
                const strategies = data[0].strategies;
                const projectHeads = data[1];
                const evaluatorName = data[2].name;
                const signatory = data[3];

                let title = 'Project Proposal Evaluation';
                let description = null;
                switch(status){
                    case 1: {
                        description = `Your activity ${strategies} has been approved by ${evaluatorName}`;
                    }break;

                    case 2: {
                        description = `Your activity ${strategies} has been pended by ${evaluatorName}`;
                    }break;

                    case 3: {
                        description = `Your activity ${strategies} has been denied by ${evaluatorName}`;
                    }break;
                }

                return database.tx(t => {
                    let queries = [];

                    if(signatory){
                        queries[0] = accountModel.addNotification(
                            //idNumber
                            signatory.idNumber,
                            // title
                            'Project Proposal Evaluation',
                            //description
                            `Please evaluate ${strategies}`,
                            // details
                            null, 
                            //returning
                            null, 
                            //connenection
                            t
                        );
                    }
                    
                    for(const user of projectHeads){
                        queries[queries.length] = accountModel.addNotification(
                            //idNumber
                            user.idnumber, 
                            // title
                            title, 
                            //description
                            description, 
                            // details
                            null, 
                            //returning
                            null, 
                            //pg-connection
                            t 
                        );
                    }
                    return t.batch(queries);
                });
            });

            res.send(reply);
        }).then(() => {
            logger.debug('Successfully notified project heads', log_options);
        }).catch(err => {
            logger.warn(`${err.message}\n${err.stack}`, log_options);

            reply.success = false;
            reply.valid = false;

            return res.send(reply);
        });
    };

    return APS_AJAXController;
};
