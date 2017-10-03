'use strict';

class SystemModel {

	constructor(database, squel){
		//PROPERTY database
		/**
		 * The default database connection to be used
		 * @type {pg-connection}
		 */
		this._database = database;
		
		/**
		 * The query builder to be used
		 * Defaults to require('squel').useFlavour('postgres')
		 * @type {squel}
		 */
		this._squel = null;
		if(squel){
			this._squel = squel;
		}else{
			this._squel = require('squel').useFlavour('postgres');
		}

		const databaseHelper = require('../utility/databaseHelper');
		/**
		 * Function from databaseHelper for attaching fields to squel queries
		 * @type {function}
		 */
		this._attachFields = databaseHelper.attachFields;

		//PROPERTY log_options
		/**
		 * contains the options for logging
		 * @type {Object}
		 */
		this._log_options = Object.create(null);
		this._log_options.from = 'SystemModel';
	}

	/**
	 * Retrieves the current database term
	 * 
	 * @param  {[String, Array] (Optional)} fields The fields to be used for the select statement 
	 * @param  {[pg-database, pg-connection, pg-task] (Optional)} connection to database
	 * @return {Promise} oneOrNone results
	 */
	getCurrentTerm(fields, connection=this._database){
		let query = this._squel.select()
		.from('Term')
		.where('CURRENT_DATE >= dateStart')
		.where('CURRENT_DATE <= dateEnd');
		this._attachFields(query, fields);

		query = query.toString();
		global.logger.debug(`Executing query: ${query}`, this._log_options);

		return connection.oneOrNone(query);
	}

	/**
	 * Retrieves the current database term with year joined
	 * Joins 2 tables Term (t) And SchoolYear (sy)
	 * The tables joined determines which field must be prefixed with the aliases to retrieve that information
	 * 
	 * @param  {[String, Array] (Optional)} fields The fields to be used for the select statement 
	 * @param  {[pg-database, pg-connection, pg-task] (Optional)} connection
	 * @return {pg-promise} oneOrNone results
	 */
	getCurrentTermWithYear(fields, connection=this._database){
		let query = this._squel.select()
		.from('Term', 't')
			.left_join('SchoolYear', 'sy', 't.schoolYearID = sy.id')
		.where('CURRENT_DATE BETWEEN dateStart AND dateEnd');
		this._attachFields(query, fields);

		query = query.toString();
		global.logger(`Executing query: ${query}`, this._log_options);

		return connection.oneOrNone(query);
	}
}
/**
 * Export the function that would construct the model
 * @param  {pg-connection} database   [description]
 * @param  {Array[QueryFiles] queryFiles [description]
 * @return SystemModel            [description]
 */
module.exports = function(database, queryFiles){
	return new SystemModel(database);
};