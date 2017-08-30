const dateFormat = require('dateFormat');

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
				.then(function(data) {
					let GOSMList = data[1];
					for(const gosm of GOSMList){
						console.log(gosm);
					}
					res.render('APS/OrglistMain', {
						GOSMList: data[1]
					});
				})
				.catch(function(error) {
					console.log(error);

					res.send(500);
					throw error;
				});
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