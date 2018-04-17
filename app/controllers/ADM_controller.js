'use strict';
module.exports = function(configuration, modules, models, database, queryFiles) {
    const STRINGIFY = require('json-stable-stringify');
    const SIGN = require('../utility/digitalSignature.js').signString;

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'ADM-Controlller';

    const accountModel = models.Account_model;
    const amtModel = models.ActivityMonitoring_model;
    const systemModel = models.System_model;
    const pnpModel = models.PNP_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const gosmModel = models.gosmModel;

    const path = require('path');

    let ADM_controller = Object.create(null);

    ADM_controller.viewActivityToCheck = (req, res) => {
        logger.info('call viewActivityToCheck()', log_options);

        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        logger.debug(`extra_data: ${JSON.stringify(req.extra_data)}`, log_options);
        return accountModel.getPostActsToSign(req.session.user.idNumber).then(data => {
            console.log(data);
            console.log("data");
            renderData.postacts = data;

            return res.render('ADM/ActivityList', renderData);
        });
    };

    ADM_controller.viewHome = (req, res) => {
        logger.info('call viewHome()', log_options);

        database.task(task => {
            return task.batch([
                postProjectProposalModel.getAllPostProjectProposal(),
                organizationModel.getAllStudentOrganizations(),
                gosmModel.getAllCurrent()
            ]);
        }).then(data=>{

            let renderData = Object.create(null);

            var uncheckedActivityReport = 0;
            var ApprovedActivityReport = 0;
            var PendedActivityReport = 0;

            for (var i = 0; i < data[0].length; i++){

                if (data[0][i].status == 3) {
                    uncheckedActivityReport = uncheckedActivityReport + 1;
                }
                else if(data[0][i].status == 4){
                    ApprovedActivityReport = ApprovedActivityReport + 1;
                }
                else if(data[0][i].status == 5){
                    PendedActivityReport = PendedActivityReport + 1;
                }

            }


            renderData.uncheckedActivityReport = uncheckedActivityReport;
            renderData.ApprovedActivityReport = ApprovedActivityReport;
            renderData.PendedActivityReport = PendedActivityReport;
            renderData.studentorganizations = data[1];
            renderData.allGosm = data[2];
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            return res.render('ADM/mainADM', renderData);

        }).catch(error=>{
            console.log(error);
        });

    };
    ADM_controller.viewGrades = (req, res) => {
        logger.info('call viewGrades()', log_options);

        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        return res.render('ADM/viewOrgGrades');
    };
    ADM_controller.viewCalendar = (req, res) => {
        logger.info('call viewCalendar()', log_options);

        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        var dbParam = {
            studentorganization: req.params.orgid
        };

         database.task(task => {
            return task.batch([
                organizationModel.getStudentOrganization(dbParam),
                projectProposalModel.getAllOrgProposal(req.params.orgid, null)
            ]);
        }).then(data=>{
            console.log("DATA");
            renderData.studentorganization = data[0];
            renderData.events = data[1];
            console.log(data);
            return res.render('ADM/viewOrgCalendar',renderData);
        }).catch(err=>{
            console.log(err);
        });
    };

    ADM_controller.viewGOSM = (req, res) => {
        logger.info('call viewGOSM()', log_options);

        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        return res.render('ADM/viewOrgGOSM');

    };
    ADM_controller.viewOrgTerms = (req, res) => {
        logger.info('call viewOrgTerms()', log_options);

        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        return res.render('ADM/viewOrgTerms');

    };
    ADM_controller.updateStatus = (req, res) => {
        logger.info('call updateStatus()', log_options);

        let dbParam = null;

        let sections = req.body['sections[]'] ? req.body['sections[]'] : req.body.sections;
        if(!Array.isArray(sections)){
            sections = [sections];
        }

        return database.task(t => {
            /**
             * This is for the promise that would update the status of the signatory sign
             * @type {Promise}
             */
            let statusPromise = null;

            let stat = {
                otherFinance: true,
                briefContext: true,
                gosmid: req.body.gosmid
            };

            //User pended
            if(req.body.status == '5'){
                statusPromise = accountModel.pendPostProjectProposal(
                    req.body.gosmid,
                    req.session.user.idNumber,
                    req.body.comment,
                    req.body.sections,
                    t
                );

                for (var x = 0; x < sections.length; x++) {
                    console.log("asd");
                    if (sections[x] == "1") {
                        stat.briefContext = false;
                    }
                    if (sections[x] == "2") {
                        stat.briefContext = false;
                    }
                    if (sections[x] == "3") {
                        stat.otherFinance = false;
                    }
                    if (sections[x] == "4") {
                        stat.otherFinance = false;
                    }
                }
            }else if(req.body.status == '4'){
                statusPromise = accountModel.getAccountDetails(
                    req.session.user.idNumber, [
                    'a.privateKey'
                ]).then(accountDetails => {
                    const documentObj = Object.create(null);
                    documentObj.GOSMActivityID = req.body.gosmid;
                    //TODO: Other details

                    const DOCUMENT_STRING = STRINGIFY(documentObj);
                    const {signature: DIGITAL_SIGNATURE} = SIGN(DOCUMENT_STRING, accountDetails.privatekey);
                    logger.debug(`Document: ${DOCUMENT_STRING}\nDigital Signature: ${DIGITAL_SIGNATURE}`, log_options);

                    //This is the statusPromise
                    return accountModel.approvePostProjectProposal(
                        req.body.gosmid,
                        req.session.user.idNumber,
                        DOCUMENT_STRING,
                        DIGITAL_SIGNATURE,
                        t
                    );
                });
            }

            return t.batch([
                statusPromise,
                postProjectProposalModel.updatePostStatus(stat, t)
            ]);
        }).then(() => {
            const reply = Object.create(null);
            reply.status = 1;

            logger.debug(`Sending reply: ${JSON.stringify(reply)}`, log_options);
            return res.json(reply);
        }).catch(error => {
            return logger.error(`${error.message}:\n${error.stack}`, log_options);
        });
    };

    ADM_controller.viewActivity = (req, res) => {
        logger.info('call viewActivity()', log_options);

        return database.task(t => {
            const dbParam = {
                gosmid: req.params.id
            };
            const dbParam1 = {
                gosmactivity: req.params.id
            };

            return t.batch([
                //0
                postProjectProposalModel.getPostActsDetails(dbParam, t),
                //1
                postProjectProposalModel.getLatestEventPicture(dbParam, t),
                //2
                postProjectProposalModel.getLatestPostExpense(dbParam, t),
                //3
                gosmModel.getGOSMActivityProjectHeads(dbParam1,t),
                //4
                postProjectProposalModel.getAllPostProjectSignatories(
                    req.params.id, [
                        "to_char(sig.\"dateSigned\", 'Mon DD, YYYY') AS \"dateSigned\"",
                        '"ppss"."name" AS "status"',
                        'a.firstname || \' \' || a.lastname AS "name"',
                        '"sig"."digitalSignature"',
                        '"ppst"."name" AS "type"'
                    ],
                    t
                )
            ]);
        }).then(([activity, pictures, expense, projectHeads, signatories]) => {
            const renderData = Object.create(null);
            renderData.activity = activity;
            renderData.pictures = pictures;
            renderData.expense = expense;
            renderData.id = activity.id;
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.projectHeads = projectHeads;
            renderData.signatories = signatories;

            logger.debug('rendering ADM/ActivityToCheck', log_options);
            return res.render('ADM/ActivityToCheck', renderData);
        }).catch(error => {
            return logger.error(`${error.message}:\n${error.stack}`, log_options);
        });
    };

    return ADM_controller;
};
