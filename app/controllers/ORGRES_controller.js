module.exports = function(configuration, modules, models, database, queryFiles){

	const orgresModel = models.Orgres_model;


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

		viewSubmitResearchActivityForm: (req, res) => {


			database.task(task => {
                        return task.batch([
							orgresModel.getActivitiesForResearchForm(),
							orgresModel.getOrganizationsForResearchForm()
                        ]);
            }).then(data=>{
            	const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.activities = data[0];
	            renderData.organizations = data[1];


				return res.render('Orgres/SubmitActivityResearchForm', renderData);

            }).catch(error=>{
            	console.log(error);
            });

		},

		submitResearchActivityForm: (req, res) =>{

			console.log("enters this");
			console.log(req.body); 

			var dbParam = {
				gosmactivity: req.body.activity,
				positionInOrganization: req.body.position,
				iutpota: req.body.radio1,
				tasmi: req.body.radio2,
				ifidta: req.body.radio3,
				tawwp: req.body.radio4,
				toumtgtta: req.body.radio5,
				wwwita: req.body.wentwell,
				fac: req.body.feedback,
				effa: req.body.expectations
			};

			orgresModel.insertActivityResearchForm(dbParam)
			.then(data=>{
				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();


				return res.redirect('/Orgres/SubmitActivityResearchForm');

			}).catch(error=>{
				console.log(error);
			});

			
		}

	};
};
