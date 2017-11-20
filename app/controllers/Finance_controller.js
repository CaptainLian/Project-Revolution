module.exports = function(configuration, modules, models, database, queryFiles){

    const projectProposalModel = models.ProjectProposal_model;
    const financeModel = models.Finance_model;


	return {
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
		},
		evaluateTransaction: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/EvaluateTransaction', renderData);
			//next();
		},
		viewFinanceList: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Finance_list', renderData);
			//next();
		},
		createPreactsCashAdvance: (req, res) => {

			//TODO: to be replaced by value from previous page
			var dbParam = {
				projectProposal: 1
			};

			financeModel.getParticulars(dbParam)
			.then(data=>{


				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.particulars = data;
	            //TODO: to come from previous page
	            renderData.gosmactivity = 1;
				return res.render('Finance/Preacts_CashAdvance', renderData);
				//next();

			}).catch(error=>{
				console.log(error)
			});

		},
		submitPreacts: (req, res) => {

			console.log("IT ENTERS HERE");
			console.log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
			console.log(req.body);

			//TODO: gosmactivity to be changed later
			var dbParam = {
				gosmactivity: 2,
				submittedBy: req.session.user.idNumber,
				purpose: req.body.purpose,
				justification: req.body.nodpjustification
			};

				


			financeModel.insertPreActivityCashAdvance(dbParam)
			.then(data=>{

				let particulars = [];
	            particulars = req.body.particulars;

	            if (!Array.isArray(particulars)) {

	                var particularParam = {
	            		cashAdvance: data.id,
	            		particular: particulars
	            	};

	            	console.log("particular is only one");
	            	console.log(particulars);
	            	console.log(req.body.particulars);

	            	financeModel.insertPreActivityCashAdvanceParticular(particularParam)
	            	.then(data1=>{

	            	}).catch(error=>{
	            		console.log("error in one particular");
	            		console.log(error);
	            	});
	            
	            }
	            else{

	            	database.tx(transaction=>{

	            		for(var i = 0; i < particulars.length; i++){
	            			console.log("particulars is more than 1");

	            			var particularParam = {
	            				cashAdvance: data.id,
	            				particular: particulars[i]
	            			};

	            			financeModel.insertPreActivityCashAdvanceParticular(particularParam, transaction)
	            			.then(data1=>{

	            			}).catch(error=>{
	            				console.log("error is in particular loop");
	            				console.log(error);
	            			});


	            		}

	            	}).then(data2=>{

	            	}).catch(error=>{
	            		console.log("error in transaction");
	            		console.log(error);
	            	});

	            	

	            }

	            

			}).catch(error=>{
				console.log(error);
			});

			return  res.send("1");
		},
		createPreacts: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/FinancePreacts', renderData);
			//next();
		},
	};
};
