'use strict';
const squel = require('squel').useFlavour('postgres');
const dbHelper = require('../utility/databaseHelper');

module.exports = function(database, queryFiles){
	return {	
		getOrganizationInformation: function(id, fields){
			const query = squel.select()
			.from('StudentOrganization')
			.where('id = ${id}');
			dbHelper.attachFields(id, fields);			
			return database.one(query.toString(), {id: id});
		}
	};
};