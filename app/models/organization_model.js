'use strict';

module.exports = function(database, queryFiles){
	const squel = require('squel').useFlavour('postgres');
	const dbHelper = require('../utility/databaseHelper');
	const log_options = Object.create(null);
	log_options.from = 'Organization-Model';
	const getActivitiesWithPPRSQL = queryFiles.getActivitiesWithPPR;
	const getActivitiesWithoutPPRSQL = queryFiles.getActivitiesWithoutPPR;


	/**
	 * The model representing the model, which contains acions a model can do
	 * @type {Object}
	 */
	const OrganizationModel = Object.create(null);

	OrganizationModel.getOrganizationInformation = (id, fields, connection = database) => {
		global.logger.debug(`Invoked, fields: ${JSON.stringify(fields)}`, log_options);
		let query = squel.select()
			.from('StudentOrganization')
			.where('id = ${id}');
		dbHelper.attachFields(query, fields);			

		let param = Object.create(null);
		param.id = id;

		query = query.toString();
		global.logger.debug(`Executing query: ${query}`, log_options);
		return connection.one(query.toString(), param);
	};


	OrganizationModel.getActivitiesWithPPR = (param, fields, connection = database) => {
		return connection.one(getActivitiesWithPPRSQL, param);
	};

	OrganizationModel.getActivitiesWithoutPPR = (param, fields, connection = database) => {
		return connection.one(getActivitiesWithoutPPRSQL, param);
	};

	/**
	 * Retrives AND parses the input into an organization chart object
	 * @method
	 * @param  {Integer} organizationID [description]
	 * @param  {Boolean} promisify      [description]
	 * @param  {[pg-connection, pg-task, pg-transaction] (Optional)} connection     [description]
	 * @return {Object}                [description]
	 */
	OrganizationModel.getOrganizationStructure = (organizationID, connection = database) => {
		/**
		 * let param = {
		 * 		organizationID: organizationID
		 * };
		 * @type {Object}
		 */
		let param = Object.create(null);
		param.organizationID = organizationID;


		connection.many('SELECT id, name, masterRole FROM OrganizationRole WHERE organization = {organizationID}', param)
		.then(data => {
			
		});



	};

	return OrganizationModel;
};