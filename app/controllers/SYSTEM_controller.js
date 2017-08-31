//Document Signature
var selfsigned = require('selfsigned');
var crypto2 = require('crypto2');
// var hash = require('object-hash');


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
		documentSign:(req , res)=>{
			
			
			// //KEY GENERATION
			// console.log("REQUEST");
			// console.log(req.session.user);

			var fullname = req.session.user.firstname + " " + req.session.user.middlename + " " + req.session.user.lastname;
			var email = req.session.user.email;
			var details = [{"name": fullname , "value": email }];

			// ATTRIBUTE ERROR . NULL CAN BE CHANGE TO ATTRS
			// var pems = selfsigned.generate(null, { days: 365 });
			// console.log(pems)
			//GENERATE KEYS
			var keys = selfsigned.generate(null,{
				days:999999,
				keySize: 2048,
				algorithm: 'sha256'
			});
			console.log("GENERATED KEYS");
			console.log(keys.private);

			//SIGN DOCUMENT
			

			var sampleDocument = {
				"Form Name": "PPR",
				Contents: "NEIL IS NICE"
			};


			console.log("SAMPLE DOCUMENT");
			console.log(sampleDocument);

			
			// THE JSON OBJECT OR FORM IS HASH
			crypto2.hash(JSON.stringify(sampleDocument),(err ,hash )=>{
				console.log("SAMPLE HASH");
				console.log(hash);

				//CRYPTO . SHA256 is USED to
				crypto2.sign(hash, keys.private, (err, signature)=>{
					console.log("SAMPLE SIGNATURE");
					console.log(signature);

					crypto2.verify(hash, keys.public, signature, (err, signature)=>{
						console.log("VERIFY SIGNATURE");
						console.log(signature);		

					});
					
						
				});
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