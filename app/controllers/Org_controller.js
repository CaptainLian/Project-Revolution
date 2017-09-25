module.exports = function(database, models, queryFiles){
	return {
		view: (req, res)=>{
			res.render('Org/MemberMain')
		},
		activityChecking: (req, res)=>{
			res.render('Org/activityCheckingMain');
		},
	};
};