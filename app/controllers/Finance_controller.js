module.exports = function(database, models, queryFiles){
	
	return {
		viewDashboard: (req, res) => {
		
			res.render('Finance/DashboardMain');
			//next();
		},
		createTransaction: (req, res) => {
		
			res.render('Finance/TransactionMain');
			//next();
		}
		
		
	};
};