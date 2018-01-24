module.exports = function(configuration, modules, models, database, queryFiles){
	const nodemailer = require('nodemailer');
	var cuid = require('cuid');
	const orgresModel = models.Orgres_model;
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
						accModel.getAccounts(['a.idnumber','a.firstname','a.middlename','a.lastname','oro.name','a.email'])
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
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
			return res.render('Orgres/ManageTime', renderData);
		},
		submitTime: (req, res) => {
			const renderData = Object.create(null);
            renderData.extra_data = req.extra_data;

            console.log(req.body);



			return res.render('Orgres/ManageTime', renderData);
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
		          to: "neil_capistrano@dlsu.edu.ph", // list of receivers
		          subject: "req.body.subject", // Subject line
		          text: "req.body.body", // plain text body
		          html: '<b>NodeJS Email Tutorial</b>' // html body
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
		    		return	accModel.createStudentAccount(req.body.idNumber, req.body.email, password, req.body.givenName, req.body.middleName, req.body.lastName, req.body.number, req.body['orgpos[]'], task)		    				
		    	}else{
		    		console.log("createAccount");
		    		return accModel.createAccount(req.body.idNumber, req.body.email, req.body['accType[]'], password, req.body.givenName, req.body.middleName, req.body.lastName, req.body.number, task);
		    	}
		    	
		    }).then(data =>{
		    	res.json(1);
		    }).catch(err=>{
		    	console.log(err)
		    	res.json(0);
		    });

			 
			
		},
		getInfo: (req, res) =>{
			console.log(req.body);
			res.json(1);	
		}

	};
};
