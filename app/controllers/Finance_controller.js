module.exports = function(database, models, queryFiles){
	
	return {
		viewDashboard: (req, res) => {
		
			return res.render('Finance/DashboardMain');
			//next();
		},
		createTransaction: (req, res) => {
		
			return res.render('Finance/TransactionMain');
			//next();
		}
		
		
	};
};