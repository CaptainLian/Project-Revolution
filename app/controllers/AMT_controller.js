'use strict';
var timediff = require('timediff');
module.exports = function(configuration, modules, models, database, queryFiles){
	let AMTController = Object.create(null);

	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'AMT-Controlller';

	const amtModel = models.ActivityMonitoring_model;
	const projectProposalModel = models.ProjectProposal_model;

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
			return t.batch([amtModel.getAvailableActivityToCheck(),
							amtModel.getAmtMyActivity(dbParam)]);
		}).then(data => {
			renderData.allActivity = data[0];
			renderData.myActivity = data[1];

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
			projectProposalModel.getProjectProposalProgramDesign(data.id, [
                        'pppd.dayid AS dayid',
                        "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                        "to_char(pppd.starttime + pppd.date, 'HH24:MI') AS starttime",
                        "to_char(pppd.endtime + pppd.date, 'HH24:MI') AS endtime",
                        'pppd.activity AS activity',
                        'pppd.activitydescription AS activitydescription',
                        'pppd.personincharge AS personincharge',
                        "to_char(pppd.date, 'YYYY-MM-DD') AS origdate"
            ]).then(data1=>{

            	console.log(data1[0].origdate);

            	var starttimeapproved = new Date(data1.origdate );
            	var actualstarttime = new Date(data1.origdate + " " +req.body.timeStart);
            	console.log("starttimeapproved.getMonth()"+data1.origdate+" "+data1.starttime);
            	
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