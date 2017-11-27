'use strict';

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

			            //to evaluate
			            renderData.isCso = null;
			            if((req.session.user.type >= 3 && req.session.user.type <= 6) ||
			            	req.extra_data.user.accessibleFunctionalitiesList['21']){
                            renderData.isCso = true;
                        	renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
                        }else{
                            renderData.isCso = req.extra_data.user.accessibleFunctionalitiesList['21'];
                            renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
                        }

						// to add transaction
						if (renderData.isCso && renderData.toadd) {

							console.log("CORRECT THIS FAR==============")

							var signatoryParam = {
								cashadvance: req.params.id,
								idnumber: req.session.user.idNumber
							};

							financeModel.checkCashAdvanceSignatory(signatoryParam)
							.then(signatory=>{

								console.log(signatory);
								console.log("inside signatoryquery");
								if (signatory.length==0) {
									renderData.isCso = false;
								}

								return res.render('Finance/EvaluateTransaction', renderData);

							}).catch(error=>{
								console.log(error);
							});

						}
						else{
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
			logger.debug('approveCashAdvance', log_options);

			database.task(t => {
				return t.batch([
					accountModel.getAccountDetails(req.session.user.idNumber, ['a.privateKey'], t),
					financeModel.getPreActivityCashAdvanceDetails(req.body.cashAdvanceId, [
						'preca.id AS cashadvance',
						'preca."GOSMActivity"',
						'preca."submissionID"',
						'preca."sequence"',
						'(a.firstname || \' \' || a.lastname ) AS submittedBy',
						"to_char(preca.\"dateSubmitted\", 'Mon DD, YYYY') AS dateSubmitted",
						'preca.purpose',
						'preca.justification'
					], t),
					financeModel.getPreActivityCashAdvanceParticularDetails(req.body.cashAdvanceId, [
						'ppe.id',
						'ppe.material',
						'ppe.quantity',
						'ppe.unitCost',
						'et.name AS type'
					], t)
				]);
			}).then(data => {
				logger.debug(`Cash Advance: ${data}`, log_options);

				const documentObj = Object.create(null);

				documentObj.CashAdvanceID = data[1].cashadvance;
				documentObj.ActivityID = data[1].GOSMActivity;
				documentObj.SubmissionID = data[1].submissionID;
				documentObj.VersionID = data[1].sequence;
				documentObj.SubmittedBy = data[1].submittedBy;
				documentObj.DateSubmitted = data[1].dateSubmitted;
				documentObj.Purpose = data[1].Purpose;
				documentObj.Justification = data[1].justification;

				documentObj.Particulars = [];
				for(const particular of data[2]){
					const particularObj = Object.create(null);
					particularObj.ID = particular.id;
					particularObj.Material = particular.material;
					particularObj.Quantity = particular.quantity;
					particularObj.UnitCost = particular.unitcost,
					particularObj.Type = particular.type;

					documentObj.Particulars[documentObj.Particulars.length] = particularObj;


				}

				const DOCUMENT_STRING = STRINGIFY(documentObj);
                logger.debug(`Private Key: ${data[0].privatekey}`);
                const {signature: DIGITAL_SIGNATURE} = SIGN(DOCUMENT_STRING, data[0].privatekey);
                logger.debug(`Document: ${DOCUMENT_STRING}\n\nDigital Signature: ${DIGITAL_SIGNATURE}`, log_options);

                return accountModel.approvePreActCashAdvance(req.body.cashAdvanceId, req.session.user.idNumber, DOCUMENT_STRING, DIGITAL_SIGNATURE);

			}).then(data => {
				console.log("successfully approved");
				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
			}).catch(err => {
				logger.warn(`${err.message}\n${err.stack}`);
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

			console.log("My user type is");
			console.log(req.session.user.type);

			if((req.session.user.type >= 3 && req.session.user.type <= 6) || req.extra_data.user.accessibleFunctionalitiesList['21']){

				var signatoryParam = {
					idnumber: req.session.user.idNumber
				}

                database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivityForSignatory(signatoryParam)]);
				})
				.then(data=>{

					console.log("DITO AKO ----------------------------------------------")

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;
	                //to evaluate
	                renderData.isCso = null;
	                if((req.session.user.type >= 3 && req.session.user.type <= 6) ||
	                	req.extra_data.user.accessibleFunctionalitiesList['21']){
	                    renderData.isCso = true;
	                	renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
	                }else{
	                    renderData.isCso = req.extra_data.user.accessibleFunctionalitiesList['21'];
	                    renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
	                }

	            	renderData.activities = data[0];
	            	renderData.transactionTotal = data[1];
	            	renderData.approvedTransactionTotal = null;

	            	if(!renderData.isCso){
	            		renderData.orgid = req.session.user.organizationSelected.id;
	            	}
	            	else if (renderData.isCso && renderData.toadd){
	            		renderData.orgid = req.session.user.organizationSelected.id;
	            	}

	            	console.log("orgid is ");
	            	console.log(renderData.orgid);

					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				});
            }
            else{

            	database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivity(),
									financeModel.getApprovedTransactionTotalPerActivity()]);
				})
				.then(data=>{

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;
	                //to evaluate
	                renderData.isCso = null;
	                if((req.session.user.type >= 3 && req.session.user.type <= 6) ||
	                	req.extra_data.user.accessibleFunctionalitiesList['21']){
	                    renderData.isCso = true;
	                	renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
	                }else{
	                    renderData.isCso = req.extra_data.user.accessibleFunctionalitiesList['21'];
	                    renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
	                }

	            	renderData.activities = data[0];
	            	renderData.transactionTotal = data[1];
	            	renderData.approvedTransactionTotal = data[2];

	            	if(!renderData.isCso){
	            		renderData.orgid = req.session.user.organizationSelected.id;
	            	}
	            	else if (renderData.isCso && renderData.toadd){
	            		renderData.orgid = req.session.user.organizationSelected.id;
	            	}

	            	console.log("orgid is ");
	            	console.log(renderData.orgid);

					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				});

            }

			
		},

		viewTransaction: (req, res) => {

			var dbParam = {
				gosmactivity: req.params.gosmactivity,
				idnumber: req.session.user.idNumber
			};

			console.log("THE DB PARAM IS");
			console.log(dbParam);
			const renderData = Object.create(null);
	        renderData.extra_data = req.extra_data;

            renderData.isCso = null;
            if((req.session.user.type >= 3 && req.session.user.type <= 6) ||
            	renderData.isCso = req.extra_data.user.accessibleFunctionalitiesList['21']){
                renderData.isCso = true;
	            renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
            }else{
                renderData.isCso = req.extra_data.user.accessibleFunctionalitiesList['21'];
                renderData.toadd = req.extra_data.user.accessibleFunctionalitiesList['18'];
            }


			if ((renderData.isCso) && (!renderData.toadd)) {

				console.log("is cso is");
				console.log(renderData.isCso);
				console.log("too add is ");
				console.log(renderData.toadd);

				console.log("it renders this one");

				database.task(t =>{
					return t.batch([financeModel.getActivityTransactionsForSignatory(dbParam),
									gosmModel.getGOSMActivity(dbParam),
									projectProposalModel.getProjectProposal(dbParam)]);
				})
				.then(data=>{


		            renderData.transactions = data[0];
		            renderData.gosmactivity = data[1];
		            renderData.projectProposal = data[2];

					return res.render('Finance/ViewActivityTransaction', renderData);

				}).catch(error=>{
					console.log(error);
				});


			}
			else{

				console.log("nope its this one");

				database.task(t =>{
					return t.batch([financeModel.getActivityTransactions(dbParam),
									gosmModel.getGOSMActivity(dbParam),
									projectProposalModel.getProjectProposal(dbParam)]);
				})
				.then(data=>{
		            renderData.transactions = data[0];
		            renderData.gosmactivity = data[1];
		            renderData.projectProposal = data[2];
					return res.render('Finance/ViewActivityTransaction', renderData);
				}).catch(error=>{
					console.log(error);
				});
			}
		},

		createPreactsCashAdvance: (req, res) => {
			var dbParam = {
				projectProposal: req.params.projectproposal
			};

			financeModel.getParticulars(dbParam)
			.then(data=>{


				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.particulars = data;
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

            let particulars = req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            database.tx(transaction => {
                return financeModel.insertPreActivityCashAdvance(dbParam, transaction)
                .then(data => {

                    for(let index = 0; index < particulars.length; ++index){
                        financeModel.insertPreActivityCashAdvanceParticular({
                            cashAdvance: data.id,
                            particular: particulars[index]
                        }, transaction);
                    }

                    

                    return Promise.resolve(true);
                });
            }).then(data =>{
                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
            }).catch(err => {
                return logger.warn(`${err.message}\n${err.stack}`, log_options);
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
