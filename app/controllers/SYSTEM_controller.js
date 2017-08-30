module.exports = function(database, models, queryFiles){

	var systemModel = models.SYSTEM_model;
	return {
		viewLogin:(req, res)=>{
			req.session.valid = false;
			res.render('System/LoginMain');
		},
		checkLogin:(req, res)=>{
			console.log("checkLogin");
			var account = {
				email : req.body.email,
				pass : req.body.pass
			};
			console.log(account);
			systemModel.checkAccount(account)
			.then(data=>{

				console.log("DATA LOGIN: "+data);

				
				req.session.valid = true;
				console.log("VALID PARAM "+req.session.valid);
				req.session.cookie.expires = new Date(Date.now() + 5000);
				req.session.cookie.maxAge = 5000;
				
				req.session.save(function(err){

					console.log(" CON VALID == "+ req.session.valid);
					res.redirect('/viewOrgList');
				});

				

			}).catch(error=>{
				req.session.valid = false;
				console.log("ERROR LOGIN: " + error);
			});

		}
	};
};