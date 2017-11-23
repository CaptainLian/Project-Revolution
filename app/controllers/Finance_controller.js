module.exports = function(configuration, modules, models, database, queryFiles){
	const SIGN = require('../utility/digitalSignature.js').signString;
    const STRINGIFY = require('json-stable-stringify');


	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'Finance-Controlelr';

    const projectProposalModel = models.ProjectProposal_model;
    const financeModel = models.Finance_model;
    const gosmModel = models.gosmModel;

    const accountModel = models.Account_model;

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

			// cash advance
			if (req.params.transaction == 1){

				var param = {
					id: req.params.id
				};

				financeModel.getPreActivityCashAdvance(param)
				.then(data=>{

					var dbParam = {
						gosmactivity: data.GOSMActivity
					};

					database.task(t=>{
						return t.batch([projectProposalModel.getProjectProposal(dbParam),
										financeModel.getCashAdvanceParticulars(param)]);
					})
					.then(data1=>{

						const renderData = Object.create(null);
			            renderData.extra_data = req.extra_data;
	            		renderData.csrfToken = req.csrfToken();
			            renderData.cashAdvance = data;
			            renderData.projectproposal = data1[0];
			            renderData.particulars = data1[1];
			            renderData.gosmactivity = data.GOSMActivity;
			            // transactionType: if 0 direct payment; if 1 cash advance
			            renderData.transactionType = req.params.transaction;

			             //from cso
			            if (req.session.user.user.type === 3 ||
							req.session.user.user.type === 4 ||
							req.session.user.user.type === 5 ||
							req.session.user.user.type === 6) {
			            	
			            	renderData.isCso = true;
			            	return res.render('Finance/EvaluateTransaction', renderData);
			            }
			            else{
			            	renderData.isCso = false;
			            	return res.render('Finance/EvaluateTransaction', renderData);
			            }

						//next();

					}).catch(error=>{
						console.log(error);
					});

					

				}).catch(error=>{
					console.log(error);
				});


			}
			else{

			}
		},
		approveCashAdvance: (req, res) => {

			console.log("approves cash advance");
			console.log(req.body.cashAdvanceId);

			var dbParam = {
				status: 1,
				id: req.body.cashAdvanceId
			};

			accountModel.getAccountDetails(req.session.user.idNumber, ['a.privateKey'])
			.then(data =>{
				return database.task(t => {
					return t.batch([
						
					]);
				});
			});

			financeModel.updatePreActivityCashAdvanceStatus(dbParam)
			.then(data=>{
				console.log("successfully approved");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error => {
				console.log(error);
			});

		},
		pendCashAdvance: (req, res) =>{

			console.log("pend cash advance");
			console.log(req.body.cashAdvanceId);

			var dbParam = {
				status: 2,
				id: req.body.cashAdvanceId
			};

			financeModel.updatePreActivityCashAdvanceStatus(dbParam)
			.then(data=>{

				console.log("successfully pended");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});

		},
		viewFinanceList: (req, res) => {

			//is cso
			if (req.session.user.type === 3 ||
				req.session.user.type === 4 ||
				req.session.user.type === 5 ||
				req.session.user.type === 6){

				database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivity(),
									financeModel.getApprovedTransactionTotalPerActivity()
									]);
				})
				.then(data=>{

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;
	            	renderData.isCso = true;
	            	renderData.activities = data[0];
	            	renderData.transactionTotal = data[1];
	            	renderData.approvedTransactionTotal = data[2];
	            	renderData.orgid = req.session.user.organizationSelected.id;
					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				});


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
	            renderData.projectProposal = data[2];

	            //from cso
	            if (req.session.user.type === 3 ||
					req.session.user.type === 4 ||
					req.session.user.type === 5 ||
					req.session.user.type === 6) {

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
				console.log(error);
			});

		},
		submitPreacts: (req, res) => {
			logger.debug('submitPreacts()', log_options);
			console.log(req.body);

			//TODO: gosmactivity to be changed later
			var dbParam = {
				gosmactivity: req.body.gosmactivity,
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
	            		
	            		res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

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

	            		res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

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
			return res.render('Finance/Preacts_DirectPayment', renderData);
			//next();
		},
		createPreactsBookTransfer: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Preacts_DirectPayment', renderData);
			//next();
		}
	};
};
