'use strict';
var timediff = require('timediff');
module.exports = function(configuration, modules, models, database, queryFiles){
	let AMTController = Object.create(null);

	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'AMT-Controlller';

	const amtModel = models.ActivityMonitoring_model;
	const projectProposalModel = models.ProjectProposal_model;
	const organizationModel = models.organization_model;
	const gosmModel = models.gosmModel;

    const accountModel = models.Account_model;
    const systemModel = models.System_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const pnpModel = models.PNP_model;
    const orgresModel = models.Orgres_model;
    const financeModel = models.Finance_model;

	AMTController.viewActivityEvaluation = (req, res) => {
		const activityId = req.params.activity;
		console.log("activity is");
		console.log(activityId);

		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();
		renderData.activity = activityId;
		
		return res.render('AMT/ActivityEvaluation', renderData);
	};

	AMTController.viewHome = (req, res) => {

		database.task(task => {
                        return task.batch([
                            amtModel.getAllAMTEvaluation(),
                            organizationModel.getAllStudentOrganizations(),
                            gosmModel.getAllCurrent()
                        ]);
        }).then(homeData=>{

            let renderData = Object.create(null);

            var pendingActivities = 0;
            var takenActivities = 0;
            var evaluatedActivities = 0;

            for (var i = 0; i < homeData[0].length; i++){

                if (homeData[0][i].status == 0) {
                    pendingActivities = pendingActivities + 1;
                }
                else if(homeData[0][i].status == 1){
                    takenActivities = takenActivities + 1;
                }
                else if(homeData[0][i].status == 3){
                    evaluatedActivities = evaluatedActivities + 1;
                }
            }

            return database.task(task => {
                return task.batch([
                    //list of organizations
                    Promise.resolve(homeData[1]),
                    //list of all gosm
                    Promise.resolve(homeData[2]),
                    Promise.resolve(pendingActivities),
                    Promise.resolve(takenActivities),
                    Promise.resolve(evaluatedActivities),
                    //TODO: give task to models
                    systemModel.getCurrentTerm([
                        'id',
                        "to_char(dateStart, 'YYYY-MM-DD') AS dateStart",
                        "to_char(dateEnd, 'YYYY-MM-DD') AS dateEnd"
                    ]),
                    projectProposalModel.getAllProjectProposal(),
                    organizationModel.getAllStudentOrganizations(),
                    gosmModel.getAllCurrent()
                ]);
            });
        }).then(homeData => {
            let organizations = homeData.shift();
            let gosm = homeData.shift();
            let pendingActivities = homeData.shift();
            let takenActivities = homeData.shift();
            let evaluatedActivities = homeData.shift();
            let term = homeData.shift();

            let termstart = term.datestart;

            return database.task(task => {
                let queries = [
                    Promise.resolve(organizations),
                    Promise.resolve(gosm),
                    Promise.resolve(pendingActivities),
                    Promise.resolve(takenActivities),
                    Promise.resolve(evaluatedActivities),
                    Promise.resolve(termstart)
                ];

                for(const organization of homeData[1]){
                    const organizationid = organization.id;
                    logger.debug(`organizationID: ${organizationid}`,log_options);

                    let dbParam = {
                        studentOrganization: organizationid,
                        termID: term.id
                    };

                    //wew task
                    queries.push(task.task(task => {
                        return task.batch([
                            //0
                            projectProposalModel.getApprovedActivities(dbParam, task),
                            //1
                            projectProposalModel.getAllProjectProposalPerTerm(dbParam, task),
                            //2
                            gosmModel.getOrgGOSM(dbParam, task),
                            //3
                            postProjectProposalModel.getAllPostProjectProposalPerTerm(dbParam, task),
                            //PNP
                            //4
                            pnpModel.getAllActivityPublicityPerTerm(dbParam, task),
                            //ORGRES
                            //5
                            orgresModel.getAllOfficerSurveyFormPerTerm(dbParam, task),
                            //6
                            orgresModel.getAllMemberSurveyFormPerTerm(dbParam, task),
                            //7
                            orgresModel.getAllActivityResearchFormPerTerm(dbParam, task),
                            //8
                            organizationModel.getAllOrganizationMembersPerYear(dbParam, task),
                            //AMT
                            //9
                            amtModel.getAllAMTEvaluationResults(dbParam, task),
                            //10
                            amtModel.getAllAMTScoreAverages(dbParam, task),
                            //FINANCE
                            //11
                            financeModel.getAllApprovedTransactions(dbParam, task),
                            //12
                            financeModel.getAllApprovedActivityExpenses(dbParam, task),
                            //13
                            financeModel.getOrganizationBudgetExpenses(dbParam, task),
                            //14
                            financeModel.getOrgApprovedTransactions(dbParam, task),
                            //15
                            Promise.resolve(organizationid)
                        ]);
                    }));
                }

                return task.batch(queries);
            });
        }).then(organizationDatas => {
            let organizations = organizationDatas.shift();
            let gosm = organizationDatas.shift();
            let pendingActivities = organizationDatas.shift();
            let takenActivities = organizationDatas.shift();
            let evaluatedActivities = organizationDatas.shift();
            let termstart = organizationDatas.shift();

            let totalGrade = [];
            const start = Date.now();
            logger.debug(`Computing each org grade - start: ${start}`, log_options);
            for(const data of organizationDatas){
                let organizationid = data[15];

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

                if (data[2] != null) {
                    if (data[2].orggosmsubmitted == null) {} else {
                        let orggosmsubmitted = data[2].orggosmsubmitted;

                        var gosmdiff = timediff(termstart, orggosmsubmitted, 'D');

                        if (gosmdiff.days <= 14) {
                            gosmSubmissionGrade = 0.075;
                        }
                    }
                }

                //approved activities
                for (var i = 0; data[0].length > i; i++) {
                    //TODO: change depending on org??
                    if (data[0][i].studentorganization == organizationid && data[0][i].isingosm == true) {
                        preactsApprovedActivities = preactsApprovedActivities + 1;

                        if (data[0][i].activitynature == 8) {
                            lasallianFormationCompliance = true
                        }

                        let actualdatestart = data[0][i].actualdatestart;
                        let datesigned = data[0][i].datesigned;
                        let targetdatestart = data[0][i].targetdatestart;

                        var diff = timediff(actualdatestart, datesigned, 'D');

                        if (diff.days < 2) {
                            preactsEarlyApprovedActivities = preactsEarlyApprovedActivities + 1;
                        } else {
                            preactsLateApprovedActivities = preactsLateApprovedActivities + 1;
                        }

                        var timingdiff = timediff(targetdatestart, actualdatestart, 'D');

                        if (timingdiff.days < 7 && timingdiff.days > -7) {
                            preactsTimingRatio = preactsTimingRatio + 1;
                        }
                    }

                    if (data[0][i].studentorganization == organizationid &&
                        data[0][i].isrelatedtoorganizationnature == true) {
                        isRelatedToOrganizationCount = isRelatedToOrganizationCount + 1;
                    }

                    if (data[0][i].studentorganization == organizationid) {
                        preactsAllApprovedTotal = preactsAllApprovedTotal + 1;
                    }
                }

                // all activities
                for (var i = 0; data[1].length > i; i++) {

                    //TODO: change depending on org??
                    if (data[1][i].studentorganization == organizationid &&
                        data[1][i].isingosm == true) {

                        totalActivities = totalActivities + 1;

                        preactsPendCount = preactsPendCount + data[1][i].timespended;


                        if (data[1][i].status == 5) {
                            preactsDeniedActivities = preactsDeniedActivities + 1;
                        }

                    } else if (data[1][i].studentorganization == organizationid &&
                        data[1][i].isingosm == false) {
                        notInGOSM = true;
                    }
                }

                var preactsPunctualityGrade = ((((parseFloat(preactsEarlyApprovedActivities) / parseFloat(preactsApprovedActivities)) * 100) - parseFloat(preactsDeniedActivities)) * 0.025);
                var preactsTimingRatioGrade = (((parseFloat(preactsTimingRatio) / parseFloat(totalActivities)) * 100) * 0.015);
                var preactsCompletenessGrade = (100 - (parseFloat(preactsPendCount) * 0.5)) * 0.025;
                var sixtyFortyRatioPercentage = isRelatedToOrganizationCount / preactsAllApprovedTotal;

                if (preactsApprovedActivities == 0) {
                    preactsPunctualityGrade = 0;
                }

                if (preactsAllApprovedTotal == 0) {
                    sixtyFortyRatioPercentage = 0;
                }

                var sixFourGradeRange = 0
                var sixtyFortyGradeFound = true;
                var gradeStart = 57;
                var gradeEnd = 63;

                while (sixtyFortyGradeFound) {
                    if (sixtyFortyRatioPercentage >= gradeStart && sixtyFortyRatioPercentage <= gradeEnd) {
                        sixtyFortyGradeFound = false;
                    } else {
                        sixFourGradeRange = sixFourGradeRange + 1;
                        gradeStart = gradeStart - 4;
                        gradeEnd = gradeEnd + 4;
                    }
                }

                var sixtyFortyGrade = (100 - (parseFloat(sixFourGradeRange) * 4)) * 0.10;

                //postacts grade
                var postactsEarlyApprovedActivities = 0;
                var postactsTotalActivities = 0;
                var postactsApprovedActivities = 0;
                var postactsLateApprovedActivities = 0;

                for (var i = 0; i < data[3].length; i++) {
                    if (data[3][i].studentorganization == organizationid) {
                        postactsTotalActivities = postactsTotalActivities + 1;
                        // if approved
                        if (data[3][i].status == 4) {
                            postactsApprovedActivities = postactsApprovedActivities + 1;
                            let actualdatestart = data[3][i].actualdatestart;
                            let datesubmitted = data[3][i].datesubmitted;
                            var diff = timediff(actualdatestart, datesubmitted, 'D');
                            if (diff.days < 30) {
                                postactsEarlyApprovedActivities = postactsEarlyApprovedActivities + 1;
                            } else {
                                postactsLateApprovedActivities = postactsLateApprovedActivities + 1;
                            }
                        }
                    }
                }

                var postactsPunctualityGrade = ((((parseFloat(postactsEarlyApprovedActivities) / parseFloat(postactsApprovedActivities)) * 100) - parseFloat(preactsDeniedActivities)) * 0.025);
                var postactsCompletenessGrade = ((parseFloat(postactsApprovedActivities) / parseFloat(preactsApprovedActivities)) * 100) * 0.025;

                if (postactsApprovedActivities == 0) {
                    postactsPunctualityGrade = 0;
                }

                if (preactsApprovedActivities == 0) {
                    postactsCompletenessGrade = 0;
                }

                var pushedThroughGrade = ((parseFloat(preactsApprovedActivities) / parseFloat(totalActivities)) * 100) * 0.0015;

                if (totalActivities == 0) {
                    preactsTimingRatioGrade = 0;
                    pushedThroughGrade = 0;
                }

                if (notInGOSM) {
                    var notInGOSMGrade = 0.15;
                } else {
                    var notInGOSMGrade = 0;
                }

                if (lasallianFormationCompliance) {
                    var lasallianFormationComplianceGrade = 6;
                } else {
                    var lasallianFormationComplianceGrade = 0;
                }

                var documentationGrade = (preactsPunctualityGrade + preactsCompletenessGrade + preactsTimingRatioGrade +
                    gosmSubmissionGrade + sixtyFortyGrade + postactsPunctualityGrade +
                    postactsCompletenessGrade + pushedThroughGrade + notInGOSMGrade +
                    lasallianFormationComplianceGrade);

                //pnp grade
                var printedPoster = false;
                var tickets = false;
                var printedPublication = false;
                var onlinePublication = false;
                var printedPublicationCount = 0;
                var onlinePublicationCount = 0;
                var onlinePoster = false;

                for (var i = 0; i < data[4].length; i++) {
                    if (data[4][i].studentorganization == organizationid &&
                        data[4][i].apstatus == 1) {

                        if (data[4][i].modeOfDistribution == 1) {

                            printedPublication = true;

                            printedPublicationCount = printedPublicationCount + 1;

                            if (data[4][i].material == 5) {
                                printedPoster = true;
                            }

                        } else {
                            onlinePublication = true;
                            onlinePublicationCount = onlinePublicationCount + 1;
                            if (data[4][i].material == 5) {
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

                if (onlinePublication) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.35;
                }

                if (printedPublicationCount == 1) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.05;
                } else if (printedPublicationCount == 2) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.1;
                } else if (printedPublicationCount >= 3) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.15;
                }

                if (onlinePublicationCount == 1) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.0375;
                } else if (onlinePublicationCount == 2) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.075;
                } else if (onlinePublicationCount == 3) {
                    NewsLettersPublicationsGrade = NewsLettersPublicationsGrade + 0.1125;
                } else if (onlinePublicationCount >= 4) {
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

                for (var i = 0; i < data[5].length; i++) {
                    if (data[5][i].organizationID == organizationid) {
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

                var osfField1Average = osfField1 / osfSurveyTotal;
                var osfField2Average = osfField2 / osfSurveyTotal;
                var osfField3Average = osfField3 / osfSurveyTotal;
                var osfField4Average = osfField4 / osfSurveyTotal;
                var osfField5Average = osfField5 / osfSurveyTotal;
                var osfField6Average = osfField6 / osfSurveyTotal;
                var osfField7Average = osfField7 / osfSurveyTotal;
                var osfField8Average = osfField8 / osfSurveyTotal;
                var osfField9Average = osfField9 / osfSurveyTotal;

                if (osfSurveyTotal == 0) {
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


                for (var i = 0; i < data[6].length; i++) {

                    if (data[6][i].organizationID == organizationid) {

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

                var msfField1Average = msfField1 / msfSurveyTotal;
                var msfField2Average = msfField2 / msfSurveyTotal;
                var msfField3Average = msfField3 / msfSurveyTotal;
                var msfField4Average = msfField4 / msfSurveyTotal;
                var msfField5Average = msfField5 / msfSurveyTotal;
                var msfField6Average = msfField6 / msfSurveyTotal;
                var msfField7Average = msfField7 / msfSurveyTotal;
                var msfField8Average = msfField8 / msfSurveyTotal;
                var msfField9Average = msfField9 / msfSurveyTotal;
                var msfField10Average = msfField10 / msfSurveyTotal;
                var msfField11Average = msfField11 / msfSurveyTotal;
                var msfField12Average = msfField12 / msfSurveyTotal;
                var msfField13Average = msfField13 / msfSurveyTotal;

                if (msfSurveyTotal == 0) {
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
                for (var i = 0; i < data[7].length; i++) {

                    if (data[7][i].studentorganization == organizationid) {

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

                var arfField1Average = arfField1 / arfSurveyTotal;
                var arfField2Average = arfField2 / arfSurveyTotal;
                var arfField3Average = arfField3 / arfSurveyTotal;
                var arfField4Average = arfField4 / arfSurveyTotal;
                var arfField5Average = arfField5 / arfSurveyTotal;
                var arfField6Average = arfField6 / arfSurveyTotal;
                var arfField7Average = arfField7 / arfSurveyTotal;

                if (arfSurveyTotal == 0) {
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

                for (var i = 0; i < data[8].length; i++) {

                    if (data[8][i].organization == organizationid) {

                        totalOrganizationMembers = totalOrganizationMembers + 1;
                    }


                }

                // orgres purpose

                var purpose1 = ((msfField1Average / 5) * 100) * 0.04;
                var purpose2 = ((((arfField1Average + msfField2Average) / 2) / 5) * 100) * 0.02;
                var purpose3 = ((((arfField2Average + msfField3Average + msfField4Average) / 3) / 5) * 100) * 0.04;

                var orgresPurposeGrade = purpose1 + purpose2 + purpose3;


                // orgres involvement

                var involvement1 = ((msfSurveyTotal / totalOrganizationMembers) * 100) * 0.045;

                if (totalOrganizationMembers == 0) {
                    involvement1 = 0;
                }

                var involvement2 = ((((arfField3Average + msfField5Average + msfField6Average) / 3) / 5) * 100) * 0.06;
                var involvement3 = ((((arfField4Average + msfField7Average) / 2) / 5) * 100) * 0.045;

                var orgresInvolvementGrade = involvement1 + involvement2 + involvement3;

                // orgres quality

                var quality1 = ((msfField8Average / 5) * 100) * 0.0225;
                var quality2 = ((((msfField9Average + msfField10Average) / 2) / 5) * 100) * 0.015;
                var quality3 = ((arfField5Average / 5) * 100) * 0.0225;
                var quality4 = ((((arfField6Average + msfField11Average) / 2) / 5) * 100) * 0.0225;
                var quality5 = ((((arfField7Average + msfField12Average) / 2) / 5) * 100) * 0.015;

                var orgresQualityGrade = quality1 + quality2 + quality3 + quality4 + quality5;


                //orgres leadership grade

                var leadership1 = ((((osfField1Average + osfField2Average) / 2) / 5) * 100) * 0.0015;
                var leadership2 = ((osfField3Average / 5) * 100) * 0.0008;
                var leadership3 = ((osfField4Average / 5) * 100) * 0.01;
                var leadership4 = ((osfField5Average / 5) * 100) * 0.0015;
                var leadership5 = ((msfField13Average / 5) * 100) * 0.0015;
                var leadership6 = ((((osfField6Average + osfField7Average) / 2) / 5) * 100) * 0.0045;
                var leadership7 = ((osfField8Average / 5) * 100) * 0.003;
                var leadership8 = ((osfField9Average / 5) * 100) * 0.0015;
                var leadership9 = 0.3; //0.003*100

                var orgresLeadershipGrade = leadership1 + leadership2 + leadership3 + leadership4 + leadership5 + leadership6 + leadership7 + leadership8 + leadership9;

                var orgresGrade = orgresPurposeGrade + orgresInvolvementGrade + orgresQualityGrade + orgresLeadershipGrade;

                // amt grade
                var totalAMTEvaluations = data[9].length;
                var totalAMTEvaluationScore = 0;

                for (var i = 0; i < data[9].length; i++) {

                    totalAMTEvaluationScore = totalAMTEvaluationScore + data[9][i].amtgrade

                }

                var amtScore = totalAMTEvaluationScore / totalAMTEvaluations;

                if (totalAMTEvaluations == 0) {

                    amtScore = 0;

                }
                var amtGrade = amtScore * 0.0375;

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
                for (var i = 0; i < data[11].length; i++) {

                    let financesign = data[11][i].datesigned;
                    let activitystart = data[11][i].datestart

                    var budgetdiff = timediff(financesign, activitystart, 'D');

                    if (budgetdiff.days <= 3) {
                        onTimeTransaction = onTimeTransaction + 1;
                    }

                    approvedParticulars = approvedParticulars + data[11][i].particulars;

                    totalApprovedTransaction = totalApprovedTransaction + 1;

                }

                // approved expenses(particulars)
                for (var i = 0; i < data[12].length; i++) {

                    if (data[12][i].expenses <= data[12][i].budget) {
                        onBudgetActivities = onBudgetActivities + 1;
                    }

                    totalFinanceActivities = totalFinanceActivities + 1;

                    if (data[12][i].isrelatedtoorganizationnature == true) {
                        relatedExpense = relatedExpense + data[12][i].expenses;
                    }

                    totalExpense = totalExpense + data[12][i].expenses;

                    totalActivityBudget = totalActivityBudget + data[12][i].budget;

                }

                if (data[13] == null) {
                    var totalParticulars = 0;
                    var operationalfunds = 0;
                    var depositoryfunds = 0;
                } else {
                    var totalParticulars = data[13].particulars;
                    var operationalfunds = data[13].operationalfunds;
                    var depositoryfunds = data[13].depositoryfunds;
                }

                // finance monitoring grade
                var tempMonitoring1 = ((onTimeTransaction / totalApprovedTransaction) * 100); //*0.01;

                if (tempMonitoring1 >= 98) {
                    var monitoring1 = 1;
                } else if (tempMonitoring1 >= 95) {
                    var monitoring1 = 0.95;
                } else if (tempMonitoring1 >= 92) {
                    var monitoring1 = 0.9;
                } else if (tempMonitoring1 >= 89) {
                    var monitoring1 = 0.85;
                } else if (tempMonitoring1 >= 86) {
                    var monitoring1 = 0.8;
                } else if (tempMonitoring1 >= 83) {
                    var monitoring1 = 0.75;
                } else if (tempMonitoring1 >= 80) {
                    var monitoring1 = 0.7;
                } else if (tempMonitoring1 >= 77) {
                    var monitoring1 = 0.65;
                } else if (tempMonitoring1 >= 74) {
                    var monitoring1 = 0.6;
                } else if (tempMonitoring1 >= 71) {
                    var monitoring1 = 0.55;
                } else {
                    var monitoring1 = 0.5;
                }

                var tempMonitoring2 = ((approvedParticulars / totalParticulars) * 100); //0.005;

                if (tempMonitoring2 >= 98) {
                    var monitoring2 = 0.5;
                } else if (tempMonitoring2 >= 95) {
                    var monitoring2 = 0.475;
                } else if (tempMonitoring2 >= 92) {
                    var monitoring2 = 0.45;
                } else if (tempMonitoring2 >= 89) {
                    var monitoring2 = 0.425;
                } else if (tempMonitoring2 >= 86) {
                    var monitoring2 = 0.4;
                } else if (tempMonitoring2 >= 83) {
                    var monitoring2 = 0.375;
                } else if (tempMonitoring2 >= 80) {
                    var monitoring2 = 0.35;
                } else if (tempMonitoring2 >= 77) {
                    var monitoring2 = 0.325;
                } else if (tempMonitoring2 >= 74) {
                    var monitoring2 = 0.3;
                } else if (tempMonitoring2 >= 71) {
                    var monitoring2 = 0.275;
                } else if (tempMonitoring2 >= 68) {
                    var monitoring2 = 0.25;
                } else if (tempMonitoring2 >= 65) {
                    var monitoring2 = 0.225;
                } else {
                    var monitoring2 = 0.2;
                }

                var monitoring3 = 1;
                var tempMonitoring45 = ((Math.abs(totalExpense - totalActivityBudget)) / totalActivityBudget) * 100;

                if (tempMonitoring45 >= 90 && tempMonitoring45 <= 110) {
                    var monitoring4 = 1.5;
                } else if (tempMonitoring45 >= 75 && tempMonitoring45 <= 125) {
                    var monitoring4 = 1.35;
                } else {
                    var monitoring4 = 1.2;
                }

                if (tempMonitoring45 >= 90 && tempMonitoring45 <= 110) {
                    var monitoring5 = 1;
                } else if (tempMonitoring45 >= 85 && tempMonitoring45 <= 115) {
                    var monitoring5 = 0.9;
                } else if (tempMonitoring45 >= 81 && tempMonitoring45 <= 120) {
                    var monitoring5 = 0.8;
                } else if (tempMonitoring45 >= 75 && tempMonitoring45 <= 125) {
                    var monitoring5 = 0.7;
                } else {
                    var monitoring5 = 0.6;
                }

                // finance generation grade

                var generation1 = 0;
                var generation2 = 0;

                // finance allocation grade

                var tempAllocation1 = ((onBudgetActivities / totalFinanceActivities) * 100); //*0.01;

                if (tempAllocation1 >= 85) {
                    var allocation1 = 1;
                } else if (tempAllocation1 >= 80) {
                    var allocation1 = 0.95;
                } else if (tempAllocation1 >= 75) {
                    var allocation1 = 0.9;
                } else if (tempAllocation1 >= 70) {
                    var allocation1 = 0.85;
                } else if (tempAllocation1 >= 65) {
                    var allocation1 = 0.8;
                } else if (tempAllocation1 >= 60) {
                    var allocation1 = 0.75;
                } else if (tempAllocation1 >= 55) {
                    var allocation1 = 0.7;
                } else if (tempAllocation1 >= 50) {
                    var allocation1 = 0.65;
                } else {
                    var allocation1 = 0.6;
                }

                var tempAllocation2 = Math.abs(60 - ((relatedExpense / totalExpense) * 100));

                if (tempAllocation2 <= 10) {
                    var allocation2 = 1;
                } else if (tempAllocation2 <= 20.99) {
                    var allocation2 = 0.9;
                } else if (tempAllocation2 <= 30) {
                    var allocation2 = 0.85;
                } else {
                    var allocation2 = 0.75;
                }

                var tempAllocation3 = ((depositoryfunds - totalExpense) / depositoryfunds) * 100;

                if (tempAllocation3 >= 100) {
                    var Allocation3 = 1;
                } else if (tempAllocation3 >= 90) {
                    var Allocation3 = 0.9;
                } else if (tempAllocation3 >= 80) {
                    var Allocation3 = 0.8;
                } else if (tempAllocation3 >= 70) {
                    var Allocation3 = 0.75;
                } else if (tempAllocation3 >= 60) {
                    var Allocation3 = 0.7;
                } else {
                    var Allocation3 = 0.6;
                }

                var financeMonitoringGrade = monitoring1 + monitoring2 + monitoring3 + monitoring4 + monitoring5;
                var financeGenerationGrade = generation1 + generation2;
                var financeAllocationGrade = allocation1 + allocation2 + Allocation3;

                var financeGrade = financeMonitoringGrade + financeGenerationGrade + financeAllocationGrade;
                totalGrade.push({
                    orgid: organizationid,
                    grade: amtGrade + documentationGrade + orgresGrade + financeGrade + pnpGrade});
            }
            const end = Date.now() - start;
            logger.debug(`Computation finished - ${end}ms`, log_options);

            return Promise.all([
                Promise.resolve(organizations),
                Promise.resolve(gosm),
                Promise.resolve(pendingActivities),
                Promise.resolve(takenActivities),
                Promise.resolve(evaluatedActivities),
                Promise.resolve(totalGrade)
            ]);
        }).then(([organizations, gosm, pendingActivities, takenActivities, evaluatedActivities, totalGrade]) => {
            let renderData = Object.create(null);
            renderData.totalGrade = totalGrade;
            console.log("Total grades are");
            console.log(totalGrade);
            renderData.pendingActivities = pendingActivities;
            renderData.takenActivities = takenActivities;
            renderData.evaluatedActivities = evaluatedActivities;
            renderData.studentorganizations = organizations;
            renderData.allGosm = gosm;
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            logger.debug('Rendering APS/APSHome', log_options);
			return res.render('AMT/AMTHome', renderData);
        }).catch(error => {
            return logger.error(`${error.message}: ${error.stack}`, log_options);
        });

            
	};
	
	//TODO: CHANGE SQL TO CURRENT TERM YEAR ONLY
	AMTController.viewActivity = (req, res) => {
		logger.debug('viewActivity()', log_options);

		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;

		const dbParam = {			
			idNumber:req.session.user.idNumber
		};
		
		database.task(t =>{
			return t.batch([
				amtModel.getAvailableActivityToCheck(),
				amtModel.getAmtMyActivity(dbParam)
			]);
		}).then(data => {
			renderData.allActivity = data[0];
			renderData.myActivity = data[1];
			console.log(data[0])
			logger.debug(`${JSON.stringify(data[0])}`, log_options);
			logger.debug(`${JSON.stringify(data[1])}`, log_options);

			return res.render('AMT/ActivityAssignment', renderData);
		});
		
	};

	AMTController.insertToMyActivityToCheck = (req, res) => {
		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();
		
		console.log("req.session.user2");
		console.log(req.session.user);
		
		const dbParam = {
			activity:req.body.id,
			idNumber:req.session.user.idNumber,
			venue:req.body.vid,
			status:1
		};
		console.log("dbParam");
		console.log(dbParam);
		amtModel.insertToMyActivityToCheck(dbParam)
		.then(data=>{
			console.log(data);
			return res.send("1");
		}).catch(err=>{console.log(err)
			return res.send("0");
		});
		
	};

	AMTController.removeToMyActivity = (req, res) => {
		let renderData = Object.create(null);
		renderData = req.extra_data;
		renderData.csrfToken = req.csrfToken();
		
		const dbParam = {
			activityId: req.body.id,
			idNumber:req.session.user.idNumber,
		};
		console.log(dbParam);

		amtModel.deleteToMyActivity(dbParam)
		.then(data =>{
			console.log(data);
			return res.send("1");
		}).catch(err => {
			console.log(err);
			return res.send("0");
		});
	};

	AMTController.submitActivityEvaluation = (req, res) =>{
		console.log(req.body);

		//TODO: Activity value will be chosen come from previous page
		//TODO: timeend score is autogenerated
		var activityExecution = parseInt(req.body.activityExecution) + parseInt(req.body.activityExecution2);

		var facilitators = 4
		if(typeof req.body.facilitators1 == "undefined"){
			facilitators = facilitators-1;
		}

		if(typeof req.body.facilitators2 == "undefined"){
			facilitators = facilitators-1;
		}

		if(typeof req.body.facilitators3 == "undefined"){
			facilitators = facilitators-1;
		}

		if(typeof req.body.facilitators4 == "undefined"){
			facilitators = facilitators-1;
		}

		console.log(facilitators);
		var param = {
			gosmactivity: req.body.activity
		};

		projectProposalModel.getProjectProposal(param)
		.then(data=>{
			console.log("data")
			console.log(data.id)
			projectProposalModel.getProjectProposalProgramDesign(req.body.activity, [
                        'pppd.dayid AS dayid',
                        "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                        "to_char(pppd.starttime + pppd.date, 'HH24:MI') AS starttime",
                        "to_char(pppd.endtime + pppd.date, 'HH24:MI') AS endtime",
                        'pppd.activity AS activity',
                        'pppd.activitydescription AS activitydescription',
                        'pppd.personincharge AS personincharge',
                        "to_char(pppd.date, 'YYYY-MM-DD') AS origdate"
            ]).then(data1=>{
            	console.log("data1");
            	console.log(data1);

            	var starttimeapproved = new Date(data1.origdate );
            	var actualstarttime = new Date(data1.origdate + " " +req.body.timeStart);
            	// console.log("starttimeapproved.getMonth()"+data1.origdate+" "+data1.starttime);
            	
            	var diff = timediff(new Date(data1[0].origdate+" "+data1[0].starttime),new Date(data1[0].origdate+" "+req.body.timeStart), 'm');
            	console.log(diff);

            	var startgrade = 0;
            	if (diff.minutes <= 0){
            		startgrade = 5;
            		console.log("ON TIME SIR");
            	}else if(diff.minutes <= 5){
            		startgrade = 4;
            	}else if(diff.minutes <= 10){
            		startgrade = 3;
            	}else if(diff.minutes <= 15){
            		startgrade = 2;
            	}else {
            		startgrade = 1;
            	}

            	console.log("GREDU DESU");
            	console.log(startgrade);

            	var last = data1.length-1;
            	console.log("last is");
            	console.log(last);

            	console.log("ENDTIME")
            	var diff2 = timediff(new Date(data1[last].origdate+" "+data1[0].endtime),new Date(data1[0].origdate+" "+req.body.timeEnd), 'm');
            	console.log(diff2);

            	var endgrade = 0;
            	if (diff2.minutes <= 0){
            		endgrade = 5;
            	}else if(diff2.minutes <= 5){
            		endgrade = 4;
            	}else if(diff2.minutes <= 10){
            		endgrade = 3;
            	}else if(diff2.minutes <= 15){
            		endgrade = 2;
            	}else{
            		endgrade = 1;
            	}

            	var endtimeapproved = new Date(data1.endtime);
            	var actualendtime = new Date(req.body.timeEnd);



                const dbParam = {
					activity: req.body.activity,
					venue: req.body.venue,
					equipment: req.body.equipment,
					materials: req.body.material,
					registration: req.body.registration,
					timeStart: startgrade,
					timeEnd: endgrade,
					activityexecution: activityExecution,
					hosts: req.body.host,
					facilitators: facilitators,
					presentation: req.body.presentation,
					activities: req.body.activities,
					organizationstandingpresentation: req.body.organizationStanding,
					actualstarttime: req.body.timeStart,
					actualendtime: req.body.timeEnd,
					anp: req.body.anp,
					person1ea: req.body.announcement,
					person1loa: req.body.learnings,
					person1iitskoa: req.body.interest,
					person1iomwm: req.body.interaction,
					person2ea: req.body.announcement2,
					person2loa: req.body.learnings2,
					person2iitskoa: req.body.interest2,
					person2iomwm: req.body.interaction2,
					comments: req.body.comments,
					suggestions: req.body.suggestions,
				};

				console.log("DBPARAM");
				console.log(dbParam);

				amtModel.updateAMTActivityEvaluation(dbParam)
				.then(data=>{
					res.redirect('/blank')
				})
				.catch(error=>{
					console.log("ERROR 1");
					console.log(error);
				});

            }).catch(error=>{
            	console.log("ERROR 2");
               	console.log(error);
            });

		}).catch(error=>{
			console.log("ERROR3")
			console.log(error);
		});


		
	};
	
	return AMTController;
};