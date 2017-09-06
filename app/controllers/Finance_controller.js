module.exports = function(database, models, queryFiles){
	
	return {
		viewDashboard: (req, res) => {
		
			res.render('Finance/DashboardMain');
			//next();
		},
		
		
	};
};