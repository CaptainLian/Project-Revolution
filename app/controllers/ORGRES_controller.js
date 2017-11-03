module.exports = function(configuration, modules, models, database, queryFiles){

	return {
		viewManageAccount: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

			return res.render('Orgres/ManageAccount', renderData);
			//next();
		},
		viewManageOrg: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Orgres/ManageOrg', renderData);
			//next();
		}


	};
};