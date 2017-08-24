module.exports = function(database, models, queryFiles){
	var getAllActivityTypeSQL = queryFiles.getAllActivityTypes;
	
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('GOSMMain');
			//next();
		},
		viewOrglist:( req, res) =>{
			res.render('OrglistMain');
		},
		viewOrgGOSM :( req, res)=>{
			res.render('OrgGOSMMain');
		},
		activityList :( req, res)=>{
			res.render('ActivityListMain');
		},
		inputCreateGOSM: (req, res) => {

			console.log(JSON.stringify(req.body));
			res.render('GOSM');
		}
	};
};