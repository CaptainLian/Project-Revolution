'use strict';

const forgePromise = require('../utility/node-forge-promise');
const squel = require('squel').useFlavour('postgres');

module.exports = function(database, queryFiles){

	class AccountModel {
		constructor(database){
			this._database = database;
		}
		
		createAccount(idNumber, email, type, password, firstname, middlename, lastname, contactNumber, onnection = this._database){
			let param = Object.create(null);
			param.idNumber = idNumber;
			param.email = email;
			param.type = type;
			param.password = password;
			param.firstname = firstname;
			param.middlename = middlename;
			param.lastname = lastname;
			param.contactNumber = contactNumber;
			
		}
	}
};
