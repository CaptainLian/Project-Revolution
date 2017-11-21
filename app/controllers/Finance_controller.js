module.exports = function(configuration, modules, models, database, queryFiles){

    const projectProposalModel = models.ProjectProposal_model;
    const financeModel = models.Finance_model;
    const gosmModel = models.gosmModel;


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
            // transactionType: if 0 direct payment; if 1 cash advance
            renderData.transactionType = req.params.transaction;
			return res.render('Finance/EvaluateTransaction', renderData);
			//next();
		},
		viewFinanceList: (req, res) => {

			//is cso
			if (req.session.user.organizationSelected.id == 0){

				database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivity(),
									financeModel.getApprovedTransactionTotalPerActivity()]);
				})
				.then(data=>{

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;
	            	renderData.isCso = true;
	            	renderData.activities = data[0];
	            	renderData.transactionTotal = data[1]
	            	renderData.approvedTransactionTotal = data[2];
	            	renderData.orgid = req.session.user.organizationSelected.id;
					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				})


			}//not cso
			else{
				
				database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivity(),
									financeModel.getApprovedTransactionTotalPerActivity()]);
				})
				.then(data=>{

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;
	            	renderData.isCso = false;
	            	renderData.activities = data[0];
	            	renderData.transactionTotal = data[1];
	            	renderData.approvedTransactionTotal = data[2];
	            	renderData.orgid = req.session.user.organizationSelected.id;
					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				});
			}


		},
		viewTransaction: (req, res) => {

			var dbParam = {
				gosmactivity: req.params.gosmactivity
			};

			database.task(t =>{
					return t.batch([financeModel.getActivityTransactions(dbParam),
									gosmModel.getGOSMActivity(dbParam),
									projectProposalModel.getProjectProposal(dbParam)]);
			})
			.then(data=>{

				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.transactions = data[0];
	            renderData.gosmactivity = data[1];
	            renderData.projectProposal = data[2]

	            //from cso
	            if (req.session.user.organizationSelected.id == 0) {
	            	renderData.isCso = true;
	            	return res.render('Finance/ViewActivityTransaction', renderData);
					//next();

	            }//not from cso
	            else{
	            	renderData.isCso = false;
	            	return res.render('Finance/ViewActivityTransaction', renderData);
					//next();
	            }

				

			}).catch(error=>{
				console.log(error);
			});


			
		},
		createPreactsCashAdvance: (req, res) => {

			//TODO: to be replaced by value from previous page
			var dbParam = {
				projectProposal: req.params.projectproposal
			};

			financeModel.getParticulars(dbParam)
			.then(data=>{


				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.particulars = data;
	            //TODO: to come from previous page
	            renderData.gosmactivity = req.params.gosmactivity;
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
				gosmactivity: 1,
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
	            		
	            		res.redirect(`/finance/list/transaction/${req.params.gosmactivity}`);

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

	            		res.redirect(`/finance/list/transaction/${req.params.gosmactivity}`);

	            	}).catch(error=>{
	            		console.log("error in transaction");
	            		console.log(error);
	            	});

	            	

	            }

	            

			}).catch(error=>{
				console.log(error);
			});


		},
		createPreacts: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/FinancePreacts', renderData);
			//next();
		},
	};
};
