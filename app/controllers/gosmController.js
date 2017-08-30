module.exports = function(database, models, queryFiles){
	var getAllActivityTypeSQL = queryFiles.getAllActivityTypes;
	const model_gosm = models.gosmModel;
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('APS/GOSMMain');
			//next();
		},
		viewOrglist:( req, res) =>{	
			let yearsPromise = model_gosm.getSubmissionYears();
			let allGOSMPromise = model_gosm.getAll();
			Promise.all([yearsPromise, allGOSMPromise])
				.then(function(years) {
					console.log(years);
				})
				.catch(function(error) {
					console.log(error);
				});
			res.render('APS/OrglistMain');
		},
		viewOrgGOSM :( req, res)=>{
			res.render('APS/OrgGOSMMain');
		},
		activityList :( req, res)=>{
			res.render('APS/ActivityListMain');
		},
		inputCreateGOSM: (req, res) => {
			console.log(JSON.stringify(req.body));
			res.render('GOSM');
		}
	};
};