'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let AMTController = Object.create(null);

	const amtModel = models.ActivityMonitoring_model;

	AMTController.viewActivityEvaluation = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();

		return res.render('AMT/ActivityEvaluation', renderData);
	};

	AMTController.submitActivityEvaluation = (req, res) =>{
		console.log(req.body);
		console.log(req.body.start);

		//TODO: Activity value will be chosen come from previous page
		//TODO: timeend score is autogenerated
		const dbParam = {
			activity: 1,
			venue: req.body.venue,
			equipment: req.body.equipment,
			materials: req.body.material,
			registration: req.body.registration,
			timeend: 1,
			activityexecutiona: req.body.activityExecution,
			activityexecutionb: req.body.activityExecution2,
			hosts: req.body.host,
			facilitators: req.body.facilitators,
			presentation: req.body.presentation,
			activities: req.body.activities,
			organizationstandingpresentation: req.body.organizationStanding,
			actualstarttime: req.body.start[0] ,
			actualendtime: req.body.start[1],
			anp: req.body.start[2],
			person1ea: req.body.announcement,
			person1loa: req.body.learnings,
			person1iitskoa: req.body.interest,
			person1iomwm: req.body.interaction,
			person2ea: req.body.announcement2,
			person2loa: req.body.learnings2,
			person2iitskoa: req.body.interest2,
			person2iomwm: req.body.interaction2,
			comments1: req.body.comment1,
			comments2: req.body.comment2,
			comments3: req.body.comment3,
			suggestions1: req.body.suggestion1,
			suggestions2: req.body.suggestion2,
			suggestions3: req.body.suggestion3
		};

		amtModel.insertAMTActivityEvaluation(dbParam)
		.then(data=>{

		})
		.catch(error=>{
			console.log(error);
		});
	};
	
	return AMTController;
};