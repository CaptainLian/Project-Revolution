module.exports = function(configuration, modules, models, database, queryFiles){

	return {
		viewDashboard: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_view_data = req.extra_view_data;

			return res.render('Finance/DashboardMain', renderData);
			//next();
		},
		createTransaction: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_view_data = req.extra_view_data;
			return res.render('Finance/TransactionMain', renderData);
			//next();
		}


	};
};
