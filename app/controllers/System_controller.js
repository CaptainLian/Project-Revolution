const debug = require('debug')('Login: ');
const bcrypt = require('bcrypt');
const squel = require('squel');
module.exports = function(database, models, queryFiles) {

	const accountModel = models.Account_model;
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
    }
  };
};
