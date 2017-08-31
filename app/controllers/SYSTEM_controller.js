module.exports = function(database, models, queryFiles){

	var systemModel = models.SYSTEM_model;
	return {
		viewLogin:(req, res)=>{
			
			res.render('System/LoginMain');
		},
		logout:(req, res)=>{
			req.session.user = undefined;
			req.session.save(function(){
				res.redirect("/");	
			});
			
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
				
				req.session.user = data;
				console.log("VALID PARAM "+req.session.valid);
								
				
				req.session.save(function(err){

					console.log(" CON VALID == "+ req.session.user);
					res.redirect('/viewOrgList');
				});

				

			}).catch(error=>{
				req.session.valid = false;
				console.log("ERROR LOGIN: " + error);
			});

		}
	};
};