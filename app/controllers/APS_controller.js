module.exports = function(database, models, queryFiles){

	var gosmModel = models.GOSM_model;
	return {
		viewCreateGOSM: (req, res) => {
			console.log('VIEW CREATE GOSM CONTROLLER');
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('APS/GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {
					console.log(error);
					res('ERROR');
				});
		},
		createActivityRequirements:(req, res)=>{
			res.render("APS/ActivityRequirementsMain");
		},

		inputCreateGOSM: (req, res) => {
			console.log(JSON.stringify(req.body));
			gosmModel.getAllActivityTypes()
				.then(data => {
					res.render('APS/GOSMMain', {
						activityTypes: data
					});
				})
				.catch(error => {

				});
		},

		inputActivityRequirements: (req, res) => {

			console.log(req.body);

			//step 1
			var perspective = req.body.perspective;
			
			//step 2
			var date = [];
			date = req.body['date[]'];
			var timeStart = [];
			timeStart = req.body['timeStart[]'];
			var timeEnd = [];
			timeEnd = req.body['timeEnd[]'];
			var activity = [];
			activity = req.body['activity[]'];
			var description = [];
			description = req.body['description[]'];
			var personInCharge = [];
			personInCharge = req.body['personInCharge'];

			//step 3
			var expenses = req.body.expenses;
			var organizationalFunds = req.body.organizationalFunds;
			var participantsFee = req.body.participantsFee;
			var others = req.body.others;

			var material = [];
			material = req.body['material[]'];
			var materialQuantity = [];
			materialQuantity = req.body['materialQuantity[]'];
			var unitCost = [];
			unitCost = req.body['unitCost[]'];

			//step 4
			var operationalFund = req.body.operationalFund;
			var depositoryFund = req.body.depositoryFund;
			var otherSourceOfFunds = req.body.otherSourceOfFunds;

			var revenueItem = [];
			revenueItem = req.body['revenueItem[]'];
			var revenueQuantity = [];
			revenueQuantity = req.body['revenueQuantity[]'];
			var revenueSellingPrice = [];
			revenueSellingPrice = req.body['revenueSellingPrice[]'];


			var expenseItem = [];
			expenseItem = req.body['expenseItem[]'];
			var expenseQuantity = [];
			expenseQuantity = req.body['expenseQuantity[]'];
			var expenseSellingPrice = [];
			expenseSellingPrice = req.body['expenseSellingPrice[]'];

			//step 5
			var attachment = req.body.attachment;

			var enp = req.body.enp;
			var venue = req.body.venue;
		}
	};
};