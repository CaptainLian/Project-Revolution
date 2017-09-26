'use strict';
const squel = require('squel').useFlavour('postgres');
const dbHelper = require('../utility/databaseHelper');

module.exports = function(database, queryFiles){

	const getActivitiesWithPPRSQL = queryFiles.getActivitiesWithPPR;
	const getActivitiesWithoutPPRSQL = queryFiles.getActivitiesWithoutPPR;

	return {	
		getOrganizationInformation: function(id, fields){
			const query = squel.select()
			.from('StudentOrganization')
			.where('id = ${id}');
			dbHelper.attachFields(id, fields);			
			return database.one(query.toString(), {id: id});
		},
		getActivitiesWithPPR: function(param){
			return database.one(getActivitiesWithPPRSQL, param);
		},
		getActivitiesWithoutPPR: function(param){
			return database.one(getActivitiesWithoutPPRSQL, param);
		}
	};
};