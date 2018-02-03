module.exports = function(configuration, modules, models, database, queryFiles){
	const nodemailer = require('nodemailer');
	var cuid = require('cuid');
	const orgresModel = models.Orgres_model;
	const systemModel = models.System_model;
	const accModel = models.Account_model;


	return {
		viewManageAccount: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
			renderData.csrfToken = req.csrfToken();
			database.task(task =>{
				return task.batch([
					accModel.getOrganizationRoles(),
					accModel.getAccountType(),
					accModel.getAccounts(['oo.isactive','a.idnumber','a.firstname','a.middlename','a.lastname','oro.name','a.email','so.acronym','a.status','a.type','ac.name'])
				]);
			}).then(data=>{
				renderData.roles = data[0]
				renderData.type = data[1]			
				renderData.accounts = data[2]			
				console.log(data[2]);
				return res.render('Orgres/ManageAccount', renderData);
			}).catch(err =>{
				console.log("ERROR");
				console.log(err);
			})
		
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
            
          	var dbParam = {
	         	startyear: firstStartSplit[2],
		       	endyear: thirdEndSplit[2],
	           	datestart: "'" + firstStartSplit[2] + "-" + firstStartSplit[0] + "-" + firstStartSplit[1] + "'",
           		dateend: "'" + thirdEndSplit[2] + "-" + thirdEndSplit[0] + "-" + thirdEndSplit[1] + "'"
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
		           	console.log("enter error 2");
		           	console.log(error);
		        })

		        console.log("CORRECT ---------------------------------");

	        }).catch(error=>{
		       	console.log("enter error 4");
	           	console.log(error);
	        });


            	
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

			orgresModel.insertActivityResearchForm(dbParam).then(data=>{
				const renderData = Object.create(null);
	            renderData.extra_data = req.extra_data;
	            renderData.csrfToken = req.csrfToken();

				return res.redirect('/Orgres/SubmitActivityResearchForm');
			}).catch(error=>{
				console.log(error);
			});	
		},

		saveAccount: (req, res) =>{
			console.log(req.body)
			console.log(req.body['accType[]'] ==1)

			console.log("req.body")
			
			let transporter = nodemailer.createTransport({		
			    host: 'smtp.gmail.com',
		        port: 465,		     
		        secure:true,  
		        connectionTimeout : "10000",	    
			    auth: {
			        user:'dlsum.facultyattendance@gmail.com',
			        pass:'01234567891011'
			    }
			});

			let mailOptions = {
		          from: 'dlsum.facultyattendance@gmail.com', // sender address
		          to: "dominique_dagunton@dlsu.edu.ph", // list of receivers
		          subject: "[IMPORTANT] Google Hacking incident", // Subject line
		          html: '<h3>IMPORTANT</h3><p>Security Breach Found!</p><p>Due to recent access to malicious websites</p>' // html body
		      };

		    transporter.sendMail(mailOptions, (error, info) => {
		        if (error) {
		        	console.log("IMAP2");
		            console.log(error);
		        }		        		             
		    });
		    var password = cuid();

		    

		    database.task(task=>{
		    	if(req.body['accType[]'] == 1){
		    		console.log("createStudentAccount");
		    		if(!Array.isArray(req.body['orgpos[]'])){
		    			req.body['orgpos[]'] = [req.body['orgpos[]']];
		    		}
		    		for(let index = 0, length= req.body['orgpos[]'].length; index < length; ++index){
		    			req.body['orgpos[]'][index] = Number.parseInt(req.body['orgpos[]'][index]);
		    		}
		    		return	accModel.createStudentAccount(req.body.idNumber, req.body.email, password, req.body.givenName, req.body.middleName, req.body.lastName, req.body.number, req.body['orgpos[]'],task)		    				
		    	}else{
		    		console.log("createAccount");
		    		return accModel.createAccount(req.body.idNumber, req.body.email, req.body['accType[]'], password, req.body.givenName, req.body.middleName, req.body.lastName, req.body.number,task);
		    	}
		    	
		    }).then(data =>{
		    	res.json({status:1});
		    }).catch(err=>{
		    	console.log(err)
		    	res.json({status:0});
		    });
		},
		
		getSpecificAccount: (req, res) =>{
			database.task(task=>{
				return task.batch([
					accModel.getSpecificAccount(req.body.idNumber,['a.idnumber','a.firstname','a.middlename','a.lastname','oro.name','a.email','so.acronym','a.idNumber','a.contactNumber','aca.id','a.status']),
					accModel.getSpecificAccount(req.body.idNumber,['oo.role'])
				])
			}).then(result=>{
				console.log("result[1]")
				var array2=[];
				for(var x = 0; x < result[1].length; x++){
					array2.push(result[1][x].role)
				}
				console.log(result[1])
				res.json({
					status:1,
					details:result[0][0],
					position:array2
				})
			}).catch(err=>{
				res.json({
					status:0					
				})
				console.log(err);
			})
			
		},

		deleteAccount: (req, res) =>{
			console.log(req.body.id)
			accModel.deleteAccount(req.body.id,2)
			.then(data=>{
				console.log(data)
				res.json({status:1});	
			}).catch(err=>{
				console.log(err)
				res.json({status:0});	
			})
			
		},
		updateAccount: (req, res) =>{
			console.log(req.body)
			accModel.updateAccount(req.body.id, req.body.email, req.body.accType, req.body.status, req.body.givenName,req.body.middleName,req.body.lastName,req.body.number, req.body['orgpos[]'])
			.then(data=>{
				console.log(data)
				res.json({status:1});	
			}).catch(err=>{
				console.log(err)
				res.json({status:0});	
			})
		},

	};
};
