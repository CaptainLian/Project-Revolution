var timediff = require('timediff');
module.exports = function(configuration, modules, models, database, queryFiles){
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'ORGRES-Controller';

	const nodemailer = require('nodemailer');
	var cuid = require('cuid');

	const orgresModel = models.Orgres_model;
	const systemModel = models.System_model;
	const gosmModel = models.gosmModel;
	const accModel = models.Account_model;
	const organizationModel = models.organization_model;

    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const pnpModel = models.PNP_model;
    const amtModel = models.ActivityMonitoring_model;
    const financeModel = models.Finance_model;

	return {
		viewManageAccount: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			renderData.csrfToken = req.csrfToken();
			database.task(task =>{
				return task.batch([
					accModel.getOrganizationRoles(),
					accModel.getAccountType(),
					accModel.getAccounts(['oo.isactive','a.idnumber','a.firstname','a.middlename','a.lastname','oro.name','a.email','so.acronym','a.status','a.type','ac.name'])
				]);
			}).then(data=>{
				renderData.roles = data[0]
				renderData.type = data[1]
				renderData.accounts = data[2]
				console.log(data[2]);
				return res.render('Orgres/ManageAccount', renderData);
			}).catch(err =>{
				logger.error(`${err.message}: ${err.stack}`, log_options);
			})

		},

		officerSurveyForm: (req, res) => {
			organizationModel.getAllStudentOrganizations().then(data=>{
				const renderData = Object.create(null);
				renderData.organizations = data;
		        renderData.extra_data = req.extra_data;
		        renderData.csrfToken = req.csrfToken();

		        return res.render('Orgres/officerSurveyForm', renderData);
			}).catch(error=>{
				console.log(error);
			});
    	},

    	memberSurveyForm: (req, res) => {

    		organizationModel.getAllStudentOrganizations()
    		.then(data=>{

    			const renderData = Object.create(null);
    			renderData.organizations = data;
		        renderData.extra_data = req.extra_data;
		        renderData.csrfToken = req.csrfToken();
		        return res.render('Orgres/memberSurveyForm', renderData);


    		}).catch(error=>{
    			console.log(error);
    		});

    	},
    	idNumberCheck: (req, res) => {
    		orgresModel.idNumbercheck(req.body.idnumber, req.body.orgid).then(data=>{
    			return res.json({status:1})	
    		}).catch(err=>{
    			console.log(err)
    			return res.json({status:0})	
    		})
    		

    	},

		viewManageOrg: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
			return res.render('Orgres/ManageOrg', renderData);
		},

		viewHome: (req, res) => {

		    database.task(task => {
	            return task.batch([
	               orgresModel.getActivitiesForResearchForm(),
	               organizationModel.getAllStudentOrganizations(),
	               gosmModel.getAllCurrent()
	            ]);
            }).then(homeData=>{
    
                let renderData = Object.create(null);
    
                var activityCount = homeData[0].length;
    
                if (homeData[0]==null) {
                	activityCount=0;
                }

            return database.task(task => {
                return task.batch([
                    //list of organizations
                    Promise.resolve(homeData[1]),
                    //list of all gosm
                    Promise.resolve(homeData[2]),
                    Promise.resolve(activityCount),
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
            let activityCount = homeData.shift();
            let term = homeData.shift();

            let termstart = term.datestart;

            return database.task(task => {
                let queries = [
                    Promise.resolve(organizations),
                    Promise.resolve(gosm),
                    Promise.resolve(activityCount),
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
            let activityCount = organizationDatas.shift();
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
                Promise.resolve(activityCount),
                Promise.resolve(totalGrade)
            ]);
        }).then(([organizations, gosm, activityCount, totalGrade]) => {
            let renderData = Object.create(null);
            renderData.totalGrade = totalGrade;
            console.log("Total grades are");
            console.log(totalGrade);
            renderData.activityCount = activityCount;
            renderData.studentorganizations = organizations;
            renderData.allGosm = gosm;
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            logger.debug('Rendering APS/APSHome', log_options);
            return res.render('Orgres/orgresHome', renderData);
        }).catch(error => {
            return logger.error(`${error.message}: ${error.stack}`, log_options);
        });  
                
         
		},

		viewManageTime: (req, res) => {
			logger.info('call viewManageTime()', log_options);

			orgresModel.getCurrentSchoolYearTerms().then(data=>{
				const renderData = Object.create(null);
    	        renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.termdates = data;

	            logger.debug('Rendering Orgres/ManageTime', log_options);
				return res.render('Orgres/ManageTime', renderData);
			}).catch(error=>{
				logger.error(`${error.message}: ${error.stack}`, log_options);
			});
		},

		submitTime: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

            console.log(req.body);

            // var startDate = req.body.targetDateStart;
            // var startDateSplit = startDate.split("/");
            //  "'" + startDateSplit[2] + "-" + startDateSplit[0] + "-" + startDateSplit[1] + "'"

            var firstStart = req.body.firststart;
            var firstStartSplit = firstStart.split("/");
            var firstEnd = req.body.firstend;
            var firstEndSplit = firstEnd.split("/");

            var secondStart = req.body.secondstart;
            var secondStartSplit = secondStart.split("/");
            var secondEnd = req.body.secondend;
            var secondEndSplit = secondEnd.split("/");

            var thirdStart = req.body.thirdstart;
            var thirdStartSplit = thirdStart.split("/");
            var thirdEnd = req.body.thirdend;
            var thirdEndSplit = thirdEnd.split("/");

          	var dbParam = {
	         	startyear: firstStartSplit[2],
		       	endyear: thirdEndSplit[2],
	           	datestart: "'" + firstStartSplit[2] + "-" + firstStartSplit[0] + "-" + firstStartSplit[1] + "'",
           		dateend: "'" + thirdEndSplit[2] + "-" + thirdEndSplit[0] + "-" + thirdEndSplit[1] + "'"
		    }

		    orgresModel.insertSchoolYear(dbParam).then(datayear=>{
		       	var dbParam1 = {
	       			schoolyearid: datayear.id,
	           		numberid: 1,
	       			datestart: "'" + firstStartSplit[2] + "-" + firstStartSplit[0] + "-" + firstStartSplit[1] + "'",
	       			dateend: "'" + firstEndSplit[2] + "-" + firstEndSplit[0] + "-" + firstEndSplit[1] + "'"
        		}

	          	var dbParam2 = {
	       			schoolyearid: datayear.id,
	       			numberid: 2,
         			datestart: "'" + secondStartSplit[2] + "-" + secondStartSplit[0] + "-" + secondStartSplit[1] + "'",
	           		dateend: "'" + secondEndSplit[2] + "-" + secondEndSplit[0] + "-" + secondEndSplit[1] + "'"
	           	}

	           	var dbParam3 = {
	           		schoolyearid: datayear.id,
	       			numberid: 3,
	       			datestart: "'" + thirdStartSplit[2] + "-" + thirdStartSplit[0] + "-" + thirdStartSplit[1] + "'",
        			dateend: "'" + thirdEndSplit[2] + "-" + thirdEndSplit[0] + "-" + thirdEndSplit[1] + "'"
	       		}

	           	database.task(t => {
		            return t.batch([
		                orgresModel.insertTerm(dbParam1, t),
		                orgresModel.insertTerm(dbParam2, t),
		                orgresModel.insertTerm(dbParam3, t)
		            ])
		        }).then(data1=>{
		           	console.log(data1);
		           	console.log("Success inserting term");
          		    res.redirect(`/ORGRES/Manage/Time`);
		        }).catch(error=>{
		           	logger.error(`${error.message}: ${error.stack}`, log_options);
		        })

		        logger.debug('Correct', log_options);
	        }).catch(error=>{
		       logger.error(`${error.message}: ${error.stack}`, log_options);
	        });
		},

		viewSubmitResearchActivityForm: (req, res) => {
			database.task(task => {
                return task.batch([
					orgresModel.getActivitiesForResearchForm(),
					orgresModel.getOrganizationsForResearchForm()
                ]);
            }).then(data=>{
            	const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.activities = data[0];
	            renderData.organizations = data[1];

				return res.render('Orgres/SubmitActivityResearchForm', renderData);
            }).catch(error=>{
            	logger.error(`${error.message}: ${error.stack}`, log_options);
            });
		},

		submitResearchActivityForm: (req, res) =>{
			logger.info('call submitResearchActivityForm()', log_options);
			logger.debug(`req.body: ${req.body}`, log_options);

			return orgresModel.insertActivityResearchForm({
				gosmactivity: req.body.activity,
				idNumber: req.body.idNumber,
				email: `${req.body.email}@dlsu.edu.ph`,
				positionInOrganization: req.body.position,
				iutpota: req.body.radio1,
				tasmi: req.body.radio2,
				ifidta: req.body.radio3,
				tawwp: req.body.radio4,
				toumtgtta: req.body.radio5,
				field6: req.body.radio6,
				field7: req.body.radio7,
				wwwita: req.body.wentwell,
				fac: req.body.feedback,
				effa: req.body.expectations,
			}).then(data=>{
				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
                
                logger.debug('Rendering /Orgres/SubmitActivityResearchForm', log_options);
				return res.redirect('/Orgres/SubmitActivityResearchForm');
			}).catch(error=>{
				logger.error(`${error.message}: ${error.stack}`, log_options);
			});
		},

		submitOfficerSurveyForm: (req, res) => {
			console.log(req.body);

			var dbParam = {
				organizationid: req.session.user.organizationSelected.id,
				officer: req.session.user.idNumber,
				field1: req.body.r1,
				field2: req.body.r2,
				field3: req.body.r3,
				field4: req.body.r4,
				field5: req.body.r5,
				field6: req.body.r6,
				field7: req.body.r7,
				field8: req.body.r8,
				field9: req.body.r9
			};

			orgresModel.insertOfficerSurveyForm(dbParam).then(data=>{

				return res.redirect('/home');
			}).catch(error=>{
				console.log(error);
			});
		},

		submitMemberSurveyForm: (req, res) =>{
			logger.info('call submitMemberSurveyForm()', log_options);

			var dbParam = {
				organizationid: req.body.organization,
				idnumber: req.body.idnumber,
				field1: req.body.radio1,
				field2: req.body.radio2,
				field3: req.body.radio3,
				field4: req.body.radio4,
				field5: req.body.radio5,
				field6: req.body.radio6,
				field7: req.body.radio7,
				field8: req.body.radio8,
				field9: req.body.radio9,
				field10: req.body.radio10,
				field11: req.body.radio11,
				field12: req.body.radio12,
				field13: req.body.radio13
			};

			orgresModel.insertMemberSurveyForm(dbParam).then(data => {
				return res.redirect('/');
			}).catch(error => {
				return logger.error(`${error.message}\n${error.stack}`, log_options);
				console.log(error);
			});

		},

		saveAccount: (req, res) =>{
			logger.info(`call saveAccount()`, log_options);
			var password = cuid();

		    database.task(task=>{
		    	let accType = Number.parseInt((req.body['accType[]'] ? req.body['accType[]'] : req.body.accType)[0]);

		    	if(accType == 1){
		    		console.log("createStudentAccount");

		    		let orgpos = req.body['orgpos[]'] ? req.body['orgpos[]'] : req.body.orgpos;
		    		if(!Array.isArray(orgpos)){
		    			orgpos = [orgpos];
		    		}

		    		for(let index = 0, length = orgpos.length; index < length; ++index){
		    			orgpos[index] = Number.parseInt(orgpos[index]);
		    		}

		    		return accModel.createStudentAccount(
		    			req.body.idNumber, 
		    			req.body.email, 
		    			password, 
		    			req.body.givenName, 
		    			req.body.middleName, 
		    			req.body.lastName,
		    			req.body.number,
		    			orgpos, 
		    			task
		    		);
		    	}else{
		    		console.log("createAccount");
		    		return accModel.createAccount(
		    			req.body.idNumber, 
		    			req.body.email,
		    			accType,
		    			password, 
		    			req.body.givenName, 
		    			req.body.middleName, 
		    			req.body.lastName, 
		    			req.body.number,
		    			task
		    		);
		    	}
		    }).then(data =>{
				res.json({status:1});

				let transporter = nodemailer.createTransport({
				    host: 'smtp.gmail.com',
			        port: 465,
			        secure:true,
			        connectionTimeout : "10000",
				    auth: {
				        user:'dlsum.facultyattendance@gmail.com',
				        pass:'01234567891011'
				    }
				});

				let mailOptions = {
		        	from: 'dlsum.facultyattendance@gmail.com', // sender address
		        	to: req.body.email, // list of receivers
		        	subject: '[CSO - Information System] Account Activation', // Subject line
		        	html: `<p>You just signed up for an account in the CSO Information System</p>
		        	<p>Your account is disabled initially,</p>
		        	<p>to activate it, login using your email OR id number and use this as the password <strong><u>${password}</u></strong></p>` // html body
			    };

			    return transporter.sendMail(mailOptions, (error, info) => {
			        if (error) {
			            return logger.warn(`${error}`, log_options);
			        }
			        return logger.debug('Mail sent', log_options);
			    });


		    }).catch(err=>{
		    	res.json({status:0});
		    	return logger.error(`${err.message}\n${err.stack}`, log_options);
		    });
		},

		getSpecificAccount: (req, res) =>{
			database.task(task=>{
				return task.batch([
					accModel.getSpecificAccount(
	                    req.body.idNumber, [
	                        'a.idnumber',
	                        'a.firstname',
	                        'a.middlename',
	                        'a.lastname',
	                        'oro.name',
	                        'a.email',
	                        'so.acronym',
	                        'a.idNumber',
	                        'a.contactNumber',
	                        'aca.id',
	                        'a.status'
	                    ], task),
					accModel.getSpecificAccount(req.body.idNumber, [
						'oo.role'
					], task)
				]);
			}).then(result=>{
				console.log("result[1]");
				var array2=[];
				for(var x = 0; x < result[1].length; x++){
					array2.push(result[1][x].role);
				}
				console.log(result[1]);
				return res.json({
					status:1,
					details:result[0][0],
					position:array2
				});
			}).catch(err=>{
				res.json({
					status:0
				});

				return logger.error(`${err.message}: ${err.stack}`, log_options);
			});
		},

		deleteAccount: (req, res) =>{
			console.log(req.body.id);
			accModel.deleteAccount(req.body.id,2).then(data=>{
				console.log(data);
				res.json({status:1});
			}).catch(err=>{
				console.log(err);
				res.json({status:0});
			});
		},

		updateAccount: (req, res) =>{
            logger.info('updateAccount()', log_options);

            let orgpos = req.body['orgpos[]'] ? req.body['orgpos[]'] : req.body.orgpos;
			logger.debug(req.body, log_options);
			accModel.updateAccount(
                req.body.id,
                req.body.email,
                req.body.accType,
                req.body.status,
                req.body.givenName,
                req.body.middleName,
                req.body.lastName,
                req.body.number,
                orgpos
            ).then(data => {
				res.json({status:1});
                return logger.debug(data, log_options);
			}).catch(error =>{
				res.json({status:0});
				return logger.error(`${error.message}: ${error.stack}`, log_options);
			});
		}

	};
};
