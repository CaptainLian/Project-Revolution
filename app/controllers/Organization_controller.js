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
    const amtModel = models.ActivityMonitoring_model;
    const financeModel = models.Finance_model;

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
            renderData.csrfToken = req.csrfToken();
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
            renderData.csrfToken = req.csrfToken();
            return res.render('Org/changePassword');
        },
        viewGradeList: (req, res) => {

            // checks if student and not cso
            if (req.session.user.type == 1 && req.session.user.organizationSelected.id != 0) {

                // Checks if user is president; only president can view in org side
                const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
                if(ACL[25]){
                    var organizationid = req.session.user.organizationSelected.id;
                    console.log(req.session.user.organizationSelected.id);
                }
                else{ // not president
                    res.redirect(`/System/NotAllowed`);
                    console.log("enterrrrrrrrrrrrrr hererererererererererererererererer");
                }
                
            }
            else{ // is cso; can view diff organization grades
                var organizationid = req.params.organizationId;
            }

            var dbParam = {
                studentorganization: organizationid
            }

            database.task(task => {
                return task.batch([        
                    organizationModel.getStudentOrganization(dbParam),
                    systemModel.getAllSchoolYear()
                ]);

            }).then(data=>{

                const renderData = Object.create(null);
                console.log(req.param)
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.studentorganization = data[0];
                renderData.schoolyear = data[1];
                return res.render('Org/gradeList', renderData);

            }).catch(error=>{
                console.log(error);
            })            

        },
        viewAmtEval: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            var dbParam = {
                gosmid: req.params.id
            };
            var dbParam2 = {
                gosmactivity: req.params.id
            };
            database.task(t=>{
                return t.batch([
                 pnpModel.getActivityDetailsforPubs(dbParam, t),
                 amtModel.viewAMTSpecificAct(req.params.id,t),
                 gosmModel.getGOSMActivityProjectHeads(dbParam2, t)
                 ])    
            }).then(data=>{
                console.log("data[1]")
                console.log(data[1])
                renderData.amt = data[1][0]
                renderData.activities = data[0];
                renderData.heads = data[2]
                return res.render('Org/viewAMTeval',renderData);
            }).catch(err=>{
                console.log(err)
            })
            
        },
        viewAmtEvalList: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            amtModel.viewOrgMyActivity(req.session.user.idNumber)
            .then(data=>{
                renderData.amt = data
                console.log("===============")
                console.log(data)
                return res.render('Org/viewAMTEvalList',renderData);
            }).catch(err=>{
                console.log(err)
            })
            
        },
        viewAddMember: (req, res) => {
            const renderData = Object.create(null);
            console.log(req.param)
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            organizationModel.viewMember(req.session.user.organizationSelected.id)
            .then(data=>{
                renderData.members = data
                return res.render('Org/addMembers',renderData);
            }).catch(err=>{
                console.log(err)
            })

        },

        viewReport: (req, res) => {

            // checks if student and not cso
            if (req.session.user.type == 1 && req.session.user.organizationSelected.id != 0) {

                // Checks if user is president; only president can view in org side
                const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
                if(ACL[25]){
                    var organizationid = req.session.user.organizationSelected.id;
                    console.log(req.session.user.organizationSelected.id);
                }
                else{ // not president
                    res.redirect(`/System/NotAllowed`);
                }
                
            }
            else{ // is cso; can view diff organization grades
                var organizationid = req.params.organizationId;
            }

            // if grade is per term
            if (req.params.syOrTerm == 1){


                var termParam = {
                    termid: req.params.syTermId
                }

                systemModel.getTermDetails(termParam)
                .then(term=>{

                    var dbParam = {
                        studentOrganization: organizationid,
                        termID: term.id
                    }

                    let termstart = term.dateStart;

                    console.log(dbParam);
                    console.log("DBPARAM+++++++++++++++++++++++++++++++++++++++++++++++++++++++");

                    database.task(task => {
                        return task.batch([
                            //APS AND ADM
                            projectProposalModel.getApprovedActivities(dbParam),
                            projectProposalModel.getAllProjectProposalPerTerm(dbParam),
                            gosmModel.getOrgGOSM(dbParam), 
                            postProjectProposalModel.getAllPostProjectProposalPerTerm(dbParam), 
                            //PNP
                            pnpModel.getAllActivityPublicityPerTerm(dbParam),
                            //ORGRES
                            orgresModel.getAllOfficerSurveyFormPerTerm(dbParam),
                            orgresModel.getAllMemberSurveyFormPerTerm(dbParam),
                            orgresModel.getAllActivityResearchFormPerTerm(dbParam),
                            organizationModel.getAllOrganizationMembersPerYear(dbParam),
                            //AMT
                            amtModel.getAllAMTEvaluationResults(dbParam),
                            amtModel.getAllAMTScoreAverages(dbParam),
                            //FINANCE
                            financeModel.getAllApprovedTransactions(dbParam),
                            financeModel.getAllApprovedActivityExpenses(dbParam),
                            financeModel.getOrganizationBudgetExpenses(dbParam),
                            financeModel.getOrgApprovedTransactions(dbParam),
                            //ACTIVITIES SUMMARY
                            gosmModel.getActivitySummaryPerOrg(dbParam)

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

                                var gosmdiff = timediff(termstart, orggosmsubmitted, 'D');

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

                                var diff = timediff(actualdatestart, datesigned, 'D');


                                if (diff.days<2){
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
                                data[0][i].isrelatedtoorganizationnature == true){
                                    isRelatedToOrganizationCount = isRelatedToOrganizationCount + 1;
                            }

                            if(data[0][i].studentorganization == organizationid){

                                preactsAllApprovedTotal = preactsAllApprovedTotal + 1;

                            }

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

                            if (data[3][i].studentorganization == organizationid) {

                                postactsTotalActivities = postactsTotalActivities + 1;

                                // if approved
                                if(data[3][i].status==4){

                                    postactsApprovedActivities = postactsApprovedActivities + 1;


                                    let actualdatestart = data[3][i].actualdatestart;
                                    let datesubmitted = data[3][i].datesubmitted;

                                    var diff = timediff(actualdatestart, datesubmitted, 'D');


                                    if (diff.days<30){
                                        postactsEarlyApprovedActivities = postactsEarlyApprovedActivities + 1;
                                    }
                                    else{
                                        postactsLateApprovedActivities = postactsLateApprovedActivities + 1;
                                    }

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

                        var documentationGrade = (preactsPunctualityGrade + preactsCompletenessGrade + preactsTimingRatioGrade
                                                    + gosmSubmissionGrade + sixtyFortyGrade + postactsPunctualityGrade
                                                    + postactsCompletenessGrade + pushedThroughGrade + notInGOSMGrade
                                                    + lasallianFormationComplianceGrade);

                        //pnp grade
                        var printedPoster = false;
                        var tickets = false;
                        var printedPublication = false;
                        var onlinePublication = false;
                        var printedPublicationCount = 0;
                        var onlinePublicationCount = 0;
                        var onlinePoster = false;

                        for (var i = 0; i < data[4].length; i++){

                            if (data[4][i].studentorganization == organizationid
                                && data[4][i].status == 1) {

                                if(data[4][i].modeOfDistribution == 1){

                                    printedPublication = true;

                                    printedPublicationCount = printedPublicationCount + 1;

                                    if(data[4][i].material == 5){
                                        printedPoster = true;
                                    }

                                }
                                else{

                                    onlinePublication = true;

                                    onlinePublicationCount = onlinePublicationCount + 1;

                                    if(data[4][i].material == 5){
                                        onlinePoster = true;
                                    }

                                }

                                if (data[4][i].material == 3) {
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

                        var pnpGrade = UniversityPublicityInstrumentGrade + NewsLettersPublicationsGrade + OnlinePublicityGrade;

                        //orgres grade

                        //officer survey form
                        var osfSurveyTotal = 0;
                        var osfField1 = 0;
                        var osfField2 = 0;
                        var osfField3 = 0;
                        var osfField4 = 0;
                        var osfField5 = 0;
                        var osfField6 = 0;
                        var osfField7 = 0;
                        var osfField8 = 0;
                        var osfField9 = 0;


                        for (var i = 0; i < data[5].length; i++){

                            if(data[5][i].organizationID == organizationid){

                                osfSurveyTotal = osfSurveyTotal + 1;

                                osfField1 = osfField1 + data[5][i].field1;
                                osfField2 = osfField2 + data[5][i].field2;
                                osfField3 = osfField3 + data[5][i].field3;
                                osfField4 = osfField4 + data[5][i].field4;
                                osfField5 = osfField5 + data[5][i].field5;
                                osfField6 = osfField6 + data[5][i].field6;
                                osfField7 = osfField7 + data[5][i].field7;
                                osfField8 = osfField8 + data[5][i].field8;
                                osfField9 = osfField9 + data[5][i].field9;


                            }


                        }

                        var osfField1Average = osfField1/osfSurveyTotal;
                        var osfField2Average = osfField2/osfSurveyTotal;
                        var osfField3Average = osfField3/osfSurveyTotal;
                        var osfField4Average = osfField4/osfSurveyTotal;
                        var osfField5Average = osfField5/osfSurveyTotal;
                        var osfField6Average = osfField6/osfSurveyTotal;
                        var osfField7Average = osfField7/osfSurveyTotal;
                        var osfField8Average = osfField8/osfSurveyTotal;
                        var osfField9Average = osfField9/osfSurveyTotal;

                        if(osfSurveyTotal == 0){
                            osfField1Average = 0;
                            osfField2Average = 0;
                            osfField3Average = 0;
                            osfField4Average = 0;
                            osfField5Average = 0;
                            osfField6Average = 0;
                            osfField7Average = 0;
                            osfField8Average = 0;
                            osfField9Average = 0;
                        }

                        //member survey form

                        var msfSurveyTotal = 0;
                        var msfField1 = 0;
                        var msfField2 = 0;
                        var msfField3 = 0;
                        var msfField4 = 0;
                        var msfField5 = 0;
                        var msfField6 = 0;
                        var msfField7 = 0;
                        var msfField8 = 0;
                        var msfField9 = 0;
                        var msfField10 = 0;
                        var msfField11 = 0;
                        var msfField12 = 0;
                        var msfField13 = 0;


                        for (var i = 0; i < data[6].length; i++){

                            if(data[6][i].organizationID == organizationid){

                                msfSurveyTotal = msfSurveyTotal + 1;

                                msfField1 = msfField1 + data[6][i].field1;
                                msfField2 = msfField2 + data[6][i].field2;
                                msfField3 = msfField3 + data[6][i].field3;
                                msfField4 = msfField4 + data[6][i].field4;
                                msfField5 = msfField5 + data[6][i].field5;
                                msfField6 = msfField6 + data[6][i].field6;
                                msfField7 = msfField7 + data[6][i].field7;
                                msfField8 = msfField8 + data[6][i].field8;
                                msfField9 = msfField9 + data[6][i].field9;
                                msfField10 = msfField10 + data[6][i].field10;
                                msfField11 = msfField11 + data[6][i].field11;
                                msfField12 = msfField12 + data[6][i].field12;
                                msfField13 = msfField13 + data[6][i].field13;


                            }


                        }

                        var msfField1Average = msfField1/msfSurveyTotal;
                        var msfField2Average = msfField2/msfSurveyTotal;
                        var msfField3Average = msfField3/msfSurveyTotal;
                        var msfField4Average = msfField4/msfSurveyTotal;
                        var msfField5Average = msfField5/msfSurveyTotal;
                        var msfField6Average = msfField6/msfSurveyTotal;
                        var msfField7Average = msfField7/msfSurveyTotal;
                        var msfField8Average = msfField8/msfSurveyTotal;
                        var msfField9Average = msfField9/msfSurveyTotal;
                        var msfField10Average = msfField10/msfSurveyTotal;
                        var msfField11Average = msfField11/msfSurveyTotal;
                        var msfField12Average = msfField12/msfSurveyTotal;
                        var msfField13Average = msfField13/msfSurveyTotal;

                        if(msfSurveyTotal == 0){
                            msfField1Average = 0;
                            msfField2Average = 0;
                            msfField3Average = 0;
                            msfField4Average = 0;
                            msfField5Average = 0;
                            msfField6Average = 0;
                            msfField7Average = 0;
                            msfField8Average = 0;
                            msfField9Average = 0;
                            msfField10Average = 0;
                            msfField11Average = 0;
                            msfField12Average = 0;
                            msfField13Average = 0;
                        }

                        //activity research form

                        var arfSurveyTotal = 0;
                        var arfField1 = 0;
                        var arfField2 = 0;
                        var arfField3 = 0;
                        var arfField4 = 0;
                        var arfField5 = 0;
                        var arfField6 = 0;
                        var arfField7 = 0;


                        var orgresActivityId = 0;
                        var orgresActivityCount = 0;
                        var orgresParticipantCount = 0;
                        for (var i = 0; i < data[7].length; i++){

                            if(data[7][i].organizationID == organizationid){

                                arfSurveyTotal = arfSurveyTotal + 1;

                                arfField1 = arfField1 + data[7][i].IUTPOTA;
                                arfField2 = arfField2 + data[7][i].TASMI;
                                arfField3 = arfField3 + data[7][i].IFIDTA;
                                arfField4 = arfField4 + data[7][i].TAWWP;
                                arfField5 = arfField5 + data[7][i].TOUMTGTTA;
                                arfField6 = arfField6 + data[7][i].field6;
                                arfField7 = arfField7 + data[7][i].field7;




                            }


                        }

                        var arfField1Average = arfField1/arfSurveyTotal;
                        var arfField2Average = arfField2/arfSurveyTotal;
                        var arfField3Average = arfField3/arfSurveyTotal;
                        var arfField4Average = arfField4/arfSurveyTotal;
                        var arfField5Average = arfField5/arfSurveyTotal;
                        var arfField6Average = arfField6/arfSurveyTotal;
                        var arfField7Average = arfField7/arfSurveyTotal;

                        if (arfSurveyTotal == 0){
                            arfField1Average = 0;
                            arfField2Average = 0;
                            arfField3Average = 0;
                            arfField4Average = 0;
                            arfField5Average = 0;
                            arfField6Average = 0;
                            arfField7Average = 0;
                        }

                        //orgres organization members count

                        var totalOrganizationMembers = 0;

                        for(var i = 0; i < data[8].length; i++){

                            if (data[8][i].organization == organizationid){

                                totalOrganizationMembers = totalOrganizationMembers + 1;
                            }


                        }

                        // orgres purpose

                        var purpose1 = ((msfField1Average/5)*100)*0.04;
                        var purpose2 = ((((arfField1Average + msfField2Average)/2)/5)*100)*0.02;
                        var purpose3 = ((((arfField2Average + msfField3Average + msfField4Average)/3)/5)*100)*0.04;

                        var orgresPurposeGrade = purpose1 + purpose2 + purpose3;


                        // orgres involvement

                        var involvement1 = ((msfSurveyTotal/totalOrganizationMembers)*100)*0.045;

                        if(totalOrganizationMembers == 0){
                            involvement1 = 0;
                        }

                        var involvement2 = ((((arfField3Average + msfField5Average + msfField6Average)/3)/5)*100)*0.06;
                        var involvement3 = ((((arfField4Average + msfField7Average)/2)/5)*100)*0.045;

                        var orgresInvolvementGrade = involvement1 + involvement2 + involvement3;

                        // orgres quality

                        var quality1 = ((msfField8Average/5)*100)*0.0225;
                        var quality2 = ((((msfField9Average + msfField10Average)/2)/5)*100)*0.015;
                        var quality3 = ((arfField5Average/5)*100)*0.0225;
                        var quality4 = ((((arfField6Average + msfField11Average)/2)/5)*100)*0.0225;
                        var quality5 = ((((arfField7Average + msfField12Average)/2)/5)*100)*0.015;

                        var orgresQualityGrade = quality1 + quality2 + quality3 + quality4 + quality5;


                        //orgres leadership grade

                        var leadership1 = ((((osfField1Average + osfField2Average)/2)/5)*100)*0.0015;
                        var leadership2 = ((osfField3Average/5)*100)*0.0008;
                        var leadership3 = ((osfField4Average/5)*100)*0.01;
                        var leadership4 = ((osfField5Average/5)*100)*0.0015;
                        var leadership5 = ((msfField13Average/5)*100)*0.0015;
                        var leadership6 = ((((osfField6Average + osfField7Average)/2)/5)*100)*0.0045;
                        var leadership7 = ((osfField8Average/5)*100)*0.003;
                        var leadership8 = ((osfField9Average/5)*100)*0.0015;
                        var leadership9 = 0.3;//0.003*100

                        var orgresLeadershipGrade = leadership1 + leadership2 + leadership3 + leadership4 + leadership5 + leadership6 + leadership7 + leadership8 + leadership9;

                        var orgresGrade = orgresPurposeGrade + orgresInvolvementGrade + orgresQualityGrade + orgresLeadershipGrade;

                        // amt grade
                        var totalAMTEvaluations = data[9].length;
                        var totalAMTEvaluationScore = 0;

                        for (var i = 0; i < data[9].length; i++){

                            totalAMTEvaluationScore = totalAMTEvaluationScore + data[9][i].amtgrade

                        }

                        var amtScore = totalAMTEvaluationScore/totalAMTEvaluations;

                        if (totalAMTEvaluations == 0){

                            amtScore = 0;

                        }
                        var amtGrade = amtScore*0.0375;

                        //finance grade

                        var onTimeTransaction = 0;
                        var totalApprovedTransaction = 0;
                        var approvedParticulars = 0;
                        var onBudgetActivities = 0;
                        var totalFinanceActivities = 0;
                        var relatedExpense = 0;
                        var totalExpense = 0;
                        var totalActivityBudget = 0

                        // approved transactions
                        for (var i = 0; i < data[11].length; i++){

                            let financesign = data[11][i].datesigned;
                            let activitystart = data[11][i].datestart

                            var budgetdiff = timediff(financesign, activitystart, 'D');

                            if(budgetdiff.days <= 3){
                                onTimeTransaction = onTimeTransaction + 1;
                            }

                            approvedParticulars = approvedParticulars + data[11][i].particulars;

                            totalApprovedTransaction = totalApprovedTransaction + 1;

                        }

                        // approved expenses(particulars)
                        for(var i = 0; i < data[12].length; i++){

                            if (data[12][i].expenses <= data[12][i].budget) {
                                onBudgetActivities = onBudgetActivities + 1;
                            }

                            totalFinanceActivities = totalFinanceActivities + 1;

                            if (data[12][i].isrelatedtoorganizationnature == true){
                                relatedExpense = relatedExpense + data[12][i].expenses;
                            }

                            totalExpense = totalExpense + data[12][i].expenses;

                            totalActivityBudget = totalActivityBudget + data[12][i].budget;

                        }

                        if(data[13]==null){
                            console.log("itssssssssssss empty------------------------------------------------------------")
                            var totalParticulars = 0;
                            var operationalfunds = 0;
                            var depositoryfunds = 0;
                        }
                        else {
                            var totalParticulars = data[13].particulars;
                            var operationalfunds = data[13].operationalfunds;
                            var depositoryfunds = data[13].depositoryfunds;
                        }


                        // finance monitoring grade

                        var tempMonitoring1 = ((onTimeTransaction/totalApprovedTransaction)*100);//*0.01;

                        if (tempMonitoring1 >= 98){
                            var monitoring1 = 1;
                        }
                        else if (tempMonitoring1 >= 95) {
                            var monitoring1 = 0.95;
                        }
                        else if (tempMonitoring1 >= 92) {
                            var monitoring1 = 0.9;
                        }
                        else if (tempMonitoring1 >= 89) {
                            var monitoring1 = 0.85;
                        }
                        else if (tempMonitoring1 >= 86) {
                            var monitoring1 = 0.8;
                        }
                        else if (tempMonitoring1 >= 83) {
                            var monitoring1 = 0.75;
                        }
                        else if (tempMonitoring1 >= 80) {
                            var monitoring1 = 0.7;
                        }
                        else if (tempMonitoring1 >= 77) {
                            var monitoring1 = 0.65;
                        }
                        else if (tempMonitoring1 >= 74) {
                            var monitoring1 = 0.6;
                        }
                        else if (tempMonitoring1 >= 71) {
                            var monitoring1 = 0.55;
                        }
                        else{
                            var monitoring1 = 0.5;
                        }

                        var tempMonitoring2 = ((approvedParticulars/totalParticulars)*100);//0.005;

                        if (tempMonitoring2 >= 98){
                            var monitoring2 = 0.5;
                        }
                        else if (tempMonitoring2 >= 95) {
                            var monitoring2 = 0.475;
                        }
                        else if (tempMonitoring2 >= 92) {
                            var monitoring2 = 0.45;
                        }
                        else if (tempMonitoring2 >= 89) {
                            var monitoring2 = 0.425;
                        }
                        else if (tempMonitoring2 >= 86) {
                            var monitoring2 = 0.4;
                        }
                        else if (tempMonitoring2 >= 83) {
                            var monitoring2 = 0.375;
                        }
                        else if (tempMonitoring2 >= 80) {
                            var monitoring2 = 0.35;
                        }
                        else if (tempMonitoring2 >= 77) {
                            var monitoring2 = 0.325;
                        }
                        else if (tempMonitoring2 >= 74) {
                            var monitoring2 = 0.3;
                        }
                        else if (tempMonitoring2 >= 71) {
                            var monitoring2 = 0.275;
                        }
                        else if (tempMonitoring2 >= 68) {
                            var monitoring2 = 0.25;
                        }
                        else if (tempMonitoring2 >= 65) {
                            var monitoring2 = 0.225;
                        }
                        else{
                            var monitoring2 = 0.2;
                        }

                        var monitoring3 = 1;
                        var tempMonitoring45 = ((Math.abs(totalExpense-totalActivityBudget))/totalActivityBudget)*100;

                        if(tempMonitoring45 >= 90 && tempMonitoring45 <=110){
                            var monitoring4 = 1.5;
                        }
                        else if(tempMonitoring45 >= 75 && tempMonitoring45 <= 125){
                            var monitoring4 = 1.35;
                        }
                        else{
                            var monitoring4 = 1.2;
                        }

                        if(tempMonitoring45 >= 90 && tempMonitoring45 <= 110){
                            var monitoring5 = 1;
                        }
                        else if(tempMonitoring45 >= 85 && tempMonitoring45 <=115){
                            var monitoring5 = 0.9;
                        }
                        else if(tempMonitoring45 >= 81 && tempMonitoring45 <=120){
                            var monitoring5 = 0.8;
                        }
                        else if(tempMonitoring45 >= 75 && tempMonitoring45 <= 125){
                            var monitoring5 = 0.7;
                        }
                        else{
                            var monitoring5 = 0.6;
                        }

                        // finance generation grade

                        var generation1 = 0;
                        var generation2 = 0;

                        // finance allocation grade

                        var tempAllocation1 = ((onBudgetActivities/totalFinanceActivities)*100);//*0.01;

                        if(tempAllocation1 >= 85){
                            var allocation1 = 1;
                        }
                        else if(tempAllocation1 >= 80){
                            var allocation1 = 0.95;
                        }
                        else if(tempAllocation1 >= 75){
                            var allocation1 = 0.9;
                        }
                        else if(tempAllocation1 >= 70){
                            var allocation1 = 0.85;
                        }
                        else if(tempAllocation1 >= 65){
                            var allocation1 = 0.8;
                        }
                        else if(tempAllocation1 >= 60){
                            var allocation1 = 0.75;
                        }
                        else if(tempAllocation1 >= 55){
                            var allocation1 = 0.7;
                        }
                        else if(tempAllocation1 >= 50){
                            var allocation1 = 0.65;
                        }
                        else{
                            var allocation1 = 0.6;
                        }

                        var tempAllocation2 = Math.abs(60-((relatedExpense/totalExpense)*100));

                        if(tempAllocation2 <= 10){
                            var allocation2 = 1;
                        }
                        else if(tempAllocation2 <=20.99){
                            var allocation2 = 0.9;
                        }
                        else if(tempAllocation2 <= 30){
                            var allocation2 = 0.85;
                        }
                        else{
                            var allocation2 = 0.75;
                        }



                        var tempAllocation3 = ((depositoryfunds-totalExpense)/depositoryfunds)*100;

                        if(tempAllocation3 >= 100){
                            var Allocation3 = 1;
                        }
                        else if(tempAllocation3 >= 90){
                            var Allocation3 = 0.9;
                        }
                        else if(tempAllocation3 >= 80){
                            var Allocation3 = 0.8;
                        }
                        else if(tempAllocation3 >= 70){
                            var Allocation3 = 0.75;
                        }
                        else if(tempAllocation3 >= 60){
                            var Allocation3 = 0.7;
                        }
                        else{
                            var Allocation3 = 0.6;
                        }

                        var financeMonitoringGrade = monitoring1 + monitoring2 + monitoring3 + monitoring4 + monitoring5;
                        var financeGenerationGrade = generation1 + generation2;
                        var financeAllocationGrade = allocation1 + allocation2 + Allocation3;

                        var financeGrade = financeMonitoringGrade + financeGenerationGrade + financeAllocationGrade;



                        // render data grades
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

                        renderData.sixty = isRelatedToOrganizationCount;
                        renderData.forty = preactsAllApprovedTotal-isRelatedToOrganizationCount;
                        renderData.push = preactsApprovedActivities;
                        renderData.notPush = totalActivities-preactsApprovedActivities;

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

                        renderData.documentationGrade = documentationGrade;

                        //orgres
                        renderData.orgresPurposeGrade = orgresPurposeGrade;
                        renderData.orgresInvolvementGrade = orgresInvolvementGrade;
                        renderData.orgresQualityGrade = orgresQualityGrade;
                        renderData.orgresLeadershipGrade = orgresLeadershipGrade;
                        renderData.orgresGrade = orgresGrade;

                        renderData.osfField1Average = osfField1Average;
                        renderData.osfField2Average = osfField2Average;
                        renderData.osfField3Average = osfField3Average;
                        renderData.osfField4Average = osfField4Average;
                        renderData.osfField5Average = osfField5Average;
                        renderData.osfField6Average = osfField6Average;
                        renderData.osfField7Average = osfField7Average;
                        renderData.osfField8Average = osfField8Average;
                        renderData.osfField9Average = osfField9Average;

                        renderData.msfField1Average = msfField1Average;
                        renderData.msfField2Average = msfField2Average;
                        renderData.msfField3Average = msfField3Average;
                        renderData.msfField4Average = msfField4Average;
                        renderData.msfField5Average = msfField5Average;
                        renderData.msfField6Average = msfField6Average;
                        renderData.msfField7Average = msfField7Average;
                        renderData.msfField8Average = msfField8Average;
                        renderData.msfField9Average = msfField9Average;
                        renderData.msfField10Average = msfField10Average;
                        renderData.msfField11Average = msfField11Average;
                        renderData.msfField12Average = msfField12Average;
                        renderData.msfField13Average = msfField13Average;


                        //documentation info
                        renderData.sixtyCount = isRelatedToOrganizationCount;
                        renderData.fortyCount = preactsAllApprovedTotal;

                        renderData.numCompetition = data[15][0].activitycount;
                        renderData.numDistribution = data[15][1].activitycount;
                        renderData.numGeneralAssembly = data[15][2].activitycount;
                        renderData.numSeminar = data[15][3].activitycount;
                        renderData.numPublicity = data[15][4].activitycount;
                        renderData.numMeetings = data[15][5].activitycount;
                        renderData.numSpiritualActivity = data[15][6].activitycount;
                        renderData.numRecruitment = data[15][7].activitycount;
                        renderData.numRecreation = data[15][8].activitycount;
                        renderData.numOthers = data[15][9].activitycount;


                        //pnp
                        renderData.universityPublicityInstrumentGrade = UniversityPublicityInstrumentGrade;
                        renderData.newsLettersPublicationsGrade = NewsLettersPublicationsGrade;
                        renderData.onlinePublicityGrade = OnlinePublicityGrade;
                        renderData.pnpCompliance = 0.3;
                        renderData.pnpGrade = pnpGrade + 0.3;

                        //amt
                        renderData.amtActivities = data[9];
                        renderData.amtAverageScores = data[10];
                        renderData.amtAverageScores2 = data[10];
                        renderData.amtAverageScores3 = data[10];
                        renderData.amtScore = amtScore;
                        renderData.amtGrade = amtGrade;

                        //finance
                        renderData.financeMonitoringGrade = financeMonitoringGrade;
                        renderData.financeGenerationGrade = financeGenerationGrade;
                        renderData.financeAllocationGrade = financeAllocationGrade;
                        renderData.financeGrade = financeGrade

                        renderData.financeTransactions = data[14];

                        renderData.gradeType = false;

                        var organizationParam = {
                            studentorganization: organizationid
                        };

                        organizationModel.getStudentOrganization(organizationParam)
                        .then(organizationData=>{

                            renderData.organization = organizationData;
                            renderData.term = term;
                            console.log(renderData);
                            renderData.extra_data = req.extra_data;
                            renderData.csrfToken = req.csrfToken();
                            return res.render('Org/report', renderData);

                        }).catch(error=>{
                            console.log(error);
                        })
                        


                    }).catch(error=>{
                        console.log(error);
                    });



                }).catch(error=>{
                    console.log(error);
                });

            }
            else if(req.params.syOrTerm == 2){

                var yearParam = {
                    yearid: req.params.syTermId
                }

                systemModel.getSchoolYearTerms(yearParam)
                .then(term=>{

                    var dbParam1 = {
                        studentOrganization: organizationid,
                        termID: term[0].id
                    }

                    var dbParam2 = {
                        studentOrganization: organizationid,
                        termID: term[1].id
                    }

                    var dbParam3 = {
                        studentOrganization: organizationid,
                        termID: term[2].id
                    }

                    let termstart1 = term[0].dateStart;
                    let termstart2 = term[1].dateStart;
                    let termstart3 = term[2].dateStart;


                    database.task(task => {
                        return task.batch([
                            //TERM 1
                            //APS AND ADM
                            projectProposalModel.getApprovedActivities(dbParam1),
                            projectProposalModel.getAllProjectProposalPerTerm(dbParam1),
                            gosmModel.getOrgGOSM(dbParam1), 
                            postProjectProposalModel.getAllPostProjectProposalPerTerm(dbParam1), 
                            //PNP
                            pnpModel.getAllActivityPublicityPerTerm(dbParam1),
                            //ORGRES
                            orgresModel.getAllOfficerSurveyFormPerTerm(dbParam1),
                            orgresModel.getAllMemberSurveyFormPerTerm(dbParam1),
                            orgresModel.getAllActivityResearchFormPerTerm(dbParam1),
                            organizationModel.getAllOrganizationMembersPerYear(dbParam1),
                            //AMT
                            amtModel.getAllAMTEvaluationResults(dbParam1),
                            amtModel.getAllAMTScoreAverages(dbParam1),
                            //FINANCE
                            financeModel.getAllApprovedTransactions(dbParam1),
                            financeModel.getAllApprovedActivityExpenses(dbParam1),
                            financeModel.getOrganizationBudgetExpenses(dbParam1),
                            financeModel.getOrgApprovedTransactions(dbParam1),
                            //ACTIVITIES SUMMARY
                            gosmModel.getActivitySummaryPerOrg(dbParam1), //15

                            //TERM 2
                            //APS AND ADM
                            projectProposalModel.getApprovedActivities(dbParam2), //16
                            projectProposalModel.getAllProjectProposalPerTerm(dbParam2),
                            gosmModel.getOrgGOSM(dbParam2), 
                            postProjectProposalModel.getAllPostProjectProposalPerTerm(dbParam2), 
                            //PNP
                            pnpModel.getAllActivityPublicityPerTerm(dbParam2),
                            //ORGRES
                            orgresModel.getAllOfficerSurveyFormPerTerm(dbParam2),
                            orgresModel.getAllMemberSurveyFormPerTerm(dbParam2),
                            orgresModel.getAllActivityResearchFormPerTerm(dbParam2),
                            organizationModel.getAllOrganizationMembersPerYear(dbParam2),
                            //AMT
                            amtModel.getAllAMTEvaluationResults(dbParam2),
                            amtModel.getAllAMTScoreAverages(dbParam2),
                            //FINANCE
                            financeModel.getAllApprovedTransactions(dbParam2),
                            financeModel.getAllApprovedActivityExpenses(dbParam2),
                            financeModel.getOrganizationBudgetExpenses(dbParam2),
                            financeModel.getOrgApprovedTransactions(dbParam2),
                            //ACTIVITIES SUMMARY
                            gosmModel.getActivitySummaryPerOrg(dbParam2), //31

                            //TERM 3
                            //APS AND ADM
                            projectProposalModel.getApprovedActivities(dbParam3), //32
                            projectProposalModel.getAllProjectProposalPerTerm(dbParam3),
                            gosmModel.getOrgGOSM(dbParam3), 
                            postProjectProposalModel.getAllPostProjectProposalPerTerm(dbParam3), 
                            //PNP
                            pnpModel.getAllActivityPublicityPerTerm(dbParam3),
                            //ORGRES
                            orgresModel.getAllOfficerSurveyFormPerTerm(dbParam3),
                            orgresModel.getAllMemberSurveyFormPerTerm(dbParam3),
                            orgresModel.getAllActivityResearchFormPerTerm(dbParam3),
                            organizationModel.getAllOrganizationMembersPerYear(dbParam3),
                            //AMT
                            amtModel.getAllAMTEvaluationResults(dbParam3),
                            amtModel.getAllAMTScoreAverages(dbParam3),
                            //FINANCE
                            financeModel.getAllApprovedTransactions(dbParam3),
                            financeModel.getAllApprovedActivityExpenses(dbParam3),
                            financeModel.getOrganizationBudgetExpenses(dbParam3),
                            financeModel.getOrgApprovedTransactions(dbParam3),
                            //ACTIVITIES SUMMARY
                            gosmModel.getActivitySummaryPerOrg(dbParam3)

                        ]);
                    }).then(data=>{

                        // TERM1
                        // preacts grade
                        var preactsApprovedActivities1 = 0;
                        var preactsEarlyApprovedActivities1 = 0;
                        var preactsLateApprovedActivities1 = 0;
                        var preactsDeniedActivities1 = 0;
                        var totalActivities1 = 0;
                        var preactsTimingRatio1 = 0;
                        var preactsPendCount1 = 0;
                        var gosmSubmissionGrade1 = 0;
                        var isRelatedToOrganizationCount1 = 0;
                        var sixtyFortyGrade1 = 0;
                        var preactsAllApprovedTotal1 = 0;
                        var notInGOSM1 = false;
                        var lasallianFormationCompliance1 = false;


                        if(data[2] != null){
                            if(data[2].orggosmsubmitted == null){
                            }
                            else{
                                let orggosmsubmitted1 = data[2].orggosmsubmitted;

                                var gosmdiff1 = timediff(termstart1, orggosmsubmitted1, 'D');

                                if(gosmdiff1.days <= 14){
                                    gosmSubmissionGrade1 = 0.075;
                                }
                            }
                        }

                        //approved activities
                        for(var i = 0; data[0].length > i; i++){

                            if(data[0][i].studentorganization == organizationid &&
                                data[0][i].isingosm == true){

                                preactsApprovedActivities1 = preactsApprovedActivities1 + 1;

                                if(data[0][i].activitynature == 8){
                                    lasallianFormationCompliance1 = true
                                }


                                let actualdatestart1 = data[0][i].actualdatestart;
                                let datesigned1 = data[0][i].datesigned;
                                let targetdatestart1 = data[0][i].targetdatestart;

                                var diff1 = timediff(actualdatestart1, datesigned1, 'D');


                                if (diff1.days<2){
                                    preactsEarlyApprovedActivities1 = preactsEarlyApprovedActivities1 + 1;
                                }
                                else{
                                    preactsLateApprovedActivities1 = preactsLateApprovedActivities1 + 1;
                                }

                                var timingdiff1 = timediff(targetdatestart1, actualdatestart1, 'D');

                                if (timingdiff1.days < 7 && timingdiff1.days > -7){
                                    preactsTimingRatio1 = preactsTimingRatio1 + 1;
                                }

                            }

                            if(data[0][i].studentorganization == organizationid &&
                                data[0][i].isrelatedtoorganizationnature == true){
                                    isRelatedToOrganizationCount1 = isRelatedToOrganizationCount1 + 1;
                            }

                            if(data[0][i].studentorganization == organizationid){

                                preactsAllApprovedTotal1 = preactsAllApprovedTotal1 + 1;

                            }

                        }

                        // all activities
                        for (var i = 0; data[1].length > i; i++){

                            //TODO: change depending on org??
                            if(data[1][i].studentorganization == organizationid &&
                                data[1][i].isingosm == true){

                                totalActivities1 = totalActivities1 + 1;

                                preactsPendCount1 = preactsPendCount1 + data[1][i].timespended;


                                if(data[1][i].status==5){
                                    preactsDeniedActivities1 = preactsDeniedActivities1 + 1;
                                }

                            }
                            else if(data[1][i].studentorganization == organizationid &&
                                data[1][i].isingosm == false){

                                notInGOSM1 = true;

                            }

                        }

                        var preactsPunctualityGrade1 = ((((parseFloat(preactsEarlyApprovedActivities1)/parseFloat(preactsApprovedActivities1))*100)-parseFloat(preactsDeniedActivities1))*0.025);
                        var preactsTimingRatioGrade1 = (((parseFloat(preactsTimingRatio1)/parseFloat(totalActivities1))*100)*0.015);
                        var preactsCompletenessGrade1 = (100 - (parseFloat(preactsPendCount1)*0.5))*0.025;

                        var sixtyFortyRatioPercentage1 = isRelatedToOrganizationCount1/preactsAllApprovedTotal1;


                        if (preactsApprovedActivities1 == 0){
                            preactsPunctualityGrade1 = 0;
                        }

                        if (preactsAllApprovedTotal1 == 0){
                            sixtyFortyRatioPercentage1 = 0;
                        }


                        var sixFourGradeRange1 = 0

                        var sixtyFortyGradeFound1 = true;

                        var gradeStart1 = 57;
                        var gradeEnd1 = 63;

                        while(sixtyFortyGradeFound1){

                            if(sixtyFortyRatioPercentage1 >= gradeStart1 && sixtyFortyRatioPercentage1 <= gradeEnd1){

                                sixtyFortyGradeFound1 = false;

                            }
                            else{
                                sixFourGradeRange1 = sixFourGradeRange1 + 1;
                                gradeStart1 = gradeStart1 - 4;
                                gradeEnd1 = gradeEnd1 + 4;
                            }

                        }

                        var sixtyFortyGrade1 = (100-(parseFloat(sixFourGradeRange1)*4))*0.10;


                        //postacts grade
                        var postactsEarlyApprovedActivities1 = 0;
                        var postactsTotalActivities1 = 0;
                        var postactsApprovedActivities1 = 0;
                        var postactsLateApprovedActivities1 = 0;

                        for (var i = 0; i < data[3].length; i++){

                            if (data[3][i].studentorganization == organizationid) {

                                postactsTotalActivities1 = postactsTotalActivities1 + 1;

                                // if approved
                                if(data[3][i].status==4){

                                    postactsApprovedActivities1 = postactsApprovedActivities1 + 1;


                                    let actualdatestart1 = data[3][i].actualdatestart;
                                    let datesubmitted1 = data[3][i].datesubmitted;

                                    var diff1 = timediff(actualdatestart1, datesubmitted1, 'D');


                                    if (diff1.days<30){
                                        postactsEarlyApprovedActivities1 = postactsEarlyApprovedActivities1 + 1;
                                    }
                                    else{
                                        postactsLateApprovedActivities1 = postactsLateApprovedActivities1 + 1;
                                    }

                                }


                            }


                        }

                        var postactsPunctualityGrade1 = ((((parseFloat(postactsEarlyApprovedActivities1)/parseFloat(postactsApprovedActivities1))*100)-parseFloat(preactsDeniedActivities1))*0.025);
                        var postactsCompletenessGrade1 = ((parseFloat(postactsApprovedActivities1)/parseFloat(preactsApprovedActivities1))*100)*0.025;

                        if(postactsApprovedActivities1 == 0){
                            postactsPunctualityGrade1 =0;
                        }

                        if(preactsApprovedActivities1 ==0){
                            postactsCompletenessGrade1 = 0;
                        }

                        var pushedThroughGrade1 = ((parseFloat(preactsApprovedActivities1)/parseFloat(totalActivities1))*100)*0.0015;

                        if(totalActivities1 == 0){

                            preactsTimingRatioGrade1 = 0;
                            pushedThroughGrade1 = 0;

                        }

                        if(notInGOSM1){

                            var notInGOSMGrade1 = 0.15;

                        }
                        else{

                            var notInGOSMGrade1 = 0;

                        }

                        if(lasallianFormationCompliance1){
                            var lasallianFormationComplianceGrade1 = 6;
                        }
                        else{
                            var lasallianFormationComplianceGrade1 = 0;
                        }

                        var documentationGrade1 = (preactsPunctualityGrade1 + preactsCompletenessGrade1 + preactsTimingRatioGrade1
                                                    + gosmSubmissionGrade1 + sixtyFortyGrade1 + postactsPunctualityGrade1
                                                    + postactsCompletenessGrade1 + pushedThroughGrade1 + notInGOSMGrade1
                                                    + lasallianFormationComplianceGrade1);

                        //pnp grade
                        var printedPoster1 = false;
                        var tickets1 = false;
                        var printedPublication1 = false;
                        var onlinePublication1 = false;
                        var printedPublicationCount1 = 0;
                        var onlinePublicationCount1 = 0;
                        var onlinePoster1 = false;

                        for (var i = 0; i < data[4].length; i++){

                            if (data[4][i].studentorganization == organizationid
                                && data[4][i].status == 1) {

                                if(data[4][i].modeOfDistribution == 1){

                                    printedPublication1 = true;

                                    printedPublicationCount1 = printedPublicationCount1 + 1;

                                    if(data[4][i].material == 5){
                                        printedPoster1 = true;
                                    }

                                }
                                else{

                                    onlinePublication1 = true;

                                    onlinePublicationCount1 = onlinePublicationCount1 + 1;

                                    if(data[4][i].material == 5){
                                        onlinePoster1 = true;
                                    }

                                }

                                if (data[4][i].material == 3) {
                                    tickets1 = true;
                                }

                            }

                        }


                        var UniversityPublicityInstrumentGrade1 = 0;
                        var NewsLettersPublicationsGrade1 = 0;
                        var OnlinePublicityGrade1 = 0;


                        if (printedPoster1) {
                            UniversityPublicityInstrumentGrade1 = UniversityPublicityInstrumentGrade1 + 0.5;
                        }

                        if (tickets1) {
                            UniversityPublicityInstrumentGrade1 = UniversityPublicityInstrumentGrade1 + 0.7;
                        }

                        if (printedPublication1) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.35;
                        }

                        if(onlinePublication1) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.35;
                        }

                        if (printedPublicationCount1 == 1) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.05;
                        }
                        else if (printedPublicationCount1 == 2) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.1;
                        }
                        else if (printedPublicationCount1 >= 3) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.15;
                        }

                        if(onlinePublicationCount1 == 1){
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.0375;
                        }
                        else if (onlinePublicationCount1 == 2) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.075;
                        }
                        else if (onlinePublicationCount1 == 3){
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.1125;
                        }
                        else if (onlinePublicationCount1 >= 4) {
                            NewsLettersPublicationsGrade1 = NewsLettersPublicationsGrade1 + 0.15;
                        }

                        if (onlinePoster1) {
                            OnlinePublicityGrade1 = OnlinePublicityGrade1 + 1.5;
                        }

                        var pnpGrade1 = UniversityPublicityInstrumentGrade1 + NewsLettersPublicationsGrade1 + OnlinePublicityGrade1;

                        //orgres grade

                        //officer survey form
                        var osfSurveyTotal1 = 0;
                        var osfField11 = 0;
                        var osfField21 = 0;
                        var osfField31 = 0;
                        var osfField41 = 0;
                        var osfField51 = 0;
                        var osfField61 = 0;
                        var osfField71 = 0;
                        var osfField81 = 0;
                        var osfField91 = 0;


                        for (var i = 0; i < data[5].length; i++){

                            if(data[5][i].organizationID == organizationid){

                                osfSurveyTotal1 = osfSurveyTotal1 + 1;

                                osfField11 = osfField11 + data[5][i].field1;
                                osfField21 = osfField21 + data[5][i].field2;
                                osfField31 = osfField31 + data[5][i].field3;
                                osfField41 = osfField41 + data[5][i].field4;
                                osfField51 = osfField51 + data[5][i].field5;
                                osfField61 = osfField61 + data[5][i].field6;
                                osfField71 = osfField71 + data[5][i].field7;
                                osfField81 = osfField81 + data[5][i].field8;
                                osfField91 = osfField91 + data[5][i].field9;


                            }


                        }

                        var osfField1Average1 = osfField11/osfSurveyTotal1;
                        var osfField2Average1 = osfField21/osfSurveyTotal1;
                        var osfField3Average1 = osfField31/osfSurveyTotal1;
                        var osfField4Average1 = osfField41/osfSurveyTotal1;
                        var osfField5Average1 = osfField51/osfSurveyTotal1;
                        var osfField6Average1 = osfField61/osfSurveyTotal1;
                        var osfField7Average1 = osfField71/osfSurveyTotal1;
                        var osfField8Average1 = osfField81/osfSurveyTotal1;
                        var osfField9Average1 = osfField91/osfSurveyTotal1;

                        if(osfSurveyTotal1 == 0){
                            osfField1Average1 = 0;
                            osfField2Average1 = 0;
                            osfField3Average1 = 0;
                            osfField4Average1 = 0;
                            osfField5Average1 = 0;
                            osfField6Average1 = 0;
                            osfField7Average1 = 0;
                            osfField8Average1 = 0;
                            osfField9Average1 = 0;
                        }

                        //member survey form

                        var msfSurveyTotal1 = 0;
                        var msfField11 = 0;
                        var msfField21 = 0;
                        var msfField31 = 0;
                        var msfField41 = 0;
                        var msfField51 = 0;
                        var msfField61 = 0;
                        var msfField71 = 0;
                        var msfField81 = 0;
                        var msfField91 = 0;
                        var msfField101 = 0;
                        var msfField111 = 0;
                        var msfField121 = 0;
                        var msfField131 = 0;


                        for (var i = 0; i < data[6].length; i++){

                            if(data[6][i].organizationID == organizationid){

                                msfSurveyTotal1 = msfSurveyTotal1 + 1;

                                msfField11 = msfField11 + data[6][i].field1;
                                msfField21 = msfField21 + data[6][i].field2;
                                msfField31 = msfField31 + data[6][i].field3;
                                msfField41 = msfField41 + data[6][i].field4;
                                msfField51 = msfField51 + data[6][i].field5;
                                msfField61 = msfField61 + data[6][i].field6;
                                msfField71 = msfField71 + data[6][i].field7;
                                msfField81 = msfField81 + data[6][i].field8;
                                msfField91 = msfField91 + data[6][i].field9;
                                msfField101 = msfField101 + data[6][i].field10;
                                msfField111 = msfField111 + data[6][i].field11;
                                msfField121 = msfField121 + data[6][i].field12;
                                msfField131 = msfField131 + data[6][i].field13;


                            }


                        }

                        var msfField1Average1 = msfField11/msfSurveyTotal1;
                        var msfField2Average1 = msfField21/msfSurveyTotal1;
                        var msfField3Average1 = msfField31/msfSurveyTotal1;
                        var msfField4Average1 = msfField41/msfSurveyTotal1;
                        var msfField5Average1 = msfField51/msfSurveyTotal1;
                        var msfField6Average1 = msfField61/msfSurveyTotal1;
                        var msfField7Average1 = msfField71/msfSurveyTotal1;
                        var msfField8Average1 = msfField81/msfSurveyTotal1;
                        var msfField9Average1 = msfField91/msfSurveyTotal1;
                        var msfField10Average1 = msfField101/msfSurveyTotal1;
                        var msfField11Average1 = msfField111/msfSurveyTotal1;
                        var msfField12Average1 = msfField121/msfSurveyTotal1;
                        var msfField13Average1 = msfField131/msfSurveyTotal1;

                        if(msfSurveyTotal1 == 0){
                            msfField1Average1 = 0;
                            msfField2Average1 = 0;
                            msfField3Average1 = 0;
                            msfField4Average1 = 0;
                            msfField5Average1 = 0;
                            msfField6Average1 = 0;
                            msfField7Average1 = 0;
                            msfField8Average1 = 0;
                            msfField9Average1 = 0;
                            msfField10Average1 = 0;
                            msfField11Average1 = 0;
                            msfField12Average1 = 0;
                            msfField13Average1 = 0;
                        }

                        //activity research form

                        var arfSurveyTotal1 = 0;
                        var arfField11 = 0;
                        var arfField21 = 0;
                        var arfField31 = 0;
                        var arfField41 = 0;
                        var arfField51 = 0;
                        var arfField61 = 0;
                        var arfField71 = 0;


                        var orgresActivityId1 = 0;
                        var orgresActivityCount1 = 0;
                        var orgresParticipantCount1 = 0;
                        for (var i = 0; i < data[7].length; i++){

                            if(data[7][i].organizationID == organizationid){

                                arfSurveyTotal1 = arfSurveyTotal1 + 1;

                                arfField11 = arfField11 + data[7][i].IUTPOTA;
                                arfField21 = arfField21 + data[7][i].TASMI;
                                arfField31 = arfField31 + data[7][i].IFIDTA;
                                arfField41 = arfField41 + data[7][i].TAWWP;
                                arfField51 = arfField51 + data[7][i].TOUMTGTTA;
                                arfField61 = arfField61 + data[7][i].field6;
                                arfField71 = arfField71 + data[7][i].field7;




                            }


                        }

                        var arfField1Average1 = arfField11/arfSurveyTotal1;
                        var arfField2Average1 = arfField21/arfSurveyTotal1;
                        var arfField3Average1 = arfField31/arfSurveyTotal1;
                        var arfField4Average1 = arfField41/arfSurveyTotal1;
                        var arfField5Average1 = arfField51/arfSurveyTotal1;
                        var arfField6Average1 = arfField61/arfSurveyTotal1;
                        var arfField7Average1 = arfField71/arfSurveyTotal1;

                        if (arfSurveyTotal1 == 0){
                            arfField1Average1 = 0;
                            arfField2Average1 = 0;
                            arfField3Average1 = 0;
                            arfField4Average1 = 0;
                            arfField5Average1 = 0;
                            arfField6Average1 = 0;
                            arfField7Average1 = 0;
                        }

                        //orgres organization members count

                        var totalOrganizationMembers1 = 0;

                        for(var i = 0; i < data[8].length; i++){

                            if (data[8][i].organization == organizationid){

                                totalOrganizationMembers1 = totalOrganizationMembers1 + 1;
                            }


                        }

                        // orgres purpose

                        var purpose11 = ((msfField1Average1/5)*100)*0.04;
                        var purpose21 = ((((arfField1Average1 + msfField2Average1)/2)/5)*100)*0.02;
                        var purpose31 = ((((arfField2Average1 + msfField3Average1 + msfField4Average1)/3)/5)*100)*0.04;

                        var orgresPurposeGrade1 = purpose11 + purpose21 + purpose31;


                        // orgres involvement

                        var involvement11 = ((msfSurveyTotal1/totalOrganizationMembers1)*100)*0.045;

                        if(totalOrganizationMembers1 == 0){
                            involvement11 = 0;
                        }

                        var involvement21 = ((((arfField3Average1 + msfField5Average1 + msfField6Average1)/3)/5)*100)*0.06;
                        var involvement31 = ((((arfField4Average1 + msfField7Average1)/2)/5)*100)*0.045;

                        var orgresInvolvementGrade1 = involvement11 + involvement21 + involvement31;

                        // orgres quality

                        var quality11 = ((msfField8Average1/5)*100)*0.0225;
                        var quality21 = ((((msfField9Average1 + msfField10Average1)/2)/5)*100)*0.015;
                        var quality31 = ((arfField5Average1/5)*100)*0.0225;
                        var quality41 = ((((arfField6Average1 + msfField11Average1)/2)/5)*100)*0.0225;
                        var quality51 = ((((arfField7Average1 + msfField12Average1)/2)/5)*100)*0.015;

                        var orgresQualityGrade1 = quality11 + quality21 + quality31 + quality41 + quality51;


                        //orgres leadership grade

                        var leadership11 = ((((osfField1Average1 + osfField2Average1)/2)/5)*100)*0.0015;
                        var leadership21 = ((osfField3Average1/5)*100)*0.0008;
                        var leadership31 = ((osfField4Average1/5)*100)*0.01;
                        var leadership41 = ((osfField5Average1/5)*100)*0.0015;
                        var leadership51 = ((msfField13Average1/5)*100)*0.0015;
                        var leadership61 = ((((osfField6Average1 + osfField7Average1)/2)/5)*100)*0.0045;
                        var leadership71 = ((osfField8Average1/5)*100)*0.003;
                        var leadership81 = ((osfField9Average1/5)*100)*0.0015;
                        var leadership91 = 0.3;//0.003*100

                        var orgresLeadershipGrade1 = leadership11 + leadership21 + leadership31 + leadership41 + leadership51 + leadership61 + leadership71 + leadership81 + leadership91;

                        var orgresGrade1 = orgresPurposeGrade1 + orgresInvolvementGrade1 + orgresQualityGrade1 + orgresLeadershipGrade1;

                        // amt grade
                        var totalAMTEvaluations1 = data[9].length;
                        var totalAMTEvaluationScore1 = 0;

                        for (var i = 0; i < data[9].length; i++){

                            totalAMTEvaluationScore1 = totalAMTEvaluationScore1 + data[9][i].amtgrade

                        }

                        var amtScore1 = totalAMTEvaluationScore1/totalAMTEvaluations1;

                        if (totalAMTEvaluations1 == 0){

                            amtScore1 = 0;

                        }
                        var amtGrade1 = amtScore1*0.0375;

                        //finance grade

                        var onTimeTransaction1 = 0;
                        var totalApprovedTransaction1 = 0;
                        var approvedParticulars1 = 0;
                        var onBudgetActivities1 = 0;
                        var totalFinanceActivities1 = 0;
                        var relatedExpense1 = 0;
                        var totalExpense1 = 0;
                        var totalActivityBudget1 = 0

                        // approved transactions
                        for (var i = 0; i < data[11].length; i++){

                            let financesign = data[11][i].datesigned;
                            let activitystart = data[11][i].datestart

                            var budgetdiff1 = timediff(financesign1, activitystart1, 'D');

                            if(budgetdiff1.days <= 3){
                                onTimeTransaction1 = onTimeTransaction1 + 1;
                            }

                            approvedParticulars1 = approvedParticulars1 + data[11][i].particulars;

                            totalApprovedTransaction1 = totalApprovedTransaction1 + 1;

                        }

                        // approved expenses(particulars)
                        for(var i = 0; i < data[12].length; i++){

                            if (data[12][i].expenses <= data[12][i].budget) {
                                onBudgetActivities1 = onBudgetActivities1 + 1;
                            }

                            totalFinanceActivities1 = totalFinanceActivities1 + 1;

                            if (data[12][i].isrelatedtoorganizationnature == true){
                                relatedExpense1 = relatedExpense1 + data[12][i].expenses;
                            }

                            totalExpense1 = totalExpense1 + data[12][i].expenses1;

                            totalActivityBudget1 = totalActivityBudget1 + data[12][i].budget;

                        }

                        if(data[13]==null){
                            var totalParticulars1 = 0;
                            var operationalfunds1 = 0;
                            var depositoryfunds1 = 0;
                        }
                        else {
                            var totalParticulars1 = data[13].particulars;
                            var operationalfunds1 = data[13].operationalfunds;
                            var depositoryfunds1 = data[13].depositoryfunds;
                        }


                        // finance monitoring grade

                        var tempMonitoring11 = ((onTimeTransaction1/totalApprovedTransaction1)*100);//*0.01;

                        if (tempMonitoring11 >= 98){
                            var monitoring11 = 1;
                        }
                        else if (tempMonitoring11 >= 95) {
                            var monitoring11 = 0.95;
                        }
                        else if (tempMonitoring11 >= 92) {
                            var monitoring11 = 0.9;
                        }
                        else if (tempMonitoring11 >= 89) {
                            var monitoring11 = 0.85;
                        }
                        else if (tempMonitoring11 >= 86) {
                            var monitoring11 = 0.8;
                        }
                        else if (tempMonitoring11 >= 83) {
                            var monitoring11 = 0.75;
                        }
                        else if (tempMonitoring11 >= 80) {
                            var monitoring11 = 0.7;
                        }
                        else if (tempMonitoring11 >= 77) {
                            var monitoring11 = 0.65;
                        }
                        else if (tempMonitoring11 >= 74) {
                            var monitoring11 = 0.6;
                        }
                        else if (tempMonitoring11 >= 71) {
                            var monitoring11 = 0.55;
                        }
                        else{
                            var monitoring11 = 0.5;
                        }

                        var tempMonitoring21 = ((approvedParticulars1/totalParticulars1)*100);//0.005;

                        if (tempMonitoring21 >= 98){
                            var monitoring21 = 0.5;
                        }
                        else if (tempMonitoring21 >= 95) {
                            var monitoring21 = 0.475;
                        }
                        else if (tempMonitoring21 >= 92) {
                            var monitoring21 = 0.45;
                        }
                        else if (tempMonitoring21 >= 89) {
                            var monitoring21 = 0.425;
                        }
                        else if (tempMonitoring21 >= 86) {
                            var monitoring21 = 0.4;
                        }
                        else if (tempMonitoring21 >= 83) {
                            var monitoring21 = 0.375;
                        }
                        else if (tempMonitoring21 >= 80) {
                            var monitoring21 = 0.35;
                        }
                        else if (tempMonitoring21 >= 77) {
                            var monitoring21 = 0.325;
                        }
                        else if (tempMonitoring21 >= 74) {
                            var monitoring21 = 0.3;
                        }
                        else if (tempMonitoring21 >= 71) {
                            var monitoring21 = 0.275;
                        }
                        else if (tempMonitoring21 >= 68) {
                            var monitoring21 = 0.25;
                        }
                        else if (tempMonitoring21 >= 65) {
                            var monitoring21 = 0.225;
                        }
                        else{
                            var monitoring21 = 0.2;
                        }

                        var monitoring31 = 1;
                        var tempMonitoring451 = ((Math.abs(totalExpense1-totalActivityBudget1))/totalActivityBudget1)*100;

                        if(tempMonitoring451 >= 90 && tempMonitoring451 <=110){
                            var monitoring41 = 1.5;
                        }
                        else if(tempMonitoring451 >= 75 && tempMonitoring451 <= 125){
                            var monitoring41 = 1.35;
                        }
                        else{
                            var monitoring41 = 1.2;
                        }

                        if(tempMonitoring451 >= 90 && tempMonitoring451 <= 110){
                            var monitoring51 = 1;
                        }
                        else if(tempMonitoring451 >= 85 && tempMonitoring451 <=115){
                            var monitoring51 = 0.9;
                        }
                        else if(tempMonitoring451 >= 81 && tempMonitoring451 <=120){
                            var monitoring51 = 0.8;
                        }
                        else if(tempMonitoring451 >= 75 && tempMonitoring451 <= 125){
                            var monitoring51 = 0.7;
                        }
                        else{
                            var monitoring51 = 0.6;
                        }

                        // finance generation grade

                        var generation11 = 0;
                        var generation21 = 0;

                        // finance allocation grade

                        var tempAllocation11 = ((onBudgetActivities1/totalFinanceActivities1)*100);//*0.01;

                        if(tempAllocation11 >= 85){
                            var allocation11 = 1;
                        }
                        else if(tempAllocation11 >= 80){
                            var allocation11 = 0.95;
                        }
                        else if(tempAllocation11 >= 75){
                            var allocation11 = 0.9;
                        }
                        else if(tempAllocation11 >= 70){
                            var allocation11 = 0.85;
                        }
                        else if(tempAllocation11 >= 65){
                            var allocation11 = 0.8;
                        }
                        else if(tempAllocation11 >= 60){
                            var allocation11 = 0.75;
                        }
                        else if(tempAllocation11 >= 55){
                            var allocation11 = 0.7;
                        }
                        else if(tempAllocation11 >= 50){
                            var allocation11 = 0.65;
                        }
                        else{
                            var allocation11 = 0.6;
                        }

                        var tempAllocation21 = Math.abs(60-((relatedExpense1/totalExpense1)*100));

                        if(tempAllocation21 <= 10){
                            var allocation21 = 1;
                        }
                        else if(tempAllocation21 <=20.99){
                            var allocation21 = 0.9;
                        }
                        else if(tempAllocation21 <= 30){
                            var allocation21 = 0.85;
                        }
                        else{
                            var allocation21 = 0.75;
                        }



                        var tempAllocation31 = ((depositoryfunds1-totalExpense1)/depositoryfunds1)*100;

                        if(tempAllocation31 >= 100){
                            var Allocation31 = 1;
                        }
                        else if(tempAllocation31 >= 90){
                            var Allocation31 = 0.9;
                        }
                        else if(tempAllocation31 >= 80){
                            var Allocation31 = 0.8;
                        }
                        else if(tempAllocation31 >= 70){
                            var Allocation31 = 0.75;
                        }
                        else if(tempAllocation31 >= 60){
                            var Allocation31 = 0.7;
                        }
                        else{
                            var Allocation31 = 0.6;
                        }

                        var financeMonitoringGrade1 = monitoring11 + monitoring21 + monitoring31 + monitoring41 + monitoring51;
                        var financeGenerationGrade1 = generation11 + generation21;
                        var financeAllocationGrade1 = allocation11 + allocation21 + Allocation31;

                        var financeGrade1 = financeMonitoringGrade1 + financeGenerationGrade1 + financeAllocationGrade1;


                        //TERM 2
                        // preacts grade
                        var preactsApprovedActivities2 = 0;
                        var preactsEarlyApprovedActivities2 = 0;
                        var preactsLateApprovedActivities2 = 0;
                        var preactsDeniedActivities2 = 0;
                        var totalActivities2 = 0;
                        var preactsTimingRatio2 = 0;
                        var preactsPendCount2 = 0;
                        var gosmSubmissionGrade2 = 0;
                        var isRelatedToOrganizationCount2 = 0;
                        var sixtyFortyGrade2 = 0;
                        var preactsAllApprovedTotal2 = 0;
                        var notInGOSM2 = false;
                        var lasallianFormationCompliance2 = false;



                        if(data[18] != null){
                            if(data[18].orggosmsubmitted == null){
                            }
                            else{
                                let orggosmsubmitted2 = data[18].orggosmsubmitted;

                                var gosmdiff2 = timediff(termstart2, orggosmsubmitted2, 'D');

                                if(gosmdiff2.days <= 14){
                                    gosmSubmissionGrade2 = 0.075;
                                }
                            }
                        }

                        //approved activities
                        for(var i = 0; data[16].length > i; i++){

                            if(data[16][i].studentorganization == organizationid &&
                                data[16][i].isingosm == true){

                                preactsApprovedActivities2 = preactsApprovedActivities2 + 1;

                                if(data[16][i].activitynature == 8){
                                    lasallianFormationCompliance2 = true
                                }


                                let actualdatestart2 = data[16][i].actualdatestart;
                                let datesigned2 = data[16][i].datesigned;
                                let targetdatestart2 = data[16][i].targetdatestart;

                                var diff2 = timediff(actualdatestart2, datesigned2, 'D');


                                if (diff2.days<2){
                                    preactsEarlyApprovedActivities2 = preactsEarlyApprovedActivities2 + 1;
                                }
                                else{
                                    preactsLateApprovedActivities2 = preactsLateApprovedActivities2 + 1;
                                }

                                var timingdiff2 = timediff(targetdatestart2, actualdatestart2, 'D');

                                if (timingdiff2.days < 7 && timingdiff2.days > -7){
                                    preactsTimingRatio2 = preactsTimingRatio2 + 1;
                                }

                            }

                            if(data[16][i].studentorganization == organizationid &&
                                data[16][i].isrelatedtoorganizationnature == true){
                                    isRelatedToOrganizationCount2 = isRelatedToOrganizationCount2 + 1;
                            }

                            if(data[16][i].studentorganization == organizationid){

                                preactsAllApprovedTotal2 = preactsAllApprovedTotal2 + 1;

                            }

                        }

                        // all activities
                        for (var i = 0; data[17].length > i; i++){

                            if(data[17][i].studentorganization == organizationid &&
                                data[17][i].isingosm == true){

                                totalActivities2 = totalActivities2 + 1;

                                preactsPendCount2 = preactsPendCount2 + data[17][i].timespended;


                                if(data[17][i].status==5){
                                    preactsDeniedActivities2 = preactsDeniedActivities2 + 1;
                                }

                            }
                            else if(data[17][i].studentorganization == organizationid &&
                                data[17][i].isingosm == false){

                                notInGOSM2 = true;

                            }

                        }

                        var preactsPunctualityGrade2 = ((((parseFloat(preactsEarlyApprovedActivities2)/parseFloat(preactsApprovedActivities2))*100)-parseFloat(preactsDeniedActivities2))*0.025);
                        var preactsTimingRatioGrade2 = (((parseFloat(preactsTimingRatio2)/parseFloat(totalActivities2))*100)*0.015);
                        var preactsCompletenessGrade2 = (100 - (parseFloat(preactsPendCount2)*0.5))*0.025;

                        var sixtyFortyRatioPercentage2 = isRelatedToOrganizationCount2/preactsAllApprovedTotal2;


                        if (preactsApprovedActivities2 == 0){
                            preactsPunctualityGrade2 = 0;
                        }

                        if (preactsAllApprovedTotal2 == 0){
                            sixtyFortyRatioPercentage2 = 0;
                        }


                        var sixFourGradeRange2 = 0

                        var sixtyFortyGradeFound2 = true;

                        var gradeStart2 = 57;
                        var gradeEnd2 = 63;

                        while(sixtyFortyGradeFound2){

                            if(sixtyFortyRatioPercentage2 >= gradeStart2 && sixtyFortyRatioPercentage2 <= gradeEnd2){

                                sixtyFortyGradeFound2 = false;

                            }
                            else{
                                sixFourGradeRange2 = sixFourGradeRange2 + 1;
                                gradeStart2 = gradeStart2 - 4;
                                gradeEnd2 = gradeEnd2 + 4;
                            }

                        }

                        var sixtyFortyGrade2 = (100-(parseFloat(sixFourGradeRange2)*4))*0.10;



                        //postacts grade
                        var postactsEarlyApprovedActivities2 = 0;
                        var postactsTotalActivities2 = 0;
                        var postactsApprovedActivities2 = 0;
                        var postactsLateApprovedActivities2 = 0;

                        for (var i = 0; i < data[19].length; i++){

                            if (data[19][i].studentorganization == organizationid) {

                                postactsTotalActivities2 = postactsTotalActivities2 + 1;

                                // if approved
                                if(data[19][i].status==4){

                                    postactsApprovedActivities2 = postactsApprovedActivities2 + 1;


                                    let actualdatestart2 = data[19][i].actualdatestart;
                                    let datesubmitted2 = data[19][i].datesubmitted;

                                    var diff2 = timediff(actualdatestart2, datesubmitted2, 'D');


                                    if (diff2.days<30){
                                        postactsEarlyApprovedActivities2 = postactsEarlyApprovedActivities2 + 1;
                                    }
                                    else{
                                        postactsLateApprovedActivities2 = postactsLateApprovedActivities2 + 1;
                                    }

                                }


                            }


                        }

                        var postactsPunctualityGrade2 = ((((parseFloat(postactsEarlyApprovedActivities2)/parseFloat(postactsApprovedActivities2))*100)-parseFloat(preactsDeniedActivities2))*0.025);
                        var postactsCompletenessGrade2 = ((parseFloat(postactsApprovedActivities2)/parseFloat(preactsApprovedActivities2))*100)*0.025;

                        if(postactsApprovedActivities2 == 0){
                            postactsPunctualityGrade2 = 0;
                        }

                        if(preactsApprovedActivities2==0){
                            postactsCompletenessGrade2 = 0;
                        }

                        var pushedThroughGrade2 = ((parseFloat(preactsApprovedActivities2)/parseFloat(totalActivities2))*100)*0.0015;

                        if(totalActivities2 == 0){

                            preactsTimingRatioGrade2 = 0;
                            pushedThroughGrade2 = 0;

                        }

                        if(notInGOSM2){

                            var notInGOSMGrade2 = 0.15;

                        }
                        else{

                            var notInGOSMGrade2 = 0;

                        }

                        if(lasallianFormationCompliance2){
                            var lasallianFormationComplianceGrade2 = 6;
                        }
                        else{
                            var lasallianFormationComplianceGrade2 = 0;
                        }

                        var documentationGrade2 = (preactsPunctualityGrade2 + preactsCompletenessGrade2 + preactsTimingRatioGrade2
                                                    + gosmSubmissionGrade2 + sixtyFortyGrade2 + postactsPunctualityGrade2
                                                    + postactsCompletenessGrade2 + pushedThroughGrade2 + notInGOSMGrade2
                                                    + lasallianFormationComplianceGrade2);

                        //pnp grade
                        var printedPoster2 = false;
                        var tickets2 = false;
                        var printedPublication2 = false;
                        var onlinePublication2 = false;
                        var printedPublicationCount2 = 0;
                        var onlinePublicationCount2 = 0;
                        var onlinePoster2 = false;

                        for (var i = 0; i < data[20].length; i++){

                            if (data[20][i].studentorganization == organizationid
                                && data[20][i].status == 1) {

                                if(data[20][i].modeOfDistribution == 1){

                                    printedPublication2 = true;

                                    printedPublicationCount2 = printedPublicationCount2 + 1;

                                    if(data[20][i].material == 5){
                                        printedPoster2 = true;
                                    }

                                }
                                else{

                                    onlinePublication2 = true;

                                    onlinePublicationCount2 = onlinePublicationCount2 + 1;

                                    if(data[20][i].material == 5){
                                        onlinePoster2 = true;
                                    }

                                }

                                if (data[20][i].material == 3) {
                                    tickets2 = true;
                                }

                            }

                        }


                        var UniversityPublicityInstrumentGrade2 = 0;
                        var NewsLettersPublicationsGrade2 = 0;
                        var OnlinePublicityGrade2 = 0;


                        if (printedPoster2) {
                            UniversityPublicityInstrumentGrade2 = UniversityPublicityInstrumentGrade2 + 0.5;
                        }

                        if (tickets2) {
                            UniversityPublicityInstrumentGrade2 = UniversityPublicityInstrumentGrade2 + 0.7;
                        }

                        if (printedPublication2) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.35;
                        }

                        if(onlinePublication2) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.35;
                        }

                        if (printedPublicationCount2 == 1) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.05;
                        }
                        else if (printedPublicationCount2 == 2) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.1;
                        }
                        else if (printedPublicationCount2 >= 3) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.15;
                        }

                        if(onlinePublicationCount2 == 1){
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.0375;
                        }
                        else if (onlinePublicationCount2 == 2) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.075;
                        }
                        else if (onlinePublicationCount2 == 3){
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.1125;
                        }
                        else if (onlinePublicationCount2 >= 4) {
                            NewsLettersPublicationsGrade2 = NewsLettersPublicationsGrade2 + 0.15;
                        }

                        if (onlinePoster2) {
                            OnlinePublicityGrade2 = OnlinePublicityGrade2 + 1.5;
                        }

                        var pnpGrade2 = UniversityPublicityInstrumentGrade2 + NewsLettersPublicationsGrade2 + OnlinePublicityGrade2;

                        //orgres grade

                        //officer survey form
                        var osfSurveyTotal2 = 0;
                        var osfField12 = 0;
                        var osfField22 = 0;
                        var osfField32 = 0;
                        var osfField42 = 0;
                        var osfField52 = 0;
                        var osfField62 = 0;
                        var osfField72 = 0;
                        var osfField82 = 0;
                        var osfField92 = 0;


                        for (var i = 0; i < data[21].length; i++){

                            if(data[21][i].organizationID == organizationid){

                                osfSurveyTotal2 = osfSurveyTotal2 + 1;

                                osfField12 = osfField12 + data[21][i].field1;
                                osfField22 = osfField22 + data[21][i].field2;
                                osfField32 = osfField32 + data[21][i].field3;
                                osfField42 = osfField42 + data[21][i].field4;
                                osfField52 = osfField52 + data[21][i].field5;
                                osfField62 = osfField62 + data[21][i].field6;
                                osfField72 = osfField72 + data[21][i].field7;
                                osfField82 = osfField82 + data[21][i].field8;
                                osfField92 = osfField92 + data[21][i].field9;


                            }


                        }

                        var osfField1Average2 = osfField12/osfSurveyTotal2;
                        var osfField2Average2 = osfField22/osfSurveyTotal2;
                        var osfField3Average2 = osfField32/osfSurveyTotal2;
                        var osfField4Average2 = osfField42/osfSurveyTotal2;
                        var osfField5Average2 = osfField52/osfSurveyTotal2;
                        var osfField6Average2 = osfField62/osfSurveyTotal2;
                        var osfField7Average2 = osfField72/osfSurveyTotal2;
                        var osfField8Average2 = osfField82/osfSurveyTotal2;
                        var osfField9Average2 = osfField92/osfSurveyTotal2;

                        if(osfSurveyTotal2 == 0){
                            osfField1Average2 = 0;
                            osfField2Average2 = 0;
                            osfField3Average2 = 0;
                            osfField4Average2 = 0;
                            osfField5Average2 = 0;
                            osfField6Average2 = 0;
                            osfField7Average2 = 0;
                            osfField8Average2 = 0;
                            osfField9Average2 = 0;
                        }

                        //member survey form

                        var msfSurveyTotal2 = 0;
                        var msfField12 = 0;
                        var msfField22 = 0;
                        var msfField32 = 0;
                        var msfField42 = 0;
                        var msfField52 = 0;
                        var msfField62 = 0;
                        var msfField72 = 0;
                        var msfField82 = 0;
                        var msfField92 = 0;
                        var msfField102 = 0;
                        var msfField112 = 0;
                        var msfField122 = 0;
                        var msfField132 = 0;


                        for (var i = 0; i < data[22].length; i++){

                            if(data[22][i].organizationID == organizationid){

                                msfSurveyTotal2 = msfSurveyTotal2 + 1;

                                msfField12 = msfField12 + data[22][i].field1;
                                msfField22 = msfField22 + data[22][i].field2;
                                msfField32 = msfField32 + data[22][i].field3;
                                msfField42 = msfField42 + data[22][i].field4;
                                msfField52 = msfField52 + data[22][i].field5;
                                msfField62 = msfField62 + data[22][i].field6;
                                msfField72 = msfField72 + data[22][i].field7;
                                msfField82 = msfField82 + data[22][i].field8;
                                msfField92 = msfField92 + data[22][i].field9;
                                msfField102 = msfField102 + data[22][i].field10;
                                msfField112 = msfField112 + data[22][i].field11;
                                msfField122 = msfField122 + data[22][i].field12;
                                msfField132 = msfField132 + data[22][i].field13;


                            }


                        }

                        var msfField1Average2 = msfField12/msfSurveyTotal2;
                        var msfField2Average2 = msfField22/msfSurveyTotal2;
                        var msfField3Average2 = msfField32/msfSurveyTotal2;
                        var msfField4Average2 = msfField42/msfSurveyTotal2;
                        var msfField5Average2 = msfField52/msfSurveyTotal2;
                        var msfField6Average2 = msfField62/msfSurveyTotal2;
                        var msfField7Average2 = msfField72/msfSurveyTotal2;
                        var msfField8Average2 = msfField82/msfSurveyTotal2;
                        var msfField9Average2 = msfField92/msfSurveyTotal2;
                        var msfField10Average2 = msfField102/msfSurveyTotal2;
                        var msfField11Average2 = msfField112/msfSurveyTotal2;
                        var msfField12Average2 = msfField122/msfSurveyTotal2;
                        var msfField13Average2 = msfField132/msfSurveyTotal2;

                        if(msfSurveyTotal2 == 0){
                            msfField1Average2 = 0;
                            msfField2Average2 = 0;
                            msfField3Average2 = 0;
                            msfField4Average2 = 0;
                            msfField5Average2 = 0;
                            msfField6Average2 = 0;
                            msfField7Average2 = 0;
                            msfField8Average2 = 0;
                            msfField9Average2 = 0;
                            msfField10Average2 = 0;
                            msfField11Average2 = 0;
                            msfField12Average2 = 0;
                            msfField13Average2 = 0;
                        }

                        //activity research form

                        var arfSurveyTotal2 = 0;
                        var arfField12 = 0;
                        var arfField22 = 0;
                        var arfField32 = 0;
                        var arfField42 = 0;
                        var arfField52 = 0;
                        var arfField62 = 0;
                        var arfField72 = 0;


                        var orgresActivityId2 = 0;
                        var orgresActivityCount2 = 0;
                        var orgresParticipantCount2 = 0;
                        for (var i = 0; i < data[23].length; i++){

                            if(data[23][i].organizationID == organizationid){

                                arfSurveyTotal2 = arfSurveyTotal2 + 1;

                                arfField12 = arfField12 + data[23][i].IUTPOTA;
                                arfField22 = arfField22 + data[23][i].TASMI;
                                arfField32 = arfField32 + data[23][i].IFIDTA;
                                arfField42 = arfField42 + data[23][i].TAWWP;
                                arfField52 = arfField52 + data[23][i].TOUMTGTTA;
                                arfField62 = arfField62 + data[23][i].field6;
                                arfField72 = arfField72 + data[23][i].field7;




                            }


                        }

                        var arfField1Average2 = arfField12/arfSurveyTotal2;
                        var arfField2Average2 = arfField22/arfSurveyTotal2;
                        var arfField3Average2 = arfField32/arfSurveyTotal2;
                        var arfField4Average2 = arfField42/arfSurveyTotal2;
                        var arfField5Average2 = arfField52/arfSurveyTotal2;
                        var arfField6Average2 = arfField62/arfSurveyTotal2;
                        var arfField7Average2 = arfField72/arfSurveyTotal2;

                        if (arfSurveyTotal2 == 0){
                            arfField1Average2 = 0;
                            arfField2Average2 = 0;
                            arfField3Average2 = 0;
                            arfField4Average2 = 0;
                            arfField5Average2 = 0;
                            arfField6Average2 = 0;
                            arfField7Average2 = 0;
                        }

                        //orgres organization members count

                        var totalOrganizationMembers2 = 0;

                        for(var i = 0; i < data[24].length; i++){

                            if (data[24][i].organization == organizationid){

                                totalOrganizationMembers2 = totalOrganizationMembers2 + 1;
                            }


                        }

                        // orgres purpose

                        var purpose12 = ((msfField1Average2/5)*100)*0.04;
                        var purpose22 = ((((arfField1Average2 + msfField2Average2)/2)/5)*100)*0.02;
                        var purpose32 = ((((arfField2Average2 + msfField3Average2 + msfField4Average2)/3)/5)*100)*0.04;

                        var orgresPurposeGrade2 = purpose12 + purpose22 + purpose32;


                        // orgres involvement

                        var involvement12 = ((msfSurveyTotal2/totalOrganizationMembers2)*100)*0.045;

                        if(totalOrganizationMembers2 == 0){
                            involvement12 = 0;
                        }

                        var involvement22 = ((((arfField3Average2 + msfField5Average2 + msfField6Average2)/3)/5)*100)*0.06;
                        var involvement32 = ((((arfField4Average2 + msfField7Average2)/2)/5)*100)*0.045;

                        var orgresInvolvementGrade2 = involvement12 + involvement22 + involvement32;

                        // orgres quality

                        var quality12 = ((msfField8Average2/5)*100)*0.0225;
                        var quality22 = ((((msfField9Average2 + msfField10Average2)/2)/5)*100)*0.015;
                        var quality32 = ((arfField5Average2/5)*100)*0.0225;
                        var quality42 = ((((arfField6Average2 + msfField11Average2)/2)/5)*100)*0.0225;
                        var quality52 = ((((arfField7Average2 + msfField12Average2)/2)/5)*100)*0.015;

                        var orgresQualityGrade2 = quality12 + quality22 + quality32 + quality42 + quality52;


                        //orgres leadership grade

                        var leadership12 = ((((osfField1Average2 + osfField2Average2)/2)/5)*100)*0.0015;
                        var leadership22 = ((osfField3Average2/5)*100)*0.0008;
                        var leadership32 = ((osfField4Average2/5)*100)*0.01;
                        var leadership42 = ((osfField5Average2/5)*100)*0.0015;
                        var leadership52 = ((msfField13Average2/5)*100)*0.0015;
                        var leadership62 = ((((osfField6Average2 + osfField7Average2)/2)/5)*100)*0.0045;
                        var leadership72 = ((osfField8Average2/5)*100)*0.003;
                        var leadership82 = ((osfField9Average2/5)*100)*0.0015;
                        var leadership92 = 0.3;//0.003*100

                        var orgresLeadershipGrade2 = leadership12 + leadership22 + leadership32 + leadership42 + leadership52 + leadership62 + leadership72 + leadership82 + leadership92;

                        var orgresGrade2 = orgresPurposeGrade2 + orgresInvolvementGrade2 + orgresQualityGrade2 + orgresLeadershipGrade2;

                        // amt grade
                        var totalAMTEvaluations2 = data[25].length;
                        var totalAMTEvaluationScore2 = 0;

                        for (var i = 0; i < data[25].length; i++){

                            totalAMTEvaluationScore2 = totalAMTEvaluationScore2 + data[25][i].amtgrade

                        }

                        var amtScore2 = totalAMTEvaluationScore2/totalAMTEvaluations2;

                        if (totalAMTEvaluations2 == 0){

                            amtScore2 = 0;

                        }
                        var amtGrade2 = amtScore2*0.0375;

                        //finance grade

                        var onTimeTransaction2 = 0;
                        var totalApprovedTransaction2 = 0;
                        var approvedParticulars2 = 0;
                        var onBudgetActivities2 = 0;
                        var totalFinanceActivities2 = 0;
                        var relatedExpense2 = 0;
                        var totalExpense2 = 0;
                        var totalActivityBudget2 = 0

                        // approved transactions
                        for (var i = 0; i < data[27].length; i++){

                            let financesign2 = data[27][i].datesigned;
                            let activitystart2 = data[27][i].datestart

                            var budgetdiff2 = timediff(financesign2, activitystart2, 'D');

                            if(budgetdiff2.days <= 3){
                                onTimeTransaction2 = onTimeTransaction2 + 1;
                            }

                            approvedParticulars2 = approvedParticulars2 + data[27][i].particulars;

                            totalApprovedTransaction2 = totalApprovedTransaction2 + 1;

                        }

                        // approved expenses(particulars)
                        for(var i = 0; i < data[28].length; i++){

                            if (data[28][i].expenses <= data[28][i].budget) {
                                onBudgetActivities2 = onBudgetActivities2 + 1;
                            }

                            totalFinanceActivities2 = totalFinanceActivities2 + 1;

                            if (data[28][i].isrelatedtoorganizationnature == true){
                                relatedExpense2 = relatedExpense2 + data[28][i].expenses;
                            }

                            totalExpense2 = totalExpense2 + data[28][i].expenses;

                            totalActivityBudget2 = totalActivityBudget2 + data[28][i].budget;

                        }

                        if(data[29]==null){
                            var totalParticulars2 = 0;
                            var operationalfunds2 = 0;
                            var depositoryfunds2 = 0;
                        }
                        else {
                            var totalParticulars2 = data[29].particulars;
                            var operationalfunds2 = data[29].operationalfunds;
                            var depositoryfunds2 = data[29].depositoryfunds;
                        }


                        // finance monitoring grade

                        var tempMonitoring12 = ((onTimeTransaction2/totalApprovedTransaction2)*100);//*0.01;

                        if (tempMonitoring12 >= 98){
                            var monitoring12 = 1;
                        }
                        else if (tempMonitoring12 >= 95) {
                            var monitoring12 = 0.95;
                        }
                        else if (tempMonitoring12 >= 92) {
                            var monitoring12 = 0.9;
                        }
                        else if (tempMonitoring12 >= 89) {
                            var monitoring12 = 0.85;
                        }
                        else if (tempMonitoring12 >= 86) {
                            var monitoring12 = 0.8;
                        }
                        else if (tempMonitoring12 >= 83) {
                            var monitoring12 = 0.75;
                        }
                        else if (tempMonitoring12 >= 80) {
                            var monitoring12 = 0.7;
                        }
                        else if (tempMonitoring12 >= 77) {
                            var monitoring12 = 0.65;
                        }
                        else if (tempMonitoring12 >= 74) {
                            var monitoring12 = 0.6;
                        }
                        else if (tempMonitoring12 >= 71) {
                            var monitoring12 = 0.55;
                        }
                        else{
                            var monitoring12 = 0.5;
                        }

                        var tempMonitoring22 = ((approvedParticulars2/totalParticulars2)*100);//0.005;

                        if (tempMonitoring22 >= 98){
                            var monitoring22 = 0.5;
                        }
                        else if (tempMonitoring22 >= 95) {
                            var monitoring22 = 0.475;
                        }
                        else if (tempMonitoring22 >= 92) {
                            var monitoring22 = 0.45;
                        }
                        else if (tempMonitoring22 >= 89) {
                            var monitoring22 = 0.425;
                        }
                        else if (tempMonitoring22 >= 86) {
                            var monitoring22 = 0.4;
                        }
                        else if (tempMonitoring22 >= 83) {
                            var monitoring22 = 0.375;
                        }
                        else if (tempMonitoring22 >= 80) {
                            var monitoring22 = 0.35;
                        }
                        else if (tempMonitoring22 >= 77) {
                            var monitoring22 = 0.325;
                        }
                        else if (tempMonitoring22 >= 74) {
                            var monitoring22 = 0.3;
                        }
                        else if (tempMonitoring22 >= 71) {
                            var monitoring22 = 0.275;
                        }
                        else if (tempMonitoring22 >= 68) {
                            var monitoring22 = 0.25;
                        }
                        else if (tempMonitoring22 >= 65) {
                            var monitoring22 = 0.225;
                        }
                        else{
                            var monitoring22 = 0.2;
                        }

                        var monitoring32 = 1;
                        var tempMonitoring452 = ((Math.abs(totalExpense2-totalActivityBudget2))/totalActivityBudget2)*100;

                        if(tempMonitoring452 >= 90 && tempMonitoring452 <=110){
                            var monitoring42 = 1.5;
                        }
                        else if(tempMonitoring452 >= 75 && tempMonitoring452 <= 125){
                            var monitoring42 = 1.35;
                        }
                        else{
                            var monitoring42 = 1.2;
                        }

                        if(tempMonitoring452 >= 90 && tempMonitoring452 <= 110){
                            var monitoring52 = 1;
                        }
                        else if(tempMonitoring452 >= 85 && tempMonitoring452 <=115){
                            var monitoring52 = 0.9;
                        }
                        else if(tempMonitoring452 >= 81 && tempMonitoring452 <=120){
                            var monitoring52 = 0.8;
                        }
                        else if(tempMonitoring452 >= 75 && tempMonitoring452 <= 125){
                            var monitoring52 = 0.7;
                        }
                        else{
                            var monitoring52 = 0.6;
                        }

                        // finance generation grade

                        var generation12 = 0;
                        var generation22 = 0;

                        // finance allocation grade

                        var tempAllocation12 = ((onBudgetActivities2/totalFinanceActivities2)*100);//*0.01;

                        if(tempAllocation12 >= 85){
                            var allocation12 = 1;
                        }
                        else if(tempAllocation12 >= 80){
                            var allocation12 = 0.95;
                        }
                        else if(tempAllocation12 >= 75){
                            var allocation12 = 0.9;
                        }
                        else if(tempAllocation12 >= 70){
                            var allocation12 = 0.85;
                        }
                        else if(tempAllocation12 >= 65){
                            var allocation12 = 0.8;
                        }
                        else if(tempAllocation12 >= 60){
                            var allocation12 = 0.75;
                        }
                        else if(tempAllocation12 >= 55){
                            var allocation12 = 0.7;
                        }
                        else if(tempAllocation12 >= 50){
                            var allocation12 = 0.65;
                        }
                        else{
                            var allocation12 = 0.6;
                        }

                        var tempAllocation22 = Math.abs(60-((relatedExpense2/totalExpense2)*100));

                        if(tempAllocation22 <= 10){
                            var allocation22 = 1;
                        }
                        else if(tempAllocation22 <=20.99){
                            var allocation22 = 0.9;
                        }
                        else if(tempAllocation22 <= 30){
                            var allocation22 = 0.85;
                        }
                        else{
                            var allocation22 = 0.75;
                        }



                        var tempAllocation32 = ((depositoryfunds2-totalExpense2)/depositoryfunds2)*100;

                        if(tempAllocation32 >= 100){
                            var Allocation32 = 1;
                        }
                        else if(tempAllocation32 >= 90){
                            var Allocation32 = 0.9;
                        }
                        else if(tempAllocation32 >= 80){
                            var Allocation32 = 0.8;
                        }
                        else if(tempAllocation32 >= 70){
                            var Allocation32 = 0.75;
                        }
                        else if(tempAllocation32 >= 60){
                            var Allocation32 = 0.7;
                        }
                        else{
                            var Allocation32 = 0.6;
                        }

                        var financeMonitoringGrade2 = monitoring12 + monitoring22 + monitoring32 + monitoring42 + monitoring52;
                        var financeGenerationGrade2 = generation12 + generation22;
                        var financeAllocationGrade2 = allocation12 + allocation22 + Allocation32;

                        var financeGrade2 = financeMonitoringGrade2 + financeGenerationGrade2 + financeAllocationGrade2;


                        //TERM 3
                        // preacts grade
                        var preactsApprovedActivities3 = 0;
                        var preactsEarlyApprovedActivities3 = 0;
                        var preactsLateApprovedActivities3 = 0;
                        var preactsDeniedActivities3 = 0;
                        var totalActivities3 = 0;
                        var preactsTimingRatio3 = 0;
                        var preactsPendCount3 = 0;
                        var gosmSubmissionGrade3 = 0;
                        var isRelatedToOrganizationCount3 = 0;
                        var sixtyFortyGrade3 = 0;
                        var preactsAllApprovedTotal3 = 0;
                        var notInGOSM3 = false;
                        var lasallianFormationCompliance3 = false;


                        if(data[34] != null){
                            if(data[34].orggosmsubmitted == null){
                            }
                            else{
                                let orggosmsubmitted3 = data[34].orggosmsubmitted;

                                var gosmdiff3 = timediff(termstart3, orggosmsubmitted3, 'D');

                                if(gosmdiff3.days <= 14){
                                    gosmSubmissionGrade3 = 0.075;
                                }
                            }
                        }

                        //approved activities
                        for(var i = 0; data[32].length > i; i++){

                            if(data[32][i].studentorganization == organizationid &&
                                data[32][i].isingosm == true){

                                preactsApprovedActivities3 = preactsApprovedActivities3 + 1;

                                if(data[32][i].activitynature == 8){
                                    lasallianFormationCompliance3 = true
                                }


                                let actualdatestart3 = data[32][i].actualdatestart;
                                let datesigned3 = data[32][i].datesigned;
                                let targetdatestart3 = data[32][i].targetdatestart;

                                var diff3 = timediff(actualdatestart3, datesigned3, 'D');


                                if (diff3.days<2){
                                    preactsEarlyApprovedActivities3 = preactsEarlyApprovedActivities3 + 1;
                                }
                                else{
                                    preactsLateApprovedActivities3 = preactsLateApprovedActivities3 + 1;
                                }

                                var timingdiff3 = timediff(targetdatestart3, actualdatestart3, 'D');

                                if (timingdiff3.days < 7 && timingdiff3.days > -7){
                                    preactsTimingRatio3 = preactsTimingRatio3 + 1;
                                }

                            }

                            if(data[32][i].studentorganization == organizationid &&
                                data[32][i].isrelatedtoorganizationnature == true){
                                    isRelatedToOrganizationCount3 = isRelatedToOrganizationCount3 + 1;
                            }

                            if(data[32][i].studentorganization == organizationid){

                                preactsAllApprovedTotal3 = preactsAllApprovedTotal3 + 1;

                            }

                        }

                        // all activities
                        for (var i = 0; data[33].length > i; i++){

                            if(data[33][i].studentorganization == organizationid &&
                                data[33][i].isingosm == true){

                                totalActivities3 = totalActivities3 + 1;

                                preactsPendCount3 = preactsPendCount3 + data[33][i].timespended;


                                if(data[33][i].status==5){
                                    preactsDeniedActivities3 = preactsDeniedActivities3 + 1;
                                }

                            }
                            else if(data[33][i].studentorganization == organizationid &&
                                data[33][i].isingosm == false){

                                notInGOSM3 = true;

                            }

                        }

                        var preactsPunctualityGrade3 = ((((parseFloat(preactsEarlyApprovedActivities3)/parseFloat(preactsApprovedActivities3))*100)-parseFloat(preactsDeniedActivities3))*0.025);
                        var preactsTimingRatioGrade3 = (((parseFloat(preactsTimingRatio3)/parseFloat(totalActivities3))*100)*0.015);
                        var preactsCompletenessGrade3 = (100 - (parseFloat(preactsPendCount3)*0.5))*0.025;

                        var sixtyFortyRatioPercentage3 = isRelatedToOrganizationCount3/preactsAllApprovedTotal3;


                        if (preactsApprovedActivities3 == 0){
                            preactsPunctualityGrade3 = 0;
                        }

                        if (preactsAllApprovedTotal3 == 0){
                            sixtyFortyRatioPercentage3 = 0;
                        }


                        var sixFourGradeRange3 = 0

                        var sixtyFortyGradeFound3 = true;

                        var gradeStart3 = 57;
                        var gradeEnd3 = 63;

                        while(sixtyFortyGradeFound3){

                            if(sixtyFortyRatioPercentage3 >= gradeStart3 && sixtyFortyRatioPercentage3 <= gradeEnd3){

                                sixtyFortyGradeFound3 = false;

                            }
                            else{
                                sixFourGradeRange3 = sixFourGradeRange3 + 1;
                                gradeStart3 = gradeStart3 - 4;
                                gradeEnd3 = gradeEnd3 + 4;
                            }

                        }

                        var sixtyFortyGrade3 = (100-(parseFloat(sixFourGradeRange3)*4))*0.10;



                        //postacts grade
                        var postactsEarlyApprovedActivities3 = 0;
                        var postactsTotalActivities3 = 0;
                        var postactsApprovedActivities3 = 0;
                        var postactsLateApprovedActivities3 = 0;

                        for (var i = 0; i < data[35].length; i++){

                            if (data[35][i].studentorganization == organizationid) {

                                postactsTotalActivities3 = postactsTotalActivities3 + 1;

                                // if approved
                                if(data[35][i].status==4){

                                    postactsApprovedActivities3 = postactsApprovedActivities3 + 1;


                                    let actualdatestart3 = data[35][i].actualdatestart;
                                    let datesubmitted3 = data[35][i].datesubmitted;

                                    var diff3 = timediff(actualdatestart3, datesubmitted3, 'D');


                                    if (diff3.days<30){
                                        postactsEarlyApprovedActivities3 = postactsEarlyApprovedActivities3 + 1;
                                    }
                                    else{
                                        postactsLateApprovedActivities3 = postactsLateApprovedActivities3 + 1;
                                    }

                                }


                            }


                        }

                        var postactsPunctualityGrade3 = ((((parseFloat(postactsEarlyApprovedActivities3)/parseFloat(postactsApprovedActivities3))*100)-parseFloat(preactsDeniedActivities3))*0.025);
                        var postactsCompletenessGrade3 = ((parseFloat(postactsApprovedActivities3)/parseFloat(preactsApprovedActivities3))*100)*0.025;

                        if(postactsApprovedActivities3 == 0){
                            postactsPunctualityGrade3 =0;
                        }

                        if(preactsApprovedActivities3==0){
                            postactsCompletenessGrade3 = 0;
                        }

                        var pushedThroughGrade3 = ((parseFloat(preactsApprovedActivities3)/parseFloat(totalActivities3))*100)*0.0015;

                        if(totalActivities3 == 0){

                            preactsTimingRatioGrade3 = 0;
                            pushedThroughGrade3 = 0;

                        }

                        if(notInGOSM3){

                            var notInGOSMGrade3 = 0.15;

                        }
                        else{

                            var notInGOSMGrade3 = 0;

                        }

                        if(lasallianFormationCompliance3){
                            var lasallianFormationComplianceGrade3 = 6;
                        }
                        else{
                            var lasallianFormationComplianceGrade3 = 0;
                        }

                        var documentationGrade3 = (preactsPunctualityGrade3 + preactsCompletenessGrade3 + preactsTimingRatioGrade3
                                                    + gosmSubmissionGrade3 + sixtyFortyGrade3 + postactsPunctualityGrade3
                                                    + postactsCompletenessGrade3 + pushedThroughGrade3 + notInGOSMGrade3
                                                    + lasallianFormationComplianceGrade3);

                        //pnp grade
                        var printedPoster3 = false;
                        var tickets3 = false;
                        var printedPublication3 = false;
                        var onlinePublication3 = false;
                        var printedPublicationCount3 = 0;
                        var onlinePublicationCount3 = 0;
                        var onlinePoster3 = false;

                        for (var i = 0; i < data[36].length; i++){

                            if (data[36][i].studentorganization == organizationid
                                && data[36][i].status == 1) {

                                if(data[36][i].modeOfDistribution == 1){

                                    printedPublication3 = true;

                                    printedPublicationCount3 = printedPublicationCount3 + 1;

                                    if(data[36][i].material == 5){
                                        printedPoster3 = true;
                                    }

                                }
                                else{

                                    onlinePublication3 = true;

                                    onlinePublicationCount3 = onlinePublicationCount3 + 1;

                                    if(data[36][i].material == 5){
                                        onlinePoster3 = true;
                                    }

                                }

                                if (data[36][i].material == 3) {
                                    tickets3 = true;
                                }

                            }

                        }


                        var UniversityPublicityInstrumentGrade3 = 0;
                        var NewsLettersPublicationsGrade3 = 0;
                        var OnlinePublicityGrade3 = 0;


                        if (printedPoster3) {
                            UniversityPublicityInstrumentGrade3 = UniversityPublicityInstrumentGrade3 + 0.5;
                        }

                        if (tickets3) {
                            UniversityPublicityInstrumentGrade3 = UniversityPublicityInstrumentGrade3 + 0.7;
                        }

                        if (printedPublication3) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.35;
                        }

                        if(onlinePublication3) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.35;
                        }

                        if (printedPublicationCount3 == 1) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.05;
                        }
                        else if (printedPublicationCount3 == 2) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.1;
                        }
                        else if (printedPublicationCount3 >= 3) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.15;
                        }

                        if(onlinePublicationCount3 == 1){
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.0375;
                        }
                        else if (onlinePublicationCount3 == 2) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.075;
                        }
                        else if (onlinePublicationCount3 == 3){
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.1125;
                        }
                        else if (onlinePublicationCount3 >= 4) {
                            NewsLettersPublicationsGrade3 = NewsLettersPublicationsGrade3 + 0.15;
                        }

                        if (onlinePoster3) {
                            OnlinePublicityGrade3 = OnlinePublicityGrade3 + 1.5;
                        }

                        var pnpGrade3 = UniversityPublicityInstrumentGrade3 + NewsLettersPublicationsGrade3 + OnlinePublicityGrade3;

                        //orgres grade

                        //officer survey form
                        var osfSurveyTotal3 = 0;
                        var osfField13 = 0;
                        var osfField23 = 0;
                        var osfField33 = 0;
                        var osfField43 = 0;
                        var osfField53 = 0;
                        var osfField63 = 0;
                        var osfField73 = 0;
                        var osfField83 = 0;
                        var osfField93 = 0;


                        for (var i = 0; i < data[37].length; i++){

                            if(data[37][i].organizationID == organizationid){

                                osfSurveyTotal3 = osfSurveyTotal3 + 1;

                                osfField13 = osfField13 + data[37][i].field1;
                                osfField23 = osfField23 + data[37][i].field2;
                                osfField33 = osfField33 + data[37][i].field3;
                                osfField43 = osfField43 + data[37][i].field4;
                                osfField53 = osfField53 + data[37][i].field5;
                                osfField63 = osfField63 + data[37][i].field6;
                                osfField73 = osfField73 + data[37][i].field7;
                                osfField83 = osfField83 + data[37][i].field8;
                                osfField93 = osfField93 + data[37][i].field9;


                            }


                        }

                        var osfField1Average3 = osfField13/osfSurveyTotal3;
                        var osfField2Average3 = osfField23/osfSurveyTotal3;
                        var osfField3Average3 = osfField33/osfSurveyTotal3;
                        var osfField4Average3 = osfField43/osfSurveyTotal3;
                        var osfField5Average3 = osfField53/osfSurveyTotal3;
                        var osfField6Average3 = osfField63/osfSurveyTotal3;
                        var osfField7Average3 = osfField73/osfSurveyTotal3;
                        var osfField8Average3 = osfField83/osfSurveyTotal3;
                        var osfField9Average3 = osfField93/osfSurveyTotal3;

                        if(osfSurveyTotal3 == 0){
                            osfField1Average3 = 0;
                            osfField2Average3 = 0;
                            osfField3Average3 = 0;
                            osfField4Average3 = 0;
                            osfField5Average3 = 0;
                            osfField6Average3 = 0;
                            osfField7Average3 = 0;
                            osfField8Average3 = 0;
                            osfField9Average3 = 0;
                        }

                        //member survey form

                        var msfSurveyTotal3 = 0;
                        var msfField13 = 0;
                        var msfField23 = 0;
                        var msfField33 = 0;
                        var msfField43 = 0;
                        var msfField53 = 0;
                        var msfField63 = 0;
                        var msfField73 = 0;
                        var msfField83 = 0;
                        var msfField93 = 0;
                        var msfField103 = 0;
                        var msfField113 = 0;
                        var msfField123 = 0;
                        var msfField133 = 0;


                        for (var i = 0; i < data[38].length; i++){

                            if(data[38][i].organizationID == organizationid){

                                msfSurveyTotal3 = msfSurveyTotal3 + 1;

                                msfField13 = msfField13 + data[38][i].field1;
                                msfField23 = msfField23 + data[38][i].field2;
                                msfField33 = msfField33 + data[38][i].field3;
                                msfField43 = msfField43 + data[38][i].field4;
                                msfField53 = msfField53 + data[38][i].field5;
                                msfField63 = msfField63 + data[38][i].field6;
                                msfField73 = msfField73 + data[38][i].field7;
                                msfField83 = msfField83 + data[38][i].field8;
                                msfField93 = msfField93 + data[38][i].field9;
                                msfField103 = msfField103 + data[38][i].field10;
                                msfField113 = msfField113 + data[38][i].field11;
                                msfField123 = msfField123 + data[38][i].field12;
                                msfField133 = msfField133 + data[38][i].field13;


                            }


                        }

                        var msfField1Average3 = msfField13/msfSurveyTotal3;
                        var msfField2Average3 = msfField23/msfSurveyTotal3;
                        var msfField3Average3 = msfField33/msfSurveyTotal3;
                        var msfField4Average3 = msfField43/msfSurveyTotal3;
                        var msfField5Average3 = msfField53/msfSurveyTotal3;
                        var msfField6Average3 = msfField63/msfSurveyTotal3;
                        var msfField7Average3 = msfField73/msfSurveyTotal3;
                        var msfField8Average3 = msfField83/msfSurveyTotal3;
                        var msfField9Average3 = msfField93/msfSurveyTotal3;
                        var msfField10Average3 = msfField103/msfSurveyTotal3;
                        var msfField11Average3 = msfField113/msfSurveyTotal3;
                        var msfField12Average3 = msfField123/msfSurveyTotal3;
                        var msfField13Average3 = msfField133/msfSurveyTotal3;

                        if(msfSurveyTotal3 == 0){
                            msfField1Average3 = 0;
                            msfField2Average3 = 0;
                            msfField3Average3 = 0;
                            msfField4Average3 = 0;
                            msfField5Average3 = 0;
                            msfField6Average3 = 0;
                            msfField7Average3 = 0;
                            msfField8Average3 = 0;
                            msfField9Average3 = 0;
                            msfField10Average3 = 0;
                            msfField11Average3 = 0;
                            msfField12Average3 = 0;
                            msfField13Average3 = 0;
                        }

                        //activity research form

                        var arfSurveyTotal3 = 0;
                        var arfField13 = 0;
                        var arfField23 = 0;
                        var arfField33 = 0;
                        var arfField43 = 0;
                        var arfField53 = 0;
                        var arfField63 = 0;
                        var arfField73 = 0;


                        var orgresActivityId3 = 0;
                        var orgresActivityCount3 = 0;
                        var orgresParticipantCount3 = 0;
                        for (var i = 0; i < data[39].length; i++){

                            if(data[39][i].organizationID == organizationid){

                                arfSurveyTotal3 = arfSurveyTotal3 + 1;

                                arfField13 = arfField13 + data[39][i].IUTPOTA;
                                arfField23 = arfField23 + data[39][i].TASMI;
                                arfField33 = arfField33 + data[39][i].IFIDTA;
                                arfField43 = arfField43 + data[39][i].TAWWP;
                                arfField53 = arfField53 + data[39][i].TOUMTGTTA;
                                arfField63 = arfField63 + data[39][i].field6;
                                arfField73 = arfField73 + data[39][i].field7;




                            }


                        }

                        var arfField1Average3 = arfField13/arfSurveyTotal3;
                        var arfField2Average3 = arfField23/arfSurveyTotal3;
                        var arfField3Average3 = arfField33/arfSurveyTotal3;
                        var arfField4Average3 = arfField43/arfSurveyTotal3;
                        var arfField5Average3 = arfField53/arfSurveyTotal3;
                        var arfField6Average3 = arfField63/arfSurveyTotal3;
                        var arfField7Average3 = arfField73/arfSurveyTotal3;

                        if (arfSurveyTotal3 == 0){
                            arfField1Average3 = 0;
                            arfField2Average3 = 0;
                            arfField3Average3 = 0;
                            arfField4Average3 = 0;
                            arfField5Average3 = 0;
                            arfField6Average3 = 0;
                            arfField7Average3 = 0;
                        }

                        //orgres organization members count

                        var totalOrganizationMembers3 = 0;

                        for(var i = 0; i < data[40].length; i++){

                            if (data[40][i].organization == organizationid){

                                totalOrganizationMembers3 = totalOrganizationMembers3 + 1;
                            }


                        }

                        // orgres purpose

                        var purpose13 = ((msfField1Average3/5)*100)*0.04;
                        var purpose23 = ((((arfField1Average3 + msfField2Average3)/2)/5)*100)*0.02;
                        var purpose33 = ((((arfField2Average3 + msfField3Average3 + msfField4Average3)/3)/5)*100)*0.04;

                        var orgresPurposeGrade3 = purpose13 + purpose23 + purpose33;


                        // orgres involvement

                        var involvement13 = ((msfSurveyTotal3/totalOrganizationMembers3)*100)*0.045;

                        if(totalOrganizationMembers3 == 0){
                            involvement13 = 0;
                        }

                        var involvement23 = ((((arfField3Average3 + msfField5Average3 + msfField6Average3)/3)/5)*100)*0.06;
                        var involvement33 = ((((arfField4Average3 + msfField7Average3)/2)/5)*100)*0.045;

                        var orgresInvolvementGrade3 = involvement13 + involvement23 + involvement33;

                        // orgres quality

                        var quality13 = ((msfField8Average3/5)*100)*0.0225;
                        var quality23 = ((((msfField9Average3 + msfField10Average3)/2)/5)*100)*0.015;
                        var quality33 = ((arfField5Average3/5)*100)*0.0225;
                        var quality43 = ((((arfField6Average3 + msfField11Average3)/2)/5)*100)*0.0225;
                        var quality53 = ((((arfField7Average3 + msfField12Average3)/2)/5)*100)*0.015;

                        var orgresQualityGrade3 = quality13 + quality23 + quality33 + quality43 + quality53;


                        //orgres leadership grade

                        var leadership13 = ((((osfField1Average3 + osfField2Average3)/2)/5)*100)*0.0015;
                        var leadership23 = ((osfField3Average3/5)*100)*0.0008;
                        var leadership33 = ((osfField4Average3/5)*100)*0.01;
                        var leadership43 = ((osfField5Average3/5)*100)*0.0015;
                        var leadership53 = ((msfField13Average3/5)*100)*0.0015;
                        var leadership63 = ((((osfField6Average3 + osfField7Average3)/2)/5)*100)*0.0045;
                        var leadership73 = ((osfField8Average3/5)*100)*0.003;
                        var leadership83 = ((osfField9Average3/5)*100)*0.0015;
                        var leadership93 = 0.3;//0.003*100

                        var orgresLeadershipGrade3 = leadership13 + leadership23 + leadership33 + leadership43 + leadership53 + leadership63 + leadership73 + leadership83 + leadership93;

                        var orgresGrade3 = orgresPurposeGrade3 + orgresInvolvementGrade3 + orgresQualityGrade3 + orgresLeadershipGrade3;

                        // amt grade
                        var totalAMTEvaluations3 = data[41].length;
                        var totalAMTEvaluationScore3 = 0;

                        for (var i = 0; i < data[41].length; i++){

                            totalAMTEvaluationScore3 = totalAMTEvaluationScore3 + data[41][i].amtgrade

                        }

                        var amtScore3 = totalAMTEvaluationScore3/totalAMTEvaluations3;

                        if (totalAMTEvaluations3 == 0){

                            amtScore3 = 0;

                        }
                        var amtGrade3 = amtScore3*0.0375;

                        //finance grade

                        var onTimeTransaction3 = 0;
                        var totalApprovedTransaction3 = 0;
                        var approvedParticulars3 = 0;
                        var onBudgetActivities3 = 0;
                        var totalFinanceActivities3 = 0;
                        var relatedExpense3 = 0;
                        var totalExpense3 = 0;
                        var totalActivityBudget3 = 0

                        // approved transactions
                        for (var i = 0; i < data[43].length; i++){

                            let financesign3 = data[43][i].datesigned;
                            let activitystart3 = data[43][i].datestart

                            var budgetdiff3 = timediff(financesign3, activitystart3, 'D');

                            if(budgetdiff3.days <= 3){
                                onTimeTransaction3 = onTimeTransaction3 + 1;
                            }

                            approvedParticulars3 = approvedParticulars3 + data[43][i].particulars;

                            totalApprovedTransaction3 = totalApprovedTransaction3 + 1;

                        }

                        // approved expenses(particulars)
                        for(var i = 0; i < data[44].length; i++){

                            if (data[44][i].expenses <= data[44][i].budget) {
                                onBudgetActivities3 = onBudgetActivities3 + 1;
                            }

                            totalFinanceActivities3 = totalFinanceActivities3 + 1;

                            if (data[44][i].isrelatedtoorganizationnature == true){
                                relatedExpense3 = relatedExpense3 + data[44][i].expenses;
                            }

                            totalExpense3 = totalExpense3 + data[44][i].expenses;

                            totalActivityBudget3 = totalActivityBudget3 + data[44][i].budget;

                        }

                        if(data[45]==null){
                            var totalParticulars3 = 0;
                            var operationalfunds3 = 0;
                            var depositoryfunds3 = 0;
                        }
                        else {
                            var totalParticulars3 = data[45].particulars;
                            var operationalfunds3 = data[45].operationalfunds;
                            var depositoryfunds3 = data[45].depositoryfunds;
                        }


                        // finance monitoring grade

                        var tempMonitoring13 = ((onTimeTransaction3/totalApprovedTransaction3)*100);//*0.01;

                        if (tempMonitoring13 >= 98){
                            var monitoring13 = 1;
                        }
                        else if (tempMonitoring13 >= 95) {
                            var monitoring13 = 0.95;
                        }
                        else if (tempMonitoring13 >= 92) {
                            var monitoring13 = 0.9;
                        }
                        else if (tempMonitoring13 >= 89) {
                            var monitoring13 = 0.85;
                        }
                        else if (tempMonitoring13 >= 86) {
                            var monitoring13 = 0.8;
                        }
                        else if (tempMonitoring13 >= 83) {
                            var monitoring13 = 0.75;
                        }
                        else if (tempMonitoring13 >= 80) {
                            var monitoring13 = 0.7;
                        }
                        else if (tempMonitoring13 >= 77) {
                            var monitoring13 = 0.65;
                        }
                        else if (tempMonitoring13 >= 74) {
                            var monitoring13 = 0.6;
                        }
                        else if (tempMonitoring13 >= 71) {
                            var monitoring13 = 0.55;
                        }
                        else{
                            var monitoring13 = 0.5;
                        }

                        var tempMonitoring23 = ((approvedParticulars3/totalParticulars3)*100);//0.005;

                        if (tempMonitoring23 >= 98){
                            var monitoring23 = 0.5;
                        }
                        else if (tempMonitoring23 >= 95) {
                            var monitoring23 = 0.475;
                        }
                        else if (tempMonitoring23 >= 92) {
                            var monitoring23 = 0.45;
                        }
                        else if (tempMonitoring23 >= 89) {
                            var monitoring23 = 0.425;
                        }
                        else if (tempMonitoring23 >= 86) {
                            var monitoring23 = 0.4;
                        }
                        else if (tempMonitoring23 >= 83) {
                            var monitoring23 = 0.375;
                        }
                        else if (tempMonitoring23 >= 80) {
                            var monitoring23 = 0.35;
                        }
                        else if (tempMonitoring23 >= 77) {
                            var monitoring23 = 0.325;
                        }
                        else if (tempMonitoring23 >= 74) {
                            var monitoring23 = 0.3;
                        }
                        else if (tempMonitoring23 >= 71) {
                            var monitoring23 = 0.275;
                        }
                        else if (tempMonitoring23 >= 68) {
                            var monitoring23 = 0.25;
                        }
                        else if (tempMonitoring23 >= 65) {
                            var monitoring23 = 0.225;
                        }
                        else{
                            var monitoring23 = 0.2;
                        }

                        var monitoring33 = 1;
                        var tempMonitoring453 = ((Math.abs(totalExpense3-totalActivityBudget3))/totalActivityBudget3)*100;

                        if(tempMonitoring453 >= 90 && tempMonitoring453 <=110){
                            var monitoring43 = 1.5;
                        }
                        else if(tempMonitoring453 >= 75 && tempMonitoring453 <= 125){
                            var monitoring43 = 1.35;
                        }
                        else{
                            var monitoring43 = 1.2;
                        }

                        if(tempMonitoring453 >= 90 && tempMonitoring453 <= 110){
                            var monitoring53 = 1;
                        }
                        else if(tempMonitoring453 >= 85 && tempMonitoring453 <=115){
                            var monitoring53 = 0.9;
                        }
                        else if(tempMonitoring453 >= 81 && tempMonitoring453 <=120){
                            var monitoring53 = 0.8;
                        }
                        else if(tempMonitoring453 >= 75 && tempMonitoring453 <= 125){
                            var monitoring53 = 0.7;
                        }
                        else{
                            var monitoring53 = 0.6;
                        }

                        // finance generation grade

                        var generation13 = 0;
                        var generation23 = 0;

                        // finance allocation grade

                        var tempAllocation13 = ((onBudgetActivities3/totalFinanceActivities3)*100);//*0.01;

                        if(tempAllocation13 >= 85){
                            var allocation13 = 1;
                        }
                        else if(tempAllocation13 >= 80){
                            var allocation13 = 0.95;
                        }
                        else if(tempAllocation13 >= 75){
                            var allocation13 = 0.9;
                        }
                        else if(tempAllocation13 >= 70){
                            var allocation13 = 0.85;
                        }
                        else if(tempAllocation13 >= 65){
                            var allocation13 = 0.8;
                        }
                        else if(tempAllocation13 >= 60){
                            var allocation13 = 0.75;
                        }
                        else if(tempAllocation13 >= 55){
                            var allocation13 = 0.7;
                        }
                        else if(tempAllocation13 >= 50){
                            var allocation13 = 0.65;
                        }
                        else{
                            var allocation13 = 0.6;
                        }

                        var tempAllocation23 = Math.abs(60-((relatedExpense3/totalExpense3)*100));

                        if(tempAllocation23 <= 10){
                            var allocation23 = 1;
                        }
                        else if(tempAllocation23 <=20.99){
                            var allocation23 = 0.9;
                        }
                        else if(tempAllocation23 <= 30){
                            var allocation23 = 0.85;
                        }
                        else{
                            var allocation23 = 0.75;
                        }



                        var tempAllocation33 = ((depositoryfunds3-totalExpense3)/depositoryfunds3)*100;

                        if(tempAllocation33 >= 100){
                            var Allocation33 = 1;
                        }
                        else if(tempAllocation33 >= 90){
                            var Allocation33 = 0.9;
                        }
                        else if(tempAllocation33 >= 80){
                            var Allocation33 = 0.8;
                        }
                        else if(tempAllocation33 >= 70){
                            var Allocation33 = 0.75;
                        }
                        else if(tempAllocation33 >= 60){
                            var Allocation33 = 0.7;
                        }
                        else{
                            var Allocation33 = 0.6;
                        }

                        var financeMonitoringGrade3 = monitoring13 + monitoring23 + monitoring33 + monitoring43 + monitoring53;
                        var financeGenerationGrade3 = generation13 + generation23;
                        var financeAllocationGrade3 = allocation13 + allocation23 + Allocation33;

                        var financeGrade3 = financeMonitoringGrade3 + financeGenerationGrade3 + financeAllocationGrade3;



                        // render data grades
                        const renderData = Object.create(null);

                        //preacts
                        renderData.preactsPunctualityGrade = (preactsPunctualityGrade1 + preactsPunctualityGrade2 + preactsPunctualityGrade3)/3;

                        renderData.preactsApprovedActivities = preactsApprovedActivities1 + preactsApprovedActivities2 + preactsApprovedActivities3;
                        renderData.preactsEarlyApprovedActivities = preactsEarlyApprovedActivities1 + preactsEarlyApprovedActivities2+ preactsEarlyApprovedActivities3;
                        renderData.preactsLateApprovedActivities = preactsLateApprovedActivities1 + preactsLateApprovedActivities2 + preactsLateApprovedActivities3;
                        renderData.preactsDeniedActivities = preactsDeniedActivities1 + preactsDeniedActivities2 + preactsDeniedActivities3;
                        renderData.totalActivities = totalActivities1 + totalActivities2 + totalActivities3;
                        renderData.preactsTimingRatio = preactsTimingRatio1 + preactsTimingRatio2 + preactsTimingRatio3;
                        renderData.preactsTimingRatioGrade = (preactsTimingRatioGrade1 + preactsTimingRatioGrade2 + preactsTimingRatioGrade3)/3;
                        renderData.preactsPendCount = preactsPendCount1 + preactsPendCount2 + preactsPendCount3;
                        renderData.preactsCompletenessGrade = (preactsCompletenessGrade1 + preactsCompletenessGrade2 + preactsCompletenessGrade3)/3;
                        renderData.gosmSubmissionGrade = (gosmSubmissionGrade1 + gosmSubmissionGrade2 + gosmSubmissionGrade3)/3;
                        renderData.sixtyFortyGrade = (sixtyFortyGrade1 + sixtyFortyGrade2 + sixtyFortyGrade3)/3;

                        renderData.sixty = isRelatedToOrganizationCount1 + isRelatedToOrganizationCount2 + isRelatedToOrganizationCount3;
                        renderData.forty = (preactsAllApprovedTotal1 + preactsAllApprovedTotal2 + preactsAllApprovedTotal3)-(isRelatedToOrganizationCount1 + isRelatedToOrganizationCount2 + isRelatedToOrganizationCount3);
                        renderData.push = preactsApprovedActivities1 + preactsApprovedActivities2 + preactsApprovedActivities3;
                        renderData.notPush = (totalActivities1 + totalActivities2 + totalActivities3)-(preactsApprovedActivities1 + preactsApprovedActivities2 + preactsApprovedActivities3);

                        //postacts
                        renderData.postactsEarlyApprovedActivities = postactsEarlyApprovedActivities1 + postactsEarlyApprovedActivities2 + postactsEarlyApprovedActivities3;
                        renderData.postactsTotalActivities = postactsTotalActivities1 + postactsTotalActivities2 + postactsTotalActivities3;
                        renderData.postactsApprovedActivities = postactsApprovedActivities1 + postactsApprovedActivities2 + postactsApprovedActivities3;
                        renderData.postactsLateApprovedActivities = postactsLateApprovedActivities1 + postactsLateApprovedActivities2 + postactsLateApprovedActivities3;
                        renderData.postactsPunctualityGrade = (postactsPunctualityGrade1 + postactsPunctualityGrade2 + postactsPunctualityGrade3)/3;
                        renderData.postactsCompletenessGrade = (postactsCompletenessGrade1 + postactsCompletenessGrade2 + postactsCompletenessGrade3)/3;
                        renderData.pushedThroughGrade = (pushedThroughGrade1 + pushedThroughGrade2 + pushedThroughGrade3)/3;
                        renderData.notInGOSMGrade = (notInGOSMGrade1 + notInGOSMGrade2 + notInGOSMGrade3)/3;
                        renderData.lasallianFormationComplianceGrade = (lasallianFormationComplianceGrade1 + lasallianFormationComplianceGrade2 + lasallianFormationComplianceGrade3)/3;

                        renderData.documentationGrade = (documentationGrade1 + documentationGrade2 + documentationGrade3)/3;

                        //orgres
                        renderData.orgresPurposeGrade = (orgresPurposeGrade1 + orgresPurposeGrade2 + orgresPurposeGrade3)/3;
                        renderData.orgresInvolvementGrade = (orgresInvolvementGrade1 + orgresInvolvementGrade2 + orgresInvolvementGrade3)/3;
                        renderData.orgresQualityGrade = (orgresQualityGrade1 + orgresQualityGrade2 + orgresQualityGrade3)/3;
                        renderData.orgresLeadershipGrade = (orgresLeadershipGrade1 + orgresLeadershipGrade2 + orgresLeadershipGrade3)/3;
                        renderData.orgresGrade = (orgresGrade1 + orgresGrade2 + orgresGrade3)/3;

                        renderData.osfField1Average = (osfField1Average1 + osfField1Average2 + osfField1Average3)/3;
                        renderData.osfField2Average = (osfField2Average1 + osfField2Average2 + osfField2Average3)/3;
                        renderData.osfField3Average = (osfField3Average1 + osfField3Average2 + osfField3Average3)/3;
                        renderData.osfField4Average = (osfField4Average1 + osfField4Average2 + osfField4Average3)/3;
                        renderData.osfField5Average = (osfField5Average1 + osfField5Average2 + osfField5Average3)/3;
                        renderData.osfField6Average = (osfField6Average1 + osfField6Average2 + osfField6Average3)/3;
                        renderData.osfField7Average = (osfField7Average1 + osfField7Average2 + osfField7Average3)/3;
                        renderData.osfField8Average = (osfField8Average1 + osfField8Average2 + osfField9Average3)/3;
                        renderData.osfField9Average = (osfField9Average1 + osfField9Average2 + osfField9Average3)/3;

                        renderData.msfField1Average = (msfField1Average1 + msfField1Average2 + msfField1Average3)/3;
                        renderData.msfField2Average = (msfField2Average1 + msfField2Average2 + msfField2Average3)/3;
                        renderData.msfField3Average = (msfField3Average1 + msfField3Average2 + msfField3Average3)/3;
                        renderData.msfField4Average = (msfField4Average1 + msfField4Average2 + msfField4Average3)/3;
                        renderData.msfField5Average = (msfField5Average1 + msfField5Average2 + msfField5Average3)/3;
                        renderData.msfField6Average = (msfField6Average1 + msfField6Average2 + msfField6Average3)/3;
                        renderData.msfField7Average = (msfField7Average1 + msfField7Average2 + msfField7Average3)/3;
                        renderData.msfField8Average = (msfField8Average1 + msfField8Average2 + msfField8Average3)/3;
                        renderData.msfField9Average = (msfField9Average1 + msfField9Average2 + msfField9Average3)/3;
                        renderData.msfField10Average = (msfField10Average1 + msfField10Average2 + msfField10Average3)/3;
                        renderData.msfField11Average = (msfField11Average1 + msfField11Average2 + msfField11Average3)/3;
                        renderData.msfField12Average = (msfField12Average1 + msfField12Average2 + msfField12Average3)/3;
                        renderData.msfField13Average = (msfField13Average1 + msfField13Average2 + msfField13Average3)/3;


                        //documentation info
                        renderData.sixtyCount = isRelatedToOrganizationCount1 + isRelatedToOrganizationCount2 + isRelatedToOrganizationCount3;
                        renderData.fortyCount = preactsAllApprovedTotal1 + preactsAllApprovedTotal2 + preactsAllApprovedTotal3;

    
                        renderData.numCompetition = parseInt(data[15][0].activitycount) + parseInt(data[31][0].activitycount) + parseInt(data[47][0].activitycount);
                        renderData.numDistribution = parseInt(data[15][1].activitycount) + parseInt(data[31][1].activitycount) + parseInt(data[47][1].activitycount);
                        renderData.numGeneralAssembly = parseInt(data[15][2].activitycount) + parseInt(data[31][2].activitycount) + parseInt(data[47][2].activitycount);
                        renderData.numSeminar = parseInt(data[15][3].activitycount) + parseInt(data[31][3].activitycount) + parseInt(data[47][3].activitycount);
                        renderData.numPublicity = parseInt(data[15][4].activitycount) + parseInt(data[31][4].activitycount) + parseInt(data[47][4].activitycount);
                        renderData.numMeetings = parseInt(data[15][5].activitycount) + parseInt(data[31][5].activitycount) + parseInt(data[47][5].activitycount);
                        renderData.numSpiritualActivity = parseInt(data[15][6].activitycount) + parseInt(data[31][6].activitycount) + parseInt(data[47][6].activitycount);
                        renderData.numRecruitment = parseInt(data[15][7].activitycount) + parseInt(data[31][7].activitycount) + parseInt(data[47][7].activitycount);
                        renderData.numRecreation = parseInt(data[15][8].activitycount) + parseInt(data[31][8].activitycount) + parseInt(data[47][8].activitycount);
                        renderData.numOthers = parseInt(data[15][9].activitycount) + parseInt(data[31][9].activitycount) + parseInt(data[47][9].activitycount);
      

                        //pnp
                        renderData.universityPublicityInstrumentGrade = (UniversityPublicityInstrumentGrade1 + UniversityPublicityInstrumentGrade2 + UniversityPublicityInstrumentGrade3)/3;
                        renderData.newsLettersPublicationsGrade = (NewsLettersPublicationsGrade1 + NewsLettersPublicationsGrade2 + NewsLettersPublicationsGrade3)/3;
                        renderData.onlinePublicityGrade = (OnlinePublicityGrade1 + OnlinePublicityGrade2 + OnlinePublicityGrade3)/3;
                        renderData.pnpCompliance = 0.3;
                        renderData.pnpGrade = ((pnpGrade1 + pnpGrade2 + pnpGrade3)/3) + 0.3;

                        //amt
                        renderData.amtActivities = data[9];
                        renderData.amtActivities2 = data[25];
                        renderData.amtActivities3 = data[41];
                        renderData.amtAverageScores = data[10];
                        renderData.amtAverageScores2 = data[26];
                        renderData.amtAverageScores3 = data[42];

                        renderData.amtScore = (amtScore1 + amtScore2 + amtScore3)/3;
                        renderData.amtGrade = (amtGrade1 + amtScore2 + amtScore3)/3;

                        //finance
                        renderData.financeMonitoringGrade = (financeMonitoringGrade1 + financeMonitoringGrade2 + financeMonitoringGrade3)/3;
                        renderData.financeGenerationGrade = (financeGenerationGrade1 + financeGenerationGrade2 + financeGenerationGrade3)/3;
                        renderData.financeAllocationGrade = (financeAllocationGrade1 + financeAllocationGrade2 + financeAllocationGrade3)/3;
                        renderData.financeGrade = (financeGrade1 + financeGrade2 + financeGrade3)/3;

                        renderData.financeTransactions = data[14];
                        renderData.financeTransactions2 = data[30];
                        renderData.financeTransactions3 = data[46];


                        renderData.gradeType = true;

                        var organizationParam = {
                            studentorganization: organizationid
                        };

                        organizationModel.getStudentOrganization(organizationParam)
                        .then(organizationData=>{

                            renderData.organization = organizationData;
                            renderData.term = term[0];
                            console.log(renderData)
                            renderData.extra_data = req.extra_data;
                            renderData.csrfToken = req.csrfToken();
                            return res.render('Org/report', renderData);

                        }).catch(error=>{
                            console.log(error);
                        })


                    }).catch(error=>{
                        console.log(error);
                    });



                }).catch(error=>{
                    console.log(error);
                });

            }
            else{
                res.render(`/System/404`);
            }


        },


        // viewGOSMDetails: (req, res) => {
        //     const renderData = Object.create(null);
        //     console.log(req.param)
        //     renderData.extra_data = req.extra_data;
        //     return res.render('Org/gosmDetails');

        // },

        viewNotInGosmList: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('Org/NotInGosmList');
        },
        viewNotInGosmMain: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_main');
        },
        viewNotInGosmAttachments: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_attachments');
        },
        viewNotInGosmBriefContext: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('Org/SubmitNotInGosm_briefContext');
        },
        viewNotInGosmExpense: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
            renderData.extra_data = req.extra_data;
            return res.render('Org/submitNotInGosm_expense');
        },
        viewNotInGosmProgramDesign: (req, res) => {
            const renderData = Object.create(null);
            renderData.csrfToken = req.csrfToken();
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

                        ]),
                        gosmModel.getTermEndDate()

                    ]);
                }).catch(err => {
                    console.log(err)
                    // return logger.warn(`Unhandled error: ${err.message}\n${err.stack} `, log_options);
                });
            }).then(data => {
                // logger.debug(`${JSON.stringify(data[3])}`, log_options);
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
                renderData.termend = data[8]
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
                // console.log(data[2].length > 0)
                console.log("REVENUE")
                console.log(renderData.isProjecthead)
                console.log("EXPENSE")

                renderData.resched = timediff(data[3][0].datestart, data[3][0].currdate, 'D').days
                console.log("Date DIFF")
                // console.log(data[3].currdate)
                console.log(renderData.resched)
                console.log(renderData.attachment);
                console.log("renderData.attachment");
                return res.render('Org/viewActivityDetails', renderData);
            }).catch(err => {
               console.log(err)
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

                    console.log(dbParam)
                    projectProposalModel.insertProjectProposal(dbParam).then(data => {
                        console.log("DATA  NIL")
                        console.log(data)
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

                            if(data[2].isbriefcontextcomplete == false){
                                var contextCompletionRate = 0;

                                var expensestatus = false;

                                if (data[2].enp != null && data[2].enp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].enmp != null && data[2].enmp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].venue != null) {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("venue");
                                    expensestatus = true;
                                }
                                if (data[2].facultyadviser != null && data[2].facultyadviser != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("facultyadviser");
                                    expensestatus = true;
                                }
                                if (data[2].context1 != null && data[2].context1 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context2 != null && data[2].context2 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context3 != null && data[2].context3 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if(expensestatus){
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                renderData.contextCompletionRate = contextCompletionRate;
                            }

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

                            console.log("err 3  ")
                            console.log(err)
                            // logger.error(`${err.message}\n${err.stack}`, log_options);

                        });
                    }).catch(err=>{
                         console.log("err 2 ")
                            console.log(err)
                    })

                }).catch(error => {
                    console.log("err4")
                     console.log(err)
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

                        if(data[2].isbriefcontextcomplete == false){
                                var contextCompletionRate = 0;

                                var expensestatus = false;

                                if (data[2].enp != null && data[2].enp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].enmp != null && data[2].enmp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].venue != null) {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("venue");
                                    expensestatus = true;
                                }
                                if (data[2].facultyadviser != null && data[2].facultyadviser != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("facultyadviser");
                                    expensestatus = true;
                                }
                                if (data[2].context1 != null && data[2].context1 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context2 != null && data[2].context2 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context3 != null && data[2].context3 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if(expensestatus){
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                renderData.contextCompletionRate = contextCompletionRate;
                            }

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

                        if(data[2].isbriefcontextcomplete == false){
                                var contextCompletionRate = 0;

                                var expensestatus = false;

                                if (data[2].enp != null && data[2].enp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].enmp != null && data[2].enmp != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].venue != null) {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("venue");
                                    expensestatus = true;
                                }
                                if (data[2].facultyadviser != null && data[2].facultyadviser != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                    console.log("facultyadviser");
                                    expensestatus = true;
                                }
                                if (data[2].context1 != null && data[2].context1 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context2 != null && data[2].context2 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if (data[2].context3 != null && data[2].context3 != '') {
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                if(expensestatus){
                                    contextCompletionRate  = contextCompletionRate + 3.125
                                }
                                renderData.contextCompletionRate = contextCompletionRate;
                            }

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
                    projectProposalModel.getLatestProjectProposalAttachment(gl,task)

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
                console.log(data[2])
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
                            projectProposalModel.getProjectProposalRevenuePPRID(data.id,transaction),
                            projectProposalModel.getOrganizationFundsAndExpense(dbParam, transaction)

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
                    renderData.listexpenses = data[3];
                    renderData.listrevenues = data[4];
                    renderData.FundsExpense = data[5];

                    // renderData.sectionsToEdit = data[3];


                    console.log("FUNDS EXPENSE");
                    console.log(data[5]);

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

                        ]),
                         gosmModel.getTermEndDate(),
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
                renderData.termend = data[3]
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
            renderData.csrfToken = req.csrfToken();

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
                renderData.csrfToken = req.csrfToken();
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

            var param = {
                studentorganization: req.session.user.organizationSelected.id
            }

            organizationModel.getStudentOrganization(param)
            .then(organizationData=>{

                console.log(organizationData);

                // ASO, CAP12, ENGAGE, PROBE
                if(organizationData.cluster != 2){


                    if(req.body['nature-type'] == 1){

                        var isRelatedToOrganization = true;

                    }
                    else{

                        var isRelatedToOrganization = false;

                    }


                }// ASPIRE
                else{

                    if(req.body['nature-type'] == 2){

                        var isRelatedToOrganization = true;

                    }
                    else{

                        var isRelatedToOrganization = false;

                    }

                }

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



            }).catch(error=>{
                console.log(error);
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
                            gosmModel.getOrgGOSM(GOSMParam, task1),
                            gosmModel.getTermEndDate(),
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
                    renderData.termend = data[5]
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
                    console.log(GOSM)
                    GOSMParam.termID = GOSM[1].termid
                    GOSMParam.studentOrganization = req.session.user.organizationSelected.id;

                    logger.debug('Starting batch queries', log_options);
                    return task1.batch([
                        gosmModel.getGOSMActivities(GOSM[0], undefined, task1),
                        gosmModel.getAllActivityTypes(['id', 'name'], task1),
                        gosmModel.getAllActivityNature(['id', 'name'], task1),
                        organizationModel.getStudentsOfOrganization(dbParam),
                        gosmModel.getOrgGOSM(GOSMParam, task1),
                        gosmModel.getRelated(GOSM[0]),
                        gosmModel.getNotRelated(GOSM[0]),
                        gosmModel.getTermEndDate(),
                    ])
                });
            }).then(data => {
                console.log("TTTTTTTTTTTTTTTTTTTTTTTTTTT")
                console.log(data[5])
                const renderData = Object.create(null);
                renderData.extra_data = req.extra_data;
                renderData.csrfToken = req.csrfToken();

                renderData.activityTypes = data[1];
                renderData.activityNature = data[2];
                renderData.gosmActivities = data[0];
                renderData.oid = req.session.user.organizationSelected.id;
                renderData.members = data[3];
                var rele = parseInt(data[5].related)
                var nrele = parseInt(data[6].notrelated);
                renderData.rrelated = Math.round(rele / (rele+nrele)*100);
                renderData.rnotrelated = Math.round(nrele / (rele+nrele)*100);
                renderData.related = rele;
                renderData.notrelated = nrele;
                renderData.termend = data[7];
                console.log("renderData.rrelated")
                console.log(renderData.rrelated)
                if(isNaN(renderData.rrelated)){
                    console.log("renderData.rrelated PUMASOK")
                    renderData.rrelated = 0
                    renderData.rnotrelated = 0
                }

                if (data[4] != undefined) {
                    renderData.status = data[4].status;
                    renderData.comments = data[4].comments;

                    console.log(data[4])
                }

                console.log("GOSM DATA")

                logger.debug('Rendering page', log_options);
                if (renderData.status == 3 || renderData.status == 5) {
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
            renderData.csrfToken = req.csrfToken();
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

        checkRatio:(req, res)=>{

            database.task(t=>{
                return  gosmModel.getCurrentTermGOSM(req.session.user.organizationSelected.id,t)
                        .then(data=>{
                            console.log(data.id)
                            return t.batch([
                                    gosmModel.getRelated(data.id),
                                    gosmModel.getNotRelated(data.id)
                                    ])



                        }).catch(err=>{

                        })
            }).then(data=>{
                console.log("REAL DATA")

                return res.json({related:data[0].related,notrelated:data[1].notrelated})
            }).catch(err=>{
                console.log(err)
            })

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
                !(req.body.mistakes).trim() ||
                !(req.body.anmp).trim() ||
                !(req.body.anp).trim()
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
                                for (var ctr = 0; ctr < pictures.length; ctr++) {
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

            database.tx(task => {

                return gosmModel.getGOSMActivityType(req.body.activityId, undefined, task).
                    then(data => {
                        console.log("DATA");
                        console.log(data);
                        return task.batch([
                            projectProposalModel.getLatestVersionAttachment(req.body.pid,task),
                            gosmModel.getGOSMActivityAttachmentRequirement(data[0].activitytype,task)
                            ]).then(data=>{
                                    var ctr = 0;
                                    console.log("data")
                                    console.log(data[0])

                                    let files = req.files['uploadfile[]'] ? req.files['uploadfile[]'] : req.files.uploadFile;
                                    if (!Array.isArray(files)) {
                                        files = [files];
                                    }
                                    var seq = 1;
                                    if(!isNaN(data[0][0].latest)){
                                        console.log("PUMASOK SA VERSION")
                                        seq = data[0][0].latest + 1;
                                    }
                                    var result = data[1].map(function(e){
                                        return e.id
                                    })
                                    result = result.concat(req.body['attachmentOthers[]'])
                                    // console.log(data);
                                    console.log("TYPE OF ONE UPLOAD");
                                    console.log(typeof files[Symbol.iterator]);
                                    if (typeof files[Symbol.iterator] == 'function') {

                                        console.log("result")
                                        console.log(result)
                                        console.log(req.body['attachmentOthers[]'])

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
                                                requirement: result[ctr],
                                                dir: dir2 + file.name + ' - ' + date,
                                                idNumber: req.session.user.idNumber,
                                                filename: date + '.' + nFilename,
                                                filenametoShow: file.name,
                                                sequence:seq

                                            };
                                            console.log("FILE");
                                            console.log(db);
                                            console.log(path.normalize(path.join(dir2, date + '.' + nFilename)));
                                            var p = path.normalize(path.join(dir2, date + '.' + nFilename));
                                            Promise.all([
                                                file.mv(p),
                                                projectProposalModel.insertProjectProposalAttachment(db,task)

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
                                            requirement: result[ctr],
                                            dir: dir2 + file.name + ' - ' + date,
                                            idNumber: req.session.user.idNumber,
                                            filename: date + '.' + nFilename,
                                            filenametoShow: file.name,
                                            sequence:seq

                                        };

                                        console.log("FILE");
                                        var p = path.normalize(path.join(dir2, date + '.' + nFilename));
                                        console.log(path.normalize(path.join(dir2, date + '.' + nFilename)));
                                        Promise.all([
                                                file.mv(p),
                                                projectProposalModel.insertProjectProposalAttachment(db,task)

                                            ]).then(result => {
                                                console.log(result);
                                            }).catch(err => {
                                                console.log(err);
                                            });
                                    }
                            })

                     });

            }).then(data => {



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
                var pubstime = timediff(new Date(), activities.actualdatestart,'D').days;
                console.log("pubstime")
                console.log(pubstime);
                renderData.pubstime = false;
                if(pubstime >= 0){
                    renderData.pubstime = true;
                }
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

            console.log("==========================")
            console.log(req.body)
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

                console.log('GOOOOOOOOOOOOLD')
                console.log(dbParam)
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
                console.log('GOOOOOOOOOOOOLD')
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


            organizationModel.addMember(req.body.idnumber, req.body.name, req.session.user.organizationSelected.id).then(data=>{
                return res.json({status:1})
            }).catch(err=>{
                console.log(err)
                return res.json({status:0})
            })


        },
        deleteMember: (req, res) => {


            organizationModel.deleteMember(req.body.idnumber, req.session.user.organizationSelected.id).then(data=>{
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
                renderData.scores = data[3];
                var arr = data[3]
                var first = [0,0,0,0,0];
                var second = [0,0,0,0,0];
                var third = [0,0,0,0,0];
                var fourth = [0,0,0,0,0];
                var fifth = [0,0,0,0,0];    
                var sixth = [0,0,0,0,0];    
                var seventh = [0,0,0,0,0];    

                var fave = 0
                var fctr = 0 ;
                var save = 0
                var sctr = 0 ;
                var tave = 0
                var tctr = 0 ;
                var ffave = 0
                var ffctr = 0 ;
                var fffave = 0
                var fffctr = 0 ;

                var ssave = 0
                var ssctr = 0 ;

                var sssave = 0
                var sssctr = 0 ;
                for(var ctr = 0; ctr < arr.length; ctr++){
                    console.log(arr[ctr])
                    if(arr[ctr].test == 1){
                        first[arr[ctr].IUTPOTA -1] = arr[ctr].count
                        fave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        console.log(fave)
                        fctr += parseInt(arr[ctr].count)
                        console.log(fctr)
                    }else if (arr[ctr].test == 2){
                        second[arr[ctr].IUTPOTA - 1] = arr[ctr].count
                        save += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        sctr += parseInt(arr[ctr].count)
                    }else if (arr[ctr].test == 3){
                        third[arr[ctr].IUTPOTA - 1] = arr[ctr].count
                        tave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        tctr += parseInt(arr[ctr].count)
                    }else if (arr[ctr].test == 4){
                        fourth[arr[ctr].IUTPOTA -1 ] = arr[ctr].count
                        ffave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        ffctr += parseInt(arr[ctr].count)
                    }else if (arr[ctr].test == 5){
                        fifth[arr[ctr].IUTPOTA - 1] = arr[ctr].count
                        fffave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        fffctr += parseInt(arr[ctr].count)
                    }else if (arr[ctr].test == 6){
                        sixth[arr[ctr].IUTPOTA - 1] = arr[ctr].count
                        ssave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        ssctr += parseInt(arr[ctr].count)
                    }else if (arr[ctr].test == 7){
                        seventh[arr[ctr].IUTPOTA - 1] = arr[ctr].count
                        sssave += arr[ctr].IUTPOTA * parseInt(arr[ctr].count)
                        sssctr += parseInt(arr[ctr].count)
                    }
                }
                renderData.first = first
                var temp =  parseFloat(fave / fctr)
                if(isNaN(temp)){
                    temp = 0
                }
                renderData.fave = temp

                renderData.second = second

                var temp2 =  parseFloat(save / sctr)
                if(isNaN(temp2)){
                    temp2 = 0
                }
                renderData.save =  temp2

                var temp3 =  parseFloat(tave / tctr)
                if(isNaN(temp3)){
                    temp3 = 0
                }
                renderData.third = third
                renderData.tave =  temp3


                var temp4 =  parseFloat(ffave / ffctr)
                if(isNaN(temp4)){
                    temp4 = 0
                }
                renderData.fourth = fourth
                renderData.ffave =  temp4


                var temp5 =  parseFloat(fffave / fffctr)
                if(isNaN(temp5)){
                    temp5 = 0
                }
                renderData.fifth = fifth;
                renderData.fffave = temp5

                var temp6 =  parseFloat(ssave / ssctr)
                if(isNaN(temp6)){
                    temp6 = 0
                }               
                renderData.sixth = sixth;
                renderData.ssave = temp6

                var temp7 =  parseFloat(sssave / sssctr)
                if(isNaN(temp7)){
                    temp7 = 0
                }       

                renderData.seventh = seventh;
                renderData.sssave = temp7

                console.log(renderData)
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
