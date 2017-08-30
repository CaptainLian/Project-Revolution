module.exports = function(database, models, queryFiles){
	var getAllActivityTypeSQL = queryFiles.getAllActivityTypes;
	
	return {
		viewCreateGOSM: (req, res) => {
		//if president
			res.render('APS/GOSMMain');
			//next();
		},
		viewOrglist:( req, res) =>{
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