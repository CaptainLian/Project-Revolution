const debug = require('debug')('Login: ');

//query builder
const squel = require('squel');

//password hashing
const bcrypt = require('bcryptjs');

//Document Signature
const selfsigned = require('selfsigned');
const crypto2 = require('crypto2');

module.exports = function(database, models, queryFiles) {

	const accountModel = models.Account_model;
	const systemModel = models.System_model;
  return {

    viewLogin: (req, res) => {
      res.render('System/LoginMain');
    },

    logout: (req, res) => {
      req.session.user = undefined;
			req.session.destroy(function(err){
				res.redirect("/");
			});
    },

    checkLogin: (req, res) => {
			let input = req.body;
			console.log(input);
			//parse id number
			let credential = parseInt(input.credential);
			let credentialFloat = parseFloat(input.credential);

			let query = squel.select()
				.from('Account')
				.field('idNumber')
				.field('email')
				.field('password')
				.field('salt');

			let valid = true;
			if(isNaN(credential)){
				//this is email. possibly invalid
				query.where('email=${credential}');
			}else if(credential != credentialFloat || credential <= 0){
				//this is a decimal number or invalid value
				valid = false;
			}else{
				query.where('idNumber=${credential}');
			}

			if(valid){
				database.one(query.toString(), {credential: input.credential})
					.then(account => {
						console.log(account);
						if(account.password === bcrypt.hashSync(input.password, account.salt)){
							console.log('Enter!!');
							req.session.user = account.email;
							req.session.valid = true;
							req.session.save(() => {});
						}else{
							console.log('incorrect Password');
						}

						res.render('System/LoginMain');
					})
					.catch(error => {
						console.log(error);
						console.log('Account does not exists');
						res.render('System/LoginMain');
					});
			}else{
				res.render('System/LoginMain');
				console.log('incorrect value');
			}
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
		}
  };
};
