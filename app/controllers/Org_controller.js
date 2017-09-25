module.exports = function(database, models, queryFiles){

	const organizationModel = models.organization_model;
	const gosmModel = models.gosmModel;

	return {
		view: (req, res)=>{
			res.render('Org/MemberMain')
		},
		activityChecking: (req, res)=>{
			res.render('Org/activityCheckingMain');
		},


		viewProject: (req, res) =>{

			var dbParam = {
				//TODO
				gosm: 1
			};

			Promise.all([organizationModel.getActivitiesWithPPR(dbParam), organizationModel.getActivitiesWithoutPPR(dbParam)])
				.then(data=>{
					console.log(data);
					res.render('Org/viewProject', {
						actWithPPR: data[0],
						actWithoutPPR: data[1]
					});
				})
				.catch(error=>{
					console.log(error);
				})
			
		},
	};
};