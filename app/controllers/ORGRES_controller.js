module.exports = function(configuration, modules, models, database, queryFiles){

	const orgresModel = models.Orgres_model;
	const systemModel = models.System_model;


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

			orgresModel.getCurrentSchoolYearTerms()
			.then(data=>{

				
				const renderData = Object.create(null);
    	        renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.termdates = data;
				return res.render('Orgres/ManageTime', renderData);


			}).catch(error=>{
				console.log(error);
			});
		},
		submitTime: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

            console.log(req.body);

            // var startDate = req.body.targetDateStart;
            // var startDateSplit = startDate.split("/");
            //  "'" + startDateSplit[2] + "-" + startDateSplit[0] + "-" + startDateSplit[1] + "'"

            var firstStart = req.body.firststart;
            var firstStartSplit = firstStart.split("/");
            var firstEnd = req.body.firstend;
            var firstEndSplit = firstEnd.split("/");

            var secondStart = req.body.secondstart;
            var secondStartSplit = secondStart.split("/");
            var secondEnd = req.body.secondend;
            var secondEndSplit = secondEnd.split("/");

            var thirdStart = req.body.thirdstart;
            var thirdStartSplit = thirdStart.split("/");
            var thirdEnd = req.body.thirdend;
            var thirdEndSplit = thirdEnd.split("/");

            
            systemModel.getCurrentTermWithYear()
            .then(data=>{

            	console.log("termyear");
            	console.log(data);

            	//insert new term values
            	if (data.startyear == firstStartSplit[2] && data.endyear == thirdEndSplit[2]){

            		var dbParam1 = {
            			schoolyearid: data.id,
            			numberid: 1,
            			datestart: "'" + firstStartSplit[2] + "-" + firstStartSplit[0] + "-" + firstStartSplit[1] + "'",
            			dateend: "'" + firstEndSplit[2] + "-" + firstEndSplit[0] + "-" + firstEndSplit[1] + "'"
            		}
            		
            		var dbParam2 = {
            			schoolyearid: data.id,
            			numberid: 2,
            			datestart: "'" + secondStartSplit[2] + "-" + secondStartSplit[0] + "-" + secondStartSplit[1] + "'",
            			dateend: "'" + secondEndSplit[2] + "-" + secondEndSplit[0] + "-" + secondEndSplit[1] + "'"
            		}

            		var dbParam3 = {
            			schoolyearid: data.id,
            			numberid: 3,
            			datestart: "'" + thirdStartSplit[2] + "-" + thirdStartSplit[0] + "-" + thirdStartSplit[1] + "'",
            			dateend: "'" + thirdEndSplit[2] + "-" + thirdEndSplit[0] + "-" + thirdEndSplit[1] + "'"
            		}

            		database.task(t => {
		                return t.batch([
		                    orgresModel.insertTerm(dbParam1, t),
		                    orgresModel.insertTerm(dbParam2, t),
		                    orgresModel.insertTerm(dbParam3, t)
		                ])
		            }).then(data1=>{

		            	console.log(data1);
		            	console.log("Success inserting term");
          		        res.redirect(`/ORGRES/Manage/Time`);


		            }).catch(error=>{
		            	console.log(error);
		            })

		            console.log("CORRECT +++++++++++++++++++++++++++++");


            	}// update previous term values
            	else{

            		var dbParam = {
		            	startyear: firstStartSplit[2],
		            	endyear: thirdEndSplit[2]
		            }

		            orgresModel.insertSchoolYear(dbParam)
		            .then(datayear=>{

		            	var dbParam1 = {
	            			schoolyearid: datayear.id,
	            			numberid: 1,
	            			datestart: "'" + firstStartSplit[2] + "-" + firstStartSplit[0] + "-" + firstStartSplit[1] + "'",
	            			dateend: "'" + firstEndSplit[2] + "-" + firstEndSplit[0] + "-" + firstEndSplit[1] + "'"
	            		}
	            		
	            		var dbParam2 = {
	            			schoolyearid: datayear.id,
	            			numberid: 2,
	            			datestart: "'" + secondStartSplit[2] + "-" + secondStartSplit[0] + "-" + secondStartSplit[1] + "'",
	            			dateend: "'" + secondEndSplit[2] + "-" + secondEndSplit[0] + "-" + secondEndSplit[1] + "'"
	            		}

	            		var dbParam3 = {
	            			schoolyearid: datayear.id,
	            			numberid: 3,
	            			datestart: "'" + thirdStartSplit[2] + "-" + thirdStartSplit[0] + "-" + thirdStartSplit[1] + "'",
	            			dateend: "'" + thirdEndSplit[2] + "-" + thirdEndSplit[0] + "-" + thirdEndSplit[1] + "'"
	            		}

	            		database.task(t => {
			                return t.batch([
			                    orgresModel.insertTerm(dbParam1, t),
			                    orgresModel.insertTerm(dbParam2, t),
			                    orgresModel.insertTerm(dbParam3, t)
			                ])
			            }).then(data1=>{

			            	console.log(data1);
			            	console.log("Success inserting term");
              			    res.redirect(`/ORGRES/Manage/Time`);


			            }).catch(error=>{
			            	console.log(error);
			            })

			            console.log("CORRECT ---------------------------------");

		            }).catch(error=>{
		            	console.log(error);
		            });


            	}

            }).catch(error=>{
            	console.log(error);
            })

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
