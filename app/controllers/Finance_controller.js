'use strict';
var timediff = require('timediff');

module.exports = function(configuration, modules, models, database, queryFiles){
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
			console.log('EvaluateTransaction !!!!-13131231231313123s	');
			logger.debug('evaluateTransaction()', log_options);

			// TODO: change payable to in html of evaluate transaction
			// direct payment
			if (req.params.transaction == 0){

				var param = {
					id: req.params.id
				};

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
			           	
			           	if(data1[2].signatory == req.session.user.idNumber){
			           		renderData.toEvaluate = true; 
			           	}
			           	else{
			           		renderData.toEvaluate = false;
			           	}


			           	return res.render('Finance/EvaluateTransaction', renderData);



					}).catch(error=>{
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});
				}).catch(error=>{
					console.log(error);
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

			            if(data1[2].signatory == req.session.user.idNumber){
			           		renderData.toEvaluate = true; 
			           	}
			           	else{
			           		renderData.toEvaluate = false;
			           	}
			           
			           
						return res.render('Finance/EvaluateTransaction', renderData);



						
					}).catch(error=>{
						return logger.debug(`${error.message}\n${error.stack}`, log_options);
					});
				}).catch(error=>{
					return logger.debug(`${error.message}\n${error.stack}`, log_options);
				});
			}
		},

		approveDirectPayment: (req, res) =>{
            logger.debug('approveDirectPayment()', log_options);

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

                //TODO: notifications, project heads and next signatory if any
                return database.task(t => {
                	return t.batch([
                		projectProposalModel.getActivityProjectProposalDetailsGAID(dpDetails.activityID, [
                			'ga.strategies'
                		], t),
                		projectProposalModel.getProjectHeadsGOSM({gosmid: dpDetails.activityID}, t),
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
            		if(nextSignatory){
            			queries[0] = accountModel.addNotification(
            				nextSignatory.idNumber,
            				//title
            				'Evaluate Direct Payment',
            				//description
            				`Please evaluate the direct payment for ${strategy}`,
            				//Details
            				{
            					directPaymentID: dpDetails.id
            				},
            				//fields
            				null,
            				t
            			);
            		}

            		for(const projectHead of projectHeads){
            			queries[queries.length] = accountModel.addNotification(
            				projectHead.idNumber,
            				//title
            				'Evaluatation of Direct Payment',
            				`Your direct payment for ${strategy} has be approved by ${currentSignatoryDetails.name}`,
            				{
            					directPaymentID: dpDetails.id,
            					signatory: currentSignatoryDetails.idNumber
            				},
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
			console.log(req.body);
			console.log("pend direct payment");
			console.log(req.body.directPaymentId);

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
			logger.debug('approveCashAdvance', log_options);

			database.task(t => {
				return t.batch([
                    //0
					accountModel.getAccountDetails(req.session.user.idNumber, ['a.privateKey'], t),
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

                return accountModel.approvePreActCashAdvance(req.body.cashAdvanceId, req.session.user.idNumber, DOCUMENT_STRING, DIGITAL_SIGNATURE);

			}).then(data => {
				console.log("successfully approved");
				return res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);
			}).catch(err => {
				logger.warn(`${err.message}\n${err.stack}`);
			});
		},

		pendCashAdvance: (req, res) =>{
			console.log(req.body);
			console.log("pend cash advance");
			console.log(req.body.cashAdvanceId);

			var dbParam = {
				signatory: req.session.user.idNumber,
				cashAdvance: req.body.cashAdvanceId
			};

			financeModel.pendCashAdvance(dbParam).then(data=>{

				console.log("successfully pended cash advance");
				res.redirect(`/finance/list/transaction/${req.body.gosmactivity}`);

			}).catch(error=>{
				console.log(error);
			});

		},
		viewFinanceList: (req, res) => {

			console.log("My user type is");
			console.log(req.session.user.type);

			// old code

			// checks if student

				// var signatoryParam = {
				// 	idnumber: req.session.user.idNumber
				// }

    //             database.task(t =>{
				// 	return t.batch([financeModel.getActivitiesWithFinancialDocuments(),
				// 					financeModel.getTransactionTotalPerActivityForSignatory(signatoryParam)]);
				// })
				// .then(data=>{

					const renderData = Object.create(null);
	            	renderData.extra_data = req.extra_data;

	                //to evaluate
		            renderData.isCso = false;
		            renderData.toadd = false;
		            if(req.session.user.type >= 3 && req.session.user.type <= 6){
                    	renderData.isCso = true;
                    }else if(typeof req.extra_data.user.accessControl !== 'undefined'){
		            	const ACL = req.extra_data.user.accessControl[String(req.session.user.organizationSelected.id)];
		            	if(typeof ACL !== 'undefined' && req.session.user.type == 1){
                    		renderData.isCso = ACL['21'] || false;
                    		renderData.toadd = true;
                    	}
		            }


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

	           	}else{
	           		renderData.isCso = true;
	           		renderData.toadd = false;
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


				database.task(t =>{
					return t.batch([
                        financeModel.getActivityTransactionsForSignatory(dbParam),
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

            	//checks if student and president/treasurer
            	const ACL = req.extra_data.user.accessControl[req.session.user.organizationSelected.id];
	           	if (req.session.user.type == 1 && (ACL[25] || ACL[26])){
		        	renderData.isCso = false;
		            renderData.toadd = true;

		            gosmModel.getGOSMActivityOrg(dbParam)
		            .then(data=>{

		            	if(req.session.user.organizationSelected.id == data.studentorganization){

		            		console.log("nope its this one");
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

					            let actualdate = data[3].dateend;
					            let currentdate = data[3].currdate;

								console.log("actualdate");
								console.log(actualdate);
								console.log("currentdate");
								console.log(currentdate);

								var diff = timediff(actualdate, currentdate, 'D');
				            	console.log(diff);
				            	console.log("difference")

				            	if (diff.days>0){
				            		renderData.reimbursement = true;
				            	}
				            	else{
				            		renderData.reimbursement = false;
				            	}

				            	if (data[3].expensestotal > 0){
				            		renderData.toadd = true;
				            	}
				            	else{
				            		renderData.toadd = false;
				            	}



								return res.render('Finance/ViewActivityTransaction', renderData);
							}).catch(error=>{
								console.log(error);

							});

		            	} else{
		
			           		//TODO: redirect cannot enter page

		            	}

		            }).catch(error=>{
		            	console.log("error is in the new query 1");
		            	console.log(error);
		            });


	           	}else{
	           		//TODO: redirect cannot enter page

	           	}

            }

		},

		createPreactsCashAdvance: (req, res) => {
			var dbParam = {
				projectProposal: req.params.projectproposal
			};

			financeModel.getParticulars(dbParam).then(data=>{
				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();
	            renderData.particulars = data;
	            renderData.gosmactivity = req.params.gosmactivity;
				return res.render('Finance/Preacts_CashAdvance', renderData);
			}).catch(error=>{
				console.log(error);
			});
		},

		//Cash Advance
		submitPreacts: (req, res) => {
			logger.debug('submitPreacts()', log_options);
			console.log(req.body);

			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				submittedBy: req.session.user.idNumber,
				justification: req.body.nodpjustification
			};
			console.log("req.files");
			console.log(req.files);

            let particulars = req.body.particulars;
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
				projectProposal: req.params.projectproposal,
				gosmactivity: req.params.gosmactivity
			};

			database.task(t=>{
				return t.batch([
                    projectProposalModel.getProjectProposal(dbParam),
					financeModel.getParticulars(dbParam)
                ]);
			}).then(data=>{
				let actualdate = data[0].actualedate;
	            let currentdate = data[0].currdate;

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
	            renderData.particulars = data[1];
	            renderData.justification = justification;
	            console.log(renderData.justification);
	            renderData.gosmactivity = req.params.gosmactivity;
				return res.render('Finance/Preacts_DirectPayment', renderData);
			}).catch(error=>{
				console.log(error);
			});
		},

		submitPreactsDirectPayment: (req, res) => {
			logger.debug('submitPreactsDirectPayment()', log_options);

			var dbParam = {
				gosmactivity: req.body.gosmactivity,
				submittedby: req.session.user.idNumber,
				reason: req.body.nodpjustification
			};

            let particulars = req.body.particulars;
            if(!Array.isArray(particulars)){
                particulars = [particulars];
            }

            database.tx(transaction => {
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
                return logger.err(`${err.message}\n${err.stack}`, log_options);
            });
		},
		
		createPreactsReimbursement: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Preacts_Reimbursement', renderData);
			//next();
		},
		createPreactsBookTransfer: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			return res.render('Finance/Preacts_DirectPayment', renderData);
		}
	};
};
