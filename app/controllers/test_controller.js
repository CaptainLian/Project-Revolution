'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let testController = Object.create(null);
	const forge = require('node-forge');


	testController.test = (req, res) => {
		models.organization_model.getOrganizationStructure(0)
		.then(data => {
			return res.send(data);
		}).catch(err => {
			return console.log(err);
		});
	};


	testController.account = (req, res) => {
		const accountModel = models.Account_model;

		accountModel.createAccount(
			1234567,
			'aguy@yahoo.aguy.com',
			1,
			'1234',
			'aguy',
			'penchorn',
			'gansa',
			'63123124',
			[
				'salt',
				'privateKey',
				'publicKey'
			]
		).then(data => {
			console.info(data);
			const privateKey = forge.pki.privateKeyFromPem(data.privatekey);
			return res.send(data);
		}).catch(err =>{
			console.error(err);

			return res.send('Error');
		});
	};

	testController.notification = (req, res) => {
		const accountModel = models.Account_model;

		return accountModel.addNotification(1011130, 'Project Proposal Submission', 'Aguy').then(() => {
			return res.send('Success');
		}).catch(err => {
			console.log(err);
			return res.send('Error');
		});
	};

	return testController;
};
