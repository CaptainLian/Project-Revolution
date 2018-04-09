'use strict';
/**
 * Export the function that would construct the model
 * @param  {pg-connection} database   [description]
 * @param  {Array[QueryFiles] queryFiles [description]
 * @return SystemModel            [description]
 */
module.exports = function(configuration, modules, database, queryFiles){
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'SystemModel';

    const squel = require('squel').useFlavour('postgres');

    const {attachReturning, attachFields} = (() => {
        let dbHelper = require('../utility/databaseHelper');

        let ret = Object.create(null);
        ret.attachReturning = dbHelper.attachReturning;
        ret.attachFields = dbHelper.attachFields;
        return ret;
    })();

    const SystemModel = Object.create(null);

    /**
	 * Retrieves the current database term
	 *
	 * @param  {[String, Array] (Optional)} fields The fields to be used for the select statement
	 * @param  {[pg-database, pg-connection, pg-task] (Optional)} connection to database
	 * @return {Promise} oneOrNone results
	 */
    SystemModel.getCurrentTerm = (fields, connection = database) => {
        let query = squel.select()
    		.from('Term')
    		.where('CURRENT_DATE >= dateStart')
    		.where('CURRENT_DATE <= dateEnd');
		attachFields(query, fields);
		query = query.toString();

		logger.debug(`Executing query: ${query}`, log_options);
		return connection.oneOrNone(query);
    };

    /**
	 * Retrieves the current database term with year joined
	 * Joins 2 tables Term (t) And SchoolYear (sy)
	 * The tables joined determines which field must be prefixed with the aliases to retrieve that information
	 *
	 * @param  {[String, Array] (Optional)} fields The fields to be used for the select statement
	 * @param  {[pg-database, pg-connection, pg-task] (Optional)} connection
	 * @return {pg-promise} oneOrNone results
	 */
	SystemModel.getCurrentTermWithYear = (fields, connection = database) => {
		let query = squel.select()
		.from('Term', 't')
			.left_join('SchoolYear', 'sy', 't.schoolYearID = sy.id')
		.where('CURRENT_DATE BETWEEN t.dateStart AND t.dateEnd');
		attachFields(query, fields);
		query = query.toString();

		logger.debug(`Executing query: ${query}`, log_options);
		return connection.oneOrNone(query);
	};

	const getTermDetailsSQL = queryFiles.getTermDetails;
	SystemModel.getTermDetails = (param, connection = database) => {
		return connection.one(getTermDetailsSQL, param);
	};

	const getSchoolYearTermsSQL = queryFiles.getSchoolYearTerms;
	SystemModel.getSchoolYearTerms = (param, connection = database) => {
		return connection.any(getSchoolYearTermsSQL, param);
	};

	const getAllSchoolYearSQL = queryFiles.getAllSchoolYear;
	SystemModel.getAllSchoolYear = (connection = database) =>{
		return connection.any(getAllSchoolYearSQL);
	};


	return SystemModel;
};
