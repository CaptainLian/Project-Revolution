'use strict';

const squel = require('squel').useFlavour('postgres');
const TABLE = 'Account';
module.exports = function(db, queryFiles){

	return {

		checkAccount: function(credential, checkWhat){
			let query = squel.select()
			.from('Account')
			.field('idNumber')
			.field('email')
			.field('password')
			.field('salt');

			if(checkWhat === CHECK_EMAIL){
				query.where('email = ${credential}');
			}else if(checkWhat === CHECK_IDNUMBER){
				query.where('idNumber = ${credential}');
			}

			/*
			SELECT
				idNumber,
				email,
				password,
				salt
			FROM
				Account
			WHERE
				idNumber = ${idNumber},
			 OR email = ${email};
			*/
			return db.one(query.toParam(), credential);
		}//getAllActivityTypes()

	};
};
