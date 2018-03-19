'use strict';
const Promise = require('bluebird');
const fs = require('fs');
var cuid = require('cuid');
var timediff = require('timediff');

module.exports = function(configuration, modules, models, database, queryFiles) {
    const ACL_SEQUENCES = require('./../utility/CONSTANTS_functionalitySequence.json');

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Organization-Controller';

    const systemModel = models.System_model;
    const pnpModel = models.PNP_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const gosmModel = models.gosmModel;
    const orgresModel = models.Orgres_model;

    const accountModel = models.Account_model;

    const path = require('path');

    return {
        //Create ProjectProposal
        viewGOSMActivityListProjectProposal: (req, res) => {
            logger.info('call viewGOSMActivityListProjectProposal()', log_options);

            systemModel.getCurrentTerm().then(term => {
                var param = {
                    termID: term.id,
                    studentOrganization: req.session.user.organizationSelected.id
                };

                return gosmModel.getOrgGOSM(param);
            }).then(data1 => {
                var dbParam = {
                    gosm: data1.id,
                    idnumber: req.session.user.idNumber
                };

                return database.task(t => {
                    return t.batch([
                        projectProposalModel.getGOSMActivitiesToImplement(dbParam),
                        gosmModel.getCurrentTermGOSM(req.session.user.organizationSelected.id, [
                            'status'
                         ])
                    ]);
                });
            }).then(([activities, gosm]) => {
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.activities = activities;
                renderData.GOSMStatus = gosm.status;

                logger.debug('Rendering Org/ActivityToImplement', log_options);
                return res.render('Org/ActivityToImplement', renderData);
            }).catch(error => {
                logger.error(`${error.message}\n${error.stack}`, log_options);
            });
        },

        viewGOSMList: (req, res) => {
            logger.info('viewGOSMList()', log_options);

            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

            gosmModel.getOrgAllGOSM(
                req.session.user.organizationSelected.id
            ).then(data=>{
                renderData.gosms = data
                console.log(data)
                return res.render('Org/GOSMList', renderData);            
             }).catch(err=>{
                console.log(err)
             })
            
        },
        viewChangePassword: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            return res.render('Org/changePassword');
        },
        viewAddMember: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            organizationModel.viewMember()
            .then(data=>{
                renderData.members = data
                return res.render('Org/addMembers',renderData);
            }).catch(err=>{
                console.log(err)
            })
            
        },
        viewReport: (req, res) => {

            if (req.session.user.type == 1) {
                var organizationid = req.session.user.organizationSelected.id;
            }
            else{
                var organizationid = req.params.id;
            }

            systemModel.getCurrentTerm([
                'id',
                'to_char(dateStart, \'Month DD, YYYY\') AS "dateStart"',
                'to_char(dateEnd, \'Month DD, YYYY\') AS "dateEnd"'
            ]).then(term=>{

                var dbParam = {
                    studentOrganization: organizationid,
                    termID: term.id
                }

                let termstart = term.dateStart;

                database.task(task => {
                        return task.batch([
                            //APS AND ADM
                            projectProposalModel.getApprovedActivities(),
                            projectProposalModel.getAllProjectProposal(),
                            gosmModel.getOrgGOSM(dbParam),
                            postProjectProposalModel.getAllPostProjectProposal(),
                            //PNP
                            pnpModel.getAllActivityPublicity()
                        ]);
                }).then(data=>{

                    // preacts grade
                    var preactsApprovedActivities = 0;
                    var preactsEarlyApprovedActivities = 0;
                    var preactsLateApprovedActivities = 0;
                    var preactsDeniedActivities = 0;
                    var totalActivities = 0;
                    var preactsTimingRatio = 0;
                    var preactsPendCount = 0;
                    var gosmSubmissionGrade = 0;
                    var isRelatedToOrganizationCount = 0;
                    var sixtyFortyGrade = 0;
                    var preactsAllApprovedTotal = 0;
                    var notInGOSM = false;
                    var lasallianFormationCompliance = false;

                    if(data[2] != null){

                        if(data[2].orggosmsubmitted == null){

                        }
                        else{

                            let orggosmsubmitted = data[2].orggosmsubmitted;

                            var gosmdiff = timediff(termstart, orggosmsubmitted, 'D').days;
                            //error to do 
                            if(gosmdiff.days <= 14){
                                gosmSubmissionGrade = 0.075;
                            }

                        }

                    }

                    


                    //approved activities
                    for(var i = 0; data[0].length > i; i++){

                        //TODO: change depending on org??
                        if(data[0][i].studentorganization == organizationid &&
                            data[0][i].isingosm == true){

                            preactsApprovedActivities = preactsApprovedActivities + 1;

                            if(data[0][i].activitynature == 8){
                                lasallianFormationCompliance = true
                            }


                            let actualdatestart = data[0][i].actualdatestart;
                            let datesigned = data[0][i].datesigned;
                            let targetdatestart = data[0][i].targetdatestart;

                            var diff = timediff(actualdatestart, datesigned, 'D').days;


                            if (diff.days>2){
                                preactsEarlyApprovedActivities = preactsEarlyApprovedActivities + 1;
                            }
                            else{
                                preactsLateApprovedActivities = preactsLateApprovedActivities + 1;
                            }

                            var timingdiff = timediff(targetdatestart, actualdatestart, 'D');

                            if (timingdiff.days < 7 && timingdiff.days > -7){
                                preactsTimingRatio = preactsTimingRatio + 1;
                            }

                        }

                        if(data[0][i].studentorganization == organizationid &&
                            data[0][i].isrelatedtoorganization == true){
                                isRelatedToOrganizationCount = isRelatedToOrganizationCount + 1;
                        }

                        preactsAllApprovedTotal = preactsAllApprovedTotal + 1;

                    }

                    // all activities
                    for (var i = 0; data[1].length > i; i++){

                        //TODO: change depending on org??
                        if(data[1][i].studentorganization == organizationid &&
                            data[1][i].isingosm == true){

                            totalActivities = totalActivities + 1;

                            preactsPendCount = preactsPendCount + data[1][i].timespended;


                            if(data[1][i].status==5){
                                preactsDeniedActivities = preactsDeniedActivities + 1;
                            }

                        }
                        else if(data[1][i].studentorganization == organizationid &&
                            data[1][i].isingosm == false){

                            notInGOSM = true;

                        }

                    }

                    var preactsPunctualityGrade = ((((parseFloat(preactsEarlyApprovedActivities)/parseFloat(preactsApprovedActivities))*100)-parseFloat(preactsDeniedActivities))*0.025);
                    var preactsTimingRatioGrade = (((parseFloat(preactsTimingRatio)/parseFloat(totalActivities))*100)*0.015);
                    var preactsCompletenessGrade = (100 - (parseFloat(preactsPendCount)*0.5))*0.025;

                    var sixtyFortyRatioPercentage = isRelatedToOrganizationCount/preactsAllApprovedTotal;


                    if (preactsApprovedActivities == 0){
                        preactsPunctualityGrade = 0;
                    }

                    if (preactsAllApprovedTotal == 0){
                        sixtyFortyRatioPercentage = 0;
                    }


                    var sixFourGradeRange = 0

                    var sixtyFortyGradeFound = true;

                    var gradeStart = 57;
                    var gradeEnd = 63;

                    while(sixtyFortyGradeFound){

                        console.log("THE GRADE RANGE IS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                        console.log(sixFourGradeRange);
                        console.log("okay the ratio percentage is!!!!!");
                        console.log(sixtyFortyRatioPercentage);

                        if(sixtyFortyRatioPercentage >= gradeStart && sixtyFortyRatioPercentage <= gradeEnd){

                            sixtyFortyGradeFound = false;

                        }
                        else{
                            sixFourGradeRange = sixFourGradeRange + 1;
                            gradeStart = gradeStart - 4;
                            gradeEnd = gradeEnd + 4;
                        }

                    }

                    var sixtyFortyGrade = (100-(parseFloat(sixFourGradeRange)*4))*0.10;

                    //postacts grade
                    var postactsEarlyApprovedActivities = 0;
                    var postactsTotalActivities = 0;
                    var postactsApprovedActivities = 0;
                    var postactsLateApprovedActivities = 0;

                    for (var i = 0; i < data[3].length; i++){

                        postactsTotalActivities = postactsTotalActivities + 1;

                        // if approved
                        if(data[3][i].status==4){

                            postactsApprovedActivities = postactsApprovedActivities + 1;


                            let actualdatestart = data[3][i].actualdatestart;
                            let datesubmitted = data[3][i].datesubmitted;

                            var diff = timediff(actualdatestart, datesubmitted, 'D').days;


                            if (diff.days>30){
                                postactsEarlyApprovedActivities = postactsEarlyApprovedActivities + 1;
                            }
                            else{
                                postactsLateApprovedActivities = postactsLateApprovedActivities + 1;
                            }

                        }

                    }

                    var postactsPunctualityGrade = ((((parseFloat(postactsEarlyApprovedActivities)/parseFloat(postactsApprovedActivities))*100)-parseFloat(preactsDeniedActivities))*0.025);
                    var postactsCompletenessGrade = ((parseFloat(postactsApprovedActivities)/parseFloat(preactsApprovedActivities))*100)*0.025;

                    if(postactsApprovedActivities == 0){
                        postactsPunctualityGrade =0;
                    }

                    if(preactsApprovedActivities==0){
                        postactsCompletenessGrade = 0;
                    }

                    var pushedThroughGrade = ((parseFloat(preactsApprovedActivities)/parseFloat(totalActivities))*100)*0.0015;

                    if(totalActivities == 0){

                        preactsTimingRatioGrade = 0;
                        pushedThroughGrade = 0;

                    }

                    if(notInGOSM){

                        var notInGOSMGrade = 0.15;

                    }
                    else{

                        var notInGOSMGrade = 0;

                    }

                    if(lasallianFormationCompliance){
                        var lasallianFormationComplianceGrade = 6;
                    }
                    else{
                        var lasallianFormationComplianceGrade = 0;
                    }

                    //pnp grade
                    var printedPoster = false;
                    var tickets = false;
                    var printedPublication = false;
                    var onlinePublication = false;
                    var printedPublicationCount = 0;
                    var onlinePublicationCount = 0;
                    var onlinePoster = false;



                    for (var i = 0; i < data[4].length; i++){

                        if (data[4].studentorganization == req.session.user.organizationSelected.id
                            && data[4].status == 1) {

                            if(data[4].modeOfDistribution == 1){

                                printedPublication = true;

                                printedPublicationCount = printedPublicationCount + 1;

                                if(data[4].material == 5){
                                    printedPoster = true;
                                }

                            }
                            else{

                                onlinePublication = true;

                                onlinePublicationCount = onlinePublicationCount + 1;

                                if(data[4].material == 5){
                                    onlinePoster = true;
                                }

                            }

                            if (data[4].material == 3) {
                                tickets = true;
                            }

                        }

                    }


                    var UniversityPublicityInstrumentGrade = 0;
                    var NewsLettersPublicationsGrade = 0;
                    var OnlinePublicityGrade = 0;


                    if (printedPoster) {
                        UniversityPublicityInstrumentGrade = UniversityPublicityInstrumentGrade + 0.5;
                    }

                    if (tickets) {
                        UniversityPublicityInstrumentGrade = UniversityPublicityInstrumentGrade + 0.7;
                    }

                    if (printedPublication) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.35;
                    }

                    if(onlinePublication) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.35;
                    }

                    if (printedPublicationCount == 1) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.05;
                    }
                    else if (printedPublicationCount == 2) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.1;
                    }
                    else if (printedPublicationCount >= 3) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.15;
                    }

                    if(onlinePublicationCount == 1){
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.0375;
                    }
                    else if (onlinePublicationCount == 2) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.075;
                    }
                    else if (onlinePublicationCount == 3){
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.1125;
                    }
                    else if (onlinePublicationCount >= 4) {
                        NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.15;
                    }

                    if (onlinePoster) {
                        OnlinePublicityGrade = OnlinePublicityGrade + 1.5;
                    }



                    const renderData = Object.create(null);

                    //preacts
                    renderData.preactsPunctualityGrade = preactsPunctualityGrade;

                    renderData.preactsApprovedActivities = preactsApprovedActivities;
                    renderData.preactsEarlyApprovedActivities = preactsEarlyApprovedActivities;
                    renderData.preactsLateApprovedActivities = preactsLateApprovedActivities;
                    renderData.preactsDeniedActivities = preactsDeniedActivities;
                    renderData.totalActivities = totalActivities;
                    renderData.preactsTimingRatio = preactsTimingRatio;
                    renderData.preactsTimingRatioGrade = preactsTimingRatioGrade;
                    renderData.preactsPendCount = preactsPendCount;
                    renderData.preactsCompletenessGrade = preactsCompletenessGrade;
                    renderData.gosmSubmissionGrade = gosmSubmissionGrade;
                    renderData.sixtyFortyGrade = sixtyFortyGrade;

                    //postacts
                    renderData.postactsEarlyApprovedActivities = postactsEarlyApprovedActivities;
                    renderData.postactsTotalActivities = postactsTotalActivities;
                    renderData.postactsApprovedActivities = postactsApprovedActivities;
                    renderData.postactsLateApprovedActivities = postactsLateApprovedActivities;
                    renderData.postactsPunctualityGrade = postactsPunctualityGrade;
                    renderData.postactsCompletenessGrade = postactsCompletenessGrade;
                    renderData.pushedThroughGrade = pushedThroughGrade;
                    renderData.notInGOSMGrade = notInGOSMGrade;
                    renderData.lasallianFormationComplianceGrade = lasallianFormationComplianceGrade;

                    //pnp
                    renderData.universityPublicityInstrumentGrade = UniversityPublicityInstrumentGrade;
                    renderData.newsLettersPublicationsGrade = NewsLettersPublicationsGrade;
                    renderData.onlinePublicityGrade = OnlinePublicityGrade;
                    renderData.pnpCompliance = 0.3;


                    console.log(renderData)
                    renderData.extra_data = req.extra_data;
                    return res.render('Org/report', renderData);


                }).catch(error=>{
                    console.log(error);
                });



            }).catch(error=>{
                console.log(error);
            });

    
        },


        viewGOSMDetails: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            return res.render('Org/gosmDetails');

        },

        viewNotInGosmList: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/NotInGosmList');
        },
        viewNotInGosmMain: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_main');
        },
        viewNotInGosmAttachments: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_attachments');
        },
        viewNotInGosmBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/SubmitNotInGosm_briefContext');
        },
        viewNotInGosmExpense: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_expense');
        },
        viewNotInGosmProgramDesign: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_programdesign');
        },
        viewActivityDetails: (req, res) => {
            logger.info('viewActivityDetails()', log_options);
            var activityId;
            database.task(task => {
                var dbParam = {
                    gosmactivity: req.params.gosmactivity
                }
                return projectProposalModel.getPPRDetails(dbParam, task).then(data => {
                    activityId = data.id;
                    logger.debug(`Activity ID: ${activityId}`);
                    var pa = {
                        projectId: data.id
                    };

                    return task.batch([
                        //0
                        Promise.resolve(data),
                        //1
                        projectProposalModel.getProjectProposalExpenses(req.params.gosmactivity),
                        //2
                        projectProposalModel.getProjectProposalProjectedIncome(req.params.gosmactivity),
                        //3
                        projectProposalModel.getProjectProposalProgramDesign(req.params.gosmactivity, [
                            'pppd.dayid AS dayid',
                            "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                            "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                            "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                            "to_char(pppd.date, 'YYYY-MM-DD') AS datestart",
                            "to_char(CURRENT_DATE, 'YYYY-MM-DD') AS currdate",
                            'pppd.activity AS activity',
                            'pppd.activitydescription AS activitydescription',
                            'pppd.personincharge AS personincharge',
                            'acc.firstname AS firstname',
                            'acc.lastname AS lastname'
                        ]),
                        //4
                        projectProposalModel.getProjectProposalProjectHeads(data.id),
                        //5
                        projectProposalModel.getLatestProjectProposalAttachment({
                            projectId: req.params.gosmactivity
                        }),
                        //6 TODO: Remove raw query
                        database.any(`SELECT
                                        a.idNumber as signatory,
                                        a.firstname || ' ' || a.lastname AS signatoryName,
                                        st.name AS type, ss.name AS status,
                                        pps.digitalSignature,
                                        TO_CHAR(pps.dateSigned, 'Mon DD, YYYY') AS dateSigned
                                      FROM (SELECT *
                                              FROM ProjectProposalSignatory pps
                                             WHERE pps.GOSMActivity = (SELECT gosmactivity
                                                                         FROM ProjectProposal
                                                                         WHERE id = \$\{projectId\})) pps LEFT JOIN SignatoryType st
                                                                                                              ON pps.type = st.id
                                                                                                       LEFT JOIN SignatoryStatus ss
                                                                                                              ON pps.status = ss.id
                                                                                                       LEFT JOIN Account a
                                                                                                              ON pps.signatory = a.idNumber
                                    ORDER BY st.lineup ASC, a.idNumber DESC;`, pa),
                        projectProposalModel.getProjectProposalProgramDesignDates(req.params.gosmactivity, [
                            
                            "to_char(pppd.date, 'MM/DD/YYYY') AS datestart",
                            
                        ])
                    ]);
                }).catch(err => {
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
                renderData.withExpense = data[1].length > 0;
                renderData.withRevenue = data[2].length > 0;
                renderData.limit = data[3][data[3].length -1]["dayid"]
                renderData.dates = ''
                for(var ctr = 0; ctr< data[7].length;ctr++){
                    renderData.dates += data[7][ctr].datestart
                    if(ctr != data[7].length - 1){
                        renderData.dates+=','
                    }
                }
                renderData.isProjecthead =  data[4].some(function(el) {
                                        console.log("asdasdl;asjdlaskjd cgecking if ")
                                        
                                        return el.idnumber == req.session.user.idNumber;
                                      }); 
                console.log(data[2].length > 0)
                console.log("REVENUE")
                console.log(renderData.isProjecthead)
                console.log("EXPENSE")

                renderData.resched = timediff(data[3][0].datestart, data[3][0].currdate, 'D').days
                console.log("Date DIFF")
                console.log(data[3].currdate)
                console.log(renderData.resched)
                console.log(renderData.attachment);
                console.log("renderData.attachment");
                return res.render('Org/viewActivityDetails', renderData);
            }).catch(err => {
                logger.debug(`${err.message}\n${err.stack}`, log_options);
                const renderData = Object.create(null);
                renderData.csrfToken = req.csrfToken();
                renderData.extra_data = req.extra_data;
                return res.render('template/APS/NoActivityToCheck', renderData);
            });
        },

        viewGOSMActivityListPostProjectProposal: (req, res) => {
            logger.info('viewGOSMActivityListPostProjectProposal()', log_options);

            var dbParam = {
                idNumber: req.session.user.idNumber
            };
            console.log(dbParam);
            postProjectProposalModel.getPostActsToImplement(dbParam)
                .then(data => {
                    console.log(data);
                    const renderData = Object.create(null);
                    renderData.extra_data = req.extra_data;
                    renderData.csrfToken = req.csrfToken();

                    renderData.activities = data;
                    console.log(renderData);
                    if (req.session.postSubmitted) {
                        renderData.success = 1;
                        req.session.postSubmitted = false;
                    }
                    console.log(renderData.activities)
                    return res.render('Org/PostActivityToImplement', renderData);
                }).catch(error => {
                    logger.warn(`${error.message}\n${error.stack}`, log_options);
                });


        },

        viewSubmitProjectProposalMain: (req, res) => {
            logger.info(`viewSubmitProjectProposalMain()`, log_options);

            //still no ppr or rejected ppr
            if (req.params.status == 0) {
                logger.debug('Status 0', log_options);
                var orgParam = {
                    studentorganization: req.session.user.organizationSelected.id
                };

                organizationModel.getStudentOrganization(orgParam).then(orgdata => {

                    var dbParam = {
                        gosmactivity: req.params.id,
                        preparedby: req.session.user.idNumber,
                        operationalfunds: orgdata.operationalfunds,
                        depositoryfunds: orgdata.depositryfunds
                    };


                    projectProposalModel.insertProjectProposal(dbParam).then(data => {
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
                            renderData.sectionsToEdit = null;
                            renderData.status = 1;
                            renderData.gosmid = req.params.id;

                            if(data[2].isattachmentscomplete == false){
                                
                                renderData.submitbutton = false;
                                console.log("DITOOOOOOOOOO");

                            }
                            else if(data[2].isbriefcontextcomplete == false){

                                renderData.submitbutton = false;
                                console.log("2aadasdasdasd");

                            }
                            else if(data[2].isexpensecomplete == false){

                                if (data[2].isexpense == true) {

                                    renderData.submitbutton = false;
                                    console.log("3asdasdasdasdasdasdasdasdas");
   
                                }
                                else{

                                    console.log("DITO DAPATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                    renderData.submitbutton = true;

                                }

                            }
                            else if(data[2].isprogramcomplete == false){

                                renderData.submitbutton = false;
                                console.log("4fadadadasdadasdasdasda");

                            }
                            else{

                                console.log("DITO DAPAT AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                                renderData.submitbutton = true;

                            }


                            return res.render('Org/SubmitProjectProposal_main', renderData);
                        }).catch(err => {
                            logger.error(`${err.message}\n${err.stack}`, log_options);

                        });
                    })

                }).catch(error => {

                });


            } // already started ppr
            else if (req.params.status == 1) {

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
                    renderData.sectionsToEdit = null;
                    renderData.status = 1;
                    renderData.gosmid = req.params.id;
                    console.log(renderData.gosmActivity);
                    console.log("KAHITANONGMESSAGE");

                    if(data[2].isattachmentscomplete == false){
                                
                        renderData.submitbutton = false;
                        console.log("DITOOOOOOOOOO");

                    }
                    else if(data[2].isbriefcontextcomplete == false){

                        renderData.submitbutton = false;
                        console.log("2aadasdasdasd");

                    }
                    else if(data[2].isexpensecomplete == false){

                        if (data[2].isexpense == true) {

                            renderData.submitbutton = false;
                            console.log("3asdasdasdasdasdasdasdasdas");
   
                        }
                        else{

                            console.log("DITO DAPATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                            renderData.submitbutton = true;

                        }

                    }
                    else if(data[2].isprogramcomplete == false){

                        renderData.submitbutton = false;
                        console.log("4fadadadasdadasdasdasda");

                    }
                    else{

                        console.log("DITO DAPAT AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                        renderData.submitbutton = true;

                    }

                    return res.render('Org/SubmitProjectProposal_main', renderData);
                }).catch(err => {
                    logger.error(`${err.message}\n${err.stack}`, log_options);
                });

            } else if (req.params.status == 4) {
                console.log("ENTER 2");

                var dbParam = {
                    gosmactivity: req.params.id
                };

                database.task(task => {
                    return task.batch([
                        gosmModel.getGOSMActivity(dbParam),
                        gosmModel.getGOSMActivityProjectHeads(dbParam),
                        projectProposalModel.getProjectProposal(dbParam),
                        projectProposalModel.getPPRSectionsToEdit(dbParam)
                    ]);
                }).then(data => {
                    const renderData = Object.create(null);
                    renderData.extra_data = req.extra_data;
                    renderData.csrfToken = req.csrfToken();

                    renderData.gosmActivity = data[0];
                    renderData.projectHeads = data[1];
                    renderData.projectProposal = data[2];
                    renderData.sectionsToEdit = data[3];
                    renderData.status = 2;
                    renderData.gosmid = req.params.id;
                    console.log(renderData.gosmActivity);
                    console.log("KAHITANONGMESSAGE");

                    if(data[2].isattachmentscomplete == false){
                                
                        renderData.submitbutton = false;
                        console.log("DITOOOOOOOOOO");

                    }
                    else if(data[2].isbriefcontextcomplete == false){

                        renderData.submitbutton = false;
                        console.log("2aadasdasdasd");

                    }
                    else if(data[2].isexpensecomplete == false){

                        if (data[2].isexpense == true) {

                            renderData.submitbutton = false;
                            console.log("3asdasdasdasdasdasdasdasdas");
   
                        }
                        else{

                            console.log("DITO DAPATAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                            renderData.submitbutton = true;


                        }

                    }
                    else if(data[2].isprogramcomplete == false){

                        renderData.submitbutton = false;
                        console.log("4fadadadasdadasdasdasda");

                    }
                    else{

                        console.log("DITO DAPAT AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                        renderData.submitbutton = true;

                    }



                    return res.render('Org/SubmitProjectProposal_main', renderData);
                }).catch(err => {
                    console.log("ERROR 1");
                    console.log(err);
                    logger.warn(`${err.message}\n${err.stack}`, log_options);
                });
            }
        },

        viewSubmitPostProjectProposalMain: (req, res) => {
            logger.info('viewSubmitPostProjectProposalMain()', log_options);

            var dbParam = {
                idNumber: req.session.user.idNumber,
                gosmid: req.params.gosmid
            };
            var dbParam2 = {
                gosmactivity: req.params.gosmid
            };

            console.log(dbParam);
            database.task(task => {
                return task.batch([
                    postProjectProposalModel.getPostProjectProposalMain(dbParam),
                    gosmModel.getGOSMActivityProjectHeads(dbParam2)
                ]);
            }).then(data => {

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.activities = data[0];
                renderData.projectHeads = data[1];
                // if(data[0].status == 5){
                //     var sections = data[0].sectionsToBeEdited;
                //     for(var x = 0; x < sections.length; x++){
                //         if(sections[x] == 1 && !renderData.activities.isBriefContextComplete){
                //             renderData.activities.isBriefContextCompleted = false
                //         }
                //         if(sections[x] == 2 && !renderData.activities.isBriefContextComplete){
                //             renderData.activities.isBriefContextCompleted = false
                //         }
                //         if(sections[x] == 3 && !renderData.activities.isBriefContextComplete){
                //             renderData.activities.isOtherFinanceDocumentsCompleted = false
                //         }
                //         if(sections[x] == 4){
                //             renderData.activities.isOtherFinanceDocumentsCompleted = false
                //         }

                //         if(sections[x] == 5){
                //             renderData.activities.isOtherFinanceDocumentsCompleted = false
                //         }
                //     }
                // }
                renderData.gosmid = req.params.gosmid;
                console.log(renderData.activities);
                console.log(renderData.projectHeads);
                return res.render('Org/SubmitPostProjectProposal_main', renderData);
            }).catch(err => {
                logger.error(`${err.message}\n${err.stack}`, log_options);
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
                projectId: req.params.gid
            }
            console.log("req.body");
            console.log(gl);
            database.task(task => {

                return task.batch([
                    gosmModel.getGOSMActivityType(req.params.gid, undefined, task).
                    then(data => {
                        console.log("DATA");
                        console.log(data[0].activitytype);
                        return gosmModel.getGOSMActivityAttachmentRequirement(data[0].activitytype, task);

                    }),
                    projectProposalModel.getLatestProjectProposalAttachment(gl)

                ])

            }).then(data => {
                console.log("DATA");
                console.log(data[0]);
                renderData.attachments = data[0];
                renderData.documents = data[1]
                renderData.gid = req.params.gid
                renderData.pid = req.params.id
                renderData.status = req.params.status;
                console.log("DATA1");
                console.log(data[1]);
                return res.render('Org/SubmitProjectProposal_attachments', renderData);
            }).catch(error => {
                logger.error(`${error.message}\n${error.stack}`, log_options);
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
                    projectProposalModel.getOrgFacultyAdvisers(dbParam),
                    projectProposalModel.getAllBuildings()
                ]);
            }).then(data => {

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.projectProposal = data[0];
                renderData.venues = data[1];
                renderData.advisers = data[2];
                renderData.buildings = data[3];
                renderData.gosmactivity = dbParam;
                renderData.status = req.params.status;

                return res.render('Org/SubmitProjectProposal_briefcontext', renderData);
            }).catch(error => {
                logger.warning(`${error.message}\n${error.stack}`, log_options);
            });
        },

        viewSubmitPostProjectProposalBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.id = req.params.gosmid
            var dbParam = {
                gosmid: req.params.gosmid
            }
            console.log("DATA")
            console.log(req.params);
            database.task(t => {
                return t.batch([
                    gosmModel.getObjectives(dbParam),
                    postProjectProposalModel.getPostBriefContext(dbParam)
                ]);
            }).then(data => {
                renderData.objectives = data[0].objectives;
                renderData.save = data[1];
                console.log(renderData.save);
                return res.render('Org/SubmitPostProjectProposal_briefcontext', renderData);
            }).catch(err => {
                logger.warn(`${err.message}\n${err.stack}`, log_options);
            })

        },
        viewSubmitPostProjectProposalOthers: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            renderData.id = req.params.gosmid;
            return res.render('Org/SubmitPostProjectProposal_others', renderData);
        },
        viewSubmitPostProjectProposalFinanceDocument: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                gosmid: req.params.gosmid
            }
            postProjectProposalModel.getPostProjectProposal(dbParam).then(data => {
                renderData.status = data;
                renderData.id = req.params.gosmid;
                console.log(data);
                return res.render('Org/SubmitPostProjectProposal_financedocuments', renderData);
            }).catch(err => {
                logger.warn(`${err.message}\n${err.stack}`, log_options);
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

            database.tx(transaction => {
                    return projectProposalModel.getProjectProposal(dbParam).then(data=>{
                        return Promise.all([
                            Promise.resolve(data),
                            projectProposalModel.getProjectProposalExpenses(req.params.id,transaction),
                            projectProposalModel.getExpenseTypes(transaction),
                            projectProposalModel.getProjectProposalExpensesPPRID(data.id,transaction),
                            projectProposalModel.getProjectProposalRevenuePPRID(data.id,transaction)


                        ]);    
                    })
                    
                })
                .then(data => {                     
                    const renderData = Object.create(null);
                    renderData.extra_data = req.extra_data;
                    renderData.csrfToken = req.csrfToken();
                    renderData.gosmactivity = dbParam;
                    renderData.projectProposal = data[0];
                    renderData.expenses = data[1];
                    renderData.revenue = req.params.revenue;
                    renderData.expenseTypes = data[2];
                    renderData.status = req.params.status;
                    renderData.listexpenses = data[3]
                    renderData.listrevenues = data[4]

                    // renderData.sectionsToEdit = data[3];


                    console.log(renderData.gosmactivity);
                    console.log(renderData.projectProposal);

                    return res.render('Org/SubmitProjectProposal_expense', renderData);
                }).catch(error => {
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


            database.task(task => {
                    return task.batch([
                        projectProposalModel.getProjectProposal(dbParam),
                        gosmModel.getGOSMActivityProjectHeads(dbParam),
                        projectProposalModel.getProjectProposalProgramDesign(req.params.id, [
                            'pppd.dayid AS dayid',
                            "to_char(pppd.date, 'MM/DD/YYYY') AS date",
                            "to_char(pppd.starttime + CURRENT_DATE, 'HH24:MI') AS starttime",
                            "to_char(pppd.endtime + CURRENT_DATE, 'HH24:MI') AS endtime",
                            'pppd.activity AS activity',
                            'pppd.activitydescription AS activitydescription',
                            'pppd.personincharge AS personincharge',
                            "concat(acc.firstname,' ',acc.middlename,' ',acc.lastname) AS name"

                        ])
                    ]);
                })
                .then(data => {

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.gosmactivity = dbParam;
                renderData.projectProposal = data[0];
                renderData.projectHeads = data[1];
                renderData.programDesign = data[2];
                renderData.status = req.params.status;
                    console.log("renderData.programDesign");
                    console.log(renderData.programDesign);
                    console.log("renderData.projectHeads");
                    console.log(renderData.projectHeads);


                    return res.render('Org/SubmitProjectProposal_programdesign', renderData);
                }).catch(error => {
                    console.log(error);
                });

        },

        viewProjectHeadHome: (req, res) => {
            logger.info('call viewProjectHeadHome()', log_options);

            //TODO: if account is president
            database.task(t => {
                return t.batch([
                    projectProposalModel.getProjectProposalCountTotal(
                        req.session.user.organizationSelected.id,
                        req.session.user.idNumber, t),
                    projectProposalModel.getProjectProposalsCountPerStatus(
                        req.session.user.organizationSelected.id, 
                        5,
                        req.session.user.idNumber, t),
                    projectProposalModel.getProjectProposalsCountPerStatus(
                        req.session.user.organizationSelected.id, 
                        4,
                        req.session.user.idNumber, t),
                    projectProposalModel.getProjectProposalsCountPerStatus(
                        req.session.user.organizationSelected.id,
                        3,
                        req.session.user.idNumber, t),
                    projectProposalModel.getActivitiesApprovedPerHead(
                        req.session.user.organizationSelected.id,
                        req.session.user.idNumber, t),
                    projectProposalModel.getProjectProposalCommentsPerStatus(
                        req.session.user.organizationSelected.id, 
                        2,
                        req.session.user.idNumber, t),
                    projectProposalModel.getProjectProposalCommentsPerStatus(req.session.user.organizationSelected.id, 3,
                        req.session.user.idNumber, t),
                    projectProposalModel.getAllOrgProposal(req.session.user.organizationSelected.id, null, t)
                ]);
            }).then(data => {
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.approvedActivities = data[4];
                renderData.pendedActivities = data[5];
                renderData.deniedActivities = data[6];
                renderData.events = data[7];

                logger.debug(`Events: ${JSON.stringify(data[7])}`, log_options);

                if (data[0] == null) {
                    renderData.allProjects = 0;
                } else {
                    renderData.allProjects = parseInt(data[0].num);
                }
                if (data[1] == null) {
                    renderData.deniedProjects = 0;
                } else {
                    renderData.deniedProjects = parseInt(data[1].num);
                }

                if (data[2] == null) {
                    renderData.pendingProjects = 0;
                } else {
                    renderData.pendingProjects = parseInt(data[2].num);
                }

                if (data[3] == null) {
                    renderData.successProjects = 0;
                } else {
                    renderData.successProjects = parseInt(data[3].num);
                }

                if (data[7].length > 0){
                    renderData.calendar = true;
                }
                else{
                    renderData.calendar = false;
                }

                logger.debug('Rendering Org/ProjectHeadHome', log_options);
                return res.render('Org/ProjectHeadHome', renderData);
            }).catch(error => {
                logger.error(`${error.message}\n${error.stack}`, log_options);
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

        /**
         * Updates the status of GOSM to submitted
         * @method
         */
        submitGOSM: (req, res) => {
            logger.debug('submitGOSM()', log_options);

            /**
             * let dbParam = {
             *      studentorganization: req.session.user.organizationSelected.id
             *  };
             * @type {Object}
             */
            let dbParam = Object.create(null);
            dbParam.studentorganization = req.session.user.organizationSelected.id;

            gosmModel.submitGOSM(dbParam).then(() => {
                res.send('1');
                logger.debug('GOSM Submitted', log_options);

                return organizationModel.getOrganizationExecutiveBoard(req.session.user.organizationSelected.id, ['oo.idNumber AS "idNumber"']);
            }).then(executiveBoard => {
                logger.debug(`Executive Board: ${executiveBoard}`, log_options);

                return database.tx(t => {
                    let queries = [];

                    for (const officer of executiveBoard) {
                        logger.debug(`Adding notification to ${officer.idNumber}`, log_options);
                        queries[queries.length] = accountModel.addNotification(
                            officer.idNumber,
                            'GOSM Submission', //title
                            'GOSM for current has been submitted', //description
                            null, //details
                            null, //returning
                            t //connection
                        );
                    }

                    return t.batch(queries);
                });
            }).then(() => {
                logger.debug('Notifications sent to executive board officers', log_options);
            }).catch(err => {
                logger.error(`${err.message}\n${err.stack}`, log_options);
            });
        },

        deleteActivity: (req, res) => {
            let dbParam = Object.create(null);
            dbParam.id = req.body.dbid;

            logger.debug(`Deleting activity: ${req.body.dbid}`, log_options);
            gosmModel.deleteActivity(dbParam).then(data => {
                res.send("1");
            }).catch(error => {
                res.send('0');
                logger.error(`${error.message}\n${error.stack}`, log_options);
            });
        },

        updateActivity: (req, res) => {
            logger.info('updateActivity()', log_options);
            var id = req.body.id;

            var strategy = req.body.strategy;
            var goals = req.body.goals;

            var objectives = objectives = req.body['objectives[]'] ? req.body['objectives[]'] : req.body.objectives;
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
            var personInCharge = req.body['personInCharge[]'] ? req.body['personInCharge[]'] : req.body.personInCharge;

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

            logger.debug('starting transaction', log_options);
            //TODO: flatten promises
            database.tx(transaction => {
                return gosmModel.updateActivity(dbParam, transaction).then(data => {
                    return Promise.all([
                        Promise.resolve(data.id),
                        gosmModel.clearProjectHeads(id, transaction)
                    ]);
                }).then(data => {
                    for (const projectHead of personInCharge) {
                        gosmModel.insertProjectHead(id, projectHead, transaction).then(() => {});
                    }

                    logger.debug(`ID: ${data[0].id}`, log_options);


                }).catch(err => {
                    logger.error(`${err.message}\n${err.stack}`, log_options);

                });
            }).then(data=>{
                return res.json({id:1});
            }).catch(err => {
                logger.warn(`${err.message}\n${err.stack}`, log_options);
                return res.json({id:0});
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
            logger.info('inputCreateGOSM(): ', log_options);

            /* TODO Validate input */
            logger.warning('inputCreateGOSM - Input not yet validated!', log_options);
            logger.debug(`req.body: ${JSON.stringify(req.body)}`, log_options);

            /* Parse input*/
            let strategy = req.body.strategy;
            let goals = req.body.goals;
            let objectives = req.body['objectives[]'] ? req.body['objectives[]'] : req.body.objectives;

            if (!Array.isArray(objectives)) {
                objectives = [objectives];
            }

            let description = req.body.description;
            let notingosm = req.body.notingosm;
            let measures = req.body.measures;
            let startDate = req.body.targetDateStart;
            let startDateSplit = startDate.split("/");
            let endDate = req.body.targetDateEnd;
            let endDateSplit = endDate.split("/");
            let activityType = req.body['activity-type'];
            let others = req.body.otherDescription;
            let natureType = req.body['nature-type'];
            let personInCharge = req.body['personInCharge[]'] ? req.body['personInCharge[]'] : req.body.personInCharge;

            if (!Array.isArray(personInCharge)) {
                personInCharge = [personInCharge];
            }

            let isRelatedToOrganization = req.body.isRelatedToOrganization;
            let budget = req.body.budget;

            return systemModel.getCurrentTerm('id').then(term => {
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
                        budget: budget,
                        notingosm: notingosm
                    };

                    if (activityType == 10 && others == null) {
                        throw new Error('Error activity type others empty');
                    }

                    logger.debug('Inserting GOSM Activity', log_options);
                    return gosmModel.insertProposedActivity(dbParam, transaction).then(activity => {
                        logger.debug(`ActivityID: ${activity.activityid}, person-in-charge_length: ${personInCharge.length}`, log_options);

                        let queries = [Promise.resolve(activity.activityid)];

                        logger.debug('Inserting project heads', log_options);
                        for (const projectHead of personInCharge) {
                            const projectHeadParam = Object.create(null);
                            projectHeadParam.idNumber = parseInt(projectHead);
                            projectHeadParam.activityID = parseInt(activity.activityid);

                            logger.debug(`${projectHead}`, log_options);
                            queries[queries.length] = gosmModel.insertActivityProjectHead(projectHeadParam, transaction);
                        }

                        logger.debug('Batching queries', log_options);
                        return transaction.batch(queries);
                    });
                });
            }).then(([data]) => {
                return res.send(String(data));
            }).catch(error => {
                return logger.error(`${error.message}\n${error.stack}`, log_options);
            });
        },

        createActivityRequirements: (req, res) => {
            logger.info('createActivityRequirements()', log_options);

            const dbParam = {};
            //TODO CHANGE ID
            dbParam.id = 1;

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

                return res.render('Org/ActivityRequirements', renderData);
            }).catch(error => {
                return logger.error(`${error.message}\n${error.stack}`, log_options);
            });
        },

        viewSettingAcl: (req, res) => {
            database.tx(t => {
                return t.batch([
                    organizationModel.getFunctionality(),
                    organizationModel.getOrgRole(),
                    organizationModel.getTestJson()
                ]);
            }).then(data => {
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                renderData.functionality = data[0]
                renderData.orgrole = data[1]
                for (var role in data[2][0].json_object) {
                    data[2][0].json_object[role] = JSON.parse(data[2][0].json_object[role])
                }
                renderData.checked = (data[2][0].json_object)

                console.log("DOOOOOOOOOOOOOOOOOOOOMS")
                    // console.log(renderData.checked)
                return res.render('Org/Settings_ACL', renderData);
            }).catch(err => {
                console.error(err);
            })
        },

        saveAcl: (req, res) => {
            console.log("req.body");
            var data = req.body;
            delete data["_csrf"];
            delete data["myTable_length"];
            console.log(data);

            database.tx(t => {
                return t.batch([
                    accountModel.deleteAcl(t),
                    accountModel.insertACL(data, t)
                ]);
            }).then(data => {
                return res.redirect('/Organization/Setting/ACL')
            }).catch(err => {
                console.error(err)
            })

        },
        additional: (req, res) => {
            console.log("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDd")
            console.log(req.session.notingosm)
            if (req.session.notingosm >= 10) {
                return res.redirect('/Organization/ProjectHead/home')
            } else {
                database.task(task1 => {
                    logger.debug('Starting database task', log_options);
                    return systemModel.getCurrentTerm('id', task1).then(term => {
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

                        return gosmModel.getOrgGOSM(GOSMParam, task1).then(GOSM => {
                            /* GOSM Exists */
                            if (GOSM) {
                                logger.debug('GOSM already exists', log_options);
                                return Promise.resolve([GOSM.id, GOSM]);
                            }
                            //else
                            logger.info('Creating new GOSM', log_options);
                            return gosmModel.insertNewGOSM(
                                GOSMParam.termID,
                                GOSMParam.studentOrganization,
                                req.session.user.idNumber,
                                true,
                                task1).then(data => {

                                return Promise.resolve([data.id, data]);
                            });
                        });
                    }).then(GOSM => {
                        var dbParam = {
                            organization: req.session.user.organizationSelected.id
                        };

                        let GOSMParam = Object.create(null);

                        GOSMParam.termID = GOSM[1].termid
                        GOSMParam.studentOrganization = req.session.user.organizationSelected.id;

                        logger.debug('Starting batch queries', log_options);
                        return task1.batch([
                            gosmModel.getnotinGOSMActivities(GOSM[0], undefined, task1),
                            gosmModel.getAllActivityTypes(['id', 'name'], task1),
                            gosmModel.getAllActivityNature(['id', 'name'], task1),
                            organizationModel.getStudentsOfOrganization(dbParam),
                            gosmModel.getOrgGOSM(GOSMParam, task1)
                        ])
                    });
                }).then(data => {
                    console.log("TTTTTTTTTTTTTTTTTTTTTTTTTTT")
                    const renderData = Object.create(null);
                    renderData.extra_data = req.extra_data;
                    renderData.csrfToken = req.csrfToken();

                    renderData.activityTypes = data[1];
                    renderData.activityNature = data[2];
                    renderData.gosmActivities = data[0];

                    renderData.members = data[3];

                    if (data[4] != undefined) {
                        renderData.status = data[4].status;
                        renderData.comments = data[4].comments;

                        console.log(data[4])
                    }

                    console.log("GOSM DATA")

                    logger.debug('Rendering page', log_options);
                    return res.render('Org/notInGOSM', renderData);

                }).catch(err => {
                    logger.error(`${err.message}\n${err.stack}`, log_options);
                });
            }



        },
        viewCreateGOSM: (req, res) => {
            console.log("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDd")

            database.task(task1 => {
                logger.debug('Starting database task', log_options);
                return systemModel.getCurrentTerm('id', task1).then(term => {
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

                    return gosmModel.getOrgGOSM(GOSMParam, task1).then(GOSM => {
                        /* GOSM Exists */
                        if (GOSM) {
                            logger.debug('GOSM already exists', log_options);
                            return Promise.resolve([GOSM.id, GOSM]);
                        }
                        //else
                        logger.info('Creating new GOSM', log_options);
                        return gosmModel.insertNewGOSM(
                            GOSMParam.termID,
                            GOSMParam.studentOrganization,
                            req.session.user.idNumber,
                            true,
                            task1).then(data => {

                            return Promise.resolve([data.id, data]);
                        });
                    });
                }).then(GOSM => {
                    var dbParam = {
                        organization: req.session.user.organizationSelected.id
                    };

                    let GOSMParam = Object.create(null);

                    GOSMParam.termID = GOSM[1].termid
                    GOSMParam.studentOrganization = req.session.user.organizationSelected.id;

                    logger.debug('Starting batch queries', log_options);
                    return task1.batch([
                        gosmModel.getGOSMActivities(GOSM[0], undefined, task1),
                        gosmModel.getAllActivityTypes(['id', 'name'], task1),
                        gosmModel.getAllActivityNature(['id', 'name'], task1),
                        organizationModel.getStudentsOfOrganization(dbParam),
                        gosmModel.getOrgGOSM(GOSMParam, task1)
                    ])
                });
            }).then(data => {
                console.log("TTTTTTTTTTTTTTTTTTTTTTTTTTT")
                console.log(data[0])
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.activityTypes = data[1];
                renderData.activityNature = data[2];
                renderData.gosmActivities = data[0];

                renderData.members = data[3];

                if (data[4] != undefined) {
                    renderData.status = data[4].status;
                    renderData.comments = data[4].comments;

                    console.log(data[4])
                }

                console.log("GOSM DATA")

                logger.debug('Rendering page', log_options);
                if (renderData.status == 3) {
                    return res.redirect('/Organization/viewGOSMList')
                } else {
                    return res.render('Org/GOSM', renderData);
                }

            }).catch(err => {
                logger.error(`${err.message}\n${err.stack}`, log_options);
            });
        },

        viewGOSMDetails: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            console.log(req.params.orgid)
            gosmModel.getGOSMActivities(req.params.orgid).then(data => {
                console.log(data)
                renderData.gosmactivity = data
                return res.render('Org/gosmDetails', renderData);
            }).catch(err => {
                console.log(err)
            });
        },

        saveContext: (req, res) => {
            console.log(req.body);

            // let startDateSplit = req.body.actualDateStart.split("/");
            // let endDateSplit = req.body.actualDateEnd.split("/");


            var dbParam = {
                id: req.body.ppr,
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

            if (!(req.body.enp).trim() ||
                !(req.body.enmp).trim() ||
                !(req.body.venue).trim() ||
                !(req.body.adviser).trim() ||
                !(req.body.expense).trim() ||
                !(req.body.context1).trim() ||
                !(req.body.context2).trim() ||
                !(req.body.context3).trim()) {

                dbParam.isBriefContextComplete = false;
            }


            if (!(req.body.enp).trim()) {
                dbParam.enp = null;
            }

            if (!(req.body.enmp).trim()) {
                dbParam.enmp = null;
            }

            console.log(req.body.id);
            console.log(dbParam);



            projectProposalModel.updatePPRBriefContext(dbParam).then(data => {

                    res.redirect(`/Organization/ProjectProposal/Main/${req.body.id}/${req.body.status}`);
            

            }).catch(error => {
                console.log(error);
            });
        },

        postSaveContext: (req, res) => {
            logger.info('postSaveContext()', log_options);

            // TODO: change id, to come from selected activity
            let inputObjectives = req.body['obj[]'] ? req.body['obj[]'] : req.body.obj;

            var paramObjectives = null;
            if (typeof inputObjectives !== 'undefined' && inputObjectives && inputObjectives.constructor === Array) {
                paramObjectives = inputObjectives.filter(function(e) {
                    return e
                });
            } else {
                paramObjectives = [];
                paramObjectives.push(inputObjectives);
            }
            

            var dbParam = {
                id: req.body.gosmid,
                anmp: req.body.anmp,
                anp: req.body.anp,
                well: req.body.wentWell,
                learning: req.body.learning,
                develop: req.body.develop,
                mistakes: req.body.mistakes,

                objectives: paramObjectives,

                isBriefContextComplete: true
            };

            console.log(dbParam)

            console.log(paramObjectives != inputObjectives.length)
            if (!(req.body.wentWell).trim() ||
                !(req.body.learning).trim() ||
                !(req.body.develop).trim() ||
                !(req.body.learning).trim() ||
                !(req.body.mistakes).trim()
            ) {


                dbParam.isBriefContextComplete = false;

            }
            console.log("dbParam")
            console.log(dbParam);
            var dbParam3 = {
                gosmid: req.body.gosmid,
                status: 2
            }
            postProjectProposalModel.updatePostProjectProposalCompleteness(dbParam3);

            postProjectProposalModel.updatePostProjectProposal(dbParam).then(data => {
                return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`)
            }).catch(err => {
                console.log(err);
            });

            // return res.redirect(`Organization/postprojectproposal/main/${req.bod}`)
        },
        postSaveExpenses: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            console.log(req.body)
            // var date = new Date().toJSON();


            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'postacts');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }

            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'postacts', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }
            var dir4 = path.join(__dirname, '..', 'assets', 'upload', 'images');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir4)) {
                fs.mkdirSync(dir4);
            }
            var dir5 = path.join(__dirname, '..', 'assets', 'upload', 'images', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir5)) {
                fs.mkdirSync(dir5);
            }

            //SETTING VALUE OF FINANCE DOCMENT
            var dp = true;
            var bt = true;
            var reim = true;
            if (typeof req.body.bt == "undefined") {
                bt = false;
            }

            if (typeof req.body.dp == "undefined") {
                dp = false
            }
            if (typeof req.body.reim == "undefined") {
                reim = false
            }

            // var expenseSubmissionID = postProjectProposalModel.getPostExpenseMaxSubmissionID({gosmid: req.body.gosmid});
            // console.log("expenseSubmissionID")
            // console.log(expenseSubmissionID)
            // console.log(req.files);

            database.tx(t => {

                var dbParam3 = {
                    gosmid: req.body.gosmid,
                    status: 2
                }
                postProjectProposalModel.updatePostProjectProposalCompleteness(dbParam3, t);

                return t.batch([
                        postProjectProposalModel.getPostExpenseMaxSubmissionID({
                            gosmid: req.body.gosmid
                        }),
                        postProjectProposalModel.getEventPictureMaxSubmission(dbParam3, t)
                    ])
                    .then(data => {
                        console.log(data[0][0].max);
                        console.log("data")
                        var submissionID = 0;
                        if (data[1][0].max != null) {
                            submissionID = data[1][0].max + 1
                        }
                        var expenseID = 0;
                        if (data[0][0].max != null) {
                            expenseID = data[0][0].max + 1
                        }
                        console.log(submissionID)
                        console.log("expenseID");
                        console.log("data")

                        //NORMAL THINGS TO INSERT
                        var statParam = {
                            dp: dp,
                            bt: bt,
                            reim: reim
                        };
                        var finParam = {
                            gosmid: req.body.gosmid,
                            status: true
                        }
                        console.log("GALS");
                        console.log(req.files['gals']);
                        console.log(typeof req.files['gals']);
                        if (typeof req.files['gals'] == 'object') {
                            var galsFilename = cuid() + path.extname(req.files['gals'].name);
                            var galsFilenameToShow = (req.files['gals'].name);
                            var pg = path.join(dir5, galsFilename);
                            var galsParam = {
                                gosmid: req.body.gosmid,
                                filename: galsFilename,
                                filenameToShow: galsFilenameToShow,
                                idNumber: req.session.user.idNumber
                            };

                            Promise.all([
                                postProjectProposalModel.insertPostProjectProposalGals(galsParam, t),
                                req.files['gals'].mv(pg)
                            ]).then(data => {
                                console.log("")
                                console.log("========IF1============");
                            }).catch(err => {
                                console.log("========PROMISE PICTURE1============");
                                console.log(err)



                            });
                        } else {
                            finParam.status = false;
                        }

                        console.log("========TAs33333333333  Sd=========");
                        console.log(finParam);
                        //EXPENSES MAY VARY
                        // console.log(typeof req.files['file[]'])
                        // if(typeof req.files['file[]'] == 'object'){
                        //     if(typeof req.files['file[]'][Symbol.iterator] == 'function'){
                        //         for(var ctr = 0; ctr < req.body['est[]'].length; ctr++){

                        //             var orignalFileName = req.files['file[]'][ctr].name;
                        //             var ftype = path.extname(orignalFileName);
                        //             console.log(ftype);
                        //             var fname = cuid()+ftype;

                        //             var dbParam ={
                        //                 gosmid: req.body.gosmid,
                        //                 submissionID:expenseID,
                        //                 particular:req.body['par[]'][ctr],
                        //                 establishment:req.body['est[]'][ctr],
                        //                 price:req.body['price[]'][ctr],
                        //                 file: fname,
                        //                 filenameToShow:req.files['file[]'][ctr].name,
                        //                 idNumber:req.session.user.idNumber,

                        //             };
                        //             console.log(dbParam);
                        //             console.log("req.files");
                        //             var p = path.join(dir2,fname);
                        //             Promise.all([
                        //                     req.files['file[]'][ctr].mv(p),
                        //                     postProjectProposalModel.insertPostProjectExpense(dbParam,t)
                        //                 ]).then(result =>{
                        //                     console.log("========IF2============");
                        //                 }).catch(err =>{
                        //                     console.log("========PROMISE2=========");
                        //                     console.log(err);
                        //                 })
                        //         }
                        //     }else{

                        //             var orignalFileName = req.files['file[]'].name;
                        //             var ftype = path.extname(orignalFileName);
                        //             console.log(ftype);
                        //             var fname = cuid()+ftype;

                        //             var dbParam ={
                        //                 gosmid: req.body.gosmid,
                        //                 submissionID:expenseID,
                        //                 particular:req.body['par[]'],
                        //                 establishment:req.body['est[]'],
                        //                 price:req.body['price[]'],
                        //                 file: fname,
                        //                 filenameToShow:req.files['file[]'].name,
                        //                 idNumber:req.session.user.idNumber,

                        //             };
                        //             var p = path.join(dir2,fname);
                        //             Promise.all([
                        //                     req.files['file[]'].mv(p),
                        //                     postProjectProposalModel.insertPostProjectExpense(dbParam,t)
                        //                 ]).then(result =>{
                        //                     console.log("========IF3============");
                        //                 }).catch(err =>{
                        //                     console.log("========PROMISE3=========");
                        //                     console.log(err);
                        //                 })
                        //     }
                        // }else{
                        //     finParam.status = false;
                        // }






                        console.log("========TA22222222222=========");
                        console.log(finParam);
                        let pictures = req.files['pictures[]'] ? req.files['pictures[]'] : req.files.pictures;
                        let pictureCaptions = req.body['pictureCaption[]'] ? req.body['pictureCaption[]'] : req.body.pictureCaption;
                        if (typeof pictures == 'object') {
                            console.log(typeof pictures[Symbol.iterator]);
                            if (typeof pictures[Symbol.iterator] == 'function') {
                                for (var ctr = 0; ctr < PICTURES.length; ctr++) {
                                    var orignalFileName = pictures[ctr].name;
                                    var ftype = path.extname(orignalFileName);
                                    console.log(ftype);
                                    var fname = cuid() + ftype;
                                    var pictureParam = {
                                        gosmid: req.body.gosmid,
                                        submissionID: submissionID,
                                        filename: fname,
                                        filenameToShow: pictures.name,
                                        idNumber: req.session.user.idNumber,
                                        description: pictureCaptions[ctr]
                                    }
                                    var p = path.join(dir5, fname);
                                    Promise.all([
                                        pictures[ctr].mv(p),
                                        postProjectProposalModel.insertPostProjectProposalEventPictures(pictureParam, t)
                                    ]).then(result => {

                                    }).catch(err => {
                                        console.log("========PROMISE=========");
                                        console.log(err);
                                    })

                                }
                            } else {
                                var orignalFileName = pictures.name;
                                var ftype = path.extname(orignalFileName);
                                console.log(ftype);
                                var fname = cuid() + ftype;
                                var pictureParam = {
                                    gosmid: req.body.gosmid,
                                    submissionID: submissionID,
                                    filename: fname,
                                    filenameToShow: pictures.name,
                                    idNumber: req.session.user.idNumber,
                                    description: pictureCaptions
                                }
                                var p = path.join(dir5, fname);
                                Promise.all([
                                    pictures.mv(p),
                                    postProjectProposalModel.insertPostProjectProposalEventPictures(pictureParam, t)
                                ]).then(result => {

                                }).catch(err => {
                                    console.log("========PROMISE=========");
                                    console.log(err);
                                })

                            }
                        } else {
                            finParam.status = false;
                        }
                        console.log("+++++++++++++++++++++++++++++++");
                        console.log(statParam)
                        postProjectProposalModel.updatePostProjectProposalFinanceDocumentStatus(statParam, t);
                        console.log("========TAsdASDASd=========");
                        console.log(finParam);
                        postProjectProposalModel.updatePostProjectRequiredCompleteness(finParam, t);
                        //PICTURES MAY VARY
                    });


            }).then(data => {
                return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`)

            }).catch(err => {
                console.log("========TAST=========");
                console.log(err);
            })

            // TODO: change id, to come from selected activity

            // return res.redirect(`Organization/postprojectproposal/main/${req.bod}`)
        },

        saveDesign: (req, res) => {


            console.log(req.body);
            console.log("asda++++++++++++++++++++++++++++++++++L");
            var sched = JSON.parse(req.body.sched);
            var keys = Object.keys(sched);
            console.log(keys);

            var dbParam = {
                projectproposal: req.body.pid
            };

            projectProposalModel.deleteProgramDesign(dbParam)
                .then(data => {

                }).catch(error => {
                    console.log("delete error");
                    console.log(error);
                });


            var index = 0;

            database.tx(transaction => {



                for (var item in sched) {
                    console.log(sched[item].length);

                    for (var i = 0; i < sched[item].length; i++) {

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
                            .then(data => {

                            }).catch(error => {
                                console.log("insertsched error");
                                console.log(error);
                            });


                    }
                    index++;
                }

                console.log("INDEX IS");
                console.log(index);

                if (index == 0) {

                    console.log("ENTERS EMPTY");

                    var param = {
                        id: req.body.pid,
                        status: false
                    };

                    console.log(param);

                    projectProposalModel.updateIsProgramDesignComplete(param, transaction)
                        .then(data => {

                        }).catch(error => {
                            console.log("updateIsProgramDesignComplete")
                            console.log(error);
                        });
                } else {

                    console.log("ENTERS");

                    var param = {
                        id: req.body.pid,
                        status: true
                    };

                    projectProposalModel.updateIsProgramDesignComplete(param, transaction)
                        .then(data => {

                        }).catch(error => {
                            console.log(error);
                        });

                }



            }).then(data => {
                return res.send("1");

            }).catch(error => {
                console.log(error);
            });


        },

        savePPR: (req, res) => {
            logger.info('call savePPR()', log_options);

            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            logger.debug(`req.body: ${JSON.stringify(req.body)}\nreq.params: ${JSON.stringify(req.params)}`, log_options);

            var dbParam = {
                id: req.body.pprid,
                preparedby: req.session.user.idNumber,
                gosmid: req.body.gosmid
            };

            if (req.body.context && req.body.program && req.body.expense && req.body.attachment) {
                console.log("IZ HERE");

                database.tx(t => {
                    return projectProposalModel.submitProjectProposal(dbParam, t).then(data => {
                        if (req.body.status == 1) { // first time nagpasa
                            return t.task(task => {
                                1
                                return task.batch([
                                    projectProposalModel.getProjectProposalProjectHeads(dbParam.id, task),
                                    projectProposalModel.getDetails(dbParam.id, ['ga.strategies'], task)
                                ]);
                            }).then(data => {
                                let description = `Please check activity ${data[1].strategies}`;

                                let queries = [postProjectProposalModel.insertPostProjectProposal(dbParam, t)];
                                for (const projectHead of data[0]) {
                                    logger.debug(`adding notification to ${JSON.stringify(projectHead)}`, log_options);
                                    queries[queries.length] = accountModel.addNotification(
                                        projectHead.idnumber,
                                        'New Project Proposal',
                                        description,
                                        null,
                                        null,
                                        t
                                    );
                                }

                                return t.batch(queries);
                            }).then(data => {
                                return res.redirect(`/Organization/ProjectProposal/gosmlist/`);
                            }).catch(error => {
                                logger.debug(`${error.message}\n${error.stack}`, log_options);
                            });
                        } else {
                            // from pend
                            let signatoryParam = {
                                status: 0,
                                gosmactivity: req.body.gosmactivity
                            };

                            return projectProposalModel.updatePPRSignatoryStatus(signatoryParam, t).then(data => {
                                return res.redirect(`/Organization/ProjectProposal/gosmlist/`);
                            }).catch(error => {
                                logger.debug(`${error.message}\n${error.stack}`, log_options);
                            });
                        }
                    });
                }).catch(error => {
                    logger.debug(`${error.message}\n${error.stack}`, log_options);
                });
            } else {
                console.log("IZ HERE INSTEAD");
                return res.redirect(`/Organization/ProjectProposal/gosmlist/`);
            }

        },


        postSaveAttachments: (req, res) => {
            var dbParam3 = {
                gosmid: req.body.gosmid,
                status: 2
            }
            postProjectProposalModel.updatePostProjectProposalCompleteness(dbParam3);

            // var date = new Date().toJSON();

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
            var bt, reim, dp;
            if (typeof req.body.bt == 'undefined') {
                bt = false;
            }
            if (typeof req.body.reim == 'undefined') {
                reim = false;
            }
            if (typeof req.body.dp == 'undefined') {
                dp = false;
            }

            console.log(req.body);
            console.log("=========================== FILES");
            console.log(typeof req.files['rof-dp']);

            database.tx(t => {
                var statFin = {
                    stat: true,
                    gosmid: (req.body.gosmid)
                }
                var fqName = '';
                var fqcuid = '';
                var rofName = '';
                var rofcuid = '';
                if (dp) {
                    if (typeof req.files['fq-dp'] == 'object' || typeof req.files['rof-dp'] == 'object') {
                        //DP

                        if (typeof req.files['fq-dp'] == 'object') {
                            fqName = req.files['fq-dp'].name;
                            fqcuid = cuid() + path.extname(fqName);
                        }

                        if (typeof req.files['rof-dp'] == 'object') {
                            rofName = req.files['rof-dp'].name;
                            rofcuid = cuid() + path.extname(rofName);
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
                        if (req.body['amount-dp'] != '') {
                            dpParam.amount = req.body['amount-dp'];
                        }
                        if (!(req.body['est-dp']).trim() ||
                            !(req.body['amount-dp']).trim() ||
                            !(req.body['pb-dp']).trim() ||
                            !(req.body['delayed-dp']).trim()

                        ) {

                            statFin.stat = false;
                        }

                        if (typeof req.files['fq-dp'] == 'object' && typeof req.files['rof-dp'] == 'object') {
                            console.log(dpParam);
                            Promise.all([
                                req.files['fq-dp'].mv(path.join(dir2, fqcuid)),
                                req.files['rof-dp'].mv(path.join(dir2, rofcuid)),
                                postProjectProposalModel.insertPostDP(dpParam, t)
                            ]).then(data => {

                            }).catch(err => {
                                console.log("==================DP1");
                                console.log(err);
                            });
                        } else if (typeof req.files['rof-dp'] == 'object') {
                            Promise.all([

                                    req.files['rof-dp'].mv(path.join(dir2, rofcuid)),
                                    postProjectProposalModel.insertPostDP(dpParam, t)
                                ])
                                .then(data => {

                                }).catch(err => {
                                    console.log("==================DP2");
                                    console.log(err);
                                });
                        } else if (typeof req.files['fq-dp'] == 'object') {
                            Promise.all([
                                    req.files['fq-dp'].mv(path.join(dir2, fqcuid)),

                                    postProjectProposalModel.insertPostDP(dpParam, t)
                                ])
                                .then(data => {

                                }).catch(err => {
                                    console.log("==================DP3");
                                    console.log(err);
                                });
                        }

                    } else {
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
                        if (req.body['amount-dp'] != '') {
                            dpParam.amount = req.body['amount-dp'];
                        }
                        postProjectProposalModel.insertPostDP(dpParam, t)
                    }
                }
                if (bt) {
                    if (typeof req.files['bs-bt'] == 'object') {
                        //BT
                        var bsName = req.files['bs-bt'].name;
                        var bscuid = cuid() + path.extname(bsName);
                        var btParam = {
                            gosmid: req.body.gosmid,
                            est: req.body["est-bt"],
                            amount: req.body["amount-bt"],
                            purpose: req.body['pur-bt'],
                            bs: bscuid,
                            bsts: bsName,
                            idNumber: req.session.user.idNumber
                        };
                        if (!(req.body['est-bt']).trim() ||
                            !(req.body['amount-bt']).trim() ||
                            !(req.body['pur-bt']).trim()
                        ) {

                            statFin.isFinanceDocumentCompleted = false;
                        }
                        if (req.body['amount-bt'] != '') {
                            btParam.amount = req.body['amount-bt'];
                        }
                        Promise.all([
                                req.files['bs-bt'].mv(path.join(dir2, bscuid)),
                                postProjectProposalModel.insertPostBT(btParam, t)
                            ])
                            .then(data => {

                            }).catch(err => {
                                console.log("==================bt");
                                console.log(err);
                            });

                    } else {
                        var bscuid = '';
                        var bsts = '';
                        statFin.stat = false;
                        var btParam = {
                            gosmid: req.body.gosmid,
                            est: req.body["est-bt"],
                            amount: 0.0,
                            purpose: req.body['pur-bt'],
                            bs: bscuid,
                            bsts: bsName,
                            idNumber: req.session.user.idNumber
                        };
                        if (req.body['amount-bt'] != '') {
                            btParam.amount = req.body['amount-bt'];
                        }
                        postProjectProposalModel.insertPostBT(btParam, t)
                    }
                }


                if (reim) {
                    if (typeof req.files['rec-pr'] == 'object') {
                        //REIM
                        var names = [];
                        var nameToShow = [];
                        if (typeof req.files['rec-pr'][Symbol.iterator] == 'function') {
                            for (var ctr = 0; ctr < req.files['rec-pr'].length; ctr++) {
                                var recName = req.files['rec-pr'][ctr].name;
                                var reccuid = cuid() + path.extname(recName);
                                names.push(recName);
                                nameToShow.push(reccuid);
                                req.files['rec-pr'][ctr].mv(path.join(dir2, reccuid))
                                    .then(data => {

                                    }).catch(err => {
                                        console.log("==================REIM");
                                        console.log(err);
                                    })
                            }
                        } else {
                            var recName = req.files['rec-pr'].name;
                            var reccuid = cuid() + path.extname(recName);
                            names.push(recName);
                            nameToShow.push(reccuid);
                            req.files['rec-pr'].mv(path.join(dir2, reccuid))
                                .then(data => {

                                }).catch(err => {
                                    console.log("==================REIM1");
                                    console.log(err);
                                })
                        }
                        var rParam = {
                            gosmid: req.body.gosmid,
                            est: req.body["est-pr"],
                            amount: 0.0,
                            paymentBy: req.body['pb-pr'],
                            delayedProcessing: req.body['delayed-pr'],
                            n: req.body['n-pr'],
                            filenames: names,
                            filenamesToShow: nameToShow,
                            idNumber: req.session.user.idNumber

                        }

                        if (!(req.body['est-pr']).trim() ||
                            !(req.body['amount-pr']).trim() ||
                            !(req.body['delayed-pr']).trim() ||
                            !(req.body['n-pr']).trim()

                        ) {

                            statFin.stat = false;
                        }
                        if (req.body['amount-pr'] != '')
                            rParam.amount = req.body['amount-pr'];
                        console.log(rParam);
                        postProjectProposalModel.insertPostReim(rParam, t)
                            .then(data => {

                            })
                            .catch(err => {
                                console.log("=======================REIM2");
                                console.log(err);
                            });
                    } else {
                        statFin.stat = false;
                        var rParam = {
                            gosmid: req.body.gosmid,
                            est: req.body["est-pr"],
                            amount: 0.0,
                            paymentBy: req.body['pb-pr'],
                            delayedProcessing: req.body['delayed-pr'],
                            n: req.body['n-pr'],
                            filenames: names,
                            filenamesToShow: nameToShow,
                            idNumber: req.session.user.idNumber

                        }
                        if (req.body['amount-pr'] != '')
                            rParam.amount = req.body['amount-pr'];
                        postProjectProposalModel.insertPostReim(rParam, t)
                    }
                }
                console.log(statFin);

                postProjectProposalModel.updatePostProjectFinanceCompleteness(statFin, t)
                    .then(data => {

                    })
                    .catch(err => {
                        console.log("=======================FINAUPDATE");
                        console.log(err);
                    });


            }).then(data => {
                return res.redirect(`/Organization/PostProjectProposal/Main/${req.body.gosmid}`);
            }).catch(err => {
                console.log("==================TRAC");
                console.log(err);
            })
        },


        saveExpenses: (req, res) => {
            console.log("HERE");
            console.log(req.body);

            var dbParam = {
                id: req.body.ppr,
                accumulatedOperationalFunds: req.body.ope,
                accumulatedDepositoryFunds: req.body.dep,
                organizationFundOtherSource: req.body.otherfunds,
                sourceFundOrganizational: req.body.org,
                sourceFundParticipantFee: req.body.par,
                sourceFundOther: req.body.others,
                isExpenseComplete: true
            };

            let item = req.body['item[]'] ? req.body['item[]'] : req.body.item;
            if (!Array.isArray(item)) {
                item = [item];
            }

            console.log(item.length);

            if(item.length < 2){
                console.log("asdaddddddddddddddddddddddddddddddddddddd duti asdadasdasdad");
                dbParam.isExpenseComplete = false;
            }



            database.tx(transaction => {
                projectProposalModel.updatePPRExpenses(dbParam, transaction).then(data => {

                }).catch(error => {
                    console.error(error);
                });

                var dbParam2 = {
                    projectproposal: req.body.ppr
                };

                projectProposalModel.deleteExpenses(dbParam2, transaction).then(data => {

                }).catch(error => {
                    console.error(error);
                });

                projectProposalModel.deleteRevenue(req.body.ppr, transaction).then(data => {

                }).catch(error => {
                    console.error(error);
                });

                let optionsRadios2 = req.body['optionsRadios2[]'] ? req.body['optionsRadios2[]'] : req.body.optionsRadios2;
                if (!Array.isArray(optionsRadios2)) {
                    optionsRadios2 = [optionsRadios2];
                }

                let quantity = req.body['quantity[]'] ? req.body['quantity[]'] : req.body.quantity;
                if (!Array.isArray(quantity)) {
                    quantity = [quantity];
                }

                let price = req.body['price[]'] ? req.body['price[]'] : req.body.price;
                if (!Array.isArray(price)) {
                    price = [price];
                }

                let typeOfItem = req.body['typeOfItem[]'] ? req.body['typeOfItem[]'] : req.body.typeOfItem;
                if (!Array.isArray(typeOfItem)) {
                    typeOfItem = [typeOfItem];
                }

                for (var i = 0; i < item.length - 1; i++) {
                    if (optionsRadios2[i] == 'Revenue') {
                        var dbParam3 = {
                            projectProposal: req.body.ppr,
                            item: item[i],
                            quantity: quantity[i],
                            sellingPrice: price[i]
                        };

                        console.log("revenue loop");
                        console.log(dbParam3);

                        projectProposalModel.insertProjectProposalProjectedIncome(dbParam3, transaction).then(data => {

                        }).catch(error => {
                            console.error(error);
                        });
                    } else {
                        var dbParam3 = {
                            projectProposal: req.body.ppr,
                            material: item[i],
                            quantity: quantity[i],
                            unitCost: price[i],
                            type: typeOfItem[i]
                        };

                        console.log("expense loop");
                        console.log(dbParam3);

                        projectProposalModel.insertProjectProposalExpenses(dbParam3, transaction).then(data => {

                        }).catch(error => {
                            console.error(error);
                        });
                    } //else
                } //for each item
            }).then(data => {
                return res.redirect(`/Organization/ProjectProposal/Main/${req.body.id}/${req.body.status}`);
            }).catch(error => {
                console.error(error);
            });
        },

        saveAttachments: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            // var date = new Date().toJSON();

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


            dir2 = path.normalize(dir2);
            console.log("req.files");
            console.log(req.body);
            console.log(req.session.user.idNumber);

            var dt = [
                'application/vnd.oasis.opendocument.text',
                'application/vnd.oasis.opendocument.spreadsheet',
                'application/vnd.oasis.opendocument.presentation',
                'application/pdf'
            ];

            database.task(task => {

                return gosmModel.getGOSMActivityType(req.body.activityId, undefined, task).
                then(data => {
                    console.log("DATA");
                    console.log(data[0].activitytype);
                    return gosmModel.getGOSMActivityAttachmentRequirement(data[0].activitytype, task);

                });

            }).then(data => {
                var ctr = 0;

                let files = req.files['uploadfile[]'] ? req.files['uploadfile[]'] : req.files.uploadFile;
                if (!Array.isArray(files)) {
                    files = [files];
                }

                console.log(files);
                console.log("TYPE OF ONE UPLOAD");
                console.log(typeof files[Symbol.iterator]);
                if (typeof files[Symbol.iterator] == 'function') {
                    for (var file of files) {
                        // console.log(file);
                        // console.log("file");
                        // console.log(data[ctr].id);

                        var date = cuid();
                        var nFilename = file.name.split('.').pop();
                        console.log("new File name");
                        console.log(nFilename);
                        var db = {
                            projectId: req.body.pid,
                            requirement: data[ctr].id,
                            dir: dir2 + file.name + ' - ' + date,
                            idNumber: req.session.user.idNumber,
                            filename: date + '.' + nFilename,
                            filenametoShow: file.name

                        };
                        console.log("FILE");
                        console.log(path.normalize(path.join(dir2, date + '.' + nFilename)));
                        var p = path.normalize(path.join(dir2, date + '.' + nFilename));
                        Promise.all([
                            file.mv(p),
                            projectProposalModel.insertProjectProposalAttachment(db)

                        ]).then(result => {
                            console.log(result);
                        }).catch(err => {
                            console.log(err);
                        });
                        ctr++
                    }
                } else if (typeof files[Symbol.iterator] == 'undefined') {
                    var file = files;
                    var nFilename = file.name.split('.').pop();
                    console.log("new File name");
                    var date = cuid();
                    var db = {
                        projectId: req.body.pid,
                        requirement: data[ctr].id,
                        dir: dir2 + file.name + ' - ' + date,
                        idNumber: req.session.user.idNumber,
                        filename: date + '.' + nFilename,
                        filenametoShow: file.name

                    };

                    console.log("FILE");
                    var p = path.normalize(path.join(dir2, date + '.' + nFilename));
                    console.log(path.normalize(path.join(dir2, date + '.' + nFilename)));
                    Promise.all([
                        file.mv(p),
                        projectProposalModel.insertProjectProposalAttachment(db)

                    ]).then(result => {
                        console.log(result);
                    }).catch(err => {
                        console.log(err);
                    });
                }


                // console.log("DATA1");
                // console.log(data);
                // console.log(data[0].id);
                // renderData.attachments = data;
                console.log("ACT ID ");
                console.log(req.body.activityId);
                return res.redirect(`/Organization/ProjectProposal/main/${req.body.activityId}/${req.body.status}`);
            }).catch(error => {
                console.log(error);
            });

            var dbParam = {
                id: req.body.pid
            };

            projectProposalModel.updateIsAttachmentsComplete(dbParam)
                .then(data => {

                }).catch(error => {
                    console.log(error);
                });


        },
        postSaveMain: (req, res) => {
            var dbParam3 = {
                gosmid: req.body.gosmid,
                status: 3
            }
            var dbParam = {
                idNumber: req.session.user.idNumber
            };
            console.log(dbParam3);

            database.tx(t => {
                postProjectProposalModel.updatePostProjectProposalCompleteness(dbParam3, t);
                return postProjectProposalModel.getPostActsToImplement(dbParam, t);
            }).then(data => {

                req.session.postSubmitted = true;
                return res.redirect('/Organization/PostProjectProposal/GOSMList');
            }).catch(err => {
                console.log("POST SAVE MAIN");
                console.log(error);
            });




        },
        viewPubs: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                idNumber: req.session.user.idNumber
            }
            projectProposalModel.getPPRToCreatePubsList(dbParam)
                .then(data => {
                    console.log("DATA");
                    console.log(data);
                    renderData.activities = data;
                    return res.render('Org/Publist', renderData);
                }).catch(err => {
                    console.log("ERROR");
                    console.log(err);
                })


        },
        viewPubsSpecific: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var gosmParam = {
                gosmid: req.params.gosmid,
                idNumber: req.session.user.idNumber
            }
            var gosmParam2 = {
                gosmactivity: req.params.gosmid
            }
            database.task(t => {
                return t.batch([
                    pnpModel.getMypubs(gosmParam, t),
                    pnpModel.getActivityDetailsforPubs(gosmParam, t),
                    gosmModel.getGOSMActivityProjectHeads(gosmParam2, t)
                ]);
            }).then(([pubs, activities, heads]) => {
                renderData.pubs = pubs;
                renderData.activities = activities;
                renderData.heads = heads;
                renderData.gosmid = req.params.gosmid
                return res.render('Org/CreatePubs', renderData);
            }).catch(error => {
                return logger.error(`${error.message}: ${error.stack}`, log_options);
            });
        },

        insertPubs: (req, res) => {
            logger.info('call insertPubs', log_options);

            var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/pubs/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'pubs');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/pubs/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'pubs', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }

            dir2 = path.normalize(dir2);
            console.log("req.files");
            console.log(req.body);

            console.log(req.body);
            console.log(req.files);
            var filename = cuid() + path.extname(req.files.pubs.name);
            //to show
            var filenameTS = req.files['pubs'].name;
            var mod = req.body.optionsRadios2 ? req.body.optionsRadios2 : 0; 

            let isResponseSent = false;
            pnpModel.getSpecificPubSeq({
                gosmid: req.body.gosmid
            }).then(data => {
                //save file
                req.files.pubs.mv(path.join(dir2, filename));

                return pnpModel.insertActivityPublicity({
                    gosmid: req.body.gosmid,
                    sid: data.seq + 1,
                    mod: mod,
                    tpd: req.body['posting-date'],
                    sb: req.session.user.idNumber,
                    ds: req.body.title,
                    status: 0,
                    filename: filename,
                    filenameToShow: filenameTS
                });
            }).then(result => {
                logger.debug(`result: ${result}`, log_options);
                
                isResponseSent = true;
                res.json({
                    status: 1,
                    path: `/upload/pubs/${req.session.user.idNumber}/${filename}`,
                    description: req.body.title,
                    id: result.id,
                    type: mod
                 });
                
                logger.debug('Adding notifications', log_options);
                return database.task(t => {
                    return t.batch([
                        gosmModel.getActivityDetails(req.body.gosmid, [
                            'strategies'
                        ], t),
                        gosmModel.getActivityProjectHeads(req.body.gosmid, [
                            'ph.idNumber AS "idNumber"'
                        ], t),
                        organizationModel.getAccountWithAccessControlSequence(ACL_SEQUENCES.EvaluatePublicityMaterial, 0, [
                            'a.idNumber AS "idNumber'
                        ], t)
                    ]);
                });
            }).then(([activityDetails, projectHeads, evaluators]) => {
                return database.tx(t => {
                    let queries = [];

                    const details = Object.create(null);
                    details.GOSMActivtyID = req.body.gosmid;

                    for(const projectHead of projectHeads){
                        queries[queries.length] = accountModel.addNotification(
                            projectHead.idNumber,
                            'Activtiy Publicity',
                            `A publicty item has been added to the activity ${activityDetails.strategies}`,
                            details,
                            null,
                            t
                        );
                     }

                     for(const evaluator of evaluators){
                        queries[queries.length] = accountModel.addNotification(
                            evaluator.idNumber,
                            'Publicity Evaluation',
                            `A publicty item has been added to the activity ${activityDetails.strategies}`,
                            details,
                            null,
                            t
                        );
                    }

                    return t.batch(queries);
                });
            }).then(data => {
                return logger.debug('Notifications added', log_options);
            }).catch(error => {
                logger.error(`${error.message}: ${error.stack}`, log_options);
                
                if(!isResponseSent){
                    return res.json({
                        status: 0
                    });
                }
            });
        },

        viewPubDetails: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                id: req.body.id
            }
            console.log(dbParam)
            pnpModel.getPubDetails(dbParam).then(data => {
                console.log(data);
                renderData.activity = data
                console.log("TPYE");
                console.log(req.body.type);
                if (req.body.type == 1) {
                    console.log("ONE TYPE");
                    res.render('section/PNP/approveModal', renderData);
                } else {
                    console.log("SECOND TYPE");
                    res.render('section/PNP/pendModal', renderData);
                }
            }).catch(err => {
                console.log(err);
            })
        },

        reuploadPubs: (req, res) => {
            var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/pubs/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'pubs');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/pubs/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'pubs', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }


            dir2 = path.normalize(dir2);
            database.task(t => {
                var dbParam = {
                    id: req.body.pubsid
                }
                return t.batch([
                    //GINAGAWA NG UPDATE PUBS TO PEND NISESET NIYA YUNG PUBS SA OLD VERSION NA STATUS
                    pnpModel.updatePubsToPend(dbParam, t),
                    pnpModel.getPubDetails(dbParam, t)
                ]);

            }).then(data => {
                console.log("DATA DOMS");
                console.log(data);
                var filename = cuid() + path.extname(req.files['file'].name);
                var filenameTS = req.files['file'].name;
                req.files['file'].mv(path.join(dir2, filename))
                var insertParam = {
                    gosmid: data[1].GOSMActivity,
                    sid: data.seq + 1,
                    mod: data[1].modeOfDistribution,
                    tpd: data[1].targetPostingDate,
                    sb: req.session.user.idNumber,
                    ds: data[1].description,
                    status: 0,
                    filename: filename,
                    filenameToShow: filenameTS

                }
                var d = data;
                console.log("DATA DOMS");
                console.log(data[1]);
                pnpModel.insertActivityPublicity(insertParam)
                    .then(data => {
                        res.json({
                            status: 1,
                            path: '/upload/pubs/' + req.session.user.idNumber + '/' + filename,
                            description: req.body.title,
                            id: data.id,
                            type: d[1].modeOfDistribution
                        });
                    }).catch(err => {
                        res.json({
                            status: 0
                        });
                        console.log(err);
                    })

            }).catch(err => {
                console.log(err);
            })

        },
        viewCompletedPostActs: (req, res) => {
            database.task(t => {
                var dbParam = {
                    gosmid: req.params.gosmid
                }

                return t.batch([
                    postProjectProposalModel.getPostActsDetails(dbParam, t),
                    postProjectProposalModel.getLatestEventPicture(dbParam, t),
                    postProjectProposalModel.getLatestPostExpense(dbParam, t),
                    projectProposalModel.getProjectHeadsGOSM(dbParam, t)
                    // projectProposalModel.getProjectProposalProjectHeads(3)
                ]);
            }).then(data => {
                console.log(data);
                console.log("data[1]");

                const renderData = Object.create(null);
                renderData.activity = data[0]
                renderData.pictures = data[1]
                renderData.expense = data[2];
                renderData.heads = data[3];
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();
                res.render('Org/PostActsCompleted', renderData)
            }).catch(err => {
                console.log(err);
            })
        },

        orgresLists: (req, res) => {
            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            var dbParam = {
                idNumber: req.session.user.idNumber
            }

            orgresModel.getOrgresList(dbParam).then(data => {
                console.log("DATA NG LIST")
                console.log(data)
                renderData.activities = data;
                console.log(data)
                res.render('Orgres/OrgresList', renderData);
            }).catch(err => {
                return logger.error(`${err.message}: ${err.stack}`, log_options);
            })
        },
        addMember: (req, res) => {
            
           
            organizationModel.addMember(req.body.idnumber, req.body.name).then(data=>{
                return res.json({status:1})     
            }).catch(err=>{
                console.log(err)
                return res.json({status:0})
            })

            
        },
        deleteMember: (req, res) => {
             
            
            organizationModel.deleteMember(req.body.idnumber).then(data=>{
                return res.json({status:1})
            }).catch(err=>{
                console.log(err)
                return res.json({status:0})
            })
            
        },

        orgresSpecficActivity: (req, res) => {

            const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                gosmid: req.params.id
            };
            database.task(t => {
                return t.batch([
                    pnpModel.getActivityDetailsforPubs(dbParam, t),
                    projectProposalModel.getProjectHeadsGOSM(dbParam, t),
                    orgresModel.getOrgresOtherDetails(dbParam, t),
                    orgresModel.calculate_peractivity(dbParam, t)
                ]);
            }).then(data => {
                renderData.projectProposal = data[0];
                renderData.projectHeads = data[1];
                renderData.others = data[2];
                renderData.scores = data[3][0];

                res.render('Orgres/orgresSpecificActivity', renderData);
            }).catch(err => {
                return logger.error(`${err.message}: ${err.stack}`, log_options);
            });
        },

        apsReport: (req, res) => {
            var param = {
                org: req.session.user.organizationSelected.id
            };

            return database.task(t => {
                return t.batch([
                    projectProposalModel.getPendedPPRCountPerOrg(param, t),
                    projectProposalModel.getApprovedPPRCountPerOrg(param, t),
                    projectProposalModel.getDeniedPPRCountPerOrg(param, t),
                    projectProposalModel.getActivitiesRelatedToNatureCount(param, t),
                    projectProposalModel.getActivitiesNotRelatedToNatureCount(param, t),
                    projectProposalModel.getGOSMCountPerOrg(param, t)
                ]);
            }).then(data => {

                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                console.log(data[0]);
                console.log(data[1]);

                renderData.haspend = false;
                renderData.hasapproved = false;
                renderData.hasdenied = false;
                renderData.hasrelated = false;
                renderData.hasnorelated = false;
                renderData.hasgosm = false;

                if (data[0] == null) {
                    console.log("enter this");
                    renderData.pended = 0;
                } else {
                    renderData.haspend = true
                    renderData.pended = data[0];
                }

                if (data[1] == null) {
                    renderData.approved = 0;
                } else {
                    renderData.hasapproved = true
                    renderData.approved = data[1];
                }

                if (data[2] == null) {
                    renderData.denied = 0
                } else {
                    renderData.hasdenied = true
                    renderData.denied = data[2];
                }

                if (data[3] == null) {
                    renderData.related = 0
                } else {
                    renderData.hasrelated = true
                    renderData.related = data[3];
                }

                if (data[4] == null) {
                    renderData.norelated = 0
                } else {
                    renderData.hasnorelated = true
                    renderData.norelated = data[4];
                }

                if (data[5] == null) {
                    renderData.gosm = 0
                } else {
                    renderData.hasgosm = true
                    renderData.gosm = data[5];
                }

                return res.render('Org/apsreport', renderData);
            }).catch(err => {
                return logger.error(`${err.message}\n${err.stack}`);
            })
        }
    };
};