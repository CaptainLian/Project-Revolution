module.exports = function(configuration, modules, models, database, queryFiles){

	return {
		viewManageAccount: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			renderData.csrfToken = req.csrfToken();
			return res.render('Orgres/ManageAccount', renderData);
		},
		viewManageOrg: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
			return res.render('Orgres/ManageOrg', renderData);
		},
		viewManageTime: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
			return res.render('Orgres/ManageTime', renderData);
		},
		submitTime: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

            console.log(req.body);



			return res.render('Orgres/ManageTime', renderData);
		},

		viewSubmitResarchActivityForm: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

			return res.render('Orgres/SubmitActivityReearchForm', renderData);
		}

	};
};
