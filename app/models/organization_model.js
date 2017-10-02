'use strict';

module.exports = function(database, queryFiles){
	const squel = require('squel').useFlavour('postgres');
	const dbHelper = require('../utility/databaseHelper');
	const log_options = Object.create(null);
	log_options.from = 'Organization-Model';
	const getActivitiesWithPPRSQL = queryFiles.getActivitiesWithPPR;
	const getActivitiesWithoutPPRSQL = queryFiles.getActivitiesWithoutPPR;

	return {	
		getOrganizationInformation: function(id, fields, connection = database){
			global.logger.debug(`Invoked, fields: ${JSON.stringify(fields)}`, log_options);
			let query = squel.select()
				.from('StudentOrganization')
				.where('id = ${id}');
			dbHelper.attachFields(query, fields);			

			let param = {};
			param.id = id;

			query = query.toString();
			global.logger.debug(`Executing query: ${query}`, log_options);
			return connection.one(query.toString(), param);
		},

		getActivitiesWithPPR: function(param, connection = database){
			return connection.one(getActivitiesWithPPRSQL, param);
		},

		getActivitiesWithoutPPR: function(param, connection = database){
			return connection.one(getActivitiesWithoutPPRSQL, param);
		}
	};
};