'use strict';
var timediff = require('timediff');

module.exports = function(configuration, modules, models, database, queryFiles){
	const Promise = modules.Promise;

	const SIGN = require('../utility/digitalSignature.js').signString;
    const STRINGIFY = require('json-stable-stringify');

    const path = require('path');
    const fs = require('fs');
	const cuid = require('cuid');

	const logger = modules.logger;
	const log_options = Object.create(null);
	log_options.from = 'Finance-Controlelr';

    const projectProposalModel = models.ProjectProposal_model;
    const financeModel = models.Finance_model;
    const gosmModel = models.gosmModel;
    const accountModel = models.Account_model;

	return {
		createTransaction: (req, res) => {
			logger.info('call createTransaction()', log_options);

			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/TransactionMain', renderData);
		},

		viewPended: (req, res) => {
			logger.info('call viewPended()', log_options);

			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/', renderData);
		},
		viewFinanceSettings: (req, res) => {
			logger.info('call viewFinanceSettings()', log_options);

			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Finance_Settings', renderData);
		},

		evaluateTransaction: (req, res) => {
			logger.info('call 3evaluateTransaction()', log_options);

			var viewEvaluation = false;
		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		viewEvaluation = true;
		    	}
		    	else{
		    		viewEvaluation = false;
		    	}
		    }
		    else if(req.session.user.type >= 3 && req.session.user.type <= 6){
		    	viewEvaluation = true;
		    }
		    else{
		    	viewEvaluation = false;
		    }

		    if(viewEvaluation){

		    	// TODO: change payable to in html of evaluate transaction
				// direct payment
				if (req.params.transaction == 0){

					var param = {
						id: req.params.id
					};

					console.log("is direct payment");

	                //TODO: flatten promise
					financeModel.getPreActivityDirectPayment(param).then(data=>{
						var dbParam = {
							gosmactivity: data.GOSMActivity
						};

						database.task(t=>{
							return t.batch([
	                            projectProposalModel.getProjectProposal(dbParam),
								financeModel.getDirectPaymentParticulars(param),
								financeModel.getDirectPaymentSignatory(param)]);
						}).then(data1=>{
							const renderData = Object.create(null);
				            renderData.extra_data = req.extra_data;
		            		renderData.csrfToken = req.csrfToken();
				            renderData.directPayment = data;
				            renderData.projectproposal = data1[0];
				            renderData.particulars = data1[1];
				            renderData.gosmactivity = data.GOSMActivity;
				            // transactionType: if 0 direct payment; if 1 cash advance
				            renderData.transactionType = req.params.transaction;
				            
				            //to evaluate
				           
				           	if(data.status==0){
				           		if(data1[2].signatory == req.session.user.idNumber){
				           			renderData.toEvaluate = true; 
					           	}
					           	else{
					           		renderData.toEvaluate = false;
					           	}
				           	}
				           	else{
				           		renderData.toEvaluate = false;
				           	}

				           	if(data.orgid == req.session.user.organizationSelected.id){
					           	return res.render('Finance/EvaluateTransaction', renderData);
				           	}
				           	else{
	    						return res.render('System/403');
				           	}
						}).catch(error => {
							return logger.debug(`${error.message}\n${error.stack}`, log_options);
						});
					}).catch(error => {
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});
				} // cash advance
			 	else if (req.params.transaction == 1){
					logger.debug('Cash Advance', log_options);
					var param = {
						id: req.params.id
					};

					financeModel.getPreActivityCashAdvance(param).then(data=>{
						var dbParam = {
							gosmactivity: data.GOSMActivity
						};

						logger.debug('starting tasks', log_options);
						database.task(t=>{
							return t.batch([projectProposalModel.getProjectProposal(dbParam),
											financeModel.getCashAdvanceParticulars(param),
											financeModel.checkCashAdvanceSignatory(param)]);
						}).then(data1=>{
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

				            if(data.status==0){
				           		if(data1[2].signatory == req.session.user.idNumber){
				           			renderData.toEvaluate = true; 
					           	}
					           	else{
					           		renderData.toEvaluate = false;
					           	}
				           	}
				           	else{
				           		renderData.toEvaluate = false;
				           	}
				           
				           
							if(data.orgid == req.session.user.organizationSelected.id){
					           	return res.render('Finance/EvaluateTransaction', renderData);
				           	}
				           	else{
	    						return res.render('System/403');
				           	}


							
						}).catch(error=>{
							return logger.debug(`${error.message}\n${error.stack}`, log_options);
						});
					}).catch(error=>{
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});


				}// book transfer
				else if(req.params.transaction==2){

					logger.debug('Book Transfer', log_options);
					var param = {
						id: req.params.id
					};

					financeModel.getPreActivityBookTransfer(param).then(data=>{
						var dbParam = {
							gosmactivity: data.GOSMActivity
						};


						logger.debug('starting tasks', log_options);
						database.task(t=>{
							return t.batch([
								projectProposalModel.getProjectProposal(dbParam),
								financeModel.getBookTransferParticulars(param),
								financeModel.getBookTransferSignatory(param)
							]);
						}).then(data1=>{
							const renderData = Object.create(null);
				            renderData.extra_data = req.extra_data;
		            		renderData.csrfToken = req.csrfToken();
				            renderData.bookTransfer = data;
				            renderData.projectproposal = data1[0];
				            renderData.particulars = data1[1];
				            renderData.gosmactivity = data.GOSMActivity;
				            // transactionType: if 0 direct payment; if 1 cash advance; if 2 book transfer; if 3 reimbursement
				            renderData.transactionType = req.params.transaction;
				            

				            //to evaluate

				            if(data.status==0){
				           		
				           		if(data1[2].signatory == req.session.user.idNumber){
				           			renderData.toEvaluate = true; 
					           	}
					           	else{
					           		renderData.toEvaluate = false;
					           	}

				           	}
				           	else{
				           		renderData.toEvaluate = false;
				           	}
				           
				           
							if(data.orgid == req.session.user.organizationSelected.id){
					           	return res.render('Finance/EvaluateTransaction', renderData);
				           	}
				           	else{
	    						return res.render('System/403');
				           	}


							
						}).catch(error=>{
							return logger.debug(`${error.message}\n${error.stack}`, log_options);
						});
					}).catch(error=>{
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});

				}// reimbursement
				else if(req.params.transaction==3){

					logger.debug('Reimbursement', log_options);
					var param = {
						id: req.params.id
					};

					financeModel.getPostProjectReimbursement(param).then(data=>{
						var dbParam = {
							gosmactivity: data.GOSMActivity
						};

						logger.debug('starting tasks', log_options);
						database.task(t=>{
							return t.batch([projectProposalModel.getProjectProposal(dbParam),
											financeModel.getReimbursementParticulars(param),
											financeModel.getReimbursementSignatory(param)]);
						}).then(data1=>{
							const renderData = Object.create(null);
				            renderData.extra_data = req.extra_data;
		            		renderData.csrfToken = req.csrfToken();
				            renderData.reimbursement = data;
				            renderData.projectproposal = data1[0];
				            renderData.particulars = data1[1];
				            renderData.gosmactivity = data.GOSMActivity;
				            // transactionType: if 0 direct payment; if 1 cash advance; if 2 book transfer; if 3 reimbursement
				            renderData.transactionType = req.params.transaction;
				            

				            //to evaluate

				            if(data.status==0){

				            	console.log(data[2]);
				            	console.log("This is the signatory");


				           		//TODO: if all has signed
				           		if(data1[2].signatory == req.session.user.idNumber){
				           			renderData.toEvaluate = true; 
					           	}
					           	else{
					           		renderData.toEvaluate = false;
					           	}
					           	
				           	}
				           	else{
				           		renderData.toEvaluate = false;
				           	}
				           
				           
							if(data.orgid == req.session.user.organizationSelected.id){
					           	return res.render('Finance/EvaluateTransaction', renderData);
				           	}
				           	else{
	    						return res.render('System/403');
				           	}


							
						}).catch(error=>{
							return logger.debug(`${error.message}\n${error.stack}`, log_options);
						});
					}).catch(error=>{
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});

				}
				else{
	    			return res.render('System/404');
				}
		    }
		    else{
	    		return res.render('System/403');
		    }
		},

		approveDirectPayment: (req, res) =>{
            logger.info('call approveDirectPayment()', log_options);

            /**
             * Gets all needed details for the digital signature
             */
            database.task(t => {
                return t.batch([
                    //0
                    accountModel.getAccountDetails(req.session.user.idNumber, [
                        'a.privateKey'
                    ], t),
                    //1
                    financeModel.getPreActivityDirectPaymentDetails(req.body.directPaymentId, [
                    	'padp.id ',
                        'padp."GOSMActivity" as "activityID"',
                        'padp."submissionID"',
                        'padp."sequence"',
                        'padp."submittedBy"',
                        'to_char(padp."dateSubmitted", \'Mon DD, YYYY\') AS "dateSubmitted"',
                        'padp."nameOfEstablishment"',
                        'padp."reasonForDelayedPRSProcessing"',
                        'padp."galsFilenameToShow" AS "GALS"',
                        'padp."fqFilenameToShow" AS "FQ"',
                        'padp."rofFilenameToShow" AS "ROF"'
                    ], t),
                    //2
                    financeModel.getPreActivityDirectPaymentParticularDetails(req.body.directPaymentId, [
                        'ppe.sequence',
                        'ppe.material',
                        'ppe.quantity',
                        'ppe.unitCost',
                        'et.name AS type'
                    ], t)
                ]);
            }).then(data => {
                const documentObject = Object.create(null);
                const dpDetails = data[1];

                documentObject.ID = dpDetails.id;
                documentObject.ActivityID = dpDetails.activityID;
                documentObject.SubmissionID = dpDetails.submissionID;
                documentObject.Sequence = dpDetails.sequence;
                documentObject.SubmittedBy = dpDetails.submittedBy;
                documentObject.DateSubmitted = dpDetails.DateSubmitted;
                documentObject.NameOfEstablishment = dpDetails.nameOfEstablishment;
                documentObject.ReasonForDelayedPRSProcessing = dpDetails.reasonForDelayedPRSProcessing ? dpDetails.reasonForDelayedPRSProcessing : undefined;
                documentObject.GALS = dpDetails.GALS;
                documentObject.FQ = dpDetails.FQ;
                documentObject.ROF = dpDetails.ROF;

                documentObject.Particulars = [];
                for(const particular of data[2]){
                    const particularObject = Object.create(null);
                    particularObject.Sequence = particular.sequence;
                    particularObject.Material = particular.material;
                    particularObject.Quantity = particular.quantity;
                    particularObject.Type = particular.type;

                    documentObject.Particulars[documentObject.Particulars.length] = particularObject;
                }

                const PRIVATE_KEY = data[0].privatekey;
                const DOCUMENT_STRING = STRINGIFY(documentObject);
                const {signature: DIGITAL_SIGNATURE} = SIGN(DOCUMENT_STRING, PRIVATE_KEY);

                return accountModel.approveDirectPayment(
                    req.body.directPaymentId,
                    req.session.idNumber,
                    DOCUMENT_STRING,
                    DIGITAL_SIGNATURE
                );
            }).then(() => {
                logger.debug('Direct payment successfully approved', log_options);
                res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

                return database.task(t => {
                	return t.batch([
                		projectProposalModel.getActivityProjectProposalDetailsGAID(dpDetails.activityID, [
                			'ga.strategies'
                		], t),
                		gosmModel.getActivityProjectHeads(dpDetails.activityID, [
                			'a.idNumber "idNumber"'
                		], t),
                		financeModel.getPreActivityDirectPaymentNextSignatory(dpDetails.id, t),
                		accountModel.getAccountDetails(req.session.idNumber, [
                			'a.idnumber AS "idNumber"',
                			'a.firstname || \' \' || a.lastname'
                		], t),

                	]);
                });
            }).then(data => {
            	const strategy = data[0].strategies;
            	const projectHeads = data[1];
            	const nextSignatory = data[2];
            	const currentSignatoryDetails = data[3];

            	return database.task(t => {
            		let queries = [];

            		let details = Object.create(null);
            		details.directPaymentID = dpDetails.id;

            		if(nextSignatory){
            			queries[0] = accountModel.addNotification(
            				nextSignatory.idNumber,
            				//title
            				'Evaluate Direct Payment',
            				//description
            				`Please evaluate the direct payment for ${strategy}`,
            				//Details
            				details,
            				//fields
            				null,
            				t
            			);
            		}

            		details.signatory = currentSignatoryDetails.idNumber;
            		for(const projectHead of projectHeads){
            			queries[queries.length] = accountModel.addNotification(
            				projectHead.idNumber,
            				//title
            				'Evaluatation of Direct Payment',
            				`Your direct payment for ${strategy} has be approved by ${currentSignatoryDetails.name}`,
            				details,
            				null,
            				t
            			);
            		}

            		return t.batch(queries);
            	});
            }).then(() => {
            	return logger.debug('Notifications successfully added', log_options);
            }).catch(err => {
                return logger.error(`${err.message}\n${err.stack}`, log_options);
            });
		},

		pendDirectPayment: (req, res) =>{
			logger.info('call pendDirectPayment()', log_options);

			var dbParam = {
				directPayment: req.body.directPaymentId,
				signatory: req.session.user.idNumber
			};

            //TODO: move function to accountModel
			financeModel.pendDirectPayment(dbParam).then(data=>{
				console.log("successfully pended direct payment");

                //TODO: notifications
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
			}).catch(error=>{
				console.log(error);
			});
		},

		approveCashAdvance: (req, res) => {
			logger.info('call approveCashAdvance()', log_options);

			database.task(t => {
				return t.batch([
                    //0
					accountModel.getAccountDetails(req.session.user.idNumber, [
						'a.privateKey'
						], t),
                    //1
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
                    //2
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

                return Promise.all([
                	accountModel.approvePreActCashAdvance(req.body.cashAdvanceId, req.session.user.idNumber, DOCUMENT_STRING, DIGITAL_SIGNATURE),
                	Promise.resolve(data[1].GOSMActivity),
                	Promise.resolve(data[1].cashadvance)
                ]);
			}).then(([signing, GAID, cashAdvanceID]) => {
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
				logger.debug('Successfully approved cash advance', log_options);

				logger.debug('Adding notifications', log_options);
				return database.task(t => {
					return t.batch([
						//0
						projectProposalModel.getActivityProjectProposalDetailsGAID(GAID, [
                			'ga.strategies'
                		], t),
                		//1
						gosmModel.getActivityProjectHeads(GAID, [
							'a.idnumber AS "idNumber"'
						], t),
						//2
						financeModel.getPreActivityCashAdvanceNextSignatory(cashAdvanceID, t),
						//3
						accountModel.getAccountDetails(req.session.idNumber, [
							'a.idnumber AS "idNumber"',
							'a.firstname || \' \' || a.lastname AS "name"'
						], t),
						//4
						Promise.resolve(cashAdvanceID)
					]);
				});
			}).then(([GOSMDetails, projectHeads, nextSignatory, currentSignatoryDetails, cashAdvanceID]) => {
				const strategy = GOSMDetails.strategies;

				return database.task(t => {
					let queries = [];

					let details = Object.create(null);
        			details.cashAdvanceID = cashAdvanceID;

					if(nextSignatory){
						queries[0] = accountModel.addNotification(
        					nextSignatory.idNumber,
	        				//title
	        				'Evaluate Cash Advance',
	        				//description
	        				`Please evaluate the cash advance for ${strategy}`,
	        				//Details
	        				details,
	        				//fields
	        				null,
	        				t
        				);
					}

					details.signatory = currentSignatoryDetails.idNumber;
	        		for(const projectHead of projectHeads){
	        			queries[queries.length] = accountModel.addNotification(
	        				projectHead.idNumber,
	        				'Evaluatation of Cash Advance',
	        				`Your cash advance for ${strategy} has be approved by ${currentSignatoryDetails.name}`,
	        				details,
	        				null,
	        				t
	        			);
	        		}

					return t.batch(queries);
				});
			}).then(() => {
				return logger.debug('successfully added notifications', log_options);
			}).catch(err => {
				return logger.error(`${err.message}\n${err.stack}`, log_options);
			});
		},

		pendCashAdvance: (req, res) =>{
			logger.info('call pendCashAdvance()', log_options);

			console.log(req.body);
			console.log("pend cash advance");
			console.log(req.body.cashAdvanceId);

			accountModel.pendCashAdvance(
				req.body.cashAdvanceId, 
				req.session.user.idNumber
			).then(data => {
				logger.debug('Successfully pended cash advance', log_options);

				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
			}).catch(error => {
				return logger.error(`${err.message}\n${err.stack}`);
			});

		},

		approveReimbursement: (req, res) =>{
			var dbParam = {
				reimbursement: req.body.reimbursementId,
				gosmactivity: req.body.gosmactivity,
				idnumber: req.session.user.idNumber
			}

			financeModel.approveReimbursement(dbParam).then(data=>{
				console.log("successfully approved reimbursement");
				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
			}).catch(error=>{
				logger.error(`${error.message}: ${error.stack}`, log_options);
			});
		},

		pendReimbursement: (req, res) =>{
			

			var dbParam = {
				reimbursement: req.body.reimbursementId,
				gosmactivity: req.body.gosmactivity,
				idnumber: req.session.user.idNumber
			}

			financeModel.pendReimbursement(dbParam).then(data=>{

				console.log("successfully pended reimbursement");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});
		},

		approveBookTransfer: (req, res) =>{


			var dbParam = {
				booktransfer: req.body.bookTransferId,
				gosmactivity: req.body.gosmactivity,
				idnumber: req.session.user.idNumber
			}

			financeModel.approveBookTransfer(dbParam)
			.then(data=>{

				console.log("successfully approved book transfer");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);


			}).catch(error=>{
				console.log(error);
			});

		},

		pendBookTransfer: (req, res) =>{


			var dbParam = {
				booktransfer: req.body.bookTransferId,
				gosmactivity: req.body.gosmactivity,
				idnumber: req.session.user.idNumber
			}

			financeModel.pendBookTransfer(dbParam)
			.then(data=>{

				console.log("successfully pended book transfer");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);


			}).catch(error=>{
				console.log(error);
			});

		},

		viewFinanceList: (req, res) => {

			console.log("My user type is");
			console.log(req.session.user.type);

			const renderData = Object.create(null);
	       	renderData.extra_data = req.extra_data;

	        //to evaluate
	        renderData.isCso = false;
		    renderData.toadd = false;

		    var financeList = false;

		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		financeList = true;
		    	}
		    	else{

		    		//TODO: if projecthead
		    		financeList = false;
		    	}

		    }
		    else if(req.session.user.type >= 3 && req.session.user.type <= 6){

		    	financeList = true;

		    }
		    else{
		    	financeList = false;
		    }

	        if (financeList){

		        database.task(t =>{
					return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
									financeModel.getTransactionTotalPerActivity(),
									financeModel.getApprovedTransactionTotalPerActivity()]);
				})
				.then(data=>{

					const renderData = Object.create(null);
		           	renderData.extra_data = req.extra_data;

		           	//checks if student
		           	if (req.session.user.type == 1 && req.session.user.organizationSelected.id != 0){
			        	renderData.isCso = false;
			            renderData.toadd = true;
			            console.log("it enters this if");

		           	}else{
		           		renderData.isCso = true;
		           		renderData.toadd = false;
		           		console.log("Is in this if actually");
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


		           	// sample session var
	   				// req.session.pprid =1;


		           	console.log("orgid is ");
		           	console.log(renderData.orgid);

					return res.render('Finance/Finance_list', renderData);
					//next();

				}).catch(error=>{
					console.log(error);
				});

	        }
	    	else{


	    		return res.render('System/403');

	    	}


            


		},

		viewTransaction: (req, res) => {


			//TODO: error check if user may enter page
			// current assumes user is authorized to view activity
			var dbParam = {
				gosmactivity: req.params.gosmactivity,
				idnumber: req.session.user.idNumber
			};

			console.log("THE DB PARAM IS");
			console.log(dbParam);
			const renderData = Object.create(null);
	        renderData.extra_data = req.extra_data;


           	//to evaluate
            renderData.isCso = null;
            renderData.toadd = null;
            if(req.session.user.type >= 3 && req.session.user.type <= 6){
            	renderData.isCso = true;
            	renderData.toadd = false;

            	console.log("User type is between 3 and 6");

				database.task(t =>{
					return t.batch([
                        financeModel.getActivityTransactions(dbParam),
                        gosmModel.getGOSMActivity(dbParam),
						projectProposalModel.getProjectProposal(dbParam)
                    ]);
				}).then(data=>{
		            renderData.transactions = data[0];
		            renderData.gosmactivity = data[1];
		            renderData.projectProposal = data[2];



					return res.render('Finance/ViewActivityTransaction', renderData);
				}).catch(error=>{
					console.log(error);
				});

            } else{

            	console.log("user reaches this point of if");


            	var viewTransaction = false;

			    if (req.session.user.type == 1){

			    	renderData.isStudent = true;

			    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
			    	if(ACL[25] || ACL[26]){
			    		viewTransaction = true;
			    	}
			    	else{
			    		viewTransaction = false;
			    	}

			    }
			    else{

			    	renderData.isStudent = false;

			    	viewTransaction = false;
			    }

	           	if (viewTransaction){
		        	renderData.isCso = false;
		            renderData.toadd = true;

		            console.log("User is student and is president/treasurer");

		            gosmModel.getGOSMActivityOrg(dbParam)
		            .then(data=>{

		            	if(req.session.user.organizationSelected.id == data.studentorganization){

		            		console.log("its this one");
							database.task(t =>{
								return t.batch([
			                        financeModel.getActivityTransactions(dbParam),
									gosmModel.getGOSMActivity(dbParam),
									projectProposalModel.getProjectProposal(dbParam),
									financeModel.getExpensesWithoutTransactionCount(dbParam)
			                    ]);
							}).then(data=>{
					            renderData.transactions = data[0];
					            renderData.gosmactivity = data[1];
					            renderData.projectProposal = data[2];

					            let actualdate = data[2].actualedate;
					            let currentdate = data[2].currdate;

								console.log("actualdate");
								console.log(actualdate);
								console.log("currentdate");
								console.log(currentdate);

								var diff = timediff(actualdate, currentdate, 'D');
				            	console.log(diff);
				            	console.log("difference");

				            	if (diff.days>0){
				            		renderData.reimbursement = true;
				            	}
				            	else{
				            		renderData.reimbursement = false;
				            	}

				            	if (data[3] == null){
				            		renderData.toadd = false;
				            	}
				            	else{
				            		renderData.toadd = true;
				            	}

				            	renderData.idnumber = req.session.user.idNumber;


								return res.render('Finance/ViewActivityTransaction', renderData);
							}).catch(error=>{
								console.log(error);

							});

		            	} else{
		
	    					return res.render('System/403');

		            	}

		            }).catch(error=>{
		            	console.log("error is in the new query 1");
		            	console.log(error);
		            });


	           	}else{

	    			return res.render('System/403');

	           	}

            }

		},

		createPreactsCashAdvance: (req, res) => {

			var dbParam = {
				gosmactivity: req.params.gosmactivity
			};

			var addTransaction = false;

		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		addTransaction = true;
		    	}
		    	else{
		    		addTransaction = false;
		    	}

		    }
		    else{
		    	addTransaction = false;
		    }

		    if(addTransaction){

		    	financeModel.getExpensesWithoutTransactionCount(dbParam)
		    	.then(transactionCount=>{

		    		console.log("eyyyyyyyyyyyyy");

		    		if (transactionCount.expensestotal > 0){
		           		
						projectProposalModel.getProjectProposal(dbParam)
						.then(data=>{

							var param ={
								projectproposal: data.id
							};

							financeModel.getParticulars(param)
							.then(data1=>{
								const renderData = Object.create(null);
					            renderData.extra_data = req.extra_data;
					            renderData.csrfToken = req.csrfToken();
					            renderData.particulars = data1;
					            renderData.gosmactivity = req.params.gosmactivity;
								return res.render('Finance/Preacts_CashAdvance', renderData);
							}).catch(error=>{
								console.log(error);
							});

						}).catch(error=>{
							console.log(error);
						});	

		        	}
		        	else{
	    				return res.render('System/403');
				    }

		    	}).catch(error=>{
		    		console.log(error);
		    	});

		    }
		    else{
	    		return res.render('System/403');
		    }

			

			
		},

		//Cash Advance
		submitPreacts: (req, res) => {
			logger.debug('submitPreacts()', log_options);
			console.log(req.body);

			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				submittedBy: req.session.user.idNumber,
				justification: req.body.nodpjustification,
				purpose: req.body.cpjustification

			};
			console.log("req.files");
			console.log(req.files);

            let particulars = req.body['particulars[]'] ? req.body['particulars[]'] : req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/finance/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'finance');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/finance/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'finance', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }
             //  //TEMP SAVING FILEs
	            // var date = cuid();
	            // var nFilename = req.files['file'].name.split('.').pop();
	            // var p = path.normalize(path.join(dir2, date + '.' + nFilename));
	            //             Promise.all([
	            //                 req.files['file'].mv(p),
	            //                 // projectProposalModel.insertProjectProposalAttachment(db)

	            //             ]).then(result => {
	            //                 console.log(result);
	            //             }).catch(err => {
	            //                 console.log(err);
	            //             });

            database.tx(transaction => {

	            //TEMP SAVING FILEs
	            var date = cuid();
	            var nFilename = req.files['file'].name.split('.').pop();
	            var p = path.normalize(path.join(dir2, date + '.' + nFilename));
	            dbParam["filename"] = date + '.' + nFilename;
	            dbParam["filenameToShow"] = req.files['file'].name.split('.')[0]+'.'+nFilename
                Promise.all([
                    req.files['file'].mv(p),
                    // projectProposalModel.insertProjectProposalAttachment(db)
                ]).then(result => {
                    console.log(result);
                }).catch(err => {
                    console.log(err);
                });
                //TO ADD FILE NAME OF FILES
              	//TODO: gosmactivity to be changed later
                return financeModel.insertPreActivityCashAdvance(dbParam, transaction).then(data => {
                    let query = [];
                    for(let index = 0; index < particulars.length; ++index){
                        query.push(
                            financeModel.insertPreActivityCashAdvanceParticular({
                                cashAdvance: data.id,
                                particular: particulars[index]
                        }, transaction));
                    }

                    return transaction.batch(query);
                });
            }).then(data =>{
                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
            }).catch(err => {
                return logger.warn(`${err.message}\n${err.stack}`, log_options);
            });
		},

		createPreactsDirectPayment: (req, res) => {

			var dbParam = {
				gosmactivity: req.params.gosmactivity
			};

			var addTransaction = false;

		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		addTransaction = true;
		    	}
		    	else{
		    		addTransaction = false;
		    	}

		    }
		    else{
		    	addTransaction = false;
		    }

		    if(addTransaction){

		    	financeModel.getExpensesWithoutTransactionCount(dbParam)
		    	.then(transactionCount=>{

		    		if (transactionCount.expensestotal > 0){
		           		
						projectProposalModel.getProjectProposal(dbParam)
						.then(data=>{

							var param ={
								projectproposal: data.id
							};


							financeModel.getParticulars(param)
				            .then(data1=>{
								let actualdate = data.actualedate;
					            let currentdate = data.currdate;

								console.log("actualdate");
								console.log(actualdate);
								console.log("currentdate");
								console.log(currentdate);

								var diff = timediff(actualdate, currentdate, 'D');
				            	console.log(diff);
				            	console.log("difference")

				            	if (diff.days>31){
				            		var justification = true;
				            		console.log("enters here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				            	}
				            	else{
				            		var justification = false;
				            		console.log("here instead----------++++++++++++++++++")
				            	}

								console.log("Here is the data ----------------------------------");
								const renderData = Object.create(null);
				            	renderData.extra_data = req.extra_data;
					            renderData.csrfToken = req.csrfToken();
					            renderData.particulars = data1;
					            renderData.justification = justification;
					            console.log(renderData.justification);
					            renderData.gosmactivity = req.params.gosmactivity;
								return res.render('Finance/Preacts_DirectPayment', renderData);
							}).catch(error=>{
								console.log(error);
							});

						}).catch(error=>{
							console.log(error);
						});	

		        	}
		        	else{
	    				return res.render('System/403');
				    }

		    	}).catch(error=>{
		    		console.log(error);
		    	});
		    }
		    else{
	    		return res.render('System/403');
		    }
		},

		submitPreactsDirectPayment: (req, res) => {
			logger.debug('submitPreactsDirectPayment()', log_options);

			var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');
            console.log(req.files)
            console.log(req.files['frf'] != undefined)
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/finance/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'finance');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/finance/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'finance', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }

			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				submittedby: req.session.user.idNumber,
				reason: req.body.nodpjustification,
				fqfn:'',
				fqfts:'',
				roffn:'',
				roffts:'',
				galfn:'',
				galfts:''
			};

            let particulars = req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            database.tx(transaction => {

            	  //TEMP SAVING FILEs
            	console.log("FQ ")

            	
	            var date = cuid();
	            var nFilename = req.files['fq'].name.split('.').pop();
	            dbParam["fqfn"] = date + '.' + nFilename;
	            dbParam["fqfts"] = req.files['fq'].name.split('.')[0]+'.'+nFilename
	            var p = path.normalize(path.join(dir2, date + '.' + nFilename));
	            req.files['fq'].mv(p,function(err){
	            	if(err){
	            		console.log("FQ ERROR")
	            		return err;
	            	}
	            })
	            console.log("FRF ")
	            if(req.files['frf'] != undefined){
	            	
		            var date2 = cuid();
		            var nFilename2 = req.files['frf'].name.split('.').pop();
		            var p2 = path.normalize(path.join(dir2, date2 + '.' + nFilename2));
		            dbParam["roffn"] = date2 + '.' + nFilename;
		            dbParam["roffts"] = req.files['frf'].name.split('.')[0]+'.'+nFilename2	
		            req.files['frf'].mv(p2,function(err){
		            	if(err){
		            		console.log("FRF ERROR")
		            		return err;
		            	}
		            })

	            }
	            
	            console.log("ELP ")
	            if(req.files['elp'] != undefined){
		            var date3 = cuid();
		            var nFilename3 = req.files['elp'].name.split('.').pop();
		            var p3 = path.normalize(path.join(dir2, date3 + '.' + nFilename3));
		            dbParam["galfn"] = date3 + '.' + nFilename;
		            dbParam["galfts"] = req.files['elp'].name.split('.')[0]+'.'+nFilename3	
		            req.files['elp'].mv(p2,function(err){
		            	if(err){
		            		console.log("ELP ERROR")
		            		return err;
		            	}
		            })

	            }
	            

	            
	           


	            
                 




	            return financeModel.insertPreActivityDirectPayment(dbParam, transaction).then(data => {
	            	let query = [];

                    for(let index = 0; index < particulars.length; ++index){
                    	query[query.length] = financeModel.insertPreActivityDirectPaymentParticular({
                            directpayment: data.id,
                            particular: particulars[index]
                        }, transaction);
                    }

                    return transaction.batch(query);
                });
            }).then(data =>{
                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
            }).catch(err => {
            	console.log("ERROR---------------------------")
                console.log(err)
            });
		},
		
		createReimbursement: (req, res) => {


			var dbParam = {
				gosmactivity: req.params.gosmactivity
			};

			var addTransaction = false;

		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		addTransaction = true;
		    	}
		    	else{
		    		addTransaction = false;
		    	}

		    }
		    else{
		    	addTransaction = false;
		    }

		    if(addTransaction){

		    	financeModel.getExpensesWithoutTransactionCount(dbParam).then(transactionCount => {
		    		if (transactionCount.expensestotal > 0){
						projectProposalModel.getProjectProposal(dbParam).then(data => {

							var param ={
								projectproposal: data.id
							};

							let actualdate = data.actualedate;
					        let currentdate = data.currdate;

							console.log("actualdate");
							console.log(actualdate);
							console.log("currentdate");
							console.log(currentdate);

							var diff = timediff(actualdate, currentdate, 'D');
				           	console.log(diff);
				           	console.log("difference");

							financeModel.getParticulars(param).then(data1=>{
								
								const renderData = Object.create(null);

								if (diff.days>30){
					           		renderData.justification = true;
					           	}
					           	else{
					           		renderData.justification = false;
					           	}

					            renderData.extra_data = req.extra_data;
					            renderData.csrfToken = req.csrfToken();
					            renderData.particulars = data1;
					            renderData.gosmactivity = req.params.gosmactivity;
								return res.render('Finance/Preacts_Reimbursement', renderData);

							}).catch(error=>{
								console.log(error);
							});

						}).catch(error=>{
							console.log(error);
						});	
		        	}
		        	else{
	    				return res.render('System/403');
				    }

		    	}).catch(error=>{
		    		console.log(error);
		    	});
		    }
		    else{
	    		return res.render('System/403');
		    }
		},

		submitReimbursement: (req, res) =>{
			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				justificationfdpp: req.body.justificationdelay,
				justificationfnucadp: req.body.nodpjustification,
				submittedby: req.session.user.idNumber
			};

            let particulars = req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            console.log(dbParam);
            console.log(particulars);

            database.tx(transaction => {
	            return financeModel.insertReimbursement(dbParam, transaction).then(data => {
	            	let query = [];

                    for(let index = 0; index < particulars.length; ++index){
                    	query[query.length] = financeModel.insertReimbursementParticular({
                            reimbursement: data.id,
                            particular: particulars[index]
                        }, transaction);
                    }

                    return transaction.batch(query);
                });
            }).then(data =>{
                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
            }).catch(error => {
            	console.log("ERROR---------------------------")
            	console.log(error);
            });

		},

		createPreactsBookTransfer: (req, res) => {

			var dbParam = {
				gosmactivity: req.params.gosmactivity
			};

			var addTransaction = false;

		    if (req.session.user.type == 1){

		    	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
		    	if(ACL[25] || ACL[26]){
		    		addTransaction = true;
		    	}
		    	else{
		    		addTransaction = false;
		    	}
		    }
		    else{
		    	addTransaction = false;
		    }

		    if(addTransaction){
				//TODO: Flatten promises
		    	financeModel.getExpensesWithoutTransactionCount(dbParam).then(transactionCount=>{

		    		if (transactionCount.expensestotal > 0){
		           		
						projectProposalModel.getProjectProposal(dbParam).then(data=>{

							var param ={
								projectproposal: data.id
							};

							financeModel.getParticulars(param).then(data1=>{
								const renderData = Object.create(null);
					            renderData.extra_data = req.extra_data;
					            renderData.csrfToken = req.csrfToken();
					            renderData.particulars = data1;
					            renderData.gosmactivity = req.params.gosmactivity;
								return res.render('Finance/Preacts_BookTransfer', renderData);

							}).catch(error=>{
								console.log(error);
							});

						}).catch(error=>{
							console.log(error);
						});	

		        	}
		        	else{
	    				return res.render('System/403');
				    }
		    	}).catch(error=>{
		    		console.log(error);
		    	});

		    }
		    else{
	    		return res.render('System/403');
		    }

		},

		submitPreactsBookTransfer: (req, res) =>{
			logger.debug('submitPreactsBookTransfer()', log_options);

			console.log(req.body);

			// TODO: recipient??
			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				submittedby: req.session.user.idNumber,
				transferaccount: req.body.recipient
			};

            let particulars = req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            console.log(dbParam);
            console.log(particulars);

            database.tx(transaction => {
	            return financeModel.insertPreActivityBookTransfer(dbParam, transaction).then(data => {
	            	let query = [];

                    for(let index = 0; index < particulars.length; ++index){
                    	query[query.length] = financeModel.insertPreActivityBookTransferParticular({
                            booktransfer: data.id,
                            particular: particulars[index]
                        }, transaction);
                    }

                    return transaction.batch(query);
                });
            }).then(data =>{
                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
            }).catch(error => {
            	logger.error(`${error.message}\n${error.stack}`);
            });

		},

		editPreactsCashAdvance: (req, res) =>{

			var dbParam = {
				id: req.params.id
			};

			database.task(t=>{
				return t.batch([
	                            financeModel.getPreActivityCashAdvance(dbParam),
	                            financeModel.getCashAdvanceParticulars(dbParam),
	                            financeModel.getCashAdvancePendSignatory(dbParam)]);
			}).then(data=>{

				if (data[0].status == 2 && data[0].submittedBy == req.session.user.idNumber){

					const renderData = Object.create(null);
			        renderData.extra_data = req.extra_data;
			        renderData.cashAdvance = data[0];
			        renderData.cashAdvanceParticulars = data[1]
			        renderData.signatory = data[2];
			        renderData.gosmactivity = data[0].GOSMActivity;

			        console.log("id");
			        console.log(renderData.cashAdvance.id);
			        console.log("gosmactivity");
			        console.log(renderData.gosmactivity);


			        if(data[0].purpose == null){
			        	renderData.purpose = false;
			        }
			        else{
			        	renderData.purpose = true;
			        }

			        if(data[0].justification == null){
			        	renderData.justification = false;
			        }
			        else{
			        	renderData.justification = true;
			        }

			        console.log(data[1]);

			        var param = {
			        	projectproposal: data[1][0].projectproposal
			        };

			        financeModel.getParticulars(param)
			        .then(data1=>{

			        	console.log(data1);

			        	renderData.particulars = data1;
			            renderData.csrfToken = req.csrfToken();

						return res.render('Finance/Preacts_EditCashAdvance', renderData);
			        }).catch(error=>{
			        	return logger.error(`${error.message}\n${error.stack}`, log_options);
			        });

				}
				else{
	    			return res.render('System/403');
				}
				

			}).catch(error=>{
				console.log(error);
			});

	    	
		},

		editPreactsDirectPayment: (req, res) =>{

	    	var dbParam = {
				id: req.params.id
			};

			database.task(t=>{
				return t.batch([
                    financeModel.getPreActivityDirectPayment(dbParam),
                    financeModel.getDirectPaymentParticulars(dbParam),
                    financeModel.getDirectPaymentPendSignatory(dbParam)
                ]);
			}).then(data=>{

				if (data[0].status == 2 && data[0].submittedBy == req.session.user.idNumber){

					const renderData = Object.create(null);
			        renderData.extra_data = req.extra_data;
			        renderData.directPayment = data[0];
			        renderData.directPaymentParticulars = data[1]
			        renderData.signatory = data[2];
			        renderData.gosmactivity = data[0].GOSMActivity;

			        console.log(data);

   			        if(data[0].reasonForDelayedPRSProcessing == null){
   			        	renderData.justification = false;
   			        }
   			        else{
   			        	renderData.justification = true;
   			        }



		
		            renderData.csrfToken = req.csrfToken();


						return res.render('Finance/Preacts_EditDirectPayment', renderData);

				}
				else{
	    			return res.render('System/403');
				}
				

			}).catch(error=>{
				console.log(error);
			});

		},

		editPreactsBookTransfer: (req, res) =>{

			var dbParam = {
				id: req.params.id
			};

			database.task(t=>{
				return t.batch([
	                            financeModel.getPreActivityBookTransfer(dbParam),
	                            financeModel.getBookTransferParticulars(dbParam),
	                            financeModel.getBookTransferPendSignatory(dbParam)]);
			}).then(data=>{

				if (data[0].status == 2 && data[0].submittedBy == req.session.user.idNumber){

					const renderData = Object.create(null);
			        renderData.extra_data = req.extra_data;
			        renderData.bookTransfer = data[0];
			        renderData.bookTransferParticulars = data[1]
			        renderData.signatory = data[2];
   			        renderData.gosmactivity = data[0].GOSMActivity;


			        console.log(data);
		
		            renderData.csrfToken = req.csrfToken();


					return res.render('Finance/Preacts_EditBookTransfer', renderData);

				}
				else{
	    			return res.render('System/403');
				}
				

			}).catch(error=>{
				console.log(error);
			});

		},

		editReimbursement: (req, res) =>{

			var dbParam = {
				id: req.params.id
			};

			database.task(t=>{
				return t.batch([
	                            financeModel.getPostProjectReimbursement(dbParam),
	                            financeModel.getReimbursementParticulars(dbParam),
	                            financeModel.getReimbursementPendSignatory(dbParam)]);
			}).then(data=>{

				if (data[0].status == 2 && data[0].submittedby == req.session.user.idNumber){

					const renderData = Object.create(null);
			        renderData.extra_data = req.extra_data;
			        renderData.reimbursement = data[0];
			        renderData.reimbursementParticulars = data[1];
			        renderData.signatory = data[2];
			        renderData.gosmactivity = data[0].GOSMActivity;

			        console.log(data);
		
		            renderData.csrfToken = req.csrfToken();

		            if(data[0].justificationfdpp == null){
   			        	renderData.justification = false;
   			        }
   			        else{
   			        	renderData.justification = true;
   			        }

   			        if(data[0].justificationfnucadp == null){
   			        	renderData.justificationfnu = false;
   			        }
   			        else{
   			        	renderData.justificationfnu = true;
   			        }

   			        console.log(data[0].justificationfnucadp);


					return res.render('Finance/Preacts_EditReimbursement', renderData);

				}
				else{
	    			return res.render('System/403');
				}
				

			}).catch(error=>{
				console.log(error);
			});


		},

		submitEditCashAdvance: (req, res) =>{

			console.log(req.body);

			var dbParam = {
				id: req.body.id,
				gosmactivity: req.body.gosmactivity,
				submittedby: req.session.user.idNumber,
				justification: req.body.nodpjustification,
				purpose: req.body.cpjustification
			};

			var dbParam2 = {
				cashadvance: req.body.id
			};

			let particulars = req.body['particulars[]'] ? req.body['particulars[]'] : req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

             var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/finance/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'finance');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/finance/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'finance', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }



            database.tx(t => {

            	var date = cuid();
	            var nFilename = req.files['file'].name.split('.').pop();
	            var p = path.normalize(path.join(dir2, date + '.' + nFilename));
	            dbParam["filename"] = date + '.' + nFilename;
	            dbParam["filenameToShow"] = req.files['file'].name.split('.')[0]+'.'+nFilename
                Promise.all([
                    req.files['file'].mv(p),
                    // projectProposalModel.insertProjectProposalAttachment(db)
                ]).then(result => {
                    console.log(result);
                }).catch(err => {
                    console.log(err);
                });


            	let query = [
            		financeModel.resubmitCashAdvance(dbParam, t),
					financeModel.deleteCashAdvanceParticulars(dbParam2, t)
				];

                for(let index = 0; index < particulars.length; ++index){
                    query.push(
                        financeModel.insertPreActivityCashAdvanceParticular({
                            cashAdvance: req.body.id,
                            particular: particulars[index]
                    }, t));
                }

                return t.batch(query);
            }).then(data => {

                return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});



		},

		submitEditDirectPayment: (req, res) =>{

			console.log(req.body);

			var dbParam = {
				id: req.body.id,
				gosmactivity: req.body.gosmactivity,
				reason: req.body.reasonForDelayedPRSProcessing,
				fqfn:'',
				fqfts:'',
				roffn:'',
				roffts:'',
				galfn:'',
				galfts:''
			};


			 
             var dir3 = __dirname + '/../assets/upload/';
            var dir3 = path.join(__dirname, '..', 'assets', 'upload');

            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir3)) {
                fs.mkdirSync(dir3);
            }
            var dir = __dirname + '/../assets/upload/finance/';
            var dir = path.join(__dirname, '..', 'assets', 'upload', 'finance');
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir);
            }
            var dir2 = __dirname + '/../assets/upload/finance/' + req.session.user.idNumber + '/';
            var dir2 = path.join(__dirname, '..', 'assets', 'upload', 'finance', req.session.user.idNumber + "");
            //CHECK IF DIRECTOR EXIST
            if (!fs.existsSync(dir2)) {
                fs.mkdirSync(dir2);
            }




			database.task(t=>{


	            var date = cuid();
	            var nFilename = req.files['fq'].name.split('.').pop();
	            dbParam["fqfn"] = date + '.' + nFilename;
	            dbParam["fqfts"] = req.files['fq'].name.split('.')[0]+'.'+nFilename
	            var p = path.normalize(path.join(dir2, date + '.' + nFilename));
	            req.files['fq'].mv(p,function(err){
	            	if(err){
	            		console.log("FQ ERROR")
	            		return err;
	            	}
	            })
	            console.log("FRF ")
	            if(req.files['frf'] != undefined){
	            	
		            var date2 = cuid();
		            var nFilename2 = req.files['frf'].name.split('.').pop();
		            var p2 = path.normalize(path.join(dir2, date2 + '.' + nFilename2));
		            dbParam["roffn"] = date2 + '.' + nFilename;
		            dbParam["roffts"] = req.files['frf'].name.split('.')[0]+'.'+nFilename2	
		            req.files['frf'].mv(p2,function(err){
		            	if(err){
		            		console.log("FRF ERROR")
		            		return err;
		            	}
		            })

	            }
	            
	            console.log("ELP ")
	            if(req.files['elp'] != undefined){
		            var date3 = cuid();
		            var nFilename3 = req.files['elp'].name.split('.').pop();
		            var p3 = path.normalize(path.join(dir2, date3 + '.' + nFilename3));
		            dbParam["galfn"] = date3 + '.' + nFilename;
		            dbParam["galfts"] = req.files['elp'].name.split('.')[0]+'.'+nFilename3	
		            req.files['elp'].mv(p2,function(err){
		            	if(err){
		            		console.log("ELP ERROR")
		            		return err;
		            	}
		            })

	            }
	            

				return t.batch([
	                financeModel.resubmitDirectPaymentSignatory(dbParam, t),
	                financeModel.resubmitDirectPayment(dbParam, t)
				]);
			}).then(data=>{

				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});

		},

		submitEditBookTransfer: (req, res) =>{

			console.log(req.body);

			var dbParam = {
				id: req.body.id,
				gosmactivity: req.body.gosmactivity,
				transferaccount: req.body.recipient
			};

			database.task(t=>{
				return t.batch([
	                financeModel.resubmitBookTransferSignatory(dbParam, t),
	                financeModel.resubmitBookTransfer(dbParam, t)
				]);
			}).then(data=>{

				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});


		},

		submitEditReimbursement: (req, res) =>{

			console.log(req.body);

			var dbParam = {
				id: req.body.id,
				gosmactivity: req.body.gosmactivity,
				justificationfdpp: req.body.justificationdelay,
				justificationfnucadp: req.body.nodpjustification
			}

			database.task(t=>{
				return t.batch([
	                financeModel.resubmitReimbursementSignatory(dbParam, t),
	                financeModel.resubmitReimbursement(dbParam, t)
				]);
			}).then(data=>{

				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});

		}

	};
};
