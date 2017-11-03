module.exports = function(configuration, modules, models, database, queryFiles){

	return {
		viewDashboard: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

			return res.render('Finance/DashboardMain', renderData);
			//next();
		},
		createTransaction: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/TransactionMain', renderData);
			//next();
		},
		viewFinanceSettings: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Finance_Settings', renderData);
			//next();
		}


	};
};
